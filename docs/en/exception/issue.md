# Create Issues
---


As the final landing unit of Incidents, Issue takes the role of integrating the information of exception source, description and related members in the current workspace. Guance defines the phenomenon observed by any member as an Issue, and notifies the relevant member to track and process it. This article will introduce **the main creation entry of Issue and related operations**.

## Concepts {#concepts}

| Field | Description |
| --- | --- |
| Title | The Issue header. |
| Channel | Default is to `All`, with support for adding custom channels. |
| Title | That is, the title of the Issue. |
| Description | Provide a detailed description of the current Issue's phenomenon, support for sending notifications by typing `@member` in the text box or adding `#channel` to deliver the current Issue to the corresponding channel. |
| Level | Optional; you can choose the default severity level configuration, where the levels of urgency are in the following order: P0 > P1 > P2; manual modification is supported;<br/>Custom levels can also be selected [Custom Level](#level). |
| Source | Include the following sources: dashboards, unresolved incidents, events, explorers, monitors. |
| Assignee | When a new Issue is created and an assignee is specified, the Guance platform will send an email notification to the assignee.<br/>You can choose a **member or team** from the current workspace as the assignee; you can also manually enter an **external email address** and press enter to add it as needed. |
| Attachments | Support adding uploads of images, videos, text (CSV/TXT/JSON/PDF, etc.) **on the Issue details page**;<br/>Support the configuration of associated links. |


## Create a New Issue

There are two ways to create an Issue: manually and automatically.


### Create Manually {#manual}

Guance enables you to quickly manually create Issue based on icons in Incidents or in function modules at the explorer and view levels.

#### Incidents
    
Enter **Incidents > New Issue**.


#### Dashboards {#dashboards}

Enter **Scenes > Dashboards > Settings** and click **New Issue**;

Automatically display the name of the current dashboard as the Issue source name. Click **Source** to automatically jump to the corresponding dashboard.

![](img/issue-cpu.png)

#### Explorers 

Enter Guance workspace, and you can click the button ![](img/Enter the Guance workspace, and you can click the button in the lower right corner **on the pages of major explorer-level functional modules** to create a new Issue.

For example, in **Logs > Explorer**, click the icon in the lower right corner to enter the new page.

Hover over the source to display the origin of this Issue. Clicking will automatically redirect you to the corresponding explorer. Guance filters and displays according to the time range and filter search conditions saved in the explorer when the Issue was created.

![](img/exception-issue-2.png)

You can also enter the detail page of a log in the **Explorer** and similarly click the button in the lower right corner to create a new Issue. The page automatically shows the current explorer detail page as the source of this Issue. Clicking **Source** will automatically redirect you to the corresponding explorer detail page; if the data no longer exists, it will redirect to the **Explorer**'s default display state.

![](img/issue-detail.png)


#### Events

Entry 1: Hover your mouse over a specific event list, and you can click to enter the **Issue** that appears on the left side.

The page will automatically display the title of the event as the name of the source for this Issue. Clicking on **Source** will automatically redirect you to the corresponding event detail page; if the event no longer exists, it will redirect to the default display page for **Events**.

![](img/exception-issue-4.png)

Entry 2: Enter the detail page of a specific event and click on **Create Issue** in the lower right corner. It will automatically display the title of the event as the name of the source for this Issue. Clicking on **Source** will automatically redirect you to the corresponding event detail page; if the event no longer exists, it will redirect to the default display page for **Events**.

![](img/exception-issue-5.png)

If an anomaly tracking Issue has associated event information that was synchronously created by a monitor, the number of associated events will be directly displayed in the list for that Issue. Clicking on it will allow you to jump directly to the event explorer to see all related events.

**Note**: Whether it is directly triggering anomaly tracking or adding in the Issue's comments, both are included in the count of associated events here.

![](img/issue-event-1116.png)




### Create Utomatically {#others}

<img src="../img/issue-monitor.png" width="80%" >

When you configure the monitor, you can select the associated channel. When the monitor generates an abnormal event alert, an Issue will be automatically created. Take configuring [Threshold Detection](../monitoring/monitor/threshold-detection.md#steps) as an example:

1. The **Status** of Issue created by event trigger is **Open** by default, and the **Level** is unknown by default;

2. The **Source** is the current monitor;

3. Enter the **event title**, which defaults to the Issue title;

4. Enter the **Event Content**, which defaults to Issue description;

5. In **Event Notice > Channel**, click the Channel drop-down box to select multiple current channels or create new channels. After selection, when the event is created, the automatically created Issue will be posted to the channel you selected at this time for display.

6. When the event notification rule configuration of the monitor is completed, if an abnormal event occurs under the monitor, Issue will be created synchronously, and you can go to **Incidents** > the **Channel** you selected to view it.

???+ warning "Configuration Notes"

    - To include `@` members in the event description, you can click the `@` button at the top of the content box, enter `@` to select notify members in the drop-down box below. When selected, a mailbox notification is automatically sent to the member when the event creation is completed.  
    - Notifying members only works on synchronized Incident issues. Please refer to the corresponding alert policy configuration for a list of alert notifications for normal monitor events.
    - The default channel is **All** channels in **Incidents**.
    - If you select the by grouping condition in **Monitor > Detection Metric** corresponding to the current event, and the Issue status associated with the current monitor is Open or Pending, then multiple events generated from the same source will not create a new Issue, but will be appended to the reply of the existing Issue.




## Example

1. In **Logs > Explorer**, filter the log data with `status:unknown`. Click the button in the lower right corner to create a new Issue.

2. Enter the title of the Issue as "Test Data" and set the severity level to P2.

3. In the description, in addition to entering text, mention relevant members, who will receive notifications of this Issue in their email; you can also associate channels by entering in the form of `#AnomalyData` in the description.

4. Select the Issue severity level.

5. Choose the assignee for the Issue as needed; the assignee will receive a notification of this Issue in their email.

6. After saving, you can view it in **Anomaly Tracking > Channel** or the associated channels.

![](img/issue-des.png)

## Issue Auto-Discovery {#auto}

If the **Issue Auto-Discovery** feature is enabled in APM/RUM, the system will automatically detect errors and generate Issues according to the configured detection frequency. The generated Issues will be delivered to the configured channels with relevant tags.

![](img/issue-auto.png)

Issues created through **Issue Auto-Discovery** will use the combination of dimensions as the unique ID. If there is already an Issue with the same combination of dimensions in history, a new Issue will not be created; instead, the content will be appended to the historical Issue's reply area for updating. Generally, the status can be identified by special tags such as "New Issue," "Repeated Issue," and "Regression Issue."

![](img/issue-auto-1.png)

1. Creator: Displayed as "Issue Auto-Discovery," indicating its automatically generated attribute.
2. Combination Dimensions: New grouping information of combination dimensions is displayed on the Issue card page and detail page.
3. Special Tags: Automatically discovered Issues generally have three different special tags: "New Issue," "Recurring Issue," and "Regression Issue."
    - New Issue: If there is no historical Issue with the same combination of dimensions, an Issue is created and marked as "New Issue" on the right.
    - Repeated Issue: If there is already a historical Issue with the same combination of dimensions and the status is Open or Pending, indicating the problem has recurred, the historical Issue is marked as "Recurring Issue" on the right.
    - Regression Issue: If there is already a historical Issue with the same combination of dimensions and the status is Resolved, indicating the problem has reappeared after being resolved, the historical Issue is marked as "Regression Issue" on the right.

![](img/auto-issue-1.png)






