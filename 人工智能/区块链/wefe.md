# 源码拆解

orm
```java
AbstractBlockChainEntity
AbstractEntity
AbstractUniqueIDEntity

log_time
updated_time
created_time
id uuid

base Entity + 自有的attr


SDK supports CNS. CnsService can configure CNS. The APIs are here:

String registerCns(String name, String version, String address, String abi): register CNS according to contract name, version, address and contract abi.
String getAddressByContractNameAndVersion(String contractNameAndVersion): inquire contract address according to contract name and version (connected with colon). If lack of contract version, it is defaulted to be the latest version.
List<CnsInfo> queryCnsByName(String name): inquire CNS information according to contract name.
List<CnsInfo> queryCnsByNameAndVersion(String name, String version): inquire CNS information according to contract name and version.


// 初始化RPC Server
Map<String, RpcServerAnnotate> rpcClassBeans = ClassUtil.loadRpcClassBeans();
if (rpcClassBeans.isEmpty()) {
    throw new Exception("start rpc server fail, is not exist available gRpc server.");
}
// Binding port
NettyServerBuilder serverBuilder = NettyServerBuilder.forPort(configProperties.getRpcServerPort());

for (Map.Entry<String, RpcServerAnnotate> entry : rpcClassBeans.entrySet()) {
    RpcServerAnnotate rpcServerAnnotateConfig = entry.getValue();
    BindableService rpcService = rpcServerAnnotateConfig.getRpcBean();
    List<Class<? extends ServerInterceptor>> interceptors = rpcServerAnnotateConfig.getInterceptors();
    if (CollectionUtils.isNotEmpty(interceptors)) {
        serverBuilder.addService(ServerInterceptors.intercept(rpcService, listToInstanceArray(interceptors)));
    } else {
        serverBuilder.addService(rpcService);
    }
}

// Set the maximum message that the server can receive（2000M）
serverBuilder.maxInboundMessageSize(2000 * 1024 * 1024);
serverBuilder.compressorRegistry(CompressorRegistry.getDefaultInstance());
serverBuilder.decompressorRegistry(DecompressorRegistry.getDefaultInstance());
serverBuilder.keepAliveTimeout(30, TimeUnit.SECONDS);
// Maximum space time
serverBuilder.maxConnectionIdle(120, TimeUnit.SECONDS);
serverBuilder.maxConnectionAge(120, TimeUnit.SECONDS);
serverBuilder.maxConnectionAgeGrace(180, TimeUnit.SECONDS);
// Start service
rpcServer = serverBuilder.build().start();
// Registration tick
Runtime.getRuntime().addShutdownHook(new Thread(InitRpcServer.this::stop));
// Start daemon
blockUntilShutdown();
```


区块链开发 ficos

https://fisco-bcos-documentation.readthedocs.io/zh_CN/v2.8.0/docs/sdk/java_sdk/quick_start.html?highlight=BcosSDK#configoptionbcossdk
