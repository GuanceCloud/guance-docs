# 飞书机器人

飞书自定义机器人是一种仅限于在创建它的群聊中使用的自动化工具。它能够在无需租户管理员审核的情况下，通过调用预设的 webhook 地址来实现消息的自动推送功能。

> 更多详情，可参考 [自定义机器人使用指南](https://open.feishu.cn/document/client-docs/bot-v3/add-custom-bot)。

## 在群组中添加自定义机器人

### 邀请自定义机器人进群

1. 进入**群组 > 设置 > 群机器人**页面；
2. 进入**添加机器人**页面；
3. 选择**自定义机器人**；
4. 设置自定义机器人的头像、名称与描述，并点击**添加**。


<img src="../img/notify_target_lark.png" width="60%" >

<img src="../img/notify_target_lark_1.png" width="60%" >

<img src="../img/notify_target_lark_2.png" width="60%" >

<img src="../img/notify_target_lark_3.png" width="60%" >

### 获取 Webhook 地址

机器人创建完成后，可直接复制 Webhook 地址。

<img src="../img/notify_target_lark_4.png" width="60%" >

在群组中添加自定义机器人后，可以为机器人添加安全设置。

比如，为机器人设置签名校验。发送的请求必须通过签名校验，才可以成功请求 Webhook 发送消息。

勾选后，自动为您提供密钥。

<img src="../img/notify_target_lark_5.png" width="60%" >


## 回到飞书机器人配置页面

1. 填入在上述步骤获取的 Webhook 地址；
2. 按需填入飞书签名校验密钥。

