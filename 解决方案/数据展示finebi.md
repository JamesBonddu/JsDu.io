# FineBI


# sql数据集合传参

跳转时添加跳转参数
```sql
SELECT *
FROM 
app_isolation_person_record AS a
JOIN dwd_isolation_point b ON ( a.point_area = b.area AND a.point_name = b.NAME )
WHERE
  b.is_open = '是' 
  AND a.is_release = '0' 
  <parameter> and a.point_area in ('${point_area}')</parameter>
  <parameter> and a.point_name in ('${point_name}')</parameter>
```

https://help.fanruan.com/finebi/doc-view-729.html

https://help.fanruan.com/finebi/doc-view-86.html

查询动态列

https://help.fanruan.com/finebi/doc-view-763.html

# 数据钻取

https://help.fanruan.com/finebi/doc-view-133.html


# Excel 导出问题

导出时需要设置分享链接为预览跳转链接这样能够保证excel导出功能是正常的.

https://help.fanruan.com/finebi/doc-view-578.html

# 解决驱动冲突

https://help.fanruan.com/finebi/doc-view-697.html

# 分享跳转

https://help.finebi.com/513/index.php?doc-view-149.html