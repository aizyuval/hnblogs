import scrapy
from scrapy.spiders import Spider, CrawlSpider, Rule
from scrapy.linkextractors import LinkExtractor, IGNORED_EXTENSIONS # LinkExtractor is the same as LxmlLinkExtractor
from scrapy.exceptions import CloseSpider, IgnoreRequest
from scrapy.http.response.text import TextResponse
from scrapy.http import Request, HtmlResponse, XmlResponse
from scrapy.utils.log import configure_logging
from scrapy.utils.project import get_project_settings
import logging
from bs4 import BeautifulSoup
import datetime
from urllib.parse import urlsplit
import feedparser
from indexer.spiders.search_my_site_parser import customparser
import re


IGNORED_EXTENSIONS += ['jar', 'json', 'cbr'] 

class HNblogsSpider(CrawlSpider):
    name = "HNblogsSpider"
"""
Typesense Schema:

blogs_schema = { 
	    "name": "HNblogsSchema", 
	    "fields": [ 
	    { "name": "title", "type": "string" }, 
	    { "name": "content", "type": "string" }, 
	    { "name": "domain", "type": "string", "facet": true }, 
	    { "name": "page-type", "type": "string"}, 
	    { "name": "description", "type": "string", "optional": true }, 
	    { "name": "anchor", "type": "string", "optional": true },  ##### remove
	    { "name": "language", "type": "string", "optional": true }, 
	    { "name": "url", "type": "string" }, 
	    { "name": "content-type", "type": "string", "index": false, "optional": true}, 
	    { "name": "page_last_modified", "type": "int64", "facet": true }, 
	    { "name": "indexed_date", "type": "int64", "optional": true,"index": false, "optional": true }
 
	    ], 
 
	    "token_separators": ["_", "-"] 
}
"""
    custom_settings = {
        'ITEM_PIPELINES': {
            'indexer.pipelines.TypesensePipeline': 300 # activate the item pipeline (that will add/commit parsed results)
        }
    }

    def __init__(self, *args, **kwargs):
        # Get kwargs
        self.typesense_helper = kwargs.get('typesense_helper')
        self.site_config = kwargs.get('site_config')
        self.home_page = self.site_config['home_page']
        self.domain = self.site_config['domain']

        """
        # Check for sitemap.xml
        self.rexml = requests.head(f'{self.home_page}/sitemap.xml')

        if rexml.status_code == 200:
            self.web_feed = f'{self.home_page}/sitemap.xml'
        else:
            self.web_feed = None

        self.site_config['feed_links'] = [] # This will be instantiated by parse_start_url, for enumerating over web_feed links
        """

        # Set Scrapy spider attributes, i.e. start_urls and allowed_domains
        # start_urls is where the indexing starts, in this case the home page and (if present) web feed
        # Currently allowd_domains is the domain of the blog.

        """if self.web_feed:
            self.start_urls = [self.home_page, self.web_feed]
        else::"""
        self.start_urls = [self.home_page]
        self.allowed_domains = [self.domain] 

        self.logger.info('Start URLs {}'.format(self.start_urls))
        self.logger.info('Allowed domains {}'.format(self.allowed_domains))

        # Set up deny list
        # Adding the pinterest and tumblr deny rules to prevent urls such as the following being indexed e.g. for example.com
        # https://www.pinterest.com/pin/create/button/?url=https%3A%2F%2Fexample.com...
        # https://www.tumblr.com/widgets/share/tool/preview?shareSource=legacy&canonicalUrl=&url=https%3A%2F%2Fexample.com%2F
        # These seem to be triggered by links on the original domain such as
        # https://example.com/page/?share=pinterest
        deny = [r'.*\?share\=pinterest.*', r'.*\?share\=tumblr.*']
        self.logger.info('Deny path {}'.format(deny))

        # Set up rule for configuring scraping behavior. Which links to extract, callback function, and following links
        self.rules = (
            Rule(
                LinkExtractor(allow_domains=self.allowed_domains, deny=deny, deny_extensions=IGNORED_EXTENSIONS, tags=('a','area','link')),
                callback=self.parse_item,
                follow=True
                ),
            )
        super(HNblogsSpider, self).__init__(self, *args, **kwargs) # invoking the __init__ function of the CrawlSpider class, to not break crucial initialisations

    # As per https://docs.scrapy.org/en/latest/topics/spiders.html the "default implementation generates Request(url, dont_filter=True) 
    # for each url in start_urls"
    # The dont_filter=True means that the start_urls bypass the deduplication, which means a 2nd home page could be indexed after the first, 
    # and the 2nd wouldn't have is_home=true, so we need to override this method
    def start_requests(self):
        for url in self.start_urls:
            yield Request(url)

    # parse_start_url is called ONCE, for each start_urls. Here we override the function (from CrawlSpider) with our configuration.
    # it parses the web_feed for links, as they don't have theirs extracted by the LinkExtractor Rule.
    # Because the LinkExtractor Rule only works where the response is an HtmlResponse 
    def parse_start_url(self, response):
        configure_logging(get_project_settings())
        logger = logging.getLogger()

        """# XML Response
        # ------------------
        if isinstance(response, XmlResponse) and response.url == self.web_feed:
            logger.info('Processing web feed: {}'.format(response.url))
            d = feedparser.parse(response.text)
            entries = d.entries
            version = None
            no_of_links = None
            # if the url isn't a valid feed, d.entries will succeed with None, but d.version will raise a
            # AttributeError: object has no attribute 'version'
            if entries:
                version = d.version
                for entry in entries:
                    if 'link' in entry:
                        self.site_config['feed_links'].append(entry.link)
            links_to_index = self.site_config['feed_links']
            logger.info('Web feed version: {}, total links: {}, total links to index: {}'.format(version, len(self.site_config['feed_links']), len(links_to_index)))
            # Also need to index the web feed itself
            # If this is not done, the web feed will not be processed by process_item in the pipeline and so the web_feed_auto_discovered will be removed in close_spider
            item = customparser(response, self.domain, self.site_config, self.common_config)
            yield item # this includes the web feed itself -> see if I do need that! #FIX

            for link in links_to_index: # have to traverse the tree because LinkExtractor won't work for xml
                try:
                    yield Request(link, callback=self.parse_item) #
                except ValueError:
                    logger.warn('ValueError for {}'.format(link)) # Sometimes links in feeds are relative and throw ValueError(f"Missing scheme in request url: {self._url}")
"""
        # Html Response
        # ------------------
        if isinstance(response, HtmlResponse):
            logger.info('Processing home page: {}'.format(response.url))
            item = customparser(response, self.domain, self.site_config)
            yield item
            # from here on LinkExtractor will get to work!
        else:
            logger.warn('Skipping processing start_url: {}'.format(response.url))

    def parse_item(self, response):
        configure_logging(get_project_settings())
        logger = logging.getLogger()
        logger.debug('Parsing URL: {}'.format(response.url))
        #scrape_count = self.crawler.stats.get_value('item_scraped_count')
        if not isinstance(response, TextResponse): #Text response is a class that is initiated when the response is html/xml
            logger.info('Item {} is not a TextResponse, so skipping.'.format(response)) # Skip item if e.g. an image
        else:
            item = customparser(response, self.domain, self.site_config)
            if item:
                yield item # go pipeline



