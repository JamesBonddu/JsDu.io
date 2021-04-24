https://github.com/marshmallow-code/marshmallow-sqlalchemy/issues/147


http://einverne.github.io/post/2018/09/sqlalchemy-relationship.html

https://www.osgeo.cn/sqlalchemy/

https://www.cnblogs.com/lixiang1013/p/7392109.html

https://www.cnblogs.com/kirito-c/p/10900024.html


https://segmentfault.com/a/1190000018006031

https://michael-f-bryan.github.io/cheat-sheets/Python/sqlalchemy.html

ORM 事件钩子

https://blog.csdn.net/weixin_41998562/article/details/102554269

https://docs.sqlalchemy.org/en/13/orm/session_events.html

https://docs.sqlalchemy.org/en/13/core/event.html

https://stackoverflow.com/questions/29921260/tracking-model-changes-in-sqlalchemy

更新

1) user.no_of_logins += 1
   session.commit()

2) session.query().\
       filter(User.username == form.username.data).\
       update({"no_of_logins": (User.no_of_logins +1)})
   session.commit()

3) conn = engine.connect()
   stmt = User.update().\
       values(no_of_logins=(User.no_of_logins + 1)).\
       where(User.username == form.username.data)
   conn.execute(stmt)

4) setattr(user, 'no_of_logins', user.no_of_logins+1)
   session.commit()

https://stackoverflow.com/questions/9667138/how-to-update-sqlalchemy-row-entry

多对多

https://docs.sqlalchemy.org/en/13/orm/tutorial.html#orm-tutorial-many-to-many

https://docs.sqlalchemy.org/en/13/orm/join_conditions.html#handling-multiple-join-paths


flask-sqlalchemy-model-has-no-attribute-foreign-keys

https://stackoverflow.com/questions/19205290/flask-sqlalchemy-model-has-no-attribute-foreign-keys

级联删除

https://stackoverflow.com/questions/5033547/sqlalchemy-cascade-delete

https://docs.sqlalchemy.org/en/13/orm/cascades.html


https://blog.csdn.net/aimill/article/details/80677263

软删除
https://stackoverflow.com/questions/44522391/implementing-a-soft-delete-system-using-sqlalchemy


https://github.com/miguelgrinberg/sqlalchemy-soft-delete


https://www.xspdf.com/resolution/50009441.html

https://graycarl.me/2014/03/24/sqlalchemy-cascade-delete.html


mutable array动态数组

https://gist.github.com/kirang89/22d111737af0fca251e3
https://www.coder.work/article/2429754

fields.DelimitedList 帶分割符的字段

https://github.com/marshmallow-code/webargs/issues/406

获取外键字段和名称

https://stackoverflow.com/questions/34894038/sqlalchemy-orm-check-if-column-is-a-foreign-key

可变dict

https://docs.sqlalchemy.org/en/13/orm/extensions/mutable.html

https://kirang.in/post/creating-a-mutable-array-data-type-in-sqlalchemy/

weakref弱引用

https://docs.python.org/zh-cn/3/library/weakref.html

# JSON中字段查询

https://stackoverflow.com/questions/29974143/python-sqlalchemy-and-postgres-how-to-query-a-json-element

# filter in

https://stackoverflow.com/questions/16158809/sqlalchemy-filter-in-operator

# 获取部分键值

https://stackoverflow.com/questions/11530196/flask-sqlalchemy-query-specify-column-names


# case when 查询

https://stackoverflow.com/questions/11258770/case-when-with-orm-sqlalchemy

https://stackoverflow.com/questions/49784816/sqlalchemy-reference-a-subquery-from-a-case-expression

https://docs.sqlalchemy.org/en/13/core/sqlelement.html?highlight=case#sqlalchemy.sql.expression.case


SELECT CASE: more than one row returned by a subquery used as an expression

https://stackoverflow.com/questions/34784219/select-case-more-than-one-row-returned-by-a-subquery-used-as-an-expression


text()
TextAsFrom

https://docs.sqlalchemy.org/en/13/core/selectable.html?highlight=textasfrom#sqlalchemy.sql.expression.TextAsFrom


select() 返回值

https://docs.sqlalchemy.org/en/13/core/selectable.html?highlight=select_from#sqlalchemy.sql.expression.FromClause


datetime时间范围过滤
https://stackoverflow.com/questions/51451768/sqlalchemy-querying-with-datetime-columns-to-filter-by-month-day-year/51468737


数据转换为dataframe的方法
qexp.first().__table__.columns.keys()

engine = create_engine(current_app.config['SQLALCHEMY_DATABASE_URI'])
conn = engine.connect()
df1 = pd.read_sql(qexp.statement, engine)
df1 = pd.DataFrame(columns=qexp.first().__table__.columns.keys(), data=[qexp.fi
rst().to_json()]) 

https://stackoverflow.com/questions/6455560/how-to-get-column-names-from-sqlalchemy-result-declarative-syntax
https://stackoverflow.com/questions/29525808/sqlalchemy-orm-conversion-to-pandas-dataframe

```python
from sqlalchemy import column, text
from sqlalchemy.sql.expression import TextAsFrom
from sqlalchemy import create_engine
from flask import current_app
from sqlalchemy import column, text, select, table
from sqlalchemy.sql.expression import TextAsFrom, join
from app.models.park_activity import ParkActivity, Appointment
from app.core import current_user
from sqlalchemy import case, literal_column

engine = create_engine(current_app.config['SQLALCHEMY_DATABASE_URI'])
conn = engine.connect()
stmt = text("""
SELECT *, 
    CASE
    WHEN a.creator_id = :user_id THEN 1
    ELSE 0
    END as is_appointmented
FROM park_activities as a
FULL OUTER JOIN appointments as b ON a.id = b.activity_id USING();
""")
cursor = conn.execute(stmt, user_id=1)
print(cursor.keys(), cursor.fetchone())


qexp = ParkActivity.query
qexp.where(
    case(
        [
            (ParkActivity.creator_id == 1, 1)
        ],
        else_=literal_column(0)
    )
)

ParkActivity.query.outerjoin(Appointment, full=True).where(id=1)
case1 = case(
    [
        (ParkActivity.creator_id == '1', '1')
    ],
    else_=literal_column('0')
).label("is_appointmented")
q = select([text('*')]).select_from(text('park_activities')).where(case1)



qexp = ParkActivity.query
qexp = qexp.query(case1).outerjoin( 
    Appointment,
    ParkActivity.id ==  Appointment.activity_id,
    full=True
)

join1 = join(
    table('appointments'),
    ParkActivity.id == Appointment.activity_id,
    full=True
    )
q = select([text("""*, 
    CASE
    WHEN park_activities.creator_id = :user_id THEN 1
    ELSE 0
    END as is_appointmented""")]).select_from(join1)
conn.execute(q, user_id=1)


stmt = text("""
SELECT 
  a.id AS park_activities_id, 
  a.title AS park_activities_title, 
  a.content AS park_activities_content, 
  a.address AS park_activities_address, 
  a.contact AS park_activities_contact, 
  a.contact_phone AS park_activities_contact_phone, 
  a.start_time AS park_activities_start_time, 
  a.end_time AS park_activities_end_time, 
  a.reg_start_time AS park_activities_reg_start_time, 
  a.reg_end_time AS park_activities_reg_end_time, 
  a.category_id AS park_activities_category_id, 
  a.cover_id AS park_activities_cover_id, 
  a.attachment_id AS park_activities_attachment_id, 
  a.creator_id AS park_activities_creator_id, 
  a.inserted_at AS park_activities_inserted_at, 
  a.updated_at AS park_activities_updated_at, 
  b.id as appointments_id, 
  b.status as appointments_status, 
  b.activity_id as appointments_activity_id, 
  b.signup as appointments_signup, 
  b.attachment_id as appointments_attachment_id, 
  b.user_id as appointments_user_id, 
  b.inserted_at as appointments_inserted_at, 
  b.updated_at as appointments_updated_at, 
  CASE WHEN a.creator_id = :user_id THEN 1 ELSE 0 END as is_appointmented 
FROM 
  park_activities as a FULL 
  OUTER JOIN appointments as b ON a.id = b.activity_id
""")
cursor = conn.execute(stmt, user_id=1)
print(cursor.keys(), cursor.fetchone())

q = select([text("*")]).select_from(Appointment)
conn.execute(q, user_id=1)
```

## webargs

```python
from webargs.core import dict2schema
bbb = dict2schema(payload)
bbb = bbb()
bbb.load(data=payload)

*** marshmallow.exceptions.ValidationError: {'joinNum': ['Unknown field.'], 'contactPhone': ['Unknown field.'], 'contactPerson': ['Unknown field.'], 'attachment': ['Unknown field.'], 'activityId': ['Unknown field.']}
```


