# main scraping job
# The crawling/scraping should persist on a list of domains (from the db) NOT just one


import logging
import os
import time

import psycopg2
import psycopg2.extras
import scrapy
from indexer.spiders.hnblogs_spider import HNblogsSpider
from scrapy.crawler import CrawlerProcess
from scrapy.utils.log import configure_logging
from scrapy.utils.project import get_project_settings
from typesense_helper import TypesenseHelper

# As per https://docs.scrapy.org/en/latest/topics/practices.html
# Running hnblogsSpider from a script instead of the command line
# CrawlerProcess will start a Twisted reactor for you

time.sleep(50)
settings = get_project_settings()

# configure_logging(settings) # no need ot configure_logging. This is called by CrawlerProcess - FIX check that
logger = logging.getLogger()


sites_to_crawl = []

logger.debug(
    "BOT_NAME: {} (indexer if custom settings are loaded okay, scrapybot if not)".format(
        settings.get("BOT_NAME")
    )
)

# Setup env variables from indexer.settings
db_name = settings.get("DB_NAME")

db_user = settings.get("DB_USER")

db_host = settings.get("DB_HOST")
db_password = settings.get("DB_PASSWORD")


# SELECT urls for indexing
sql_select_domains_to_index = "SELECT url FROM tbllinks ORDER BY id LIMIT 1"
# if 'TEST_SITES_NUM' in os.environ:
#    sql_select_domains_to_index = f"SELECT url FROM tbllinks ORDER BY id LIMIT {os.environ['TEST_SITES_NUM']}"   # limit in test env

# MAIN INDEXING JOB
# Read blog links from database, and save to self variables

logger.info("Checking for sites to index")

logger.debug("Reading from database {}".format(db_name))

try:
    conn = psycopg2.connect(
        dbname="hnblogsdb", user="postgres", host="db", password="xyz"
    )
    logger.info("Connection to db succeeded")
    cursor = conn.cursor(
        cursor_factory=psycopg2.extras.DictCursor
    )  # column names are keys

    cursor.execute(sql_select_domains_to_index)
    results = cursor.fetchall()
    for result in results:
        site = {}
        site["home_page"] = result["url"]
        site["domain"] = (site["home_page"].split("://")[-1]).split("/")[
            0
        ]  # https://lol.ex.xyz/page/1 -> lol.ex.xyz

        sites_to_crawl.append(site)

except psycopg2.Error as e:
    logger.error("psycopg2 error %s" % e.pgerror)
    logger.error("db connection isn't available")
finally:
    conn.close() ####   NOT GOOD CODE!

if sites_to_crawl:
    logger.info("sites_to_crawl: {}".format(sites_to_crawl))


# Define helper *once* for all sites
typesense_helper = TypesenseHelper(
    "hnblogs_index_alias",  #  alias
    "hnblogs_index_1",
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
    logger.info("Starting indexing")
    process.start()  # hang till done
    process.stop()

    # After the crawling and indexing of the new collection is over, update the alias to use the new collection.
    typesense_helper.commit_collection()

    logger.info("Completed indexing")
