#  SLS 存储
---

## 简介

观测云产品的存储方案支持 SLS 存储，支持阿里云 SLS 用户能够快速使用观测云进行数据查看分析。

本文将介绍观测云商业版中，阿里云账号结算模式下，选择 SLS 存储方案操作流程。关于直接注册商业版，可参考文档 [注册商业版](../../billing/commercial-version.md) 。

???+ attention

    - SLS 存储方案仅支持 ”中国区-杭州“、”中国区-张家口“站点，一旦选择 SLS 数据存储方案后便不能更改；
    - 选择 SLS 存储方案的工作空间默认开启多索引，且不支持删除指标集。
    - SLS 存储使用的语言是 promql，存在部分函数无法使用的情况。更多关于 SLS 函数相关信息，可参考文档 [DQL 函数](../../dql/funcs.md#sls)。


## 一键注册商业版 SLS 存储流程

在观测云商业版注册页面，按照注册步骤进入 “选择结算方式” ，选择 “阿里云账号结算“，填写“阿里云用户 ID” 和“商品实例 ID” ，点击 下一步，进入存储方式选择界面。

![](../img/1.sls_1.png)

​       

在选择存储方式页面，默认选择 “默认存储” ，支持选择 “SLS 存储” 。

- 当您选择“默认存储”时，点击下一步，直接跳转成功开通页面。

- 当您选择 “SLS 存储” 时，点击下一步，显示用户服务协议，同意后进入阿里云账号绑定页面。

![](../img/1.sls_3.png)

同意用户使用协议，并点击下一步。

![](../img/1.sls_7.png)

下载获取 SLS 授权文件，在 [阿里云控制台](https://www.aliyun.com/) 创建阿里云 RAM 账号，获取该账号的 AccessKey ID、AccessKey Secret 信息。

关于使用 SLS 授权文件给 RAM 账号授权的具体操作，可参考文档 [RAM账号授权](../../billing/billing-method/sls-grant.md) 。

![](../img/1.sls_4.png)

填写 AccessKey ID、AccessKey Secret 并进行验证，若验证通过，可以进行下一步；若验证未通过，提示 “该AK无效，请重新填写”。

![](../img/1.sls_6.png)



​     验证通过后，点击 确认开通，提示 “成功开通观测云商业版”。

![](../img/1.sls_8.png)


## 阿里云一键开通商业版 SLS 存储流程

若您在 [阿里云云市场](https://market.aliyun.com/products/56838014/cmgj00053362) 已购买观测云，您可以在阿里云控制台“已购买的服务”中，点击右侧的“免登”按钮， [开通观测云商业版](../../billing/billing-account/aliyun-account.md#aliyun-register) 并按照以上的步骤选择 SLS 存储。
