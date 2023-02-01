# 同比环比


```sql
-- 去年
select
year(DATE_SUB(CURDATE(), INTERVAL 1 YEAR)),
sum(`calc_field`) as calc_field
from table_name as last_year_table;

select
year(CURDATE()),
sum(`calc_field`) as calc_field
from table_name as cur_year_table;

select
   last_year_table.calc_field
from last_year_table,
cur_year_table
```


https://blog.csdn.net/qq_45272190/article/details/115675045
https://blog.csdn.net/qq_36654629/article/details/98595763


# postgresql

```sql
-- pg查看表
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';
-- pg查看表结构
SELECT column_name FROM information_schema.columns WHERE table_name ='point_logs';
```
