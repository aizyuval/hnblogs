"""TypesenseHelper
Wrapper on top of the Typesense API client"""

import typesense
from typesense import exceptions
import json
from builtins import range
import os


class TypesenseHelper:
    """TypesenseHelper"""

    def __init__(
        self, alias_name, collection_name_tmp, custom_settings
    ):   # alias_name is the name for global actual index
        self.typesense_client = typesense.Client(
            {
                'api_key': os.environ.get('TYPESENSE_API_KEY', None),
                'nodes': [
                    {
                        'host': os.environ.get('TYPESENSE_HOST', None),
                        'port': os.environ.get('TYPESENSE_PORT', None),
                        'path': os.environ.get('TYPESENSE_PATH', ''),
                        'protocol': os.environ.get('TYPESENSE_PROTOCOL', None),
                    }
                ],
                'connection_timeout_seconds': 30 * 60,
            }
        )
        self.alias_name = alias_name
        self.collection_name_tmp = collection_name_tmp
        self.collection_locale = os.environ.get(
            'TYPESENSE_COLLECTION_LOCALE', 'en'
        )
        self.custom_settings = custom_settings

    def create_tmp_collection(self):
        """Create a temporary index to add records to"""
        # if one already exists with that name, delete it
        try:
            self.typesense_client.collections[
                self.collection_name_tmp
            ].delete()
        except exceptions.ObjectNotFound:
            pass

        schema = {
            'name': 'hnblogs',
            'fields': [
                {'name': 'title', 'type': 'string'},
                {'name': 'content', 'type': 'string'},
                {'name': 'domain', 'type': 'string', 'facet': true},
                {'name': 'page-type', 'type': 'string'},
                {'name': 'description', 'type': 'string', 'optional': true},
                {'name': 'anchor', 'type': 'string', 'optional': true},
                {'name': 'language', 'type': 'string', 'optional': true},
                {'name': 'url', 'type': 'string'},
                {
                    'name': 'content-type',
                    'type': 'string',
                    'index': false,
                    'optional': true,
                },
                {'name': 'page_last_modified', 'type': 'int64', 'facet': true},
                {
                    'name': 'indexed_date',
                    'type': 'int64',
                    'optional': true,
                    'index': false,
                    'optional': true,
                },
            ],
            'token_separators': ['_', '-'],
        }

        self.typesense_client.collections.create(schema)

    def add_records(self, records, record_count):
        """Add all the records to the temporary index"""

        for i in range(0, record_count, 50):
            result = self.typesense_client.collections[
                self.collection_name_tmp
            ].documents.import_(records[i : i + 50])
            failed_items = list(
                map(
                    lambda r: json.loads(json.loads(r)),
                    filter(
                        lambda r: json.loads(json.loads(r))['success']
                        is False,
                        result,
                    ),
                )
            )
            if len(failed_items) > 0:
                print(failed_items)
                raise Exception

    def commit_tmp_collection(self):
        """Update alias to point to new collection"""
        old_collection_name = None

        try:
            old_collection_name = self.typesense_client.aliases[
                self.alias_name
            ].retrieve()['collection_name']
        except exceptions.ObjectNotFound:
            pass

        self.typesense_client.aliases.upsert(
            self.alias_name, {'collection_name': self.collection_name_tmp}
        )

        if old_collection_name:
            self.typesense_client.collections[old_collection_name].delete()
