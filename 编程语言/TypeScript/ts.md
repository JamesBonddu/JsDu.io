# TypeScript


## 语言和生态介绍

https://zhuanlan.zhihu.com/p/28494162
https://juejin.im/post/59c46bc86fb9a00a4636f939

## 编译和调试
以ES5语法生成sourcemap文件
tsc --sourcemap --target ES5 warship.ts

https://segmentfault.com/a/1190000011935122
https://segmentfault.com/a/1190000010605261

http://www.typescriptlang.org/docs/handbook/compiler-options.html



## TypeScript 编译原理
TypeScript 编译器源文件位于`src/compiler`目录下:
- Scanner扫描器(scanner.ts)
- Parser解析器(parser.ts)
- Binder绑定器(binder.ts)
- Checker检查器(checker.ts)
- Emitter发射器(emitter.ts)
  
处理流程

SourceCode(源码) ~~ 扫描器 ~~> Token流

Token流 ~~ 解析器 ~~> AST语法树

AST ~~ 绑定器 ~~> Symbols(符号)

符号和AST是检查器用来验证源代码语义的:

AST + 符号 ~~ 检查器 ~~> 类型验证

最后输出Javascript代码

AST + 检查器 ~~ 发射器 ~~> Javascript代码

参考:
https://jkchao.github.io/typescript-book-chinese/

TS 资源
https://juejin.im/entry/5b9e4a135188255c3a2d3695


