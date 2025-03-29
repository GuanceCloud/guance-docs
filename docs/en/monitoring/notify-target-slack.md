# Slack
---

Incoming Webhooks is a way to send messages from other applications to Slack. After enabling Incoming Webhooks, you will receive a unique URL for sending JSON data packets that include message text and some options.

> For more details, refer to [Sending Messages Using Incoming Webhooks](https://api.slack.com/messaging/webhooks).

???+ warning "Note"

    This notification target only applies to workspaces on overseas sites.

## Enabling Incoming Webhooks

1. Log in and go to the Slack > Applications page;
2. Select Incoming Webhooks;
3. Click add, and choose to add it to Slack;
4. Select a channel as the target channel for the bot to post messages;
5. Proceed to the next step;
6. The system will generate a unique Webhook URL for subsequent message pushes;
7. Save settings;
8. Return to the channel, and the integration will be displayed as added.


<img src="../img/notify_target_slack.png" width="70%" >

<img src="../img/notify_target_slack_1.png" width="70%" >

<img src="../img/notify_target_slack_2.png" width="70%" >

<img src="../img/notify_target_slack_3.png" width="70%" >


## Returning to the Slack Configuration Page

1. Enter the Webhook address obtained in the steps above;
2. Confirm.