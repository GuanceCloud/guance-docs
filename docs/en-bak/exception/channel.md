# Manage Issues
---

After **[Issue creation](./issue.md)**, to present the specific information of Issues more intuitively to users, **Incidents** further manages all Issues generated in the current workspace through **Channels**.

Based on channels, you can customize the scope of Issues you want to follow, view subscribed members or notification targets, use time controls, or reply to Issues in various ways to achieve team collaboration. This article will introduce **how to manage Issues and related operations and configurations at the channel level.

## Channel List

Go to **Incidents > Channels**, each workspace has a default **All** channel, which displays all Issues. You can also create custom channels.

### Create a New Channel

Enter **Incidents**, at the bottom of the channel list on the left side of the current page, click **Add Channel**, enter the channel name, and the addition is complete.

<img src="../img/exception-1.png" width="80%" >

You can also create a new channel in the following situations:

- When [replying to an Issue](#reply-issue), type `#` in the reply content, and you can select **Add** in the pop-up window to create a new channel;

- In one of the [new Issue entry points](./issue.md#others) > Monitoring, in **Event Notification > Channel**, click the channel dropdown box, and you can create a new channel as needed.

## Manage Channels

After creating a channel, you can manage it as needed. On the right side of the channel list, you can configure a series of settings such as subscription, notification targets, filtering & searching; at the same time, all Issues associated with the current channel will be listed one by one, and you can open the detail page of a certain Issue by clicking on it.

### Basic Info

You can view or modify the name of the current channel, and you can add a description for the current channel, describing the background of the creation of the current channel and the scope of anomaly problem processing, etc.

**Note**: The default channel name cannot be changed; and the default channel cannot be deleted, only exited.

### Notice {#upgrade}

At the top left of the Issue list, click the icon :material-bell:, or click **Settings** to expand the display page.

- You can directly choose a more detailed [notification strategy](./config-manag.md#reate) to achieve more flexible notifications;

- You can add or remove notification targets; click the notification target dropdown box to view all members in the current workspace, select a member to add as a notification target, and the corresponding notification target will receive new Issue delivery and Issue processing daily report notifications. Select again to cancel.

- Upgrade configuration: You can set a specific number of minutes for new Issues, if no assignee is specified, then send an upgrade notification to the corresponding notification target.

<img src="../img/exception-5.png" width="50%" >

### Subscribe to Channels

At the top left of the Issue list, click the icon :material-bookmark-plus-outline:, you can choose the subscription function as needed.

1. Undertake: After subscribing, you will receive new Issue delivery, existing Issue reply, and daily Issue summary notifications;

2. Participate: After subscribing, you will receive new Issue notifications;

3. Follow: After subscribing, you will receive daily Issue summary notifications at 9:00 am every day;

4. None: Unsubscribe.

### Time Range Filtering {#time}

By default, all Issues are automatically listed, and you can add a time range for further filtering.

After selecting the date range, all audit events within the period will be listed. The default start time is `00:00:00`, and the default end time is `23:59:59`.

- After selecting the time range, click **Select Time** to customize the time range;

- Click **Clear** to clear the time filtering conditions.

![](img/exception-2.png)

### Filtering & Searching

In the filter and search bar at the top left of the Issue list, enter the corresponding filter & search conditions to accurately locate your target Issue.

- Filter conditions: Source, Severity, Status, Creator, Updater

- Search conditions: Issue Title, Issue Description

> For more information on search methods, see [Search Instructions](../getting-started/function-details/explorer-search.md#search).

### Issue Association Analysis

If the current Issue is already associated with certain events, the Icon will be displayed and the corresponding quantity will be shown. Click to jump to the event viewer to list the relevant event quantity statistics: including all associated events (whether they triggered incidents or were added later in comments).

### Issue Detail Page

Click on an Issue in the channel to open its detail page, where you can view the [status, severity, source, description, attachments](./issue.md#concepts) of the Issue;

You can also change the information here, please refer to the [Permission List](../management/role-list.md).

<img src="../img/exception-6.png" width="70%" >

### Reply to Issue {#reply-issue}

There are generally two reasons for the existence of reply records in an Issue:

1. A member initially creates an Issue or changes the Issue status, severity, description, and other related information;

2. Manual input of replies. For this situation, you can refer to the following instructions:

    - If you need to mention `members` in the reply content, and the `member` name exists, it will automatically trigger a notification; if the `member` name does not exist, it will not trigger a notification;


    - If you enter `#` in the reply content, there may be the following two scenarios:

        - The channel already exists: Once your reply is created successfully, the Issue will be delivered to the corresponding channel for display;

        - The channel does not exist: You can select **Add** in the pop-up window to create a new channel;


    - You can add links or upload images, videos, text (CSV/TXT/JSON/PDF, etc.) in the reply.

#### Modify or Delete Replies

Click the edit and delete buttons on the right side of the **Reply** to **edit** or **delete** the reply.

**Note**: Only the creator of the reply can modify the reply.
