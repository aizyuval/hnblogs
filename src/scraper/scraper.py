# main scraping job
# The crawling/scraping should persist on a list of domains (from the db) NOT just one


# here i will the run the scraper: 
# for site in sites: # recursive on all sites links
# crawl run site
import scrapy
from twisted.internet import reactor
from scrapy.crawler import CrawlerRunner
from scrapy.utils.log import configure_logging
from scrapy.utils.project import get_project_settings
import logging
import psycopg2
import psycopg2.extras
from indexer.spiders.search_my_site_spider import SearchMySiteSpider
from common.utils import update_indexing_status, get_all_domains, get_domains_allowing_subdomains, get_all_indexed_inlinks_for_domain, get_already_indexed_links, get_contents, check_for_stuck_jobs, expire_listings
import os

# As per https://docs.scrapy.org/en/latest/topics/practices.html
# This runs the SearchMySiteSpider directly rather than via 'scrapy crawl' at the command line
# CrawlerProcess will start a Twisted reactor for you
# CrawlerRunner "provides more control over the crawling process" but
# "the reactor should be explicitly run after scheduling your spiders" and 
# "you will also have to shutdown the Twisted reactor yourself after the spider is finished"

settings = get_project_settings()
configure_logging(settings) # Need to pass in settings to pick up LOG_LEVEL, otherwise it will stay at DEBUG irrespective of LOG_LEVEL in settings.py
logger = logging.getLogger()

 
sites_to_crawl = []
# Just lookup domains_for_indexed_links and domains_allowing_subdomains once
common_config = {}

logger.debug('BOT_NAME: {} (indexer if custom settings are loaded okay, scrapybot if not)'.format(settings.get('BOT_NAME')))

# SETUP ENV VARIABLES

db_name = settings.get('DB_NAME')
db_user = settings.get('DB_USER')
db_host = settings.get('DB_HOST') # host -> 'db' ?
db_password = settings.get('DB_PASSWORD')


# SELECT urls for indexing
sql_select_domains_to_index = "SELECT url FROM tbllinks" 
if 'TEST_DOCS_NUM' in os.environ:
    sql_select_domains_to_index = f"SELECT url FROM tbllinks LIMIT ${os.environ['TEST_DOCS_NUM']}" # limit in test env

# MAIN INDEXING JOB
# Read blog links from database, and save to self variables

logger.info('Checking for sites to index')

logger.debug('Reading from database {}'.format(db_name))
try:
    conn = psycopg2.connect(dbname=db_name, user=db_user, host=db_host, password=db_password)
    cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor) # column names are keys
    # sites_to_crawl is the config specific to each site
    cursor.execute(sql_select_domains_to_index)
    results = cursor.fetchall()
    for result in results:
        site = {}
        site['home_page'] = result['url']
        site['domain'] = (site['home_page'].split('://')[-1]).split('/')[0] # https://lol.ex.xyz/page/1 -> lol.ex.xyz

        sites_to_crawl.append(site)
except psycopg2.Error as e:
    logger.error(' %s' % e.pgerror)
finally:
    conn.close()

if sites_to_crawl: logger.info('sites_to_crawl: {}'.format(sites_to_crawl))

# Read data from Solr (indexed_inlinks, content and if necessary already_indexed_links)

sites_to_remove = []
for site_to_crawl in sites_to_crawl:
    domain = site_to_crawl['domain']
    full_index = site_to_crawl['full_index']
    indexing_page_limit = site_to_crawl['indexing_page_limit']
    # indexed_inlinks, i.e. pages (from other domains within this search index) which link to this domain.
    indexed_inlinks = get_all_indexed_inlinks_for_domain(domain)
    logger.debug('indexed_inlinks: {}'.format(indexed_inlinks))
    site_to_crawl['indexed_inlinks'] = indexed_inlinks
    # content, i.e. get_contents(domain)
    contents = get_contents(domain)
    logger.debug('contents: {}'.format(contents))
    site_to_crawl['contents'] = contents
    # already_indexed_links, i.e. pages on this domain which have already been indexed.
    # This is only set if it is needed, i.e. for an incremental index.
    if full_index == False:
        already_indexed_links = get_already_indexed_links(domain)
        no_of_already_indexed_links = len(already_indexed_links)
        if no_of_already_indexed_links >= indexing_page_limit:
            # if the indexing_page_limit was reached in the last index then remove this site from the sites to crawl
            # update the status in the database so that it isn't selected again until the next scheduled full or incremental reindex
            sites_to_remove.append(domain)
            message = 'The indexing page limit was reached on the last index, so not going to perform incremental reindex for {}'.format(domain)
            update_indexing_status(domain, full_index, 'COMPLETE' , message)
            logger.warning(message)
        else:
            # reduce the indexing_page_limit according to the number of pages already in the index
            # so the incremental reindex doesn't exceed the indexing_page_limit
            new_indexing_page_limit = indexing_page_limit - no_of_already_indexed_links
            site_to_crawl['indexing_page_limit'] = new_indexing_page_limit
            logger.info('no_of_already_indexed_links: {}, indexing_page_limit: {}, new_indexing_page_limit: {}, for {}'.format(no_of_already_indexed_links, indexing_page_limit, new_indexing_page_limit, domain))
            site_to_crawl['already_indexed_links'] = already_indexed_links

sites_to_crawl = [site_to_crawl for site_to_crawl in sites_to_crawl if site_to_crawl['domain'] not in sites_to_remove]

# Run the crawler

if sites_to_crawl:
    runner = CrawlerProcess(settings)
    for site_to_crawl in sites_to_crawl:
        runner.crawl(SearchMySiteSpider, 
        config=config, # common_config
        typesense_helper=typesense_helper
        )

    # Actually run the indexing
    logger.info('Starting indexing')
    process.start()
    process.stop()
    logger.info('Completed indexing')
