import datetime

indexed_date = datetime.datetime.now().timestamp()   # unix-time
indexed_date_ok = int(datetime.datetime.now().timestamp())

print(indexed_date, indexed_date_ok)
