# Gym & Universal

# install

```sh
python3 -m pip install gym
# centos8 install libjpeg-turbo8-dev
# 依赖 https://libjpeg-turbo.org/Downloads/YUM
yum install golang libjpeg-turbo8-dev

python3 -m pip install universe

docker run --privileged --cap-add=SYS_ADMIN --ipc=host \
    -p 5900:5900 -p 15900:15900 quay.io/openai/universe.flashgames
```

5900是vnc 链接接口
15900是web的vnc链接接口

http://ip:15900/viewer/


## error

遇到这种情况是universe安装有问题, 需要重装.

```sh
gym.error.UnregisteredEnv: No registered env with id: flashgames.21Balloons-v0
```
https://github.com/openai/universe/blob/master/universe/__init__.py


https://wagonhelm.github.io/articles/2018-02/Installing-OpenAI-Universe

https://quay.io/repository/openai/universe.gym-core?tag=latest&tab=tags

# universe 开始路径

https://github.com/openai/universe

https://github.com/openai/universe-starter-agent

https://github.com/openai/retro