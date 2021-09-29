# hive

Hive 是一个构建在 Hadoop 之上的数据仓库，它可以将结构化的数据文件映射成表，并提供类 SQL 查询功能，用于查询的 SQL 语句会被转化为 MapReduce 作业，然后提交到 Hadoop 上运行。

Hive 在执行一条 HQL 的时候，会经过以下步骤：

语法解析：Antlr 定义 SQL 的语法规则，完成 SQL 词法，语法解析，将 SQL 转化为抽象 语法树 AST Tree；
语义解析：遍历 AST Tree，抽象出查询的基本组成单元 QueryBlock；
生成逻辑执行计划：遍历 QueryBlock，翻译为执行操作树 OperatorTree；
优化逻辑执行计划：逻辑层优化器进行 OperatorTree 变换，合并不必要的 ReduceSinkOperator，减少 shuffle 数据量；
生成物理执行计划：遍历 OperatorTree，翻译为 MapReduce 任务；
优化物理执行计划：物理层优化器进行 MapReduce 任务的变换，生成最终的执行计划。

Hive 的核心是驱动引擎， 驱动引擎由四部分组成：

- 解释器：解释器的作用是将 HiveSQL 语句转换为抽象语法树（AST）

- 编译器：编译器是将语法树编译为逻辑执行计划

- 优化器：优化器是对逻辑执行计划进行优化

- 执行器：执行器是调用底层的运行框架执行逻辑执行计划


元数据，通俗的讲，就是存储在 Hive 中的数据的描述信息。

　　Hive 中的元数据通常包括：表的名字，表的列和分区及其属性，表的属性（内部表和 外部表），表的数据所在目录

　　Metastore 默认存在自带的 Derby 数据库中。缺点就是不适合多用户操作，并且数据存 储目录不固定。数据库跟着 Hive 走，极度不方便管理

　　解决方案：通常存我们自己创建的 MySQL 库（本地 或 远程）

　　Hive 和 MySQL 之间通过 MetaStore 服务交互


https://tech.meituan.com/2014/02/12/hive-sql-to-mapreduce.html

https://www.cnblogs.com/qingyunzong/p/8707885.html

# hive 启动

https://blog.csdn.net/lblblblblzdx/article/details/79760959

# hive 查询语句


https://github.com/heibaiying/BigData-Notes/blob/master/notes/Hive%E6%95%B0%E6%8D%AE%E6%9F%A5%E8%AF%A2%E8%AF%A6%E8%A7%A3.md