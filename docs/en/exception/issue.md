# Create Issue
---

An Issue is used to integrate information about the source of anomalies, descriptions, and related members within a workspace. Any abnormal phenomena observed by any member will be defined as an Issue and automatically notify relevant members for tracking and handling.

## Concepts {#concepts}

| Field | Description |
| --- | --- |
| Channel | Defaults to "All," supports custom addition of other channels. |
| Title | The title of the Issue. |
| Description | Detailed description of the current Issue's phenomenon, supports notifying via `@member` in the text box or adding `#channel` to deliver the current Issue to the corresponding channel. |
| Priority | Optional; default priority levels can be selected, with urgency levels being: P0 > P1 > P2; supports manual modification;<br/>you can also choose [custom priorities](#level). |
| Source | Includes the following sources: Dashboard, Unresolved Incidents, Events, Explorer, Monitors. |
| Assignee | When creating an Issue, <<< custom_key.brand_name >>> sends email notifications to the assignee.<br/>You can select **members or teams** from the current workspace as assignees; you can also manually input **external emails** and add them by pressing Enter. |
| Attachments | Supports uploading images, videos, text (CSV/TXT/JSON/PDF, etc.) in the **Issue Details Page**;<br/>supports configuring associated links. |
| Status | The status of the Issue.<br/>`open`: Not started. Default status when an Issue is created.<br/>`working`: In progress. Issue has been accepted by the assignee and is being handled.<br/>`pending`: Waiting. Issue is determined to be unsolvable in a short time.<br/>`resolved`: Resolved. Issue has been resolved.<br/>`closed`: Closed. Issue does not need to be solved or is deemed normal. |



## Create Issue

Creating an Issue supports two methods: manual creation and automatic creation.

### Manual Creation {#manual}

#### Incident

Go to **Incident**, click **Create Issue**.

#### Dashboard {#dashboards}

Go to **Use Cases > Dashboard > Settings**, click **Create Issue**;

The name of the current dashboard will automatically be set as the source name for this Issue. Clicking **Source** will redirect to the corresponding dashboard, if it doesn't exist, it will redirect to the **Use Cases** default page.

![](img/issue-cpu.png)

#### Explorer 

In the <<< custom_key.brand_name >>> workspace, you can click the button at the bottom right corner on various Explorer-level feature pages to create an Issue.

For example, in **Logs > Explorer**, clicking the **Create Issue** icon at the bottom right will take you to the creation page.
 
Hovering over the source will display the origin of that Issue. Clicking it will redirect to the corresponding Explorer. <<< custom_key.brand_name >>> filters based on the time range and search conditions saved when the Issue was created.

![](img/exception-issue-2.png)


You can also click into the details page of a log under **Explorer**, and similarly click the button at the bottom right to create an Issue. The page will automatically show the current Explorer details page as the source of the Issue. Clicking **Source** will redirect to the corresponding Explorer details page, if the data no longer exists, it will redirect to the default display state of the **Explorer**.

![](img/issue-detail.png)

#### Event {#event}

Entry 1: Hover over an event list, then click the **Issue** link that appears on the left.

The title of the event will automatically be set as the source name for the Issue. Clicking **Source** will redirect to the corresponding event details page, if the event no longer exists, it will redirect to the default entry page for **Events**.

![](img/exception-issue-4.png)


 
Entry 2: Click into the details page of an event, then click **Create Issue** at the bottom right. The title of the event will automatically be set as the source name for the Issue. Clicking **Source** will redirect to the corresponding event details page, if the event no longer exists, it will redirect to the default entry page for **Events**.

![](img/exception-issue-5.png)


If an Incident Issue has associated events created by a monitor, the number of related events will be displayed directly in the list. Clicking it will redirect to the event viewer to see all related events.

**Note**: This includes both directly triggered Incidents and those added in Issue comments.

![](img/issue-event-1116.png)

### Automatic Creation {#others}

<img src="../img/issue-monitor.png" width="80%" >

When configuring a **Monitor**, you can choose to associate a **Channel**. When the monitor generates an incident alert, it will automatically create an Issue. For example, when [configuring threshold detection](../monitoring/monitor/threshold-detection.md#steps):

1. Issues created by incidents are defaulted to Open status and Unknown priority;

2. The source is the current monitor;

3. Input the event title, which defaults to the Issue title;

4. Input the event content, which defaults to the Issue description;

5. In **Event Notification > Associate Incident**, click the enable button and choose the priority, channel, and assignee as needed. After selection, once the event is created, the automatically created Issue will be delivered to the selected channel, and an email notification will be sent to the Issue assignee.


6. Once the event notification rule for the monitor is configured, if there are incidents generated by the monitor, they will synchronously create Incident Issues, which can be viewed in **Incident > Selected Channel**.

???+ warning "Configuration Notes"

    - If you need to `@member` in the event description, you can click the `@` button above the content box, input `@` in the content box, or directly select from the dropdown below the `@`. Once selected, when the event is created, an email notification will be sent to the member.
    - @ notifications only work for the synchronized Incident Issues, for regular monitor event alerts, please refer to the corresponding alert strategy configuration.
    - The default channel is the **All** channel in Incidents.
    - If you have selected a `by` grouping condition in the **Monitor > Detection Metrics** and the associated Issue status is Open or Pending, subsequent events from the same source will not create new Issues but will be appended to the replies of existing Issues.



## <u>Example</u>

1. In **Logs > Explorer**, filter logs with `status:unknown`. Click the button at the bottom right to create an Issue.

2. Set the title of the Issue to "Test Data" and the priority to P2;

3. In the description, besides entering text, tag relevant members who will receive an email notification for this Issue; you can also enter channels in the format `#incident data` for association;

4. Select the Issue priority;

5. Choose the assignee for the Issue as needed; the assignee will receive an email notification for this Issue;

6. After saving, you can view the Issue in **Incident > Channel** or the associated channel.

![](img/issue-des.png)


## Issue Auto Discovery {#auto}

If **Issue Auto Discovery** is enabled in [APM](../application-performance-monitoring/error.md#issue) or [RUM](../real-user-monitoring/explorer/error.md#issue), the system will automatically discover errors according to the configured detection frequency and generate Issues. Generated Issues will be delivered to the configured channel with relevant tags.

![](img/issue-auto.png)

Issues created through **Issue Auto Discovery** use combined dimensions as unique IDs. If a similar combination dimension already exists historically, a new Issue will not be created but rather the content will be appended to the reply section of the historical Issue for updates. Generally, special tags like "New Issue," "Duplicate Issue," and "Recurrent Issue" help identify the status.

![](img/issue-auto-1.png)

- Creator: Displays as "Issue Auto Discovery," indicating its auto-generated nature.  
- Combined Dimensions: New combined dimension group information displayed on the Issue card page and detail page.  
- Special Tags: Auto-discovered Issues generally have three types of special tags:  
    - New Issue: If no historical Issue with the same combined dimension exists, a new Issue is created and marked as "New Issue" on the right side;  
    - Duplicate Issue: If a historical Issue with the same combined dimension exists and its status is Open or Pending, it indicates the issue reappeared, and the historical Issue is marked as "Duplicate Issue" on the right side;
    - Recurrent Issue: If a historical Issue with the same combined dimension exists and its status is Resolved, it indicates the issue resurfaced after resolution, and the historical Issue is marked as "Recurrent Issue" on the right side.

![](img/auto-issue-1.png)

![](img/auto-issue-2.png)