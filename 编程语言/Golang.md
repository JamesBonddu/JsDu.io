# 语法Tips

Golang中 `:=` 和 `=`的区别?

= 只是一个赋值运算符, :=实际上不是一个运算符,而是一个短变量声明.
ShortVarDecl = IdentifierList ":=" ExpressionList


参考:
https://stackoverflow.com/questions/17891226/difference-between-and-operators-in-go


type 类型名称 底层类型

func (c Celsius) String() string {  return fmt.Sprintf("%g 'C", c)}

## 包

每个包都有对应的一个独立的namespace,例如image的Decode函数和unicde/utf16包中的Decode函数是不同的,必须显示地使用image.Decode或utf16.Decode。

包还可以让我们通过控制哪些名字是外部可见的来隐藏内部实现信息.在Go中一个简单的规则是:如果一个名字是大写字母开头的,那么该名字是导出的(由于汉字不区分大小写,所以汉字开头的名字是没有导出的);

对于在包级别声明的变量,如果有初始化表达式则用表达式初始化,还有一些没有初始化表达式的,可以用一个特殊的init初始化函数来简化初始化工作.
这样的init初始化函数除了不能被调用或引用外,其他行为和普通函数类似,每个包在解决依赖的前提下,以导入声明的顺序初始化,每个包只会被初始化,main函数执行之前init将依赖都完善了.

## 数组; Sloce不定长数组

判断slice是否为空,使用len(s) == 0 来判断,而不应该用s == nil来判断.除了和nil相等比较外,一个nil的slice行为和其它任意0长度的slice一样;

make([]T, len) 创建一个指定元素类型, 长度和容量的slice.容量部分可以省略,在这种情况下容量等于长度.
make([]T, len, cap)

```go
var runes []rune
for _, r := range "Hi, World" {
    runes = append(runes, r)
}
fmt.Printf("%q\n", runes)
```

## map
 
 ages := make(map[string]int)
 ages := map[string]{}

// json {string : {"string": bool}}
var graph = make(map[string]map[string]bool)

## 结构体

```go
type Employee struct {
    ID int
    Name string
    Address string
    Time    time.Time
    Salary  int
}

var jobs Employee
// &取址jobs结构体的Time变量的地址
st := &jobs.Time
*st = "Senior" + *st

type jsdu struct {
    Cnt int
    Ts  time.Time
    Name string
}

func main() {
    // 结构体赋值
    rt := jsdu{}
    rt.Cnt = 6
    rt.Ts  = time.Now()
    rt.Name= "jsdu"

    //修改结构体的实例的某个值 change变量
    // 1. 先取址,再通过指针访问
    cg := &rt.Name
    *cg = "Fighting" +*cg

    // 2. 点操作符和指向结构体的指针一起工作; 这一种看起来更常用
    var jsVar *jsdu = &rt
    jsVar.Name = "LoL"
    fmt.Printf(rt)
}
//  结构体和map

type address struct {
    hostname string
    port     int
}

hits := make(map[address]int)
hits[address{"golang.org", 443}]++
```

## JSON类型

"omitempty"选项指定如果字段具有空值（定义为false，0，nil指针，nil接口值以及任何空数组，切片，映射或字符串），则应从编码中省略该字段。

```go
type Movie struct {
    Title string
    Year  int   `json:"release"`
    Color bool  `json:"color,omitempty"`
    Actors []string
}

var movies = []Movie{
    {
        Title: "Beijing",
        Year:   1987,
        Color:  true,
        Actors: []string{"jsdu"}
    },
    {
        Title: "Harbin",
        Year:   1965,
        Color:  false,
        Actors: []string{"go"}
    }
}
data, err := json.Marsha1(movies)

// 将数据整齐缩进,后面2个参数标识每一行输出的前缀和每一个层级的缩进
data, err := json.MarshalIndent(movies, "", "   ")
if err != nil {
    log.Fatalf("JSON marshaling failed: %s", err)
}
fmt.Printf("%s\n", data)



package main

import (
	"fmt"
	"encoding/json"
)

type High struct {
	Hid string 
}

type jsdu struct{
	Pk string
	Year int `json:"year"` 
	High `json:"faith,omitempty"`
}

func main() {
	jj := jsdu{}
	jj.Pk = "King"
	//jj.Year = 1987
	//jj.Hid = "Hi"
	
	jsRt, _ := json.MarshalIndent(jj," ", "  ")
	fmt.Println(string(jsRt))
}

/**
{
 "Pk": "King",
 "year": 1987,
 "faith": {
  "Hid": ""
 }
}
or 
{
 "Pk": "King",
 "faith": {
  "Hid": ""
 }
}
*/
```



## go安装vscode插件

```json
// vscode的语言配置
{
    "git.ignoreMissingGitWarning": true,
    "gitlens.advanced.messages": {
        "suppressShowKeyBindingsNotice": true
    },
    "go.inferGopath": true,
    "go.docsTool": "gogetdoc",
    "go.autocompleteUnimportedPackages": true,
    "go.gocodePackageLookupMode": "go",
    "go.gotoSymbol.includeImports": true,
    "go.useCodeSnippetsOnFunctionSuggest": true,
    "go.useCodeSnippetsOnFunctionSuggestWithoutType": true,
    "go.buildOnSave": "workspace",
    "go.lintOnSave": "package",
    "go.vetOnSave": "package",
    "go.buildTags": "",
    "go.buildFlags": [],
    "go.lintFlags": [],
    "go.vetFlags": [],
    "go.coverOnSave": false,
    "go.formatTool": "goreturns",
    "go.goroot": "D:\\Go",
    "go.gopath": "D:\\JSDu\\Learn",
    "go.gocodeAutoBuild": false
}
```

参考:
[Golang 代码提示插件](https://maiyang.me/post/2018-09-14-tips-vscode/)
[Go安装包被墙的解决方法](https://studygolang.com/articles/9490)
[cow二级代理配置](https://131.re/marchives/101)
[window shell](http://www.ntu.edu.sg/home/ehchua/programming/howto/environment_variables.html)
[golang环境配置](https://zhuanlan.zhihu.com/p/52517506)
[vscode golang环境搭建](https://maiyang.me/post/2018-09-14-tips-vscode/)