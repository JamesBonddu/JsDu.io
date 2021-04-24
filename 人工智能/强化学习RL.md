# 强化学习

https://www.openai.com/blog/spinning-up-in-deep-rl/

https://spinningup.openai.com/en/latest/

https://spinningup.openai.com/en/latest/user/introduction.html

## Spinning Up
The following algorithms are implemented in the Spinning Up package:

Vanilla Policy Gradient (VPG)
Trust Region Policy Optimization (TRPO)
Proximal Policy Optimization (PPO)
Deep Deterministic Policy Gradient (DDPG)
Twin Delayed DDPG (TD3)
Soft Actor-Critic (SAC)


RL的主要特征是主体和环境。环境是代理人生活并与之互动的世界。在交互的每个步骤中，代理都会看到（可能是部分）对世界状态的观察，然后决定要采取的行动。当代理对它进行操作时，环境会发生变化，但也可能会自己发生变化。

代理还从环境中感知到奖励信号，该数字表明当前环境的好坏。代理的目标是最大化其累积奖励，称为return。强化学习方法是代理可以学习行为以实现其目标的方法。

RL算法分类

https://spinningup.openai.com/en/latest/spinningup/rl_intro2.html

# 无模型和基于模型的RL
RL算法中最重要的分支点之一是代理是否可以访问（或学习）环境模型的问题。通过环境模型，我们意味着可以预测状态转换和奖励的函数。

拥有模型的主要好处是，它允许代理人通过预先考虑，查看一系列可能的选择会发生什么，并明确决定其选择来进行计划。然后，业务代表可以将预先计划的结果提炼成已学习的策略。

# 学习什么

随机或确定性策略
动作值函数（Q函数），
价值函数
和/或环境模型。

关键论文

https://spinningup.openai.com/en/latest/spinningup/keypapers.html

