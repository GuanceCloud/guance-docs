# 接口签名认证

---

## 认证方式

接口以 API KEY 为认证方式，每一次请求使用请求体 Header 中的 *DF-API-KEY* 的值作为有效性检验。 以及本次请求的工作空间限定依据（取此 DF-API-KEY 所属的工作空间）。

当前 Open API 所展示的所有接口都只需要提供 API KEY（Header：DF-API-KEY）作为凭证。
如果凭据存在且有效，则视为认证通过。

获取方式见[API Key 管理](../management/api-key/index.md)


