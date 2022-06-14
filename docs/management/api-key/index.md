# API Key 管理
---


“观测云” 支持通过调用 Open API 接口的方式来获取和更新观测云工作空间的数据，在调用 API 接口前，需要先创建 API Key 作为认证方式。关于 API 介绍，可参考文档 [OpenAPI](../../management/api-key/open-api.md) 。


## 新建 API Key

在观测云工作空间「管理」-「API Key 管理」，点击右上角 「新建 Key」，输入 Key 名称，点击确定。<br />注意：API Key 管理支持管理员及以上可编辑。<br />![](../img/3_apikey_1.png)<br />点击确定后，即可获取用于调用的 API Key ID和密钥。<br />![](../img/3_apikey_2.png)<br />或通过在 API Key 管理列表右侧点击![](../img/3.apikey_5.png)获取 API Key ID和密钥，若不再需要或有泄露风险，可删除重新再创建。<br />![](../img/3.apikey_3.png)<br />新建/删除 API Key 都会产生操作审计事件，可在观测云工作空间「管理」-「基本设置」下的操作审计进行查看。<br />![](../img/3.apikey_4.png)


---


