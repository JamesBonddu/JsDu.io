## mongodb fork 不是安全的

```sh
/home/jsdu/.local/share/virtualenvs/bdp_backup-KvSb1zsF/lib/python3.6/site-packages/pymongo/topology.py:149: UserWarning: MongoClient opened before fork. Create MongoClient only after forking. See PyMongo's documentation for details: http://api.mongodb.org/python/current/faq.html#is-pymongo-fork-safe
  "MongoClient opened before fork. Create MongoClient only "

/home/jsdu/.local/share/virtualenvs/bdp_backup-KvSb1zsF/lib/python3.6/site-packages/pymongo/topology.py:149: UserWarning: MongoClient opened before fork. Create MongoClient only after forking. See PyMongo's documentation for details: http://api.mongodb.org/python/current/faq.html#is-pymongo-fork-safe
  "MongoClient opened before fork. Create MongoClient only "
```

## mongodb 导入导出

```sh
mongodump -d <database_name> -o <directory_backup>

mongoexport --collection events --db reporting --out events.json
```

https://stackoverflow.com/questions/11255630/how-to-export-all-collections-in-mongodb

https://docs.mongodb.com/manual/reference/program/mongoexport/


mongoexport --collection bigfile --db bdp_backup --out ~/bigfile.json

db.bigfile.update({
    'tb_id': 'tb_8c181e3715fb4358bb45d97f989db393'
}, {'$set': {
    'edate': [],
    'sdate': [],
}})


db.version_update.update({'package': 'com.run.workout.music'}, {'$set': {
    'last_version': '2.13',
}})
