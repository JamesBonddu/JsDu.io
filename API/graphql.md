# graphql

https://ruby-china.org/topics/40695

https://github.com/hasura/learn-graphql

# hasura

https://hasura.io/docs/latest/graphql/core/actions/index.html

https://hasura.io/learn/#fullstack-tutorials

https://hasura.io/blog/bring-rest-apis-as-a-data-source-to-hasura-announcing-rest-connectors-data-hub/

https://hasura.io/docs/latest/graphql/core/actions/rest-connectors.html#action-transforms


https://hasura.io/docs/latest/graphql/core/api-reference/restified.html

# hasura创建rest数据

https://hasura.io/docs/latest/graphql/core/api-reference/schema-metadata-api/restified-endpoints.html#schema-metadata-api-restified-endpoints

## 支持rest api

https://hasura.io/docs/latest/graphql/core/actions/rest-connectors.html


# 速查表

http://caibaojian.com/scb/graphql.html


# apollo

https://www.apollographql.com/docs/tutorial/data-source/


# 常用语法定义

https://hasura.io/docs/latest/graphql/core/api-reference/syntax-defs.html


https://www.cnblogs.com/rongfengliang/p/9942742.html

# hasura开启debug模式

```md
Dev (debugging) mode
The Hasura GraphQL engine may provide additional information for each object in the extensions key of errors. The internal key contains error information including the generated SQL statement and exception information from Postgres. This can be highly useful, especially in the case of debugging errors in action requests.

By default the internal key is not sent in the extensions response (except for admin roles). To enable this, start the GraphQL engine server in debugging mode with the following configuration:

# env var
HASURA_GRAPHQL_DEV_MODE=true

# flag
--dev-mode
The internal key is sent for admin role requests by default. To disable them, configure as follows:

# env var
HASURA_GRAPHQL_ADMIN_INTERNAL_ERRORS=false

# flag
--admin-internal-errors false
```
