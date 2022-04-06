# kong 和konga的docker-compose

```yml
version: '3.6'
services:
  kong:
    image: kong
    ports:
      - 0.0.0.0:8000:8000
      - 8443:8443
      - 8001:8001
      - 8444:8444
    environment:
      - "KONG_PROXY_ACCESS_LOG=/dev/stdout"
      - "KONG_ADMIN_ACCESS_LOG=/dev/stdout"
      - "KONG_PROXY_ERROR_LOG=/dev/stderr"
      - "KONG_ADMIN_ERROR_LOG=/dev/stderr"
      - "KONG_ADMIN_LISTEN=0.0.0.0:8001, 0.0.0.0:8444 ssl"
      - "KONG_DATABASE=postgres"
      - "KONG_PG_HOST=kong-db"
      - "KONG_PG_USER=kong"
      - "KONG_PG_PASSWORD=kong"
      - "KONG_CASSANDRA_CONTACT_POINTS=kong-db"
    depends_on:
      - "kong-migrate"
    restart: "on-failure:3"

  kong-migrate:
    image: kong
    depends_on:
      - "kong-db"
    environment:
      KONG_DATABASE: "postgres"
      KONG_PG_HOST: "kong-db"
      KONG_PG_USER: "kong"
      KONG_PG_PASSWORD: "kong"
      KONG_CASSANDRA_CONTACT_POINTS: "kong-db"
    command: "kong migrations bootstrap"
    restart: "on-failure:3"

  kong-db:
    image: "postgres:9.6"
    environment:
      POSTGRES_USER: "kong"
      POSTGRES_PASSWORD: "kong"
      POSTGRES_DB: "kong"
    volumes:
      - ./kong_data:/var/lib/postgresql/data

  konga:
    image: pantsel/konga
    ports:
      - 1337:1337
    environment:
      - "DB_ADAPTER=postgres"
      - "DB_HOST=konga-db"
      - "DB_USER=konga"
      - "DB_PASSWORD=konga"
    restart: "on-failure:3"
    depends_on:
      - konga-db

  konga-db:
    image: "postgres:9.6"
    environment:
      POSTGRES_USER: "konga"
      POSTGRES_PASSWORD: "konga"
      POSTGRES_DB: "konga"
    volumes:
      - ./konga_data:/var/lib/postgresql/data
```

Kong Admin Urlにhttp://kong:8001/


https://docs.konghq.com/gateway/

https://www.cnblogs.com/xuwujing/p/15182016.html

开启dev-portal

https://docs.konghq.com/gateway/2.8.x/developer-portal/enable-dev-portal/


https://pantsel.github.io/konga/

https://www.cnblogs.com/sunhongleibibi/p/12024386.html

https://help.aliyun.com/document_detail/195626.html

https://izcqi.com/posts/2020/07/28/kong-quick-start-and-core-concepts-cn/

https://bbs.huaweicloud.com/blogs/335064


https://xie.infoq.cn/article/ba0f7503c73b86126017c0d32
