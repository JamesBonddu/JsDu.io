# RPA


## UIBot
基于DirectUI的软件
以前，Windows软件界面的开发框架都是微软提供的，包括MFC、WTL、WinForm、WPF等。微软很贴心的为这些框架制作出来的界面都提供了自动化操作的接口。近年来，为了让软件界面更好看，也更容易制作，很多厂商或开发团队推出了自己的Windows软件界面开发框架。这类框架统称为DirectUI。用这些框架制作的界面，其界面元素都是“画”出来的，虽然人眼可以看到，但操作系统和其他程序都不知道界面元素到底在哪里。有的DirectUI框架提供了对外的接口，可以找到界面元素，有的则根本没有提供这样的接口，其它程序，包括UiBot，自然也无法找到界面元素。

实际上，UiBot Creator、UiBot Worker本身的界面就是用一种DirectUI框架开发的，这种框架称为electron。electron其实提供了界面元素的查找接口，但对外发布的版本默认都关闭了。所以，细心的读者可能会发现，UiBot里面的界面元素，反而是市面上任何RPA平台，包括UiBot自己，都无法找到的。

自有编程语言 BotScript，一种 BASIC 编程语言的实现


https://forum.uibot.com.cn/

https://forum.uibot.com.cn/thread-4.htm