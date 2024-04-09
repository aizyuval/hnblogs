

data directory, where the sql and typesense data are persisted, need to be set up locally.


Note for improvement: configure_logging() might be obsolete for the entire project because:
(a) I'm using CrawlerProcess, and this class configures the root logger by default.
(b) Even If I wasn't, I could've configured it once, and then pull in the other modules from the root logger. So in every other module onlly getLogger is needed.
