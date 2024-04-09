# File that defines the various complementary utilities functions to be used for parsing, scraping, indexing into typesense, etc.

# get_text()


# Convert BeautifulSoup html object to relatively clean plain text
def get_text(html):
    text = html.get_text()
    lines = (line.strip() for line in text.splitlines())
    chunks = (phrase.strip() for line in lines for phrase in line.split('  '))
    text = ' \n '.join(chunk for chunk in chunks if chunk)
    if text == '':
        text = None
    return text
