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
