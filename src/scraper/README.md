
Note:
Because this scraper is dependent on typesense, everytime it will run - the typesense service will be up, and so we can validate that an index schema exists, or create it if it doesn't.

commands:
#RUN /bin/sh -c 'apt-get -y update && apt-get -y install curl'

# Make create_collection the initial command to run
#COPY create_collection.sh /usr/local/bin
#RUN chmod +rx /usr/local/bin/create_collection.sh



--------
What about duplicate filter?
