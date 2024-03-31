curl "http://localhost:8108/collections" \
      -X POST \
      -H "Content-Type: application/json" \
      -H "X-TYPESENSE-API-KEY: ${TYPESENSE_API_KEY}" -d '{ 
	    "name": "hnblogs", 
	    "fields": [ 
	    { "name": "title", "type": "string" }, 
	    { "name": "content", "type": "string" }, 
	    { "name": "domain", "type": "string", "facet": True }, 
	    { "name": "page-type", "type": "string"}, 
	    { "name": "description", "type": "string", "optional": True }, 
	    { "name": "anchor", "type": "string", "optional": True }, 
	    { "name": "language", "type": "string", "optional": True }, 
	    { "name": "url", "type": "string", "index": "False" }, 
	    { "name": "content-type", "type": "string", "index": False}, 
	    { "name": "page_last_modified", "type": "int64", "facet": True, "index": False }, 
	    { "name": "indexed_date", "type": "int64", "optional": True,"index": False }, 
 
	    ], 
 
	    "default_sorting_field": "item_priority", 
	    "token_separators": ["_", "-"] 
      }'


curl http://localhost:8108/collections

