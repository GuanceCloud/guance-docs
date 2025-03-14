# 申请 License

<<< custom_key.brand_name >>>部署版为老师、学生、云计算爱好者等社区用户提供一个简单易得又功能完备的产品化本地部署平台。欢迎免费申请并下载试用，搭建您自己的<<< custom_key.brand_name >>>平台，体验完整的产品功能。

## 步骤


### 注册部署版账号

直接打开部署版注册地址（[https://<<< custom_key.boss_domain >>>/index.html#/signup?type=private](https://<<< custom_key.boss_domain >>>/index.html#/signup?type=private)），根据提示注册部署版账号。

![](img/6.deployment_3.png)

注册完成后，进入<<< custom_key.brand_name >>>部署版费用中心。


### 获取 AK/SK

在<<< custom_key.brand_name >>>部署版费用中心的“AK 管理”，点击“创建 AK”，创建的 AK 和 SK 复制后可填入 “Step4：激活部署版”的 AK 和 SK 中。

![](img/6.deployment_5.png)

### 获取 License

在<<< custom_key.brand_name >>>部署版费用中心的 “License 管理”，点击“创建 License”，创建 License 时需要同意部署版用户许可协议并通过手机验证。创建的 License 复制后可填入“Step2：激活部署版”的 License 文本中。

![](img/6.deployment_6.png)


**注意**：

1. 获取 License 之后，请前往激活。若未激活 License，则无法查询数据。

2. 数据网关地址后面的 **`**?token={}**`**原样保留，不要移除，不需要写具体的 token，**`**{}**`**只是个占位。
 
## FAQ {#faq}

:material-chat-question: 如何申请一个有 DK 数量限制的 License？

1. 访问 launcher 控制台；
2. 进入修改应用配置界面；
3. 修改 [kodo-inner 组件](./application-configuration-guide.md#kodo-inner)下的 `datakit_usage_check_enabled` 配置项，从而决定检测 DataKit 数量是否超过 License 限制。

## 更多阅读

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **激活<<< custom_key.brand_name >>>**</font>](./activate.md)

</div>

</font>