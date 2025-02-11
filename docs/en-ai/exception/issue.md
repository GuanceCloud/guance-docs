# Create an Issue
---

An **Issue** serves as the final implementation unit for the **Incident** feature, integrating information on sources of anomalies, descriptions, and relevant members within the current workspace. Guance defines any phenomenon observed by a member as an Issue and notifies relevant members to track and handle it. This article will introduce <u>the main entry points for creating an Issue and related operations</u>.

## Concept Explanation {#concepts}

| Field | Description |
| --- | --- |
| Delivery Channel | Defaults to "All", supports adding other channels customly. |
| Title | The title of the Issue. |
| Description | Detailed description of the current Issue's phenomenon, supports notifying via `@member` or adding `#channel` in the text box to deliver the current Issue to the corresponding channel. |
| Priority | Optional; can choose from default priority settings, with urgency levels being: P0 > P1 > P2; supports manual modification;<br/>also allows choosing [custom priorities](#level). |
| Source | Includes several sources: Dashboard, Unresolved Events, Events, Explorer, Monitors. |
| Assignee | When creating an Issue, specify an assignee, and Guance will send an email notification to the assignee.<br/>You can choose **members or teams** from the current workspace as assignees; you can also manually input **external emails** directly and add them by pressing Enter. |
| Attachments | Supports uploading images, videos, texts (CSV/TXT/JSON/PDF, etc.) in the **Issue Details Page**;<br/>supports configuring associated links. |

## Creating an Issue

Creating an Issue supports two methods: manual creation and automatic creation.

### Manual Creation {#manual}

Guance supports you in quickly manually creating an Issue based on icons in the **Incident** or in the **Explorer and View-level functional modules**.

#### Incident
    
Enter the **Incident**, click **Create New Issue**.

#### Dashboard {#dashboards}

Enter **Scenario > Dashboard > Settings**, click **Create New Issue**;

The name of the current dashboard is automatically displayed as the source name for this Issue. Clicking **Source** will automatically redirect to the corresponding dashboard, if the dashboard does not exist, it will redirect to the default page of **Scenario**.

![](img/issue-cpu.png)

#### Explorer 

Enter the Guance workspace, you can click the bottom-right button ![](img/buttom.png) to create a new Issue on <u>various Explorer-level functional module pages</u>.

For example, in **Logs > Explorer**, clicking the bottom-right **Create Issue** icon will enter the creation page.
 
Hovering over the source will display the source of this Issue. Clicking it will automatically redirect to the corresponding Explorer. Guance will filter and display according to the time range and filtering/search conditions saved when the Issue was created.

![](img/exception-issue-2.png)


You can also click into the details page of a log under **Explorer**, and similarly, click the bottom-right button to create a new Issue. The page will automatically display the current Explorer detail page as the source of this Issue. Clicking **Source** will automatically redirect to the corresponding Explorer detail page, if the data no longer exists, it will redirect to the default display state of **Explorer**.

![](img/issue-detail.png)

#### Event {#event}

Entry 1: Hover over an event list, and click the **Issue** that appears on the left side.

The title of this event is automatically displayed as the source name for this Issue. Clicking **Source** will automatically redirect to the corresponding event detail page, if the event no longer exists, it will redirect to the default entry display page of **Event**.

![](img/exception-issue-4.png)


 
Entry 2: Click into the detail page of an event, then click the bottom-right **Create New Issue**. The title of this event is automatically displayed as the source name for this Issue. Clicking **Source** will automatically redirect to the corresponding event detail page, if the event no longer exists, it will redirect to the default entry display page of **Event**.

![](img/exception-issue-5.png)


If an Incident has associated events synchronized and created by monitors, the number of associated events will be displayed directly in the list. Clicking will directly redirect to the event viewer to view all related events.

**Note**: Whether triggered directly by Incident or added in the comments of an Issue, both are included in the associated event count here.

![](img/issue-event-1116.png)

### Automatic Creation {#others}

<img src="../img/issue-monitor.png" width="80%" >

When configuring **Monitors**, you can choose to associate **Channels**. When a monitor generates an alert for an anomaly event, it will automatically create an Issue. For example, when [configuring threshold detection](../monitoring/monitor/threshold-detection.md#steps):

1. Issues created by event triggers have a default status of Open and unknown priority;

2. The source is the current monitor;

3. Input the event title, which defaults to the Issue title;

4. Input the event content, which defaults to the Issue description;

5. In **Event Notification > Associated Incident**, click the enable button and select the priority, channel, and assignee as needed. After selection, once the event is created, the Issue will be delivered to the selected channel and an email notification will be sent to the Issue assignee.

6. After completing the configuration of the monitor's event notification rules, if there is an anomaly event under the monitor, an Issue will be created synchronously for anomaly tracking, which can be viewed at **Incident > Selected Channel**.

???+ warning "Configuration Notes"

    - To notify members in the event description using `@`, you can click the `@` button above the content box, input `@` in the content box, or directly select members from the dropdown below the `@`. Once selected, an email notification will be sent to the member upon event creation.
    - @ notifications only take effect in the synchronously created Incident issues. For normal monitor event alerts, refer to the corresponding alert strategy configuration.
    - The default channel is the **All** channel in Incident.
    - If you have selected a by-group condition in the **Monitor > Detection Metrics** for the current event, and the associated Issue status is Open or Pending, multiple subsequent events from the same source will not create new Issues but will be appended to the replies of the existing Issue.


        
## <u>Example</u>

1. In **Logs > Explorer**, filter logs with `status:unknown`. Click the bottom-right button to create a new Issue.

2. Set the title of this Issue to "Test Data", set the priority to P2;

3. In the description, besides entering text, tag relevant members who will receive an email notification for this Issue; you can also enter channels in the form of `#anomaly data` for association;

4. Select the Issue priority;

5. Select the assignee for this Issue as needed; the assignee will receive an email notification for this Issue;

6. After saving, you can view it in **Incident > Channel** or the associated channel.

![](img/issue-des.png)


## Automatic Issue Discovery {#auto}

If **Automatic Issue Discovery** is enabled in APM/RUM, the system will automatically detect errors at the configured frequency and generate Issues. Generated Issues will be delivered to the configured channel and tagged accordingly.

![](img/issue-auto.png)

Issues created through **Automatic Issue Discovery** use a combination of dimensions as a unique ID. If an Issue with the same combination of dimensions already exists historically, a new Issue will not be created but rather updated in the reply section of the existing Issue. Generally, "New Issue," "Duplicate Issue," and "Recurrent Issue" special tags help identify the status.

![](img/issue-auto-1.png)

- Creator: Displays as "Automatic Issue Discovery," indicating its auto-generated nature.  
- Combination Dimensions: Additional combination dimension group information is displayed on the Issue card page and detail page.  
- Special Tags: Automatically discovered Issues generally have three different special tags: "New Issue," "Duplicate Issue," and "Recurrent Issue."   
    - New Issue: If no historical Issue with the same combination of dimensions exists, a new Issue is created and marked as "New Issue" on the right side;  
    - Duplicate Issue: If a historical Issue with the same combination of dimensions exists and its status is Open or Pending, it indicates a recurring issue, and the historical Issue is marked as "Duplicate Issue" on the right side;
    - Recurrent Issue: If a historical Issue with the same combination of dimensions exists and its status is Resolved, it indicates a recurrence after resolution, and the historical Issue is marked as "Recurrent Issue" on the right side.

![](img/auto-issue-1.png)

![](img/auto-issue-2.png)