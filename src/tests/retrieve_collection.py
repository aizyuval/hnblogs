import typesense

client = typesense.Client(
    {
        'nodes': [{'host': 'localhost', 'port': '8108', 'protocol': 'http'}],
        'api_key': 'abc',
        'connection_timeout_second': 2,
    }
)
#
#
"""
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
"""
print(client.collections['hnblogs_index_1'].retrieve())
