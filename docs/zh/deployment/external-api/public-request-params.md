# 公共请求参数

---

本文介绍 External API 的公共请求参数。 

## 公共请求头(Header)

| 参数名             | 必选     | 示例                 | 描述                                                                                          |
|:----------------|:-------|:-------------------|:--------------------------------------------------------------------------------------------|
| Content-Type    | 是      | application/json   | 请求内容类型, API 接口必须强制添加该请求头，且默认值为 application/json                                             |
| X-Df-Access-Key | 是      | e243xxxxxxxx       | 访问者标识。该值即为 「服务配置项」中描述的 `accessKey`  |
| X-Df-Timestamp | 是      | 1711701527         | 请求发起的时间点，秒级时间戳。允许的误差绝对值为「服务配置项」中描述的`timeliness`的值，超过这个时间范围将引发 `ft.MissingAuthHeaderInfo` 异常 |
| X-Df-SVersion | 是      | v20240417          | 签名算法版本, 固定为: `v20240417` |
| X-Df-Nonce | 是      | 5931f3059ba244dxxx | 每次请求生成的随机临值 |
| X-Df-Signature | 是      | 4SW5WlUkeNoFsh+KPdJob2SAdZ2hrp7l2txXjCAub2g= | 签名结果值 |


