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

df.iloc[[2]]

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



drop table gcp_gcpbillingrange;
drop table gcp_gsuitebilling;
DELETE FROM  `hedwig`.`django_migrations` WHERE name = '0003_auto_20191107_0132';
