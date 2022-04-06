# sparksql


```sql
select explode(to_json_array(content)) as jsonColumn from newTable as jsonTable;


select explode(from_json(content, 'controls Map, status Map, custom Map')) as jsonColumn from newTable as jsonTable;
```

https://experienceleague.adobe.com/docs/experience-platform/query/sql/spark-sql-functions.html?lang=zh-Hans

https://spark.apache.org/docs/latest/sql-ref-datatypes.html
