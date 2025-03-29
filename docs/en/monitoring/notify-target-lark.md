# Lark Bots

A Lark custom bot is an automation tool that can only be used in the group chat where it was created. It can push messages automatically by calling a preset webhook address without requiring tenant administrator approval.

> For more details, refer to the [Custom Bot Usage Guide](https://open.feishu.cn/document/client-docs/bot-v3/add-custom-bot).

## Adding a Custom Bot to a Group

### Inviting a Custom Bot into the Group

1. Go to the **Group > Settings > Group Bots** page;
2. Enter the **Add Bot** page;
3. Select **Custom Bot**;
4. Set the avatar, name, and description for the custom bot and click **Add**.


<img src="../img/notify_target_lark.png" width="60%" >

<img src="../img/notify_target_lark_1.png" width="60%" >

<img src="../img/notify_target_lark_2.png" width="60%" >

<img src="../img/notify_target_lark_3.png" width="60%" >

### Obtaining the Webhook Address

After creating the bot, you can directly copy the Webhook address.

<img src="../img/notify_target_lark_4.png" width="60%" >

After adding a custom bot to the group, security settings can be added for the bot.

For example, setting up signature verification for the bot. Requests must pass the signature verification to successfully send messages via the Webhook.

When selected, a secret key will be automatically provided for you.

<img src="../img/notify_target_lark_5.png" width="60%" >


## Returning to the Lark Bot Configuration Page

1. Fill in the Webhook address obtained from the previous steps;
2. Optionally fill in the Lark signature verification secret key.