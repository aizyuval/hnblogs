# main scraping job
# The crawling/scraping should persist on a list of domains (from the db) NOT just one


import scrapy
from scrapy.crawler import CrawlerProcess
from scrapy.utils.log import configure_logging
from scrapy.utils.project import get_project_settings
import logging
import psycopg2
import psycopg2.extras
from typesense_helper import TypesenseHelper
from indexer.spiders.HNblogsSpider import HNblogsSpider
import os

# As per https://docs.scrapy.org/en/latest/topics/practices.html
# This runs the SearchMySiteSpider directly rather than via 'scrapy crawl' at the command line
# CrawlerProcess will start a Twisted reactor for you

settings = get_project_settings()

# Need to pass in settings to pick up LOG_LEVEL, otherwise it will stay at DEBUG irrespective of LOG_LEVEL in settings.py
configure_logging(settings)
logger = logging.getLogger()


sites_to_crawl = []

logger.debug(
    'BOT_NAME: {} (indexer if custom settings are loaded okay, scrapybot if not)'.format(
        settings.get('BOT_NAME')
    )
)

# Setup env variables
db_name = settings.get('DB_NAME')
db_user = settings.get('DB_USER')
db_host = settings.get('DB_HOST')
db_password = settings.get('DB_PASSWORD')


# SELECT urls for indexing
sql_select_domains_to_index = 'SELECT url FROM tbllinks'
if 'TEST_DOCS_NUM' in os.environ:
    sql_select_domains_to_index = f"SELECT url FROM tbllinks LIMIT ${os.environ['TEST_DOCS_NUM']}"   # limit in test env

# MAIN INDEXING JOB
# Read blog links from database, and save to self variables

logger.info('Checking for sites to index')

logger.debug('Reading from database {}'.format(db_name))

try:
    conn = psycopg2.connect(
        dbname=db_name, user=db_user, host=db_host, password=db_password
    )
    cursor = conn.cursor(
        cursor_factory=psycopg2.extras.DictCursor
    )   # column names are keys

    cursor.execute(sql_select_domains_to_index)
    results = cursor.fetchall()
    for result in results:
        site = {}
        site['home_page'] = result['url']
        site['domain'] = (site['home_page'].split('://')[-1]).split('/')[
            0
        ]   # https://lol.ex.xyz/page/1 -> lol.ex.xyz

        sites_to_crawl.append(site)

except psycopg2.Error as e:
    logger.error(' %s' % e.pgerror)
finally:
    conn.close()

if sites_to_crawl:
    logger.info('sites_to_crawl: {}'.format(sites_to_crawl))


# Define helper *once* for all sites
typesense_helper = TypesenseHelper(
    'HNblogsIndex',  #  alias
    'HNblogsIndexTMP',
    config.custom_settings,
)

if sites_to_crawl:
    process = CrawlerProcess(settings)
    for site_to_crawl in sites_to_crawl:
        process.crawl(
            HNblogsSpider,
            site_config=site_to_crawl,
            typesense_helper=typesense_helper,
        )

    # Actually run the indexing
    logger.info('Starting indexing')
    process.start()   # hang
    process.stop()
    logger.info('Completed indexing')
