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

## mysql Insert ignore into,insert into on duplicate,replace into

整体上我分为两个大的部分，会分别测试这三种数据写入场景。

> 第一部分基于id,name的数据列，其中id为主键，自增

这三种场景的结果从自增列的处理方式来看是完全对等的，但是对于重复数据的处理方式还是存在差异。

相比而言，**replace into**和**insert into on duplicate**存在本质的区别，**replace into**是覆盖写，即删除原来的，写入新的。不光是主键列，其他列也会保持一致

**insert into on duplicate**则可以根据自己的需求来定制重复数据的处理策略，不会主动改变数据。

**insert ignore into** 在这种场景下最为通用，而且对于数据的侵入性最小。

所以如果要保证源端的数据基于主键完全一致，不管非主键列的数据是否一致，都需要完全覆盖，选择**replace into**是一种好的方法。

否则采用**insert into on duplcate**或者**insert ignore into**

> 第二部分基于id,xid,name的数据列，其中id为主键，自增，xid为唯一性索引

**insert ignore into**如果不指定自增列，尽管没有写入数据，但是自增列依然会自增

**replace into**如果不指定自增列，会看到数据重新写入的效果已经非常明显，而且自增列始终会自动维护。

**insert into on duplicate**对于重复数据依然会消耗自增列值，实现相对更加灵活。

https://mp.weixin.qq.com/s/T4sXXPn-9rXSSag0hP9zwg


## mysql 死锁

```mysql
mysql> show variables like '%innodb%lock%timeout%';
+--------------------------+-------+
| Variable_name            | Value |
+--------------------------+-------+
| innodb_lock_wait_timeout | 50    |
+--------------------------+-------+
1 row in set (0.01 sec)

mysql> show variables like '%innodb%deadlock%';
+----------------------------+-------+
| Variable_name              | Value |
+----------------------------+-------+
| innodb_print_all_deadlocks | OFF   |
+----------------------------+-------+
1 row in set (0.02 sec)
```

InnoDb 的监控主要分为四种：标准监控（Standard InnoDB Monitor）、锁监控（InnoDB Lock Monitor）、表空间监控（InnoDB Tablespace Monitor）和表监控（InnoDB Table Monitor）。后两种监控已经基本上废弃了，关于各种监控的作用可以参考 MySQL 的官方文档 Enabling InnoDB Monitors [https://dev.mysql.com/doc/refman/5.6/en/innodb-enabling-monitors.html] 或者 [http://yeshaoting.cn/article/database/%E5%BC%80%E5%90%AFInnoDB%E7%9B%91%E6%8E%A7/] 这篇文章.

常见锁的类型:
- 记录锁（LOCK_REC_NOT_GAP）: lock_mode X locks rec but not gap
- 间隙锁（LOCK_GAP）: lock_mode X locks gap before rec
- Next-key 锁（LOCK_ORNIDARY）: lock_mode X
- 插入意向锁（LOCK_INSERT_INTENTION）: lock_mode X locks gap before rec insert intention

https://ketao1989.github.io/2014/10/09/Mysql-Delete-Insert-Deadlock-Analyse/

https://juejin.im/post/5d04b33e6fb9a07ee1692653

https://leokongwq.github.io/2017/07/06/mysql-deadlock-detection.html

https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html

https://www.aneasystone.com/archives/2018/04/solving-dead-locks-four.html

<<<<<<< HEAD
# 使用技巧

```sql
-- 百分比方法
select 1.234, concat(1.234 * 100, '%');
-- 避免分母为0
SELECT 
    COUNT(*) AS 人口总数,
    SUM(CASE  WHEN sex = 0 THEN 1 ELSE 0 END) AS 男人数 , 
    CAST(CAST(100.0 * SUM(CASE  WHEN sex = 0 THEN 1 ELSE 0 END) / COUNT(*) AS decimal(18, 2)) AS varchar(5)) OR '%' AS 男所占比例, 
    SUM(CASE  WHEN sex = 1 THEN 1 ELSE 0 END) AS 女人数 ,
    CAST(CAST(100.0 * SUM(CASE  WHEN sex = 1 THEN 1 ELSE 0 END) / COUNT(*) AS decimal(18, 2)) AS varchar(5)) OR '%' AS 女所占比例 
FROM people
```

https://www.cnblogs.com/seanyan/p/9496124.html
https://blog.csdn.net/jiaolongdy/java/article/details/87701520

# full group by

使用ANY_VAlUE解决
```shell script
ession #2 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'xxx' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by"
```

# datetime to date转换
```sql
SELECT CAST(orders.date_purchased AS DATE) AS DATE_PURCHASED
```
https://stackoverflow.com/questions/4740612/query-to-convert-from-datetime-to-date-mysql
 
# exists 替换 in

```shell script

```
https://www.cnblogs.com/V1haoge/p/6385312.html
 

# SQL 横表 纵表转换

https://blog.csdn.net/u014236541/article/details/54912907

# mysql 获取当前记录的上下条记录

如果ID是主键或者有索引，可以直接查找：
方法1：


1.select * from table_a where id = (select id from table_a where id < {$id} order by id desc limit 1); 
2.select * from table_a where id = (select id from table_a where id > {$id} order by id asc limit 1);

方法2：

1.select * from table_a where id = (select max(id) from table_a where id < {$id}); 
2.select * from table_a where id = (select min(id) from table_a where id > {$id});

https://blog.csdn.net/rorntuck7/article/details/50699409
=======

## 放置数据重复读写

参考:

https://cloud.tencent.com/developer/news/458227

https://juejin.im/post/5d7108abe51d453b753a1b37
>>>>>>> c2a1203da667ebeb9f0cd68b9a536f88b9e69f7c
