package org.jeecg.modules.cas.entity;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.experimental.Accessors;

import java.util.HashMap;
import java.util.Map;

/**
 * 用于传递给CAS服务器验证数据
 *
 * @author xufeixiang
 * @date 2022年01月20日 4:51 PM
 */
@Data
@Accessors(chain = true)
public class CasUser {

    @JsonProperty("id")
    private String id;

    @JsonProperty("@class")
    private String clazz = "org.apereo.cas.authentication.principal.SimplePrincipal";

    @JsonProperty("attributes")
    private Map<String, Object> attributes = new HashMap<>();

}
