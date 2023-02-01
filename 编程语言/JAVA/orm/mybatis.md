# mybatis


## @MapperScane和@Mapper

从mybatis3.4.0开始加入了@Mapper注解，目的就是为了不再写mapper映射文件.

@MapperScan和@Mapper简介

在不使用@MapperScan前，我们需要直接在Mapper类上面添加注解@Mapper，这种方式要求每一个Mapper类都需要添加此注解，非常麻烦，属于重复劳动。通过使用@MapperScan注解，可以让我们不用为每个Mapper类都添加@Mapper注解。

http://www.mybatis.cn/archives/862.html

https://mapperhelper.github.io/docs/


## @Param 注解的用法解析

复杂类型，使用注解传递参数，不需要设置 parameterType
创建接口，使用注解传递多个参数进行查询

```java
public List<Users> getUsers(@Param("name") String name, @Param("age") int age);

<select id="selectUsers" resultType="User">
  select id, username, password
  from users
  where id = #{id} and age = #{age}
</select>
```

这种方式不需要设置参数类型 ，参数名称为注解定义的名称。这种方式能够大大提高可读性，但是只适合参数较少的情况，一般是少于5个用此方法

使用@Param注解则可以使用多个参数，无需再设置parameterType，并且在查询语句中使用时可以使用#{}或者${};

http://www.mybatis.cn/archives/920.html


## mybatis 批量插入删除操作

```java
<insert id="insert" parameterType="java.util.List">
        INSERT INTO games (
        id,
        game_id,
        game_vendor,
        game_code,
        game_name,
        game_type)
        VALUES
        <foreach collection="list" item="element" index="index" open="(" separator="),("  close=")">
            #{element.id},
            #{element.gameId},
            #{element.gameVendor},
            #{element.gameCode},
            #{element.gameName},
            #{element.gameType},
       </foreach>
    </insert>
</mapper>
```

对于foreach标签的解释参考了网上的资料，具体如下：
foreach的主要用在构建in条件中，它可以在SQL语句中进行迭代一个集合。
foreach元素的属性主要有 item，index，collection，open，separator，close。
item表示集合中每一个元素进行迭代时的别名，index指定一个名字，用于表示在迭代过程中，每次迭代到的位置，open表示该语句以什么开始，separator表示在每次进行迭代之间以什么符号作为分隔 符，close表示以什么结束，在使用foreach的时候最关键的也是最容易出错的就是collection属性，该属性是必须指定的，但是在不同情况 下，该属性的值是不一样的，主要有一下3种情况：

1. 如果传入的是单参数且参数类型是一个List的时候，collection属性值为list
2. 如果传入的是单参数且参数类型是一个array数组的时候，collection的属性值为array
3. 如果传入的参数是多个的时候，我们就需要把它们封装成一个Map了，当然单参数也可以封装成map


https://stackoverflow.com/questions/17563463/mybatis-insert-list-values


https://978420544.github.io/2017/05/27/Mybatis%E6%89%B9%E9%87%8Finsert%E6%80%BB%E7%BB%93/

## mybatis 中mapper映射文件配置之insert、update、delete

https://www.cnblogs.com/dongying/p/4048828.html


## mybatis配置

https://mp.weixin.qq.com/s/0_zTBooRV4RTWQa8VOwiWg


## Mybatis 插件机制  Interceptor

https://segmentfault.com/a/1190000040485072
