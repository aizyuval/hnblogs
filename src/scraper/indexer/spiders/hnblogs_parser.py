import scrapy
from scrapy.linkextractors import LinkExtractor
from scrapy.exceptions import DropItem
from scrapy.http import HtmlResponse, XmlResponse
from bs4 import BeautifulSoup, SoupStrainer
import datetime
from scrapy.utils.log import configure_logging
from scrapy.utils.project import get_project_settings
import logging
import feedparser
from httpdate import httpdate_to_unixtime
from common.utils import get_text

""" Typesense schema:
blogs_schema = { 
	    "name": "hnblogs", 
	    "fields": [ 
	    { "name": "title", "type": "string" }, 
	    { "name": "content", "type": "string" }, 
	    { "name": "domain", "type": "string", "facet": true }, 
	    { "name": "page-type", "type": "string"}, 
	    { "name": "description", "type": "string", "optional": true }, 
	    { "name": "anchor", "type": "string", "optional": true }, 
	    { "name": "language", "type": "string", "optional": true }, 
	    { "name": "url", "type": "string" }, 
	    { "name": "content-type", "type": "string", "index": false, "optional": true}, 
	    { "name": "page_last_modified", "type": "int64", "facet": true }, 
	    { "name": "indexed_date", "type": "int64", "optional": true,"index": false, "optional": true }
 
	    ], 
 
	    "token_separators": ["_", "-"] 
}
"""

# Custom parser will be invoked by my_scraper, after retrieving the response from the get request


def customparser(response, domain, site_config, common_config):

    configure_logging(get_project_settings())
    logger = logging.getLogger()
    logger.info('Parsing {}'.format(response.url))

    # check for type (this is first because some types might be on the exclude type list and we want to return None so it isn't yielded)
    ctype = None
    if isinstance(response, XmlResponse) or isinstance(
        response, HtmlResponse
    ):   # i.e. not a TextResponse like application/json which wouldn't be parseable via xpath
        # If the page returns a Content-Type suggesting XmlResponse or HtmlResponse but is e.g. JSON it will throw a "ValueError: Cannot use xpath on a Selector of type 'json'"
        try:
            ctype = response.xpath(
                '//meta[@property="og:type"]/@content'
            ).get()   # <meta property="og:type" content="..." />
            if not ctype:
                ctype = response.xpath(
                    '//article/@data-post-type'
                ).get()   # <article data-post-id="XXX" data-post-type="...">
        except ValueError:
            logger.info(
                'Aborting parsing for {}: not XmlResponse or HtmlResponse'.format(
                    response.url
                )
            )
            return None   # Don't perform further parsing of this item in case it causes additional errors
    # item
    # Document in the form of a dictionairy, parsed from the response and structured in the schema form.
    item = {}

    # All TextResponse
    # --------------------------------------------

    original_url = response.url
    if 'redirect_urls' in response.request.meta:
        original_url = response.request.meta['redirect_urls'][0]   # first url
        logger.info(
            'Redirect detected. Current URL: {}, original URL(s): {}, using {} for id'.format(
                response.url,
                response.request.meta['redirect_urls'],
                original_url,
            )
        )

    # id
    # This is set to the original_url without redirections, if any.
    # This is the unique identifier for each page. In case the id already exists, typesense will update the stored data thanks to UPSIRT - FIX
    # It is crucial to set ID to the pre-redirect URL to prevent overwriting a document with one that redirects to it.
    item['id'] = original_url

    # url
    item['url'] = response.url

    # domain
    item['domain'] = domain

    # content_type, e.g. text/html; charset=utf-8
    content_type = None
    content_type_header = response.headers.get('Content-Type')
    if content_type_header:
        content_type = content_type_header.decode('utf-8').split(';')[
            0
        ]   # decode it to a string
    item['content_type'] = content_type

    # last_modified_date
    last_modified_date = response.headers.get('Last-Modified')
    if last_modified_date:
        last_modified_date = last_modified_date.decode('utf-8')
        last_modified_date = httpdate_to_unixtime(last_modified_date)
    item['page_last_modified'] = last_modified_date

    # indexed_date
    indexed_date = datetime.datetime.now().timestamp()   # unix-time
    item['indexed_date'] = indexed_date

    # XmlResponse and HtmlResponse, i.e. not TextResponse which includes application/json
    # -----------------------------------------------------------------------------------

    # i.e. not a TextResponse like application/json which wouldn't be parseable via xpath
    if isinstance(response, XmlResponse) or isinstance(response, HtmlResponse):

        # title
        # XML can have a title tag
        item['title'] = response.xpath(
            '//title/text()'
        ).get()   # <title>...</title>

        # page_type (value obtained at the start in case there was a page type exclusion)

    # HtmlResponse
    # ------------

    if isinstance(response, HtmlResponse):
        # description
        item['page_type'] = ctype
        description = response.xpath(
            '//meta[@name="description"]/@content'
        ).get()   # <meta name="description" content="...">
        if not description:
            description = response.xpath(
                '//meta[@property="og:description"]/@content'
            ).get()   # <meta property="og:description" content="..." />
        item['description'] = description

        # content
        only_body = SoupStrainer('body')
        body_html = BeautifulSoup(response.text, 'lxml', parse_only=only_body)
        for non_content in body_html(
            ['nav', 'header', 'footer']
        ):   # Remove nav, header, and footer tags and their contents
            non_content.decompose()
        main_html = body_html.find('main')
        article_html = body_html.find('article')
        if main_html:
            content_text = get_text(main_html)
        elif article_html:
            content_text = get_text(article_html)
        else:
            content_text = get_text(body_html)
        item['content'] = content_text

        # language, e.g. en-GB
        language = response.xpath('/html/@lang').get()
        # if language: language = language.lower() # Lowercasing to prevent facetted nav thinking e.g. en-GB and en-gb are different
        item['language'] = language

        """
        # language_primary, e.g. en
        language_primary = None
        if language:
            language_primary = language[:2] # First two characters, e.g. en-GB becomes en
        item['language_primary'] = language_primary
        """

    # XmlResponse
    # -----------

    elif isinstance(response, XmlResponse):

        # For XML this will record the rood node name
        item['page_type'] = response.xpath('name(/*)').get()

        d = feedparser.parse(response.text)
        entries = d.entries
        version = None
        if entries:
            version = d.version
            item['is_web_feed'] = True

    # Not HtmlResponse, i.e. TextResponse including text/plain and application/json
    # ---------------------------------------------------------------------------------------------
    # Note that non-browser friendly results, e.g. XML and RSS, are filtered out from the results pages

    else:
        item['content'] = response.text

    return item
