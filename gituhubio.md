# github pages

静态生成网站

https://www.staticgen.com/

https://ojbk.im/posts/2018/whats-next-about-this-site/

## Hugo


## Ghost建站

https://halfrost.com/ghost_build/

## jekyll

```sh
sudo apt install ruby-full -y
sudo gem install bundler jekyll
# gem设置国内镜像源
sudo gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/
sudo gem sources -l

bundle config mirror.https://rubygems.org https://gems.ruby-china.com

# error
jsdu@ubuntu:~/project/blog/devlopr-jekyll$ cat /var/lib/gems/2.5.0/extensions/x86_64-linux/2.5.0/nokogiri-1.10.9/gem_make.out
current directory: /var/lib/gems/2.5.0/gems/nokogiri-1.10.9/ext/nokogiri
/usr/bin/ruby2.5 -r ./siteconf20200519-54146-1ripw2e.rb extconf.rb
checking if the C compiler accepts ... yes
Building nokogiri using packaged libraries.
Using mini_portile version 2.4.0
checking for gzdopen() in -lz... no
zlib is missing; necessary for building libxml2

sudo apt-get install zlib1g-dev
sudo gem install nokogiri -v '1.10.9' --source 'https://rubygems.org/'
bundle install
bundle exec jekyll server
```

https://gems.ruby-china.com/

## 选择主题

https://devlopr.netlify.app/#/


## jekyll 语法

设置多级`categories`


https://blog.webjeda.com/jekyll-categories/

https://marsishandsome.github.io/2018/04/Jekyll%E6%90%AD%E5%BB%BA%E4%B8%AA%E4%BA%BA%E5%8D%9A%E5%AE%A2

http://jekyllcn.com/docs/frontmatter/

http://jekyllcn.com/docs/variables/

https://en.wikipedia.org/wiki/YAML#Lists

## 自动化部署



https://linuxize.com/post/how-to-install-ruby-on-ubuntu-18-04/

https://github.com/jekyll/jekyll/wiki/Sites

https://jekyllrb.com/docs/deployment/automated/

http://www.ityouknow.com/other/2018/09/16/create-blog.html
