## gzip Huge file 解压


```python
import zlib

def stream_gzip_decompress(stream):
    dec = zlib.decompressobj(32 + zlib.MAX_WBITS)  # offset 32 to skip the header
    for chunk in stream:
        rv = dec.decompress(chunk)
        if rv:
            yield rv
```

or

```python
try:
    response = requests.get(url, paramDict)
except Exception as e:
    print(e)

data = zlib.decompress(response.content, zlib.MAX_WBITS|32)

with open('outFileName.txt','w') as outFile:
    outFile.write(data)
```


[gzip decompress](https://stackoverflow.com/questions/12571913/python-unzipping-stream-of-bytes)


## python batch list

```python
def chunks(l, n):
    """Yield successive n-sized chunks from l."""
    for i in range(0, len(l), n):
        yield l[i:i + n]
```

https://stackoverflow.com/questions/312443/how-do-you-split-a-list-into-evenly-sized-chunks


# update dict return none

https://stackoverflow.com/questions/18037798/why-does-dictk-4-z-2-updatedictl-1-return-none-in-python


## for loop else

https://stackoverflow.com/questions/9979970/why-does-python-use-else-after-for-and-while-loops


## single loop  create dict

https://stackoverflow.com/questions/27715692/single-line-for-loop-to-build-a-dictionary


## python使用

@property的含义

http://www.liujiangblog.com/course/python/46


datetime 时间戳转换
```python
>>> from datetime import datetime
>>> dt_str = '9/24/2010 5:03:29 PM'
>>> dt_obj = datetime.strptime(dt_str, '%m/%d/%Y %I:%M:%S %p')

>>> dt_obj.strftime('%A, %B %d, %Y at %H:%M hours')
'Friday, September 24, 2010 at 17:03 hours'
```

https://blogs.harvard.edu/rprasad/2011/09/21/python-string-to-a-datetime-object/


## 获取一个季度 quarter

```python
def is_leap_year(year):
    """Determine whether a year is a leap year."""
    return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)


def get_quarter(current_date):
    return (current_date.month - 1) // 3 + 1


def get_quarter_delta(current_date):
    leap_year = is_leap_year(current_date.year)
    quarter = get_quarter(current_date)
    delta_time = 0
    if leap_year and quarter == 1:
        delta_time = QUARTER_DELTA[str(quarter)] + 1
    else:
        delta_time = QUARTER_DELTA[str(quarter)]
    return delta_time


def get_first_day_of_the_quarter(date):
    quarter = get_quarter(date)
    return datetime(date.year, 3 * quarter - 2, 1)

"""
Q1 = get_quarter(now)
Q2 = get_quarter(now - timedelta(days=days))
if Q1 == Q2:
    quarter_first_day = get_first_day_of_the_quarter(last7days)
    cur_cost_day_str = last7days_str
else:
    quarter_first_day = get_first_day_of_the_quarter(now)
    cur_cost_day_str = now_str
quarter_first_day_str = quarter_first_day.strftime(DATE_FORMAT)
"""
```

https://stackoverflow.com/questions/1406131/is-there-a-python-function-to-determine-which-quarter-of-the-year-a-date-is-in

## argparse

```sh
parser = argparse.ArgumentParser()
parser.add_argument('--date', type=lambda d: datetime.strptime(d, '%Y%m%d'))
args = parser.parse_args()
```

https://stackoverflow.com/questions/25470844/specify-format-for-input-arguments-argparse-python

## unboundlocalerror

https://stackoverflow.com/questions/9264763/dont-understand-why-unboundlocalerror-occurs
https://stackoverflow.com/questions/16837305/unboundlocalerror-local-variable-system-referenced-before-assignment

## bound method


https://stackoverflow.com/questions/11685936/python-attributeerror-object-has-no-attribute

https://stackoverflow.com/questions/114214/class-method-differences-in-python-bound-unbound-and-static


## 多进程和多线程

https://blog.csdn.net/qq_37258787/article/details/79172916

https://stackoverflow.com/questions/46045956/whats-the-difference-between-threadpool-vs-pool-in-python-multiprocessing-modul


## 并行执行多线程请求

https://stackoverflow.com/questions/43448042/parallel-post-requests-using-multiprocessing-and-requests-in-python

https://stackoverflow.com/questions/38193596/asyncio-multiprocessing-unix


## requests

requests 拿文件拿不全

https://stackoverflow.com/questions/23645212/requests-response-iter-content-gets-incomplete-file-1024mb-instead-of-1-5gb

https://blog.csdn.net/prike/article/details/52723611


## transitions

https://stackoverflow.com/questions/53036689/transitions-in-an-event-driven-finite-state-machine


## stringIO, BytesIO

https://webkul.com/blog/using-io-for-creating-file-object/


https://stackoverflow.com/questions/41790750/writing-files-asynchronously


## python3 f 表达式

https://mlln.cn/2018/05/19/python3%20f-string%E6%A0%BC%E5%BC%8F%E5%8C%96%E5%AD%97%E7%AC%A6%E4%B8%B2%E7%9A%84%E9%AB%98%E7%BA%A7%E7%94%A8%E6%B3%95/

https://stackoverflow.com/questions/45965007/multiline-f-string-in-python
