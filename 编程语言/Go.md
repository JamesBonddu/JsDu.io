# Go语言学习



```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}

```

## GOPATH环境变量

GOPATH环境变量确定了你的工作空间位置.

on Unix： $HOME/go

on Windows: %USERPROFILE%\go(usually C:\Users\YourName\go)



UNIX下设置GOPATH：

```sh
GOPATH=$HOME
export PATH=$PATH:$(go env GOPATH)/bin # windows下则是设置环境变量
```



## 



参考:

[Go官网](https://go-zh.org/doc/)

[Go 语言圣经](https://legacy.gitbook.com/book/yar999/gopl-zh/details)

[Go wiki](https://github.com/golang/go/wiki)