# Create Issue
---

## Overview

As the final landing unit of Incidents, Issue takes the role of integrating the information of exception source, description and related members in the current workspace. Guance defines the phenomenon observed by any member as an Issue, and notifies the relevant member to track and process it. This article will introduce **the main creation entry of Issue and related operations**.

## Concepts {#concepts}

| Field | Description |
| --- | --- |
| Title | The Issue header. |
| Channel | Deliver to **All** by default; custom addition of other channels is supported.|
| Source | Contain the following sources: Dashboards, Unrecovered Events, Events, Explorers, Monitors. |
| Level | Four levels can be selected, and **Unknown** is selected by default; The emergency degree of grade is P0 > P1 > P2;<br/>Manual modification is supported. |
| Description | Describe the phenomenon of the current Issue in detail, and supports sending notifications to `@ members` or adding `# channels` in the text box to post the current Issue to the corresponding channel. |
| Attachment | Support uploading pictures, videos and texts (CSV/TXT/JSON/PDF, etc.);<br/>Support for configuring associated links. |

## Create Issue

There are two ways to create an Issue: manually and automatically.


### Create Manually {#manual}

Guance enables you to quickly manually create Issue based on icons in Incidents or in function modules at the explorer and view levels.

#### Incidents
    
Enter **Incidents > Issue**.

![](img/creat-issue-1.png)

#### Dashboards {#dashboards}

Enter **Scenes > Dashboards > Settings** and click **New Issue**;
<!--
![](img/exception-issue-1.png)
-->
Automatically display the name of the current dashboard as the Issue source name. Click **Source** to automatically jump to the corresponding dashboard.

![](img/issue-cpu.png)

#### Explorers 

Enter Guance workspace, and you can click the button ![](img/buttom.png) in the lower right corner of the functional module page of each major Explorer level to create a new Issue;

For example, in **Logs > Explorers**, click the icon in the lower right corner to enter the new page.
 
![](img/exception-issue-2.png)

Automatically display the current explorer as the source of this Issue. Click **Source** to automatically jump to the corresponding explorer, and filter it according to the time range saved by the explorer and the filtering search criteria when Issue was created.

<img src="../img/issue-scheck.png" width="50%" >

You can also click to enter the details page of a log under the explorer, and click the button in the lower right corner to create a new Issue. The current Explorer Details page is automatically displayed as the Issue source. Click **Source** to automatically jump to the corresponding explorer details page.
 

![](img/issue-detail.png)

#### Events

:material-numeric-1-circle: Enter **Unrecovered events**, hover to a certain event list and click to enter the **New Issue**;

![](img/exception-issue-4.png)

Automatically display the unrecovered event header as the Issue source name. Click **Source** to automatically jump to the corresponding event details page.

![](img/issue-event-1.png)
 
:material-numeric-2-circle: Click to enter the details page of an event, and click **New Issue** in the upper right corner.

<img src="../img/exception-issue-5.png" width="80%" >

Automatically display the event header as the source name of the Issue. Click **Source** to automatically jump to the corresponding event details page.



### Create utomatically {#others}

When you configure the monitor, you can select the associated channel. When the monitor generates an abnormal event alarm, an Issue will be automatically created. Take configuring [Threshold Detection](../monitoring/monitor/threshold-detection.md#steps) as an example:

I. The **Status** of Issue created by event trigger is **Open** by default, and the **Level** is unknown by default;

II. The **Source** is the current monitor;

III. Enter the **event title**, which defaults to the Issue title;

IV. Enter the **Event Content**, which defaults to Issue description;

**Note:**

- To include `@` members in the event description, you can click the `@` button at the top of the content box, enter `@` to select notify members in the drop-down box below. When selected, a mailbox notification is automatically sent to the member when the event creation is completed.  
- Notifying members only works on synchronized Incident issues. Please refer to the corresponding alert policy configuration for a list of alert notifications for normal monitor events.


<img src="../img/issue-monitor-1.png" width="80%" >

V. In **Event Notice > Channel**, click the Channel drop-down box to select multiple current channels or create new channels. After selection, when the event is created, the automatically created Issue will be posted to the channel you selected at this time for display.

**Note:** The default channel is **All** channels in **Incidents**.

<img src="../img/issue-monitor.png" width="80%" >

VI. When the event notification rule configuration of the monitor is completed, if an abnormal event occurs under the monitor, Issue will be created synchronously, and you can go to **Incidents** > the **Channel** you selected to view it.

**Note:** If you select the by grouping condition in **Monitor > Detection Metric** corresponding to the current event, and the Issue status associated with the current monitor is Open or Pending, then multiple events generated from the same source will not create a new Issue, but will be appended to the reply of the existing Issue.
        
## <u>Example</u>

I. In **Logs > Explorers**, click the button ![](img/buttom.png) in the lower right corner to create a new Issue. In the new pop-up window, it will automatically display that the Issue comes from the current explorer.


II. Enter the Issue title as "Test Data" and set the level as P2;

III. In the description, in addition to the input text, notify the relevant members by entering `@`;

IV. You can also enter the channel in the form of `#abnormal data` in the description for association;

V. Select to add attachments as needed and click **Save**;


<img src="../img/issue-des.png" width="50%" >

VI. After saving, you can view it on all channels tracked by anomaly or the associated channel `#abnormal data`;

VII. Members notified will receive this Issue notification in the email address.

![](img/ex-0803.png)




