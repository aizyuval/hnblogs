#response = $(curl http://localhost:8108/collections)
#if ["$response" -eq 200]; then
#url is not marked index:false because then it would not be mandatory
curl "http://localhost:8108/collections" \
      -X POST \
      -H "Content-Type: application/json" \
      -H "X-TYPESENSE-API-KEY: abc" -d '{ 
	    "name": "hnblogs", 
	    "fields": [ 
	    { "name": "title", "type": "string" }, 
	    { "name": "content", "type": "string" }, 
	    { "name": "domain", "type": "string", "facet": true }, 
	    { "name": "page-type", "type": "string"}, 
	    { "name": "description", "type": "string", "optional": true }, 
	    { "name": "anchor", "type": "string", "optional": true }, 
	    { "name": "language", "type": "string", "optional": true }, 
	    { "name": "url", "type": "string" }, 
	    { "name": "content-type", "type": "string", "index": false, "optional": true}, 
	    { "name": "page_last_modified", "type": "int64", "facet": true }, 
	    { "name": "indexed_date", "type": "int64", "optional": true,"index": false, "optional": true }
 
	    ], 
 
	    "token_separators": ["_", "-"] 
      }'
#fi




