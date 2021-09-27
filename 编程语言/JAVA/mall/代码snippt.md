# mall 中常见代码套路


# spring security 实现动态权限管理


```sh
mall-security
├── component
|    ├── JwtAuthenticationTokenFilter -- JWT登录授权过滤器
|    ├── RestAuthenticationEntryPoint -- 自定义返回结果：未登录或登录过期
|    └── RestfulAccessDeniedHandler -- 自定义返回结果：没有权限访问时
├── config
|    ├── IgnoreUrlsConfig -- 用于配置不需要安全保护的资源路径
|    └── SecurityConfig -- SpringSecurity通用配置
└── util
     └── JwtTokenUtil -- JWT的token处理工具类
```

基于路径的动态权限控制

http://www.macrozheng.com/#/technology/permission_back


## 解决依赖冲突

http://www.macrozheng.com/#/technology/swagger_upgrade

## 带参数和resp响应的代码

```java
@ApiOperation(value = "登录以后返回token")
@RequestMapping(value = "/login", method = RequestMethod.POST)
@ResponseBody
public CommonResult login(@Validated @RequestBody UmsAdminLoginParam umsAdminLoginParam) {
    String token = adminService.login(umsAdminLoginParam.getUsername(), umsAdminLoginParam.getPassword());
    if (token == null) {
        return CommonResult.validateFailed("用户名或密码错误");
    }
    Map<String, String> tokenMap = new HashMap<>();
    tokenMap.put("token", token);
    tokenMap.put("tokenHead", tokenHead);
    return CommonResult.success(tokenMap);
}
```


## 批量删除原有关系，并批量更新新关系

```java
@Override
public int allocMenu(Long roleId, List<Long> menuIds) {
    //先删除原有关系
    QueryWrapper<UmsRoleMenuRelation> wrapper = new QueryWrapper<>();
    wrapper.lambda().eq(UmsRoleMenuRelation::getRoleId,roleId);
    roleMenuRelationService.remove(wrapper);
    //批量插入新关系
    List<UmsRoleMenuRelation> relationList = new ArrayList<>();
    for (Long menuId : menuIds) {
        UmsRoleMenuRelation relation = new UmsRoleMenuRelation();
        relation.setRoleId(roleId);
        relation.setMenuId(menuId);
        relationList.add(relation);
    }
    roleMenuRelationService.saveBatch(relationList);
    return menuIds.size();
}
```

## 更新密码

```java
@Override
public boolean update(Long id, UmsAdmin admin) {
    admin.setId(id);
    UmsAdmin rawAdmin = getById(id);
    if(rawAdmin.getPassword().equals(admin.getPassword())){
        //与原加密密码相同的不需要修改
        admin.setPassword(null);
    }else{
        //与原加密密码不同的需要加密修改
        if(StrUtil.isEmpty(admin.getPassword())){
            admin.setPassword(null);
        }else{
            admin.setPassword(passwordEncoder.encode(admin.getPassword()));
        }
    }
    boolean success = updateById(admin);
    adminCacheService.delAdmin(id);
    return success;
}
```

http://www.macrozheng.com/#/architect/mall_arch_02


# 核心业务逻辑

http://www.macrozheng.com/#/database/mall_oms_02

http://www.macrozheng.com/#/database/mall_oms_03