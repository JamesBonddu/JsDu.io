# Pandas 数据结构

Series

带一个带维度的容量的数组,能支持任意数据类型(integers, strings, floating point numbers, Python Objects)

DataFrame是一个2维化的标记数据结构,可以接受不同的输入:
- 1维度ndarraysm, lists, dicts, or Series
- 2-D numpy.ndarray
- Structured or record ndarray
- A Series
- Another DataFrame



Indexing 和 Selecting Data
索引和

MultiIndex/Advanced Indexing

Merge,join 和concatenate


## pandas tips

## 改變列的順序
df.insert(0, 'mean', df.mean(1))

https://stackoverflow.com/questions/13148429/how-to-change-the-order-of-dataframe-columns

## 修改列名
df.columns = ["企业名称", "所属园区", "参与人数", "企业联系人", "联系方式", "已报名人员"]

https://stackoverflow.com/questions/11346283/renaming-columns-in-pandas

## 遍历

```python 
import pandas as pd
import numpy as np

df = pd.DataFrame([{'c1':10, 'c2':100}, {'c1':11,'c2':110}, {'c1':12,'c2':120}])
for index, row in df.iterrows():
    print(row['c1'], row['c2'])
```
https://stackoverflow.com/questions/16476924/how-to-iterate-over-rows-in-a-dataframe-in-pandas

### groupby
- 按照单列分组求和其它列;

```python
# series
group_accountid = raw_data_df.groupby(['Account ID'])['Amount'].sum()
# dataframe
group_accountid = raw_data_df.groupby(['Account ID'])['Amount'].sum().reset_index()
```

参考:

https://stackoverflow.com/questions/39116735/group-by-of-a-column-and-sum-contents-of-another-column-with-python
https://stackoverflow.com/questions/53781634/aggregation-in-pandas

- groupby 访问长度

https://stackoverflow.com/questions/19384532/get-statistics-for-each-group-such-as-count-mean-etc-using-pandas-groupby

### 过滤


- df依据其他df filter自身

```python
df1 = df1[~df1.index.isin(df2.index)]
```

https://stackoverflow.com/questions/33282119/pandas-filter-dataframe-by-another-dataframe-by-row-elements

- 向dataframe添加一列
  df1['e'] = pd.Series(np.random.randn(sLength), index=df1.index)

- isin 无法保留输入序列的顺序

https://stackoverflow.com/questions/23414161/pandas-isin-with-output-keeping-order-of-input-list/40027719

- dataframe 合并
```python
import pandas
dfinal = df1.merge(df2, on="movie_title", how = 'inner')
dfinal = df1.merge(df2, how='inner', left_on='movie_title', right_on='movie_name')
```

https://stackoverflow.com/questions/43297589/merge-two-data-frames-based-on-common-column-values-in-pandas

- dataframe get row

```python
df.iloc[[2]]
In [5]: df.iloc[[2]]
Out[5]: 
          A         B
4 -0.284561  0.756029
In [6]: df.loc[[2]]
Out[6]: 
```

https://stackoverflow.com/questions/16096627/selecting-a-row-of-pandas-series-dataframe-by-integer-index

- isnan

https://stackoverflow.com/questions/29530232/how-to-check-if-any-value-is-nan-in-a-pandas-dataframe

- pandas 丢弃list rows data

https://stackoverflow.com/questions/14661701/how-to-drop-a-list-of-rows-from-pandas-dataframe

- merge  groupby objects

https://stackoverflow.com/questions/52425332/merge-pandas-groupby-objects

https://stackoverflow.com/questions/24980437/pandas-groupby-and-then-merge-on-original-table/55852714

https://pandas.pydata.org/pandas-docs/stable/user_guide/merging.html


https://stackoverflow.com/questions/53645882/pandas-merging-101

- pandas 避免重复列

```python
cols_to_use = df2.columns - df.columns
```
https://stackoverflow.com/questions/19125091/pandas-merge-how-to-avoid-duplicating-columns

https://goldengrape.github.io/posts/python/pandaszhong-ji-he-de-yun-suan/

- groupby with NAN cloumns

https://stackoverflow.com/questions/18429491/groupby-columns-with-nan-missing-values


- dataframe to csv

https://stackoverflow.com/questions/16923281/writing-a-pandas-dataframe-to-csv-file

https://stackoverflow.com/questions/34425607/how-to-write-a-pandas-dataframe-to-django-model

bc

- dataframe to sql too slow

https://stackoverflow.com/questions/29706278/python-pandas-to-sql-with-sqlalchemy-how-to-speed-up-exporting-to-ms-sql

https://stackoverflow.com/questions/48006551/speeding-up-pandas-dataframe-to-sql-with-fast-executemany-of-pyod

展示to sql的语句
https://stackoverflow.com/questions/32920127/output-sql-as-string-from-pandas-dataframe-to-sql
-
https://stackoverflow.com/questions/16597265/appending-to-an-empty-dataframe-in-pandas

- pandas 直接读取 sql query

  https://stackoverflow.com/questions/27770729/how-to-read-sql-query-to-pandas-dataframe-python-django

- pandas numpy narray to list dict

 df.to_dict('records')

https://stackoverflow.com/questions/47555539/efficient-way-to-convert-numpy-matrix-into-a-nested-dictionary

https://stackoverflow.com/questions/26716616/convert-a-pandas-dataframe-to-a-dictionary

- pandas read from resp

https://stackoverflow.com/questions/39213597/convert-text-data-from-requests-object-to-dataframe-with-pandas


# 数据透视表

https://nikgrozev.com/2015/07/01/reshaping-in-pandas-pivot-pivot-table-stack-and-unstack-explained-with-pictures/


# 按年月分组

```python
#1
park_df['date'] = pd.to_datetime(park_df['date'])
gp = park_df.groupby(pd.Grouper(key='date', freq='M'))

#2
park_df['date'] = pd.to_datetime(park_df['date'])
year_month_gp1 = park_df.groupby([park_df.date.dt.year, park_df.date.dt.month])
```


https://stackoverflow.com/questions/44908383/how-can-i-group-by-month-from-a-date-field-using-python-pandas
https://pandas.pydata.org/pandas-docs/stable/user_guide/timeseries.html#offset-aliases


https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Grouper.html

http://blog.josephmisiti.com/group-by-datetimes-in-pandas

# 日期转换

https://stackoverflow.com/questions/17134716/convert-dataframe-column-type-from-string-to-datetime-dd-mm-yyyy-format

# dataframe 转json

df.to_json(orient='records')

https://stackoverflow.com/questions/33061302/dictionary-of-pandas-dataframe-to-json


# pandas 横纵转换


纵变横; 长变宽;
pandas.pivot_table

df.pivot

https://www.cnblogs.com/onemorepoint/p/8425300.html

https://nikgrozev.com/2015/07/01/reshaping-in-pandas-pivot-pivot-table-stack-and-unstack-explained-with-pictures/

https://hackernoon.com/reshaping-data-in-python-fa27dda2ff77

https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.pivot.html

https://stackoverflow.com/questions/12860421/python-pandas-pivot-table-with-aggfunc-count-unique-distinct

横变纵; 宽变长;

pandas.melt

https://stackoverflow.com/questions/55845916/how-to-convert-structure-vertical-to-horizontal-with-pandas

https://medium.com/%E6%95%B8%E6%93%9A%E4%B8%8D%E6%AD%A2-not-only-data/%E5%B8%B6%E4%BD%A0%E5%BF%AB%E9%80%9F%E7%90%86%E8%A7%A3-pandas-melt-%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8-443976e00f2

https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.melt.html

http://shzhangji.com/cnblogs/2017/09/30/pandas-and-tidy-data/

# pandas groupby后追加一列

https://stackoverflow.com/questions/37189878/pandas-add-column-to-groupby-dataframe

# 计算同比环比

diff计算环比;
https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.diff.html

http://www.pointborn.com/article/2020/5/31/608.html

https://blog.csdn.net/qq_43220632/article/details/99935599

# 追加一行到dataframe

df['总计'] = df.sum(axis=1)

https://stackoverflow.com/questions/20804673/appending-column-totals-to-a-pandas-dataframe/56720533

# multiindex to single index

https://stackoverflow.com/questions/32938060/reverting-from-multiindex-to-single-index-dataframe-in-pandas

# 数据分箱

bins = [0,59,79,89,100]
score_cut = pd.cut(score_list,bins)
type(score_cut)
pandas.core.arrays.categorical.Categorical
 
In [8]: pd.value_counts(score_cut) # 查看每个区间的人数
Out[8]:
(0, 59]      54
(59, 79]     22
(89, 100]    12
(79, 89]     12


https://blog.csdn.net/weixin_42398658/article/details/82936525

# pandas 插值 interpolation

https://juejin.im/post/6844904166238715912#heading-13

https://mlln.cn/2015/05/15/pandas%E6%95%99%E7%A8%8B%EF%BC%9A[25]%E6%8F%92%E5%80%BC%E6%B3%95%E5%A1%AB%E8%A1%A5%E7%BC%BA%E5%A4%B1%E5%80%BC/

https://stackoverflow.com/questions/62997758/create-new-column-in-data-frame-by-interpolating-other-column-in-between-a-parti

# 日期补齐

http://sofasofa.io/forum_main_post.php?postid=1003719

# groupby apply 返回dataframe

https://stackoverflow.com/questions/37715246/pandas-groupby-apply-behavior-returning-a-series-inconsistent-output-type

https://stackoverflow.com/questions/41576242/valueerror-cannot-insert-id-already-exists

# get_dummies

将类别变量转换为伪变量/指标变量

https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.get_dummies.html

https://blog.csdn.net/lujiandong1/article/details/52836051#