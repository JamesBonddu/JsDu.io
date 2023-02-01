# ambari 编译报错

cd /tmp/phantomjs/ && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2

```sh
[INFO] Directory /home/ambari/apache-ambari-2.7.5-src/ambari-project/target/rpm/ambari-project/buildroot already exists. Deleting all contents.
[[IINNFFOO]]  错C误r：esattaitn g/ hsopmeec/ afmiblaer i//haopmaec/haem-baamrbia/raip-a2c.h7e.-5-asmrbca/raim-b2a.r7i.-5p-rsorjce/camtb/atrair-gperto/jercptm//taamrbgaerti/-rpprmo/jaemcbta/rSiP-EpCrSo/jaemcbta/rSPiE-CpSr/oajmbeacrti.-sppreocj e失c败t：.没s有p那e个c文件或目录

[INFO] 构建目标平台：noarch-openEuler-linux
[INFO] 为目标noarch-openEuler-linux构建


[ERROR] error /home/ambari/apache-ambari-2.7.5-src/ambari-web/node_modules/mocha-phantomjs/node_modules/phantomjs: Command failed.
[ERROR] Exit code: 1
[ERROR] Command: sh
[ERROR] Arguments: -c node install.js
[ERROR] Directory: /home/ambari/apache-ambari-2.7.5-src/ambari-web/node_modules/mocha-phantomjs/node_modules/phantomjs
[ERROR] Output:
[INFO] info Visit https://yarnpkg.com/en/docs/cli/install for documentation about this command.
[ERROR] Downloading https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2
[ERROR] Saving to /tmp/phantomjs/phantomjs-1.9.7-linux-x86_64.tar.bz2
[ERROR] Receiving...
[ERROR]
[ERROR] Error requesting archive.
[ERROR] Status: 429
[ERROR] Request options: {
[ERROR]   "uri": "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2",
[ERROR]   "encoding": null,
[ERROR]   "followRedirect": true,
[ERROR]   "headers": {},
[ERROR]   "strictSSL": true
[ERROR] }
[ERROR] Response headers: {
[ERROR]   "content-security-policy-report-only": "style-src 'self' 'unsafe-inline' https://aui-cdn.atlassian.com https://d301sr5gafysq2.cloudfront.net; base-uri 'self'; connect-src bitbucket.org *.bitbucket.org bb-inf.net *.bb-inf.net id.atlassian.com api.atlassian.com wss://bitbucketci-ws-service.services.atlassian.com analytics.atlassian.com as.atlassian.com api-private.stg.atlassian.com api-private.atlassian.com cofs.staging.public.atl-paas.net cofs.prod.public.atl-paas.net intake.opbeat.com api.media.atlassian.com api.segment.io xid.statuspage.io xid.atlassian.com xid.sourcetreeapp.com bam.nr-data.net bam-cell.nr-data.net www.google-analytics.com sentry.io *.ingest.sentry.io bqlf8qjztdtr.statuspage.io https://d301sr5gafysq2.cloudfront.net; object-src 'none'; default-src 'self' 'unsafe-inline' 'unsafe-eval' data: blob: *; script-src 'unsafe-eval' 'strict-dynamic' 'unsafe-inline' 'self' http: https: https://d301sr5gafysq2.cloudfront.net; report-uri https://web-security-reports.services.atlassian.com/csp-report/bb-website",
[ERROR]   "server": "envoy",
[ERROR]   "x-usage-quota-remaining": "999200.457",
[ERROR]   "vary": "Accept-Language, Origin",
[ERROR]   "x-usage-request-cost": "808.47",
[ERROR]   "cache-control": "max-age=0, no-cache, no-store, must-revalidate",
[ERROR]   "content-type": "text/plain",
[ERROR]   "x-b3-traceid": "c5cd43f1db956227",
[ERROR]   "x-usage-output-ops": "0",
[ERROR]   "x-dc-location": "Micros-3",
[ERROR]   "strict-transport-security": "max-age=31536000; includeSubDomains; preload",
[ERROR]   "date": "Tue, 11 Oct 2022 11:14:33 GMT",
[ERROR]   "x-usage-user-time": "0.024254",
[ERROR]   "x-usage-system-time": "0.000000",
[ERROR]   "expires": "Tue, 11 Oct 2022 11:14:33 GMT",
[ERROR]   "x-served-by": "4e2ab9e0185e",
[ERROR]   "x-envoy-upstream-service-time": "40",
[ERROR]   "content-language": "en",
[ERROR]   "x-view-name": "bitbucket.apps.downloads.views.download_file",
[ERROR]   "x-static-version": "1ed9a0ac4168",
[ERROR]   "x-render-time": "0.02954840660095215",
[ERROR]   "connection": "close",
[ERROR]   "x-usage-input-ops": "0",
[ERROR]   "x-frame-options": "SAMEORIGIN",
[ERROR]   "x-version": "1ed9a0ac4168",
[ERROR]   "x-request-count": "871",
[ERROR]   "x-cache-info": "not cacheable; response code not cacheable",
[ERROR]   "content-length": "46"
[ERROR] }
[ERROR] Make sure your network and proxy settings are correct.
[ERROR]
[ERROR] If you continue to have issues, please report this full log at https://github.com/Medium/phantomjs
[INFO] ------------------------------------------------------------------------

```

node版本不匹配

```sh
[root@server-openeuler-1 apache-ambari-2.7.5-src]# node -v
v12.22.11
[root@server-openeuler-1 apache-ambari-2.7.5-src]# npm -v
6.14.16
```


```sh
Stack trace:
SyntaxError: Unexpected token {
    at exports.runInThisContext (vm.js:53:16)
    at Module._compile (module.js:373:25)
    at Object.Module._extensions..js (module.js:416:10)
    at Module.load (module.js:343:32)
    at Function.Module._load (module.js:300:12)
    at Module.require (module.js:353:17)
    at require (internal/module.js:12:17)
    at Object.<anonymous> (/home/ambari/apache-ambari-2.7.5-src/ambari-admin/src/main/resources/ui/admin-web/node_modules/bower/node_modules/bower-registry-client/node_modules/request/lib/cookies.js:3:13)
    at Module._compile (module.js:409:26)
    at Object.Module._extensions..js (module.js:416:10)

Console trace:
Trace
    at StandardRenderer.error (/home/ambari/apache-ambari-2.7.5-src/ambari-admin/src/main/resources/ui/admin-web/node_modules/bower/lib/renderers/StandardRenderer.js:72:17)
    at Logger.<anonymous> (/home/ambari/apache-ambari-2.7.5-src/ambari-admin/src/main/resources/ui/admin-web/node_modules/bower/bin/bower:111:22)
    at emitOne (events.js:77:13)
    at Logger.emit (events.js:169:7)
    at Logger.emit (/home/ambari/apache-ambari-2.7.5-src/ambari-admin/src/main/resources/ui/admin-web/node_modules/bower/node_modules/bower-logger/lib/Logger.js:29:39)
    at /home/ambari/apache-ambari-2.7.5-src/ambari-admin/src/main/resources/ui/admin-web/node_modules/bower/lib/commands/index.js:40:20
    at _rejected (/home/ambari/apache-ambari-2.7.5-src/ambari-admin/src/main/resources/ui/admin-web/node_modules/bower/node_modules/q/q.js:797:24)
    at /home/ambari/apache-ambari-2.7.5-src/ambari-admin/src/main/resources/ui/admin-web/node_modules/bower/node_modules/q/q.js:823:30
    at Promise.when (/home/ambari/apache-ambari-2.7.5-src/ambari-admin/src/main/resources/ui/admin-web/node_modules/bower/node_modules/q/q.js:1035:31)
    at Promise.promise.promiseDispatch (/home/ambari/apache-ambari-2.7.5-src/ambari-admin/src/main/resources/ui/admin-web/node_modules/bower/node_modules/q/q.js:741:41)



[INFO] --- exec-maven-plugin:1.2.1:exec (Bower install) @ ambari-admin ---
fs.js:36
} = primordials;
    ^

ReferenceError: primordials is not defined
    at fs.js:36:5
    at req_ (/home/ambari/apache-ambari-2.7.5-src/ambari-admin/src/main/resources/ui/admin-web/node_modules/bower/node_modules/graceful-fs/node_modules/natives/index.js:143:24)
    at Object.req [as require] (/home/ambari/apache-ambari-2.7.5-src/ambari-admin/src/main/resources/ui/admin-web/node_modules/bower/node_modules/graceful-fs/node_modules/natives/index.js:55:10)
    at Object.<anonymous> (/home/ambari/apache-ambari-2.7.5-src/ambari-admin/src/main/resources/ui/admin-web/node_modules/bower/node_modules/graceful-fs/fs.js:1:37)
    at Module._compile (internal/modules/cjs/loader.js:999:30)
    at Object.Module._extensions..js (internal/modules/cjs/loader.js:1027:10)
    at Module.load (internal/modules/cjs/loader.js:863:32)
    at Function.Module._load (internal/modules/cjs/loader.js:708:14)
    at Module.require (internal/modules/cjs/loader.js:887:19)
    at require (internal/modules/cjs/helpers.js:74:18)

```


```sh
[root@server-openeuler-1 apache-ambari-2.7.5-src]# node -v
v12.22.11
[root@server-openeuler-1 apache-ambari-2.7.5-src]# npm -v
6.14.16

npm install -g n

sudo n 11.15.0

npm install gulp@^3.9.1
npm install
npm rebuild node-sass
```

https://stackoverflow.com/questions/55921442/how-to-fix-referenceerror-primordials-is-not-defined-in-node-js
