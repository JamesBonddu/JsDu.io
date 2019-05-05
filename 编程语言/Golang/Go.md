# Go语言学习



```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}

```

## Go的主要特性
Go 是一门类型安全和内存安全的编程语言.虽然Go中仍有指针的存在,但并不允许进行指针运算.

Go的另一个目标是对于网络通信,并发和并行编程的极佳支持.
Go语言一个非常好的目标就是实现所谓的复杂事件处理(CEP),这项技术要求并行支持,高度的抽象化和高性能.

由于垃圾回收和自动内存分配的原因,Go不适合用来开发对实时性要求很高的软件.

Chrome浏览器内置了一款Go的编译器用于本地客户端(NaCI).

### 特性缺失
许多能够在大多数面向对象语言中使用的特性 Go 语言都没有支持，但其中的一部分可能会在未来被支持。

- 为了简化设计，不支持函数重载和操作符重载
- 为了避免在 C/C++ 开发中的一些 Bug 和混乱，不支持隐式转换
- Go 语言通过另一种途径实现面向对象设计（第 10-11 章）来放弃类和类型的继承
- 尽管在接口的使用方面（第 11 章）可以实现类似变体类型的功能，但本身不支持变体类型
- 不支持动态加载代码
- 不支持动态链接库
- 不支持泛型
- 通过 recover 和 panic 来替代异常机制（第 13.2-3 节）
- 不支持断言
- 不支持静态变量

## GOPATH环境变量
- $GOROOT 表示 Go 在你的电脑上的安装位置，它的值一般都是 $HOME/go，当然，你也可以安装在别的地方。
$GOARCH 表示目标机器的处理器架构，它的值可以是 386、amd64 或 arm。
- $GOOS 表示目标机器的操作系统，它的值可以是 darwin、freebsd、linux 或 windows。
- $GOBIN 表示编译器和链接器的安装位置，默认是 $GOROOT/bin，如果你使用的是 Go 1.0.3 及以后的版本，一般情况下你可以将它的值设置为空，Go 将会使用前面提到的默认值。

- $GOPATH
GOPATH环境变量确定了你的工作空间位置.

on Unix： $HOME/go

UNIX下设置GOPATH：

```sh
GOPATH=$HOME
export PATH=$PATH:$(go env GOPATH)/bin # windows下则是设置环境变量
```

on Windows: %USERPROFILE%\go(usually C:\Users\YourName\go)


> 目前有2个版本的编译器: Go 原生编译器 gc(已移植到Window) 和非原生编译器 gccgo

安装目录清单:
- `/bin`：包含可执行文件，如：编译器，Go 工具
- `/doc`：包含示例程序，代码工具，本地文档等
- `/lib`：包含文档模版
- `/misc`：包含与支持 Go 编辑器有关的配置文件以及 cgo 的示例
- `/os_arch`：包含标准库的包的对象文件（.a）
- `/src`：包含源代码构建脚本和标准库的包的完整源代码（Go 是一门开源语言）
- `/src/cmd`：包含 Go 和 C 的编译器和命令行脚本

### Go 运行时(runtime)
这个runtime类似于Java和.NET语言里用到的虚拟机,它负责管理包括内存分配,垃圾回收, 栈处理, gorutine, channel, 切片(slice), map和反射(reflection)等.


### 例子
```go
s := "" // 短变量声明,只能用在函数内部,而不能用于包变量
var s string  // 依赖于字符串的默认初始化零值机制
var s = "" // 用的较少
var s string = "" // 显示地标明变量的类型
```


```go
package main

import (
	"fmt"
	"bufio"
	"os"
)

// unique
func main() {
	fmt.Println("Find Dump!")
	cnt := make(map[string]int)
	files := os.Args[1:]
	if len(files) == 0 {
		CountLines(os.Stdin, cnt)
	} else {
		for _, arg := range files {
			f, err := os.Open(arg)
			if err != nil {
				fmt.Fprintf(os.Stderr, "dup2: %v\n", err)
				continue
			}
			CountLines(f, cnt)
			f.Close()
		}
	}
	
	for line, n := range cnt {
		if n > 1 {
			fmt.Printf("%d\t%s", n, line)
		}
	}
}


func CountLines(f *os.File, counts map[string]int) {
	input := bufio.NewScanner(f)
	for input.Scan() {
		counts[input.Text()]++
	}
}

```

## Go基本数据类型

### 基础类型
数字, 字符串, 布尔型.

整型, 浮点数, 复数, 布尔型, 字符串, 常量.

### 复合类型
数组, 结构体.

### 引用类型
指针, 切片, 字典, 函数, 通道;

### 接口类型



## 单元测试

在包目录内,所有以`_test.go`为后缀名的源文件在执行go build时不会被构建成包的一部分, 它们是go test测试的一部分.

在`*_test.go`文件中,有三种类型的函数: 
- 测试函数
- 基准测试函数(benchmark)
- 示例函数
一个测试函数是以`Test`为函数名前缀的函数, 用于测试程序的一些逻辑行为是否正确;
基准测试函数是以`Benchmark`为函数名前缀的函数,它们用于衡量一些函数的性能.
示例函数是以`Example`为函数名前缀的函数,提供一个由编译器保证正确性的示例文档.

> 测试覆盖率使用方法: 
> go tool cover -html=t.out
> go test -coverprofile=t.out

go tool 命令运行Go工具链的底层可执行程序。 这些底层可执行程序放在
`$GOROOT/pkg/tool/${GOOS}_${GOARCH}`

参考:

[Go官网](https://go-zh.org/doc/)

[Go 语言圣经](https://legacy.gitbook.com/book/yar999/gopl-zh/details)

[Go wiki](https://github.com/golang/go/wiki)

[Go 起源和设计动机](https://talks.golang.org/2012/splash.article)

[Go 编码规范](https://golang.org/ref/spec)

[Go 代码评审](https://github.com/golang/go/wiki/CodeReviewComments)

[Go 测试覆盖率的故事](https://brantou.github.io/2017/05/24/go-cover-story/)

[Go 相关资料的搜索引擎](https://gowalker.org/)


参考:

https://www.cnblogs.com/yxlblogs/p/10115672.html