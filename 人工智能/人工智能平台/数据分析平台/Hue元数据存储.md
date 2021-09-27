# hue存储支持的元数据库类型

```python
def coerce_database(database):
  if database == 'mysql':
    return 'django.db.backends.mysql'
  elif database == 'postgres' or database == 'postgresql_psycopg2':
    return 'django.db.backends.postgresql_psycopg2'
  elif database == 'oracle':
    return 'django.db.backends.oracle'
  elif database in ('sqlite', 'sqlite3'):
    return 'django.db.backends.sqlite3'
  else:
    return str(database)
```