# pipelines are like typesense_helper.
# they provide creating, adding and commiting of new records to the overall index meanwhile the crawling process is undergoing.
"""TypesenseHelper
Wrapper on top of the Typesense API client"""

import typesense
from typesense import exceptions
import json
from builtins import range
import os


class TypesenseHelper:
    """TypesenseHelper"""

    def __init__(self, alias_name, collection_name_tmp, custom_settings): # alias_name is the name for global actual index
        self.typesense_client = typesense.Client({
            'api_key': os.environ.get('TYPESENSE_API_KEY', None),
            'nodes': [{
                'host': os.environ.get('TYPESENSE_HOST', None),
                'port': os.environ.get('TYPESENSE_PORT', None),
                'path': os.environ.get('TYPESENSE_PATH', ''),
                'protocol': os.environ.get('TYPESENSE_PROTOCOL', None)
            }],
            'connection_timeout_seconds': 30 * 60
        })
        self.alias_name = alias_name
        self.collection_name_tmp = collection_name_tmp
        self.collection_locale = os.environ.get('TYPESENSE_COLLECTION_LOCALE', 'en')
        self.custom_settings = custom_settings

    def create_tmp_collection(self):
        """Create a temporary index to add records to"""
        try:
            self.typesense_client.collections[self.collection_name_tmp].delete()
        except exceptions.ObjectNotFound:
            pass

        schema = {
            'name': self.collection_name_tmp,
            'fields': [
                {'name': 'anchor', 'type': 'string', 'optional': True},
                {'name': 'content', 'type': 'string', 'locale': self.collection_locale, 'optional': True},
                {'name': 'url', 'type': 'string', 'facet': True},
                {'name': 'url_without_anchor', 'type': 'string', 'facet': True, 'optional': True},
                {'name': 'version', 'type': 'string[]', 'facet': True, 'optional': True},
                {'name': 'hierarchy.lvl0', 'type': 'string', 'facet': True, 'locale': self.collection_locale, 'optional': True},
                {'name': 'hierarchy.lvl1', 'type': 'string', 'facet': True, 'locale': self.collection_locale, 'optional': True},
                {'name': 'hierarchy.lvl2', 'type': 'string', 'facet': True, 'locale': self.collection_locale, 'optional': True},
                {'name': 'hierarchy.lvl3', 'type': 'string', 'facet': True, 'locale': self.collection_locale, 'optional': True},
                {'name': 'hierarchy.lvl4', 'type': 'string', 'facet': True, 'locale': self.collection_locale, 'optional': True},
                {'name': 'hierarchy.lvl5', 'type': 'string', 'facet': True, 'locale': self.collection_locale, 'optional': True},
                {'name': 'hierarchy.lvl6', 'type': 'string', 'facet': True, 'locale': self.collection_locale, 'optional': True},
                {'name': 'type', 'type': 'string', 'facet': True, 'locale': self.collection_locale, 'optional': True},
                {'name': '.*_tag', 'type': 'string', 'facet': True, 'locale': self.collection_locale, 'optional': True},
                {'name': 'language', 'type': 'string', 'facet': True, 'optional': True},
                {'name': 'tags', 'type': 'string[]', 'facet': True, 'locale': self.collection_locale, 'optional': True},
                {'name': 'item_priority', 'type': 'int64'},
            ],
            'default_sorting_field': 'item_priority',
            'token_separators': ['_', '-']
        }

        if self.custom_settings is not None:
            token_separators = self.custom_settings.get('token_separators', None)
            if token_separators is not None:
                schema['token_separators'] = token_separators

            symbols_to_index = self.custom_settings.get('symbols_to_index', None)
            if symbols_to_index is not None:
                schema['symbols_to_index'] = symbols_to_index

            field_definitions = self.custom_settings.get('field_definitions', None)
            if field_definitions is not None:
                schema['fields'] = field_definitions

        self.typesense_client.collections.create(schema)

    def add_records(self, records, url, from_sitemap):
        """Add new records to the temporary index"""
        transformed_records = list(map(TypesenseHelper.transform_record, records))
        record_count = len(transformed_records)

        for i in range(0, record_count, 50):
            result = self.typesense_client.collections[self.collection_name_tmp].documents.import_(
                transformed_records[i:i + 50])
            failed_items = list(
                map(lambda r: json.loads(json.loads(r)),
                    filter(lambda r: json.loads(json.loads(r))['success'] is False, result)))
            if len(failed_items) > 0:
                print(failed_items)
                raise Exception

        color = "96" if from_sitemap else "94"

        print(
            '\033[{}m> DocSearch: \033[0m{}\033[93m {} records\033[0m)'.format(
                color, url, record_count))

    def commit_tmp_collection(self):
        """Update alias to point to new collection"""
        old_collection_name = None

        try:
            old_collection_name = self.typesense_client.aliases[self.alias_name].retrieve()['collection_name']
        except exceptions.ObjectNotFound:
            pass

        self.typesense_client.aliases.upsert(self.alias_name, {'collection_name': self.collection_name_tmp})

        if old_collection_name:
            self.typesense_client.collections[old_collection_name].delete()

    @staticmethod
    def transform_record(record):
        transformed_record = {k: v for k, v in record.items() if v is not None}
        transformed_record['item_priority'] = transformed_record['weight']['page_rank'] * 1000000000 + \
                                              transformed_record['weight']['level'] * 1000 + \
                                              transformed_record['weight']['position_descending']

        # Flatten nested hierarchy field
        for x in range(0, 7):
            if record['hierarchy'][f'lvl{x}'] is None:
                continue
            transformed_record[f'hierarchy.lvl{x}'] = record['hierarchy'][f'lvl{x}']

        # Convert version to array
        if 'version' in record and type(record['version']) == str:
            transformed_record['version'] = record['version'].split(',')

        return transformed_record










############################3 PIPELINES
import pysolr
from scrapy.utils.log import configure_logging
from scrapy.exceptions import DropItem
import re
from scrapy.utils.log import configure_logging
from scrapy.utils.project import get_project_settings
import logging
from common.utils import update_indexing_status, get_last_complete_indexing_log_message, deactivate_indexing, web_feed_and_sitemap, convert_datetime_to_utc_date, send_email


# This is the Solr pipeline, for submitting indexed items to Solr
# It originally just did a self.solr.add(dict(item)) in process_item 
# and self.solr.commit() in close_spider because a commit on every add was slow.
# However, it now builds a list of dicts and only connects to Solr on the close_spider.
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

class TypesensePypline:

    def __init__(self, stats, solr_url):
        self.solr_url = solr_url
        self.items = [] # store all items
        configure_logging()
        self.logger = logging.getLogger()
        self.stats = stats

    @classmethod
    def from_crawler(cls, crawler):
        logfile = getattr(crawler.spider
        return cls(
            solr_url = crawler.settings.get('SOLR_URL'),
            stats = crawler.stats
            logfile = crawler.settings.set('LOG_FILE',
        )

    def open_spider(self, spider):
        # instantiate conntection to typesense
        self.solr = pysolr.Solr(self.solr_url) # always_commit=False by default
        return

    # close_spider is run for each site at the end of the spidering process
    # Depending on the type of index (full or incremental) and the outcome
    # - If it is a full reindex, but zero documents have been found, that suggests an error somewhere, e.g. site unavailable.
    #   If that happens twice in a row, that suggests a more permanent error, so indexing for the site is deactivated.
    # - If it is a full reindex, but documents are found, get all the site specific data which is set on the home page,
    #   and clean out the existing index for that site.
    # - If it is an incremental reindex, don't delete the existing docs, just add the new ones.
    def close_spider(self, spider):
        no_of_docs = len(self.items)
        if no_of_docs == 0:
            self.logger.warning('No documents found at start urls {} (domain {}). This is likely an error with the site or with this system.'.format(spider.start_urls, spider.domain))
            if self.stats.get_value('robotstxt/forbidden'):
                submessage = 'Likely robots.txt forbidden. '
            elif self.stats.get_value('retry/max_reached'):
                submessage = 'Likely site timeout. '
            message = message + submessage + 'robotstxt/forbidden {}, retry/max_reached {}'.format(self.stats.get_value('robotstxt/forbidden'), self.stats.get_value('retry/max_reached'))
            self.logger.error('No documents found with message: {}'.format.(messsage))
        else:
            self.logger.info('Submitting {} newly spidered docs to Typesense for {}.'.format(str(no_of_docs), spider.domain))

            # add the items 
            for item in self.items:
                self.solr.add(dict(item))

            # Save changes
            self.solr.commit()
            message = 'SUCCESS: {} documents found. '.format(self.stats.get_value('item_scraped_count'))
            if self.stats.get_value('log_count/WARNING'):
                message = message + 'log_count/WARNING: {} '.format(self.stats.get_value('log_count/WARNING'))
            if self.stats.get_value('log_count/ERROR'):
                message = message + 'log_count/ERROR: {} '.format(self.stats.get_value('log_count/ERROR'))
        self.logger.info('For domain:{}, COMPLETE, and mes: {}'.format(spider.domain,message))

    def process_item(self, item, spider):
        new_url = item['url']
        # Strip out the trailing slashes of the new for a fairer comparison
        # so e.g. https://michael-lewis.com/ and https://michael-lewis.com get treated as duplicates
        #if new_url.endswith('/'): new_url = new_url[:-1]
        if 'title' in item: new_title = item['title']
        add = True
        for i in self.items:
            existing_url = i['url'] # last url
            if 'title' in i: existing_title = i['title']
            # if new_url is the same as existing_url (this shouldn't happen because of built-in deduplication) or
            # if new_url without www. is the same as an existing_url or vice versa (which could happen because the built-in deduplication doesn't catch this)
            if new_url == existing_url or re.sub("www\.", "", new_url, 1) == existing_url or re.sub("www\.", "", existing_url, 1) == new_url:
                # double check with title, to increase chance of it being a genuine duplicate
                # could put more checks, e.g. keywords, but not sure about last_modified_date in case that is dynamic
                if new_title == existing_title:
                    add = False
                    self.logger.info("Not going to add {} because it is a duplicate of {}".format(new_url, existing_url))
        if add == True:
            self.logger.debug("Adding {}".format(new_url))
            self.items.append(dict(item))
            return item
        else:
            raise DropItem("Duplicate: {}".format(new_url))
