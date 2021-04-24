root@jinqia-test:/opt/docker-compose-elasticsearch-kibana# docker logs -f elasticsearch1
{"type": "server", "timestamp": "2021-04-09T03:13:19,398Z", "level": "INFO", "component": "o.e.n.Node", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "version[7.8.0], pid[8], build[oss/docker/757314695644ea9a1dc2fecd26d1a43856725e65/2020-06-14T19:35:50.234439Z], OS[Linux/4.15.0-91-generic/amd64], JVM[AdoptOpenJDK/OpenJDK 64-Bit Server VM/14.0.1/14.0.1+7]" }
{"type": "server", "timestamp": "2021-04-09T03:13:19,402Z", "level": "INFO", "component": "o.e.n.Node", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "JVM home [/usr/share/elasticsearch/jdk]" }
{"type": "server", "timestamp": "2021-04-09T03:13:19,402Z", "level": "INFO", "component": "o.e.n.Node", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "JVM arguments [-Xshare:auto, -Des.networkaddress.cache.ttl=60, -Des.networkaddress.cache.negative.ttl=10, -XX:+AlwaysPreTouch, -Xss1m, -Djava.awt.headless=true, -Dfile.encoding=UTF-8, -Djna.nosys=true, -XX:-OmitStackTraceInFastThrow, -XX:+ShowCodeDetailsInExceptionMessages, -Dio.netty.noUnsafe=true, -Dio.netty.noKeySetOptimization=true, -Dio.netty.recycler.maxCapacityPerThread=0, -Dio.netty.allocator.numDirectArenas=0, -Dlog4j.shutdownHookEnabled=false, -Dlog4j2.disable.jmx=true, -Djava.locale.providers=SPI,COMPAT, -Xms1g, -Xmx1g, -XX:+UseG1GC, -XX:G1ReservePercent=25, -XX:InitiatingHeapOccupancyPercent=30, -Djava.io.tmpdir=/tmp/elasticsearch-16748389769431837396, -XX:+HeapDumpOnOutOfMemoryError, -XX:HeapDumpPath=data, -XX:ErrorFile=logs/hs_err_pid%p.log, -Xlog:gc*,gc+age=trace,safepoint:file=logs/gc.log:utctime,pid,tags:filecount=32,filesize=64m, -Des.cgroups.hierarchy.override=/, -Xms256M, -Xmx256M, -XX:MaxDirectMemorySize=134217728, -Des.path.home=/usr/share/elasticsearch, -Des.path.conf=/usr/share/elasticsearch/config, -Des.distribution.flavor=oss, -Des.distribution.type=docker, -Des.bundled_jdk=true]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,282Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [aggs-matrix-stats]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,282Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [analysis-common]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,283Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [geo]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,283Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [ingest-common]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,283Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [ingest-geoip]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,283Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [ingest-user-agent]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,283Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [kibana]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,284Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [lang-expression]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,284Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [lang-mustache]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,284Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [lang-painless]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,284Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [mapper-extras]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,284Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [parent-join]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,285Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [percolator]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,285Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [rank-eval]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,285Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [reindex]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,285Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [repository-url]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,285Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [tasks]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,285Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "loaded module [transport-netty4]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,289Z", "level": "INFO", "component": "o.e.p.PluginsService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "no plugins loaded" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,409Z", "level": "INFO", "component": "o.e.e.NodeEnvironment", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "using [1] data paths, mounts [[/usr/share/elasticsearch/data (/dev/vda1)]], net usable_space [173.5gb], net total_space [196.7gb], types [ext4]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,410Z", "level": "INFO", "component": "o.e.e.NodeEnvironment", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "heap size [256mb], compressed ordinary object pointers [true]" }
{"type": "server", "timestamp": "2021-04-09T03:13:22,513Z", "level": "INFO", "component": "o.e.n.Node", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "node name [elasticsearch1], node ID [3gFSmT0PQPujgd_RR57Pzw], cluster name [docker-cluster]" }
{"type": "server", "timestamp": "2021-04-09T03:13:30,558Z", "level": "INFO", "component": "o.e.d.DiscoveryModule", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "using discovery type [zen] and seed hosts providers [settings]" }
{"type": "server", "timestamp": "2021-04-09T03:13:31,520Z", "level": "INFO", "component": "o.e.n.Node", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "initialized" }
{"type": "server", "timestamp": "2021-04-09T03:13:31,521Z", "level": "INFO", "component": "o.e.n.Node", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "starting ..." }
{"type": "server", "timestamp": "2021-04-09T03:13:31,740Z", "level": "INFO", "component": "o.e.t.TransportService", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "publish_address {172.20.0.9:9300}, bound_addresses {172.20.0.9:9300}" }
{"type": "server", "timestamp": "2021-04-09T03:13:31,934Z", "level": "INFO", "component": "o.e.b.BootstrapChecks", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "bound or publishing to a non-loopback address, enforcing bootstrap checks" }
ERROR: [1] bootstrap checks failed
[1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
ERROR: Elasticsearch did not exit normally - check the logs at /usr/share/elasticsearch/logs/docker-cluster.log
{"type": "server", "timestamp": "2021-04-09T03:13:31,969Z", "level": "INFO", "component": "o.e.n.Node", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "stopping ..." }
{"type": "server", "timestamp": "2021-04-09T03:13:32,046Z", "level": "INFO", "component": "o.e.n.Node", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "stopped" }
{"type": "server", "timestamp": "2021-04-09T03:13:32,047Z", "level": "INFO", "component": "o.e.n.Node", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "closing ..." }
{"type": "server", "timestamp": "2021-04-09T03:13:32,057Z", "level": "INFO", "component": "o.e.n.Node", "cluster.name": "docker-cluster", "node.name": "elasticsearch1", "message": "closed" }


# 需要认证

root@jinqia-test:/opt/docker-compose-elasticsearch-kibana# docker logs -f docker-compose-elasticsearch-kibana_app-search_1
Found java executable in PATH
Java version: 1.8.0_242

App Search is starting...

scripting container class loader urls: [file:/tmp/jruby6908283015188464435extract/lib/jruby-stdlib-9.2.9.0.jar, file:/tmp/jruby6908283015188464435extract/lib/jetty-util.jar, file:/tmp/jruby6908283015188464435extract/lib/jruby-rack-1.1.21.jar, file:/tmp/jruby6908283015188464435extract/lib/jetty-servlets.jar, file:/tmp/jruby6908283015188464435extract/lib/jruby-core-9.2.9.0-complete.jar, file:/tmp/jruby6908283015188464435extract/lib/jruby-rack-worker_0.14.1.jar]
setting GEM_HOME to /tmp/jruby6908283015188464435extract/gems
... and BUNDLE_GEMFILE to /tmp/jruby6908283015188464435extract/Gemfile
loading resource: /tmp/jruby6908283015188464435extract/./META-INF/rails.rb
invoking /tmp/jruby6908283015188464435extract/./META-INF/rails.rb with: [runner, LocoTogo.start_app_server!]
[2021-04-09T06:09:13.283+00:00][18][2002][app-server][INFO]: Successfully connected to Elasticsearch
[2021-04-09T06:09:13.362+00:00][18][2002][app-server][ERROR]: 
--------------------------------------------------------------------------------

Elasticsearch cluster must be licensed. OSS versions of Elasticsearch do not contain a supported license. Please download and run an Elasticsearch binary from https://elastic.co/downloads/elasticsearch to acquire a free, Basic license.

--------------------------------------------------------------------------------


ERROR: org.jruby.exceptions.SystemExit: (SystemExit) exit
org.jruby.exceptions.SystemExit: (SystemExit) exit
	at org.jruby.RubyKernel.exit(org/jruby/RubyKernel.java:751)
	at org.jruby.RubyKernel.exit(org/jruby/RubyKernel.java:714)
	at RUBY.fatal_error(/tmp/jruby6908283015188464435extract/shared_togo/lib/shared_togo.class:829)
	at RUBY.check_elasticsearch_license!(/tmp/jruby6908283015188464435extract/loco_togo/lib/loco_togo.class:64)
	at RUBY.configure!(/tmp/jruby6908283015188464435extract/shared_togo/lib/shared_togo.class:180)
	at RUBY.configure!(/tmp/jruby6908283015188464435extract/shared_togo/lib/shared_togo.class:37)
	at RUBY.<main>(/tmp/jruby6908283015188464435extract/config/application.class:24)
	at org.jruby.RubyKernel.load(org/jruby/RubyKernel.java:1013)
	at RUBY.<main>(/tmp/jruby6908283015188464435extract/config/application.rb:1)
	at org.jruby.RubyKernel.require(org/jruby/RubyKernel.java:978)
	at RUBY.<main>(/tmp/jruby6908283015188464435extract/gems/gems/railties-4.2.11.1/lib/rails/commands/runner.rb:51)
	at org.jruby.RubyKernel.require(org/jruby/RubyKernel.java:978)
	at RUBY.require_command!(/tmp/jruby6908283015188464435extract/gems/gems/railties-4.2.11.1/lib/rails/commands/commands_tasks.rb:123)
	at RUBY.runner(/tmp/jruby6908283015188464435extract/gems/gems/railties-4.2.11.1/lib/rails/commands/commands_tasks.rb:90)
	at RUBY.run_command!(/tmp/jruby6908283015188464435extract/gems/gems/railties-4.2.11.1/lib/rails/commands/commands_tasks.rb:39)
	at RUBY.<main>(/tmp/jruby6908283015188464435extract/gems/gems/railties-4.2.11.1/lib/rails/commands.rb:17)
	at org.jruby.RubyKernel.require(org/jruby/RubyKernel.java:978)
	at tmp.jruby6908283015188464435extract.$_dot_.META_minus_INF.rails.<main>(/tmp/jruby6908283015188464435extract/./META-INF/rails.rb:7)
