import os

# -*- coding: utf-8 -*-

# Scrapy settings for indexer project
#
# For simplicity, this file contains only settings considered important or
# commonly used. You can find more settings consulting the documentation:
#
#     https://docs.scrapy.org/en/latest/topics/settings.html
#     https://docs.scrapy.org/en/latest/topics/downloader-middleware.html
#     https://docs.scrapy.org/en/latest/topics/spider-middleware.html


BOT_NAME = 'indexer'

SPIDER_MODULES = ['indexer.spiders']
NEWSPIDER_MODULE = 'indexer.spiders'

# hnblogs custom config for database settings
DB_PASSWORD = os.getenv('POSTGRES_PASSWORD')   # (->docker-compose->.env)
DB_NAME = 'hnblogsdb'
DB_USER = 'postgres'
DB_HOST = 'db'


# The following are automatically loaded by scrapy onto the ROOT logger, when calling configure_logging. We will be using the root logger for all modules (and libraries), with these values
LOG_LEVEL = 'INFO'
LOG_FILE = logs

# Searchmysite custom dupe filter
# DUPEFILTER_CLASS = 'indexer.custom_filters.SearchMySiteDupeFilter'

# Crawl responsibly by identifying yourself (and your website) on the user-agent
# USER_AGENT = 'indexer (+http://www.yourdomain.com)'
USER_AGENT = 'Mozilla/5.0 (compatible; HNblogsBot/1.0)'

# Obey robots.txt rules
ROBOTSTXT_OBEY = True

# Configure maximum concurrent requests performed by Scrapy (default: 16)
CONCURRENT_REQUESTS = 16

# Configure a delay for requests for the same website (default: 0)
# DOWNLOAD_DELAY = 0.5

# CONCURRENT_REQUESTS_PER_DOMAIN = 4
# CONCURRENT_REQUESTS_PER_IP = 16

# Default: 180 (seconds)
DOWNLOAD_TIMEOUT = 30

# Need to set this because large files like https://drwho.virtadpt.net/files/OMNI_1987_11.cbr were crashing production
# Can't set it too small though because some RSS feeds are >2.5Mb
# Default: 1073741824 (1024MB)
DOWNLOAD_MAXSIZE = 2097152   # 2Mb

# Default: 33554432 (32MB)
DOWNLOAD_WARNSIZE = 1048576   # 1Mb

# If the spider remains open for more than that number of seconds, it will be automatically closed with the reason closespider_timeout
CLOSESPIDER_TIMEOUT = 1800   # i.e. 30 minutes

REQUEST_FINGERPRINTER_IMPLEMENTATION = '2.7'

# Changing from Last In First Out to First In First Out as per https://docs.scrapy.org/en/latest/faq.html#does-scrapy-crawl-in-breadth-first-or-depth-first-order
# This is because important links like the RSS/Atom feed are often found first but not reached before the indexing page limit
SCHEDULER_DISK_QUEUE = 'scrapy.squeues.PickleFifoDiskQueue'
SCHEDULER_MEMORY_QUEUE = 'scrapy.squeues.FifoMemoryQueue'

# Disable cookies (enabled by default)
# COOKIES_ENABLED = False

# Disable Telnet Console (enabled by default)
# TELNETCONSOLE_ENABLED = False

# Override the default request headers:
# DEFAULT_REQUEST_HEADERS = {
#   'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
#   'Accept-Language': 'en',
# }

# Enable or disable spider middlewares
# See https://docs.scrapy.org/en/latest/topics/spider-middleware.html
# SPIDER_MIDDLEWARES = {
#    'indexer.middlewares.IndexerSpiderMiddleware': 543,
# }

# Enable or disable downloader middlewares
# See https://docs.scrapy.org/en/latest/topics/downloader-middleware.html
# DOWNLOADER_MIDDLEWARES = {
#    'indexer.middlewares.IndexerDownloaderMiddleware': 543,
# }

# Enable or disable extensions
# See https://docs.scrapy.org/en/latest/topics/extensions.html
# EXTENSIONS = {
#    'scrapy.extensions.telnet.TelnetConsole': None,
# }

# Configure item pipelines
# See https://docs.scrapy.org/en/latest/topics/item-pipeline.html
# ITEM_PIPELINES = {
#    'indexer.pipelines.IndexerPipeline': 300,
# }

# Enable and configure the AutoThrottle extension (disabled by default)
# See https://docs.scrapy.org/en/latest/topics/autothrottle.html
# AUTOTHROTTLE_ENABLED = True
# The initial download delay
# AUTOTHROTTLE_START_DELAY = 5
# The maximum download delay to be set in case of high latencies
# AUTOTHROTTLE_MAX_DELAY = 60
# The average number of requests Scrapy should be sending in parallel to
# each remote server
# AUTOTHROTTLE_TARGET_CONCURRENCY = 1.0
# Enable showing throttling stats for every response received:
# AUTOTHROTTLE_DEBUG = False

# Enable and configure HTTP caching (disabled by default)
# See https://docs.scrapy.org/en/latest/topics/downloader-middleware.html#httpcache-middleware-settings
# HTTPCACHE_ENABLED = True
# HTTPCACHE_EXPIRATION_SECS = 0
# HTTPCACHE_DIR = 'httpcache'
# HTTPCACHE_IGNORE_HTTP_CODES = []
# HTTPCACHE_STORAGE = 'scrapy.extensions.httpcache.FilesystemCacheStorage'
