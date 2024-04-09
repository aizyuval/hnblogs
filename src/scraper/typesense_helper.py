"""TypesenseHelper
Wrapper on top of the typesense API client"""

import typesense
from typesense import exceptions
import json
from builtins import range
import os
import logging

# This is the typesense helper. This will be utilized to connect and operate with the typesense service.
# As per: https://typesense.org/docs/26.0/api/collection-alias.html#create-or-update-an-alias
# In this helper a collection and an alias are created once for all crawled sites. documents are being imported to the collection in batches, after a crawling of a website ends. At the end, the alias is updated to point to the collection.
# The alias is a convenient way to later be able to switch the collection being used, when the alias changes.
class TypesenseHelper:
    """TypesenseHelper"""

    def __init__(
        self, alias_name, collection_name
    ):   # alias_name is the name for global actual index
        self.typesense_client = typesense.Client(
            {
                'nodes': [
                    {'host': 'typesense', 'port': '8108', 'protocol': 'http'}
                ],
                'api_key': os.environ.get('TYPESENSE_API_KEY'),
                'connection_timeout_seconds': 30 * 60,
            }
        )
        self.alias_name = alias_name
        self.collection_name = collection_name
        self.logger = logging.getLogger()

        try:
            old_collection_name = self.typesense_client.aliases[
                self.alias_name
            ].retrieve()['collection_name']
            self.logger.info(
                'On helper init, retrieved old collection name: {}'.format(
                    old_collection_name
                )
            )
        except exceptions.ObjectNotFound:
            pass

    def create_collection(self):
        """Create a temporary index to add records to"""
        # if one already exists with that name, delete it

        try:
            old_collection_name = self.typesense_client.aliases[
                self.alias_name
            ].retrieve()['collection_name']
            self.logger.info(
                'on open_spider, retrieved old collection name: {}'.format(
                    old_collection_name
                )
            )
        except exceptions.ObjectNotFound:
            pass
        # an id field will also be included by hnblogs_parser as the original url
        schema = {
            'name': self.collection_name,
            'fields': [
                {'name': 'content', 'type': 'string'},
                {'name': 'domain', 'type': 'string', 'facet': True},
                {'name': 'url', 'type': 'string'},
                {'name': 'page_last_modified', 'type': 'int64', 'facet': True},
                {
                    'name': 'indexed_date',
                    'type': 'int64',
                    'facet': True,
                },
                {'name': 'page_type', 'type': 'string', 'optional': True},
                {'name': 'title', 'type': 'string', 'optional': True},
                {'name': 'description', 'type': 'string', 'optional': True},
                {'name': 'anchor', 'type': 'string', 'optional': True},
                {'name': 'language', 'type': 'string', 'optional': True},
                {
                    'name': 'content-type',
                    'type': 'string',
                    'index': False,
                    'optional': True,
                },
            ],
            'token_separators': ['_', '-'],
        }

        # try to create a collection with that name, if one does not exist.
        # although collection names should be unique if an update is desired, like: hnblogsdb1,hnblogsdb1.1 etc. it will be best to validate
        try:
            self.logger.debug(
                'trying to create a new collection with api key: {} and collection name: {} testing that formatting works(abha): {}'.format(
                    os.environ.get('TYPESENSE_API_KEY'),
                    self.collection_name,
                    'abha',
                )
            )
            self.typesense_client.collections.create(schema)
            self.logger.info(
                'Successfully created collection: {}'.format(
                    self.collection_name
                )
            )
        except Exception as e:
            self.logger.info(
                'With api key: {} Couldnt create a collection named: {} With error: {}'.format(
                    os.environ.get('TYPESENSE_API_KEY'),
                    self.collection_name,
                    e,
                )
            )
            pass

    def add_records(self, records, record_count):
        """Add all the records to the temporary index"""
        # records are converted to jsonl by typesense python package, so we don't need to handle this.

        self.logger.info(
            'Adding {} records by batches of 50'.format(record_count)
        )
        for i in range(0, record_count, 50):   # importing in bataches of 50.
            self.logger.info(
                'Adding {}->{} batch of records'.format(i, i + 50)
            )
            result = self.typesense_client.collections[
                self.collection_name
            ].documents.import_(records[i : i + 50])
            self.logger.debug(
                'Importing the following records: {}'.format(
                    records[i : i + 50]
                )
            )

            self.logger.info(
                'Successful import of {}->{} batch of records with message: {}'.format(
                    i, i + 50, result
                )
            )

    def commit_collection(self):
        """Update alias to point to new collection and delete the former"""
        # taking the old_collection_name, and after updating the alias to point to the new collection, we delete the old_collection (pointing to its name)
        old_collection_name = None

        try:
            old_collection_name = self.typesense_client.aliases[
                self.alias_name
            ].retrieve()['collection_name']
            self.logger.info(
                'Retrieved old_collection_name: {}'.format(old_collection_name)
            )
        except exceptions.ObjectNotFound:
            pass

        self.logger.info(
            'Updating alias: {} to point to: {}'.format(
                self.alias_name, self.collection_name
            )
        )

        self.typesense_client.aliases.upsert(
            self.alias_name, {'collection_name': self.collection_name}
        )

        if old_collection_name:
            if old_collection_name != self.collection_name:
                self.logger.info(
                    'Deleting the old collection name: {}'.format(
                        old_collection_name
                    )
                )
                self.typesense_client.collections[old_collection_name].delete()
