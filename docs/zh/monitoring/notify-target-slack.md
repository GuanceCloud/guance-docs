# Slack
---

Incoming Webhooks 是一种从其他应用向 Slack 发送消息的方式。启用 Incoming Webhooks 后，您将获得一个唯一的 URL，用于发送包含消息文本和一些选项的 JSON 数据包。

> 更多详情，可参考 [使用 Incoming Webhooks 发送消息](https://api.slack.com/messaging/webhooks)。

???+ warning "注意"

    该通知对象仅适用于海外站点的工作空间。

## 启用 Incoming Webhooks

1. 登录进入 Slack > 应用页面；
2. 选择 Incoming Webhooks；
3. 点击添加，选择将其添加到 Slack；
4. 选择一个频道作为机器人发布消息的目标频道；
5. 进入下一步；
6. 系统会生成一个唯一的 Webhook URL，用于后续的消息推送；
7. 保存设置；
8. 回到该频道，显示已添加该集成。


<img src="../img/notify_target_slack.png" width="70%" >

<img src="../img/notify_target_slack_1.png" width="70%" >

<img src="../img/notify_target_slack_2.png" width="70%" >

<img src="../img/notify_target_slack_3.png" width="70%" >


## 回到 Slack 配置页面

1. 填入在上述步骤获取的 Webhook 地址；
2. 确认。