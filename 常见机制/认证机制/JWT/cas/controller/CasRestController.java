package org.jeecg.modules.cas.controller;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringPool;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.jeecg.common.api.vo.Result;
import org.jeecg.common.constant.CommonConstant;
import org.jeecg.common.system.util.JwtUtil;
import org.jeecg.common.util.PasswordUtil;
import org.jeecg.common.util.RedisUtil;
import org.jeecg.modules.cas.entity.CasUser;
import org.jeecg.modules.cas.util.CASServiceUtil;
import org.jeecg.modules.cas.util.XmlUtils;
import org.jeecg.modules.system.entity.SysDepart;
import org.jeecg.modules.system.entity.SysUser;
import org.jeecg.modules.system.service.ISysDepartService;
import org.jeecg.modules.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * CAS单点登录服务端REST用户验证
 *
 * @author xufeixiang
 * @since 2018-12-20
 */
@Slf4j
@RestController
@RequestMapping("/sys/cas/rest")
public class CasRestController {

    @Autowired
    private ISysUserService sysUserService;

    @Autowired
    private ISysDepartService sysDepartService;

    @ApiOperation("CAS用户验证")
    @RequestMapping(value = "/validateUser", method = RequestMethod.POST)
    public ResponseEntity<CasUser> validateUser(@RequestHeader HttpHeaders httpHeaders) {
        log.info("Rest api login.");
        // 根据官方文档，当请求过来时，会通过把用户信息放在请求头authorization中，并且通过Basic认证方式加密
        // 1. 将得到 Basic Base64(用户名:密码)
        String authorization = httpHeaders.getFirst("authorization");
        if (org.apache.commons.lang3.StringUtils.isEmpty(authorization)) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        // 2. 解密base64获取密码
        String baseCredentials = org.apache.commons.lang3.StringUtils.split(authorization, StringPool.SPACE)[1];
        String usernamePassword = new String(Base64Utils.decodeFromString(baseCredentials), StandardCharsets.UTF_8);
        String[] credentials = StringUtils.split(usernamePassword, StringPool.COLON);
        String username = credentials[0], password = credentials[1];

        // 3. 校验用户是否有效
        LambdaQueryWrapper<SysUser> queryWrapper = new LambdaQueryWrapper<SysUser>().eq(SysUser::getUsername, username);
        SysUser sysUser = sysUserService.getOne(queryWrapper);
        if (null == sysUser) {
            // 3.1 用户不存在
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
        if (CommonConstant.DEL_FLAG_1.equals(sysUser.getDelFlag())) {
            // 3.2 用户已注销
            return new ResponseEntity<>(HttpStatus.FORBIDDEN);
        }
        if (CommonConstant.USER_FREEZE.equals(sysUser.getStatus())) {
            // 3.3 用户已冻结
            return new ResponseEntity<>(HttpStatus.LOCKED);
        }

        // 4. 校验用户名或密码是否正确
        String userPassword = PasswordUtil.encrypt(username, password, sysUser.getSalt());
        String sysPassword = sysUser.getPassword();
        if (!sysPassword.equals(userPassword)) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

        // 5. 获取用户部门信息
        List<SysDepart> departs = sysDepartService.queryUserDeparts(sysUser.getId());
        Map<String, Object> attributes = new HashMap<>(4);
        attributes.put("departs", departs);
        CasUser casUser = new CasUser().setId(username).setAttributes(attributes);
        log.info("[{}] login is ok", username);
        return new ResponseEntity<>(casUser, HttpStatus.OK);
    }


}
