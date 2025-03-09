# Manage Issues
---

After **[Issue creation is completed](./issue.md)**, to present Issue details more intuitively to users, **Incident** further manages all Issues generated within the current workspace through **Channels**.

Based on channels, you can customize the scope of Issues you want to subscribe to, view subscribers or notification targets, use time widgets, or collaborate through replying to Issues. This article will introduce <u>how to manage Issues at the channel level and related operations and configurations</u>.

## Channel List

Navigate to **Incident > Channels**, each workspace defaults to having an **All** channel where all Issues are displayed. You can also create custom channels.

### Create a Channel

Enter **Incident**, click **Add Channel** below the channel list on the left side of the current page, enter the channel name, and it will be added immediately.

![Create Channel](../img/exception-1.png)

You can also create a new channel in the following situations:

- When [replying to an Issue](#reply-issue), input `#` in the reply content, and choose **Add** from the popup to create a new channel;

- In [one of the Issue creation entries](./issue.md#others) > Monitoring, under **Event Notification > Channel**, click the channel dropdown box to create a new channel as needed.

## Channel Management

Once channels are created, they can be managed as required. On the right side of the channel list, you can perform subscriptions, notification target management, filtering & searching, etc.; meanwhile, all Issues associated with the current channel will be listed individually, clicking on an Issue opens its detail page.

### Basic Information

You can view or modify the current channel's name, add a description, explaining the background of the channel's creation and the scope of incident handling.

**Note**: The default channel name cannot be changed; and the default channel cannot be deleted, only exited.

### Upgrade Channel Notifications {#upgrade}

In the top-left corner of the Issue list, click the icon :material-bell:, or click **Settings**, expand the display page.

- Directly select [notification policies](./config-manag.md#create);

- Select notification targets; click the dropdown box, choose a notification target to receive Issue updates for the current channel;

- Upgrade configuration: Set up notifications to be sent to specified notification targets if a new Issue exceeds a certain number of minutes without an assigned responsible person.

![Upgrade Notification](../img/exception-5.png)

### Subscribe to Channels

In the top-left corner of the Issue list, click the icon :material-bookmark-plus-outline:, you can choose subscription options as needed.

1. Responsible: Subscribing will receive notifications for new Issues, replies to existing Issues, and daily Issue summaries;

2. Participate: Subscribing will receive notifications for new Issues;

3. Follow: Subscribing will receive daily Issue summaries at 9:00 AM;

4. None: Unsubscribe.

### Time Range Filtering {#time}

By default, all Issues are listed automatically. You can add a time range for further filtering.

After selecting a date range, all audit events within that period will be listed based on the selected time range. Default start time `00:00:00`, default end time `23:59:59`.

- After selecting a time range, click **Select Time** to define a custom time range;
- Click **Clear** to remove the time filter.

![](img/exception-2.png)

### Filtering & Searching

In the filtering and search bar at the top-left corner of the Issue list, enter the corresponding filtering & search conditions to precisely locate your target Issue.

- Filter conditions: Source, Severity, Status, Creator, Updater

- Search conditions: Issue Title, Issue Description

> For more information on search methods, refer to [Search Instructions](../getting-started/function-details/explorer-search.md#search).

### Issue Association Analysis

If an Issue is associated with certain events, the Icon will be displayed along with the corresponding count. Clicking on it will redirect you to the event viewer listing the related event statistics: including all associated events (whether triggered by Incident or subsequently added in comments).

### Issue Detail Page

Clicking on an Issue within a channel opens its detail page where you can view the Issue's [status, severity, source, description, attachments](./issue.md#concepts).

> You can also modify this information here; refer to [Permission List](../management/role-list.md).

![Issue Detail](../img/exception-6.png)

### Reply to Issues {#reply-issue}

Issue replies generally originate from two scenarios:

1. A member initially creates an Issue or changes the Issue’s status, severity, or description;
2. Manual input replies. For this scenario, follow these instructions:

1) If you need to mention a `member` in your reply and the `member` exists, automatic notifications will be triggered; if the `member` does not exist, no notification will be triggered;

2) If you input `#` in your reply, there are two possible scenarios:
   - The channel already exists: Once your reply is successful, the Issue will be delivered to the corresponding channel;
   - The channel does not exist: Choose **Add** from the popup to create a new channel;

3) You can add links or upload images, videos, text files (CSV/TXT/JSON/PDF, etc.) in your reply.

#### Modify or Delete Replies

Click the edit and delete buttons to the right of the **Reply** to **edit** or **delete** the reply.

**Note**: Only the creator of the reply can modify it.