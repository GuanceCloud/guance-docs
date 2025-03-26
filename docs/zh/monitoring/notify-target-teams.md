# Teams
---

传入 Webhook 允许外部应用在 Microsoft Teams 的聊天和频道中共享内容，作为跟踪和通知的工具。当收到 Webhook 请求时，您可以向相应的频道或聊天发送消息。


> 更多详情，可参考 [为 Microsoft Teams 创建 Webhook](https://support.microsoft.com/en-us/office/create-incoming-webhooks-with-workflows-for-microsoft-teams-8ae491c7-0394-4861-ba59-055e33f75498)。

???+ warning "注意"

    该通知对象仅适用于海外站点的工作空间。

## 从模板创建 Webhook 工作流

1. 打开**工作流程**页面；
2. 选择**收到 Webhook 请求时发布到渠道**为工作流；
3. 打开流程后，可以更改名称，并使用账户进行身份验证；
4. 选择团队、渠道作为通知发布的目标位置；
5. 添加完成后，会显示一个对话框，其中包含可以复制的 URL。

<img src="../img/notify_target_teams.png" width="60%" >

<img src="../img/notify_target_teams_1.png" width="50%" >

<img src="../img/notify_target_teams_2.png" width="50%" >

<img src="../img/notify_target_teams_3.png" width="50%" >


## 回到 Teams 配置页面

1. 填入在上述步骤获取的 Webhook 地址；
2. 确认。