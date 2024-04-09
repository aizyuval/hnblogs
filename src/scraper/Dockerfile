# if this is not production, take a few db urls, instead of everything (for testing)
# in the code: if 'TEST_DOCS_NUM' in os.environ: ...
# in the docker compose.test: environment: TEST_DOCS_NUM: 30
FROM python:latest

WORKDIR /usr/src/app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

# docker-compose.yml (env=dev) and docker-compose.test.yml (env=test) have the following:
#    volumes:
#      - "./indexer:/usr/src/app/:ro"
# For prod we need to copy the source files in to that location
COPY ./ /usr/src/app
#ARG env
#RUN if [ "$env" = "prod" ] ; then cp -r /tmp/scraper/* /usr/src/app/ ; fi

ENV ENVIRONMENT $env
#CMD [ "sh", "-c", "/usr/src/app/indexer/run.sh ${ENVIRONMENT}" ]
CMD ["python", "scraper.py"] 
