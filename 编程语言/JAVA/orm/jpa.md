# Spring Data JPA

对象关系映射ORM（Object-Relation Mapping）是用来将对象和对象之间的关系对应到数据库中表与表之间的关系的一种模式。

ORM框架能够将Java对象映射到关系数据库，能够直接持久化复杂的Java对象。ORM框架的出现，使开发者从数据库编程中解脱出来，把更多的精力放在了业务模型与业务逻辑上。目前比较流行的ORM框架有Hibernate、iBatis、TopLink等。在JPA规范之前，由于没有官方的标准，使得各ORM框架之间的API差别很大，使用了某种ORM框架的系统会严重受制于该ORM的标准。

JPA本身是一个规范，基于此规范实现的产品有：Hibernate, Eclipselink, Toplink, Spring Data JPA, etc.

基于此，Sun引入新的JPA ORM，主要的原因有：
其一，简化现有Java EE和Java SE应用开发工作；
其二，Sun希望整合ORM技术，实现天下归一。
JPA-Java Persistence API的简称，中文名Java持久层API，是JDK 5.0注解或XML描述对象－关系表的映射关系，并将运行期的实体对象持久化到数据库中。
JPA由EJB 3.0软件专家组开发，作为JSR-220实现的一部分。但它又不限于EJB 3.0，你可以在Web应用、甚至桌面应用中使用

## JPA 实体映射到数据库

JPA将实体映射到数据库有两种方法，一种是基于xml文件，一种是基于标注。

> 按照规范命名方法, jpa自动转换层对应的查询sql语句

https://segmentfault.com/a/1190000022308656?utm_source=sf-similar-article

采用标注方法映射的实体Bean，在类的定义中还包含了映射信息，这些映射信息都是通过标注表示的。下面是用户类的实体Bean。
```java
@Entity
@Table(name = "USER")
public class User implements Serializable {
}
```

1. 引入jar包
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
```
2. yml配置
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/mytest
    type: com.alibaba.druid.pool.DruidDataSource
    username: root
    password: root
    driver-class-name: com.mysql.jdbc.Driver //驱动

######
####配置JPA
####从上往下依次数据源mysql、显示ddl语句、自动执行ddl语句（更新、创建或者销毁、创建）
####最后两句表示自动在数据库创建实体的表
######
  jpa:
    database: mysql
    hibernate:
      ddl-auto: update //自动更新
    show-sql: true  //日志中显示sql语句
```

3. 实体类
```java
@Entity
@Getter
@Setter
@Table(name = "person")
public class Person {

    @Id
    @GeneratedValue
    private Long id;

    @Column(name = "name", length = 20)
    private String name;

    @Column(name = "agee", length = 4)
    private int age;
}
```

4. Repository接口

```java
public interface PersonRepository extends JpaRepository<Person, Long> {
}

// jpa有一个方法可以实现复杂的查询
public interface JpaSpecificationExecutor<T> {

    T findOne(Specification<T> spec);

    List<T> findAll(Specification<T> spec);

    Page<T> findAll(Specification<T> spec, Pageable pageable);

    List<T> findAll(Specification<T> spec, Sort sort);

    long count(Specification<T> spec);
}

public interface Specification<T> {

    Predicate toPredicate(Root<T> root, CriteriaQuery<?> query, CriteriaBuilder cb);
}

```

service 方法众实现分页和排序

```java
// 在UserRepository对象中添加新方法
Page<User> findAll(Pageable pageable);
// 排序,在UserRepository对象中添加新方法
Iterable<User> findAll(Sort sort);

// 分页
int page = 0;
int size = 5;
Pageable pageable = new PageRequest(page, size); 
Pgae<User> users = userRepository.findAll(pageable);

// 排序
Sort sort = new Sort(Sort.Direction.DESC,"id");    //依据id降序排列
Iterable<User> users = userRepository.findAll(sort);
```

5. 在controller编写业务代码

```java
@RestController
@RequestMapping(value="person")
public class PersonController {
    
    @Autowired
    private PersonRepository personRepository;

    @PostMapping(path="addPerson")
    public void addPerson(Person person) {
        personRepository.save(person);
    }

    @DeleteMapping(path="deletePerson")
    public void deletePerson(Long id) {
        personRepository.delete(id);
    }

    // 除了findBy这种不用写sql的方法,还有一种可以自己编写sql
    /**
     * 查询根据参数位置
     * @param name
     * @return
     */
    @Query(value = "select * from person  where name = ?1",nativeQuery = true)
    Person findPersonByName(String Name);
 
    /**
     * 查询根据Param注解
     * @param name
     * @return
     */
    @Query(value = "select p from person p where p.uname = :name")
    Person findPersonByNameTwo(@Param("name") String name);
}
```


https://juejin.cn/post/6844903822423408647

https://segmentfault.com/a/1190000037755804

https://segmentfault.com/a/1190000011910166?utm_source=sf-similar-article

https://segmentfault.com/a/1190000011174235?utm_source=sf-similar-article

https://segmentfault.com/a/1190000022308656?utm_source=sf-similar-article


## jpa的级联操作

https://www.yiibai.com/jpa/jpa-cascade-persist.html