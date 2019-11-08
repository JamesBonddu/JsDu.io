# .env file

```sh
PYTHONUNBUFFERED=TRUE
# DJANGO_SETTINGS_MODULE=admin.debug
ENV=dev
```

# supervisor

去除stdout缓存,

gunicorn -R

并且在相关目录下加 `.env`配置相应环境变量
```sh
PYTHONUNBUFFERED=TRUE
```

https://learnku.com/laravel/t/2126/supervisor-installation-configuration-use


https://kyle.ai/blog/6382.html

https://blog.csdn.net/jasonchen_gbd/article/details/80795645

https://ocavue.com/pipenv.html#%E8%83%8C%E6%99%AF%E7%9F%A5%E8%AF%86

https://stackoverflow.com/questions/27687867/is-there-a-way-to-log-python-print-statements-in-gunicorn


yum install -y google-chrome-stable &&
yum install -y chromedriver

wget -o ~/chromedriver_linux64.zip  https://chromedriver.storage.googleapis.com/77.0.3865.40/chromedriver_linux64.zip


https://intoli.com/blog/installing-google-chrome-on-centos/
