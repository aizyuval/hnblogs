FROM postgres:alpine3.18

ADD initdb.sql /docker-entrypoint-initdb.d/
# files in the /docker-entrypoint-initdb.d/ are automatically executed by the postgresql container (without us needing to do anything)

# any pre-existing database will be left untouched on container startup

# Dev docker-compose.yml has the following:
#    volumes:
#      - "../data/sqldata:/var/lib/postgresql/data"
# No need to copy this in to the prod image though

