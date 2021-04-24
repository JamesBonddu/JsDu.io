# 生命游戏

元胞自动机(cellular automaton)

```python
"""
根据 百度百科 ，生命游戏，简称为生命，是英国数学家约翰·何顿·康威在 1970 年发明的细胞自动机。

给定一个包含 m × n 个格子的面板，每一个格子都可以看成是一个细胞。每个细胞都具有一个初始状态：1 即为活细胞（live），或 0 即为死细胞（dead）。每个细胞与其八个相邻位置（水平，垂直，对角线）的细胞都遵循以下的规则:

每个网格称为cell
每个cell有两种状态，alive和dead，分别用两种不同的颜色来表示
每个cell的状态变化受其周围8个cell影响
如果一个活的(alive)cell，其周围的活的cell数量少于2——即为0或1，则这个cell将死去(dead)
如果一个活的cell，其周围的活的cell数量超过3——即为4至8，则这个cell将死去
如果一个活的cell，其周围的活的cell数量为2或3，则它继续存活
如果一个死的cell，其周围的活的cell数量为3，则它成为活的cell，否则仍然为死的cell
"""


```

https://rosettacode.org/wiki/Conway%27s_Game_of_Life

https://fiftyexamples.readthedocs.io/en/latest/life.html

https://www.zmonster.me/2014/07/04/game-of-life-and-implementation-with-python.html


https://zh.wikipedia.org/zh-hans/%E5%BA%B7%E5%A8%81%E7%94%9F%E5%91%BD%E6%B8%B8%E6%88%8F

http://ironphoenix.org/gtklife/

https://bitstorm.org/gameoflife/


https://zxi.mytechroad.com/blog/simulation/leetcode-289-game-of-life/

## Langton's ant 兰顿蚂蚁

## 通用图灵机

https://en.wikipedia.org/wiki/Universal_Turing_machine
