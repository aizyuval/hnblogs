FROM typesense/typesense:0.25.2

ARG env
RUN if [ "$env" = "test" ] ; then mkdir /tmp/data ; fi

# create collection on the node
RUN /bin/sh -c 'apt-get -y update && apt-get -y install curl'

# Make create_collection the initial command to run
COPY create_collection.sh /usr/local/bin
RUN chmod +rx /usr/local/bin/create_collection.sh
#CMD ["/bin/sh", "-c", "/usr/local/bin/create_collection.sh"]
CMD echo hello > /tmp/whmi
