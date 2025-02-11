# Managing Issues
---

After **[Issue Creation](./issue.md)** is completed, to present Issue details more intuitively to users, **Incident** further manages all Issues generated within the current workspace through **Channels**.

Based on channels, you can customize the scope of Issues you wish to subscribe to, view subscribed members or notification targets, use time controls, or collaborate via replies to Issues. This article will introduce how to manage Issues and related operations and configurations at the channel level.

## Channel List

Enter **Incident > Channels**, each workspace defaults to having an **All** channel, which displays all Issues. You can also create custom channels.

### Creating a New Channel

Enter **Incident**, click **Add Channel** below the channel list on the left side of the current page, enter the channel name, and it will be added.

![Exception-1](../img/exception-1.png)

You can also create a new channel in the following situations:

- When [Replying to an Issue](#reply-issue), input `#` in the reply content, and choose **Add** from the pop-up window to create a new channel;

- In [One of the Issue Creation Entrances](./issue.md#others) > Monitoring, under **Event Notification > Channel**, click the channel dropdown box to create a new channel as needed.

## Channel Management

After creating a channel, you can manage it as needed. On the right side of the channel list, you can configure subscriptions, notification targets, filtering & searching, etc. All Issues associated with the current channel are listed individually; clicking on an Issue opens its detail page.

### Basic Information

You can view or modify the current channel's name and add a description explaining the background of the channel's creation and the scope of incident handling.

**Note**: The default channel name cannot be changed; and the default channel cannot be deleted, only exited.

### Upgrading Channel Notifications {#upgrade}

In the top-left corner of the Issue list, click the icon :material-bell:, or click **Settings**, to expand the display page.

- You can directly select a more detailed [Notification Policy](./config-manag.md#reate) to make notifications more flexible;

- You can add or remove notification targets; click the notification target dropdown box to view all members of the current workspace, select a member to add them as a notification target. Selected members will receive notifications for new Issues and daily Issue handling reports. Selecting again will cancel the subscription.

- Upgrade Configuration: You can set up an upgrade notification to be sent to corresponding notification targets if a new Issue exceeds a specific number of minutes without a designated responsible person.

![Exception-5](../img/exception-5.png)

### Subscribing to Channels

In the top-left corner of the Issue list, click the icon :material-bookmark-plus-outline: to choose subscription options as needed.

1. Responsible: Subscribing will receive notifications for new Issues, replies to existing Issues, and daily Issue summaries;
2. Participating: Subscribing will receive notifications for new Issues;
3. Watching: Subscribing will receive daily Issue summaries at 9:00 AM;
4. None: Unsubscribe.

### Time Range Filtering {#time}

By default, all Issues are listed. You can add a time range for further filtering.

After selecting a date range, all audit events within that period will be listed. The default start time is `00:00:00`, and the default end time is `23:59:59`.

- After selecting a time range, click **Select Time** to customize the time range;
- Click **Clear** to remove the time filter condition.

![Exception-2](../img/exception-2.png)

### Filtering & Searching

In the filter and search bar at the top-left of the Issue list, input the corresponding filter and search conditions to precisely locate your target Issue.

- Filter Conditions: Source, Severity, Status, Creator, Updater
- Search Conditions: Issue Title, Issue Description

> For more information on search methods, refer to [Search Instructions](../getting-started/function-details/explorer-search.md#search).

### Issue Correlation Analysis

If an Issue is associated with certain events, an icon showing the count of related events will be displayed. Clicking it will redirect you to the Event Viewer listing all related events (whether they were triggered by Incident or subsequently added in comments).

### Issue Detail Page

Clicking on an Issue within a channel opens its detail page where you can view the Issue's [status, severity, source, description, attachments](./issue.md#concepts).

> You can also modify this information here; refer to the [Permission List](../management/role-list.md).

![Exception-6](../img/exception-6.png)

### Replying to Issues {#reply-issue}

Issue reply records generally originate from two scenarios:

1. A member initially creates an Issue or changes the Issue's status, severity, or description;
2. Manual replies. For this scenario, follow these instructions:

1) If you need to mention a `member` in your reply and the `member` exists, it will automatically trigger a notification; if the `member` does not exist, no notification will be triggered;

2) If you input `#` in your reply, there may be two scenarios:
   - If the channel exists: Once your reply is successful, the Issue will be delivered to the corresponding channel.
   - If the channel does not exist: You can choose **Add** from the pop-up window to create a new channel;

3) You can add links or upload images, videos, text files (CSV/TXT/JSON/PDF, etc.) in your reply.

#### Editing or Deleting Replies

Click the edit or delete button next to the **Reply** to edit or delete the reply.

**Note**: Only the creator of the reply can modify it.