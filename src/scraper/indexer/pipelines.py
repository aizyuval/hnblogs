# they provide creating, adding and commiting of new records to the overall index meanwhile the crawling process is undergoing.

import typesense
from typesense import exceptions
import json
from builtins import range

# from typesense_helper import TypesenseHelper
from scrapy.utils.log import configure_logging
from scrapy.exceptions import DropItem
import re
from scrapy.utils.project import get_project_settings
import logging


#
# Notes on deduplication:
# If I start indexing https://michael-lewis.com/ from https://www.michael-lewis.com/
# I get the following duplicated entries:
# https://www.michael-lewis.com/ and https://michael-lewis.com/
# And if I index http://www.paulgraham.com/ I get duplicates for most of the pages, e.g.
# http://www.paulgraham.com/airbnb.html and http://paulgraham.com/airbnb.html
# The recommended way of doing deduplication according to https://docs.scrapy.org/en/latest/topics/settings.html#dupefilter-class
# is to do a DUPEFILTER_CLASS = 'indexer.custom_filters.SearchMySiteDupeFilter' and class SearchMySiteDupeFilter(RFPDupeFilter)
# in custom_filters.py (at the same level as settings.py) extending request_fingerprint.
# However, only the request object is available, and that makes a fingerprint of the request.url
# e.g. with w3lib.url.canonicalize_url, but (i) you can't reliably remove the www. from all pages
# (a workaround could be to remove the whole domain and fingerprint on the path, but that would break
# if there were ever sites like blog.domain.com and news.domain.com), and (ii) I don't think you can
# access previous request.urls for comparison.


class TypesensePipeline:
    def __init__(self, stats):
        self.items = []   # store all items
        # configure_logging() # is configure_logging no necessary as it is
        self.logger = logging.getLogger()
        self.stats = stats

    @classmethod
    def from_crawler(cls, crawler):
        return cls(stats=crawler.stats)

    def open_spider(self, spider):
        self.typesense_helper = spider.typesense_helper
        self.typesense_helper.create_collection()
        return

    # close_spider is run for each site at the end of the spidering process
    def close_spider(self, spider):
        no_of_docs = len(self.items)
        if no_of_docs == 0:
            self.logger.warning(
                'No documents found at start urls {} (domain {}). This is likely an error with the site or with this system.'.format(
                    spider.start_urls, spider.domain
                )
            )
            if self.stats.get_value('robotstxt/forbidden'):
                submessage = 'Likely robots.txt forbidden. '
            elif self.stats.get_value('retry/max_reached'):
                submessage = 'Likely site timeout. '
            message = (
                message
                + submessage
                + 'robotstxt/forbidden {}, retry/max_reached {}'.format(
                    self.stats.get_value('robotstxt/forbidden'),
                    self.stats.get_value('retry/max_reached'),
                )
            )
            self.logger.error(
                'No documents found with message: {}'.format(messsage)
            )
        else:
            self.logger.info(
                'Submitting {} newly spidered docs to Typesense for {}.'.format(
                    str(no_of_docs), spider.domain
                )
            )

            # sequentially add the items to the TEMPORARY COLLECTION
            self.typesense_helper.add_records(self.items, no_of_docs)

            message = 'SUCCESS: {} documents found. '.format(
                self.stats.get_value('item_scraped_count')
            )
            if self.stats.get_value('log_count/WARNING'):
                message = message + 'log_count/WARNING: {} '.format(
                    self.stats.get_value('log_count/WARNING')
                )
            if self.stats.get_value('log_count/ERROR'):
                message = message + 'log_count/ERROR: {} '.format(
                    self.stats.get_value('log_count/ERROR')
                )

        self.logger.info(
            'For domain:{}, COMPLETE, and message: {}'.format(
                spider.domain, message
            )
        )

    def process_item(self, item, spider):
        # checking for duplicates and then appending to items (that will be commited at the end)
        # Checking for existing urls in items list and if they:
        # (a) Exactly match the new url
        # or
        # (b) Match when adding www. prefix to the url/new url.
        # In both cases the item is dropped and considered as duplicate.
        new_url = item['url']

        if 'title' in item:
            new_title = item['title']
        add = True
        for i in self.items:
            existing_url = i['url']
            if 'title' in i:
                existing_title = i['title']
            # if new_url is the same as existing_url (this shouldn't happen because of built-in deduplication) or
            # if new_url without www. is the same as an existing_url or vice versa (which could happen because the built-in deduplication doesn't catch this)
            if (
                new_url == existing_url
                or re.sub('www\.', '', new_url, 1) == existing_url
                or re.sub('www\.', '', existing_url, 1) == new_url
            ):
                # double check with title, to increase chance of it being a genuine duplicate
                if new_title == existing_title:
                    add = False
                    self.logger.info(
                        'Not going to add {} because it is a duplicate of {}'.format(
                            new_url, existing_url
                        )
                    )
        if add == True:
            self.logger.debug('Adding {}'.format(new_url))
            self.items.append(dict(item))
            return item
        else:
            raise DropItem('Duplicate: {}'.format(new_url))
