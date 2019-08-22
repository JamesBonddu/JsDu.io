## mysql初始化和配置

sudo /etc/init.d/mysql restart

https://serverfault.com/questions/361614/mysqld-unrecognized-service



## Mysql

SCHEMATA表：提供了关于数据库的信息。

TABLES表：给出了关于数据库中的表的信息。

COLUMNS表：给出了表中的列信息。

STATISTICS表：给出了关于表索引的信息。

USER_PRIVILEGES表：给出了关于全程权限的信息。该信息源自mysql.user授权表。

SCHEMA_PRIVILEGES表：给出了关于方案（数据库）权限的信息。该信息来自mysql.db授权表。

TABLE_PRIVILEGES表：给出了关于表权限的信息。该信息源自mysql.tables_priv授权表。

COLUMN_PRIVILEGES表：给出了关于列权限的信息。该信息源自mysql.columns_priv授权表。

CHARACTER_SETS表：提供了关于可用字符集的信息。

COLLATIONS表：提供了关于各字符集的对照信息。

COLLATION_CHARACTER_SET_APPLICABILITY表：指明了可用于校对的字符集。

TABLE_CONSTRAINTS表：描述了存在约束的表。

KEY_COLUMN_USAGE表：描述了具有约束的键列。

ROUTINES表：提供了关于存储子程序（存储程序和函数）的信息。此时，ROUTINES表不包含自定义函数（UDF）。

VIEWS表：给出了关于数据库中的视图的信息。

TRIGGERS表：提供了关于触发程序的信息。

参考:

https://stackoverflow.com/questions/13085655/search-of-table-names


## mysql 导入数据文件

show databases;
show tables;

show columns from tablename;
show index from tablename;

sudo mysql -u root -p < sql_file.sql

https://www.cnblogs.com/yuwensong/p/3955834.html

https://dev.mysql.com/doc/


## 查看指定库的指定表的大小

```sql
select concat(round(sum(DATA_LENGTH/1024/1024),2),'MB') as data  from TABLES where table_schema='db_name' and table_name like 'xxx_%';
```

## 查看指定库的大小

```sql
select concat(round(sum(DATA_LENGTH/1024/1024),2),'MB') as data  from TABLES where table_schema='db_name';
```

## 导出多个表

```sh
mysqldump db tb1 tb2 > path
```

[导入导出sql数据] (https://stackoverflow.com/questions/11407349/how-to-export-and-import-a-sql-file-from-command-line-with-options)

## like 查询

['like % 查询'] (https://dataedo.com/kb/query/mysql/find-tables-which-names-start-with-specific-prefix)
