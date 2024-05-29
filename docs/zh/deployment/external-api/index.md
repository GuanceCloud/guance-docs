---
icon: zy/open-api
---

# 概述

---

观测云 External API 是一个简化的 HTTP REST API。

* 只有 GET / POST 请求
* 使用面向资源的 URL 调用 API
* 使用状态码指示请求成功或失败
* 所有请求返回 JSON 结构
* External API 以编程方式维护观测云平台

## 支持Endpoint

| 部署类型  | 节点名       | Endpoint                |
|-------|-----------|-------------------------|
| 私有部署版 | 私有部署版     | 以实际部署的 Endpoint 为准, 一般为`http://external-api.dataflux.cn` |

## API 文档配置

1. 接口文档地址固定为: \<Endpoint\>/v1/doc <br/>
例如: http://external-api.dataflux.cn/v1/doc

3. API 文档开关配置位于 launcher 中的 core (命名空间：forethought-core) 配置中。具体配置如下
```yaml
# API Doc
apiDocPageSwitch:
  # external api 接口文档页面开关, true: 表示开启; false: 表示关闭。默认`false`
  external: true

```

## 服务配置项

可选配置项位于 launcher 中的 core (命名空间：forethought-core) 配置中。具体可选配置如下
```yaml
# external-api 服务的配置项
external:
  # 每次请求签名的有效期, 单位秒, 默认 60秒
  timeliness: 60
  # 访问者标识, 对应接口请求头中的`X-Df-Access-Key`值; 非空字符串
  accessKey: ""
  # 用于计算签名的密钥
  secretKey: ""

```
