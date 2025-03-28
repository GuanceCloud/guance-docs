---
icon: fontawesome/solid/mobile-screen
---
# Mobile Application
---

Guance Mobile App allows you to conveniently access Event data, Log data, Scene views, and more from Guance on your mobile device, anytime and anywhere.

## Installation {#app-install}

In the workspace of Guance, you can download it through "Integration"-"Mobile Application" or scan the code below.

<img src="img/1.mobile_qrcode.png" width=300px  />

Or you can directly click on the following link to download.             

- [iOS system download](https://apps.apple.com/cn/app/dataflux-mobile/id1494097190)

- [Android system download](https://android.myapp.com/myapp/detail.htm?apkName=com.cloudcare.ft.dataflux.mobile&info=BC6B6D70A723FAA93DB84F11BF50AE8A)

## Login

Existing Guance free/commercial users can log in to the Guance App using their registered account, password, or mobile verification code. You can select the corresponding Access Node for your account. If you don't have an Guance account yet, you can visit the [Sign Up Now](https://auth.guance.com/register) page on the Guance official website and choose the appropriate Access Node for registration.

## Account Manager

Once you're logged into the Guance App, you can access various features under the 'Mine' menu. You can switch workspaces, enable message notifications, configure dashboard quick action entry, clear cache, view the terms of service, privacy policy, and check the current mobile version. If you need to switch accounts, you can log out of the current user's session.

![](img/1.mobile_account.png)


### Change Workspace

The Guance App supports viewing data content from all workspaces under your account. By switching workspaces, you can view Logs, Events, and Scenes from different workspaces.

After logging into the Guance App, you need to select a default workspace to view its corresponding data. During usage, if you need to switch to another workspace, you can change the workspace through "Mine" - "Change Workspace."

If you currently don't have any workspaces, you can either create a new workspace on the Guance web version by [creating a new workspace](../management/space-management.md), or you can be invited as a new member to other spaces by the space administrators of those spaces [via invitation](../management/member-management.md).

### Notification {#notification}

The Guance App offers mobile intelligent push services based on Guance Workbench alerts. This helps you integrate notifications for your alert events, enabling efficient, accurate, and real-time information push. You can enable or disable alert notification push through "Mine" - "Notification" in the app.

### Configure Dashboard Quick Action Entry {#shortcut-entry}

The Guance App provides a shortcut to configure dashboards, allowing you to quickly access key dashboard data. You can configure the dashboards you want to access quickly through "Mine" - "Configure Dashboard Quick Action Entry" in the app.

![](img/1.mobile_board_shortcut.png)

### Clear Cache

The cache files of the Guance App include certain temporary files generated by the application, which might lead to slow app performance. You can clean up file caches and more through "Mine" - "Clear Cache" in the app.

## Common Function

The Guance App supports searching and filtering data. You can select different time ranges to quickly locate data, enabling you to promptly identify, investigate, and resolve issues. Additionally, you can share the data you're currently viewing and use macOS's Continuity feature to sync data viewing between your mobile device and computer.

### Time Control Component

The Guance App supports using the time component to set the time range for displaying Scene views, Logs, and Event data. You can quickly select preset time ranges or customize a time range by choosing start and end times.

![](img/1.mobile_time_1.png) &nbsp;![](img/1.mobile_time_2.png)

### Search and Filter {#search-filter}

The Guance App allows you to quickly locate and query relevant text data in Scene views, Logs, and Event viewers through search and filtering. It supports searching by keywords, `key:value` field filters, and more. For further details on field filtering, please refer to the documentation on [Search Instructions](../getting-started/function-details/explorer-search.md#filter).

![](img/1.mobile_filter.png) &nbsp;![](img/1.mobile_search.png)

### Share {#share}

The Guance App offers the functionality to share and view Event details, Logs details, Dashboards, Notes, and Explorers. Simply click the "Share" option in the upper-right corner to generate a shareable link for others to view.

>Note: The shared content can only be viewed by individuals who also have permission to access the workspace of the shared content.

![](img/1.mobile_share.png)

**Scenario 1：Share to PC**

In this scenario, clicking on the received shared link allows you to log in and view the corresponding data on a PC.

**Scenario 2：Share with mobile devices running Android or iOS that have the Guance App installed.**

In this scenario, clicking on the received shared link allows you to open the corresponding data.


#### Link {#link}
If you have the Guance App installed on your iOS or Android device, opening any web link from Guance will redirect you to the corresponding content page within the Guance App. This includes alert notifications from platforms like DingTalk, Feishu (Lark), and email.

>Currently, this feature only supports Envents, Scene and Logs pages.


### Hand Off {#hand-off}

The Guance App supports using Continuity to sync data viewing between mobile and computer devices. This helps you quickly switch devices when necessary to address issues.

>Note: When using Continuity, your computer must be running macOS, and your mobile device must be running iOS. Both devices need to have Continuity enabled, and you should be logged into iCloud with the same Apple ID. For more settings, refer to the documentation on [How to Use Continuity](https://support.apple.com/en-us/HT209455).

**Scenario 1：When viewing Guance App events on your mobile device, your computer will display a prompt to sync the viewing.**

In this scenario, while viewing an event on your mobile device, your computer's web browser will display a viewing prompt. Clicking the browser will open the corresponding event content. Refer to the illustrative image below:

<img src="img/1.mobile_handoff_2.jpg" width=240px border=1px/>
<img src="img/1.mobile_handoff_1.1.png" width=370px />

**Scenario 2：When viewing Guance App events on your computer, your mobile device will display a prompt to sync the viewing** 

In this scenario, when you're viewing an event on your computer, the bottom of your mobile device will display a Guance viewing prompt. Clicking on it will open the relevant event content on your mobile device. See the illustrative image below:
 
<img src="img/1.mobile_handoff_3.png" width=640px/>


### iOS Widget  {#widget}

Guance App supports the Widget feature, allowing you to customize and add Guance to your mobile device's home screen widget. You can use the widget's information display feature to quickly view relevant data from Guance.

>Note: When using the Widget feature on iOS, you need to have an iOS version of 14 or above.

You can follow the steps below to add the Guance widget:

1. Download and install Guance, then log in to the desired workspace.
2. In the widget search, type "Guance" to search for it.
3. Open Guance and click "Add Widget."
4. After adding the widget, you can view real-time data from Guance on your mobile device's home screen.

<img src="img/1.mobile_widget_1.png" width=210px border=1px/>&nbsp;<img src="img/1.mobile_widget_2.png" width= 210px border=1px />&nbsp;<img src="img/1.mobile_widget_3.png"  width= 210px border=1px/>

## Scene {#scene}

The Scene module supports users in viewing all accessible Dashboards, Notes, and Viewers within their workspace.

### Dashboard {#board}

**Dashboard**，Indeed, the Data Insight Scene supports adding various visualization charts to display data. This feature aids users in visually tracking, analyzing, and displaying key performance indicators, allowing them to monitor the overall operational status. By switching the viewer to "Dashboard," you can view all dashboards that cater to different business scenarios within the current workspace.

Guance App supports switching between "All Dashboards," "My Favorites," "Imported Projects," "My Creations," and "Frequently Viewed" by clicking on the dropdown menu. This allows you to quickly filter and locate the corresponding dashboard. Dashboards are synchronized with the web content. For more details, you can refer to the [Dashboard documentation](../scene/dashboard.md).  

**Dashboard Icon Explanations**

- Search: Quickly search using keywords or fields.
- Filter: Switch and view variables within the dashboard scenes.
- Share: Share the current dashboard with others for viewing.
- Dropdown Toggle: In dashboard view, click the dropdown to toggle and view different charts.
        
<img src="img/1.mobile_board_1.png"/>&nbsp;<img src="img/1.mobile_board_2.png"  />

### Note {#note}

**Note Integration and Viewing**

Notes support the insertion of real-time visualizations, text documents, and explanations, allowing you to combine charts and documentation for data analysis and summary reporting. This assists in problem retrospection, localization, and resolution. Switching the viewer to "Notes" enables you to see all notes within your viewing permissions for the current workspace.

Guance allows you to use the dropdown menu to switch between "All Notes," "My Favorites," and "My Creations" for quickly filtering and finding relevant notes. Notes are synchronized with the web content, and you can find more details in the [Notes section](../scene/note.md).

**Note Icon Explanations**

- Search: Quickly search using keywords or fields.
- Share: Share the current note with others for viewing.

<img src="img/1.mobile_note_1.png"  />&nbsp;<img src="img/1.mobile_note_2.png"  />

### Explorer {#explorer}

**Viewer and Its Icons Explanation**

The term "Explorer" refers to a customizable Log Explorer that supports various tailored log viewing needs within the workspace. By switching to the "Viewer" section, you can access all viewers within your viewing permissions for the current workspace.

Guance allows you to use the dropdown menu to switch between "All Explorer","My Favorites","Imported Projects","Created By You" and "Frequently Viewed" to quickly filter and locate the corresponding viewers. Viewers are synchronized with the web content, and you can find more details in the [Viewer section](../scene/explorer/custom-explorer.md).

**Viewer Icon Explanations**

- Search: Quickly search using keywords or fields.
- Filter: Swiftly filter and view based on the data status within the viewer.
- Share: Share the current viewer with others for viewing.

<img src="img/1.mobile_viewer_1.png"  />&nbsp;<img src="img/1.mobile_viewer_2.png"  />

## Log Data {#log}

In the "Logs" section, you can synchronize and view log data from the Guance workspace. By selecting different log sources, you can query and analyze various log data within the workspace. The Guance mobile app defaults to displaying log data from the last 15 minutes. If you need to view more log data, you can search and view relevant data by selecting a time range. For more details, please refer to the [Log Explorer](../logs/explorer.md).

Please note that the translation is based on the provided text and may be slightly adjusted according to contextual needs. If there are specific terms or context that require further adjustments, please make appropriate modifications.

**Log Icon**

- Search: Quickly search using keywords or fields.
- Filter: Swiftly filter and view based on the log status.
- Share: Share the current log with others for viewing.

<img src="img/1.mobile_log_1.png"  width=210px/>&nbsp;<img src="img/1.mobile_log_2.png"  width=210px />&nbsp;<img src="img/1.mobile_log_3.png"  width=210px />



## Events {#event}
Guance mobile app enables you to stay connected with the Guance workspace anytime, anywhere. You can use the "All" events section to view, search, and filter all unrecovered events triggered by **monitors**, including critical events, important events, warning events, and more. Through the "My" events section, you can view events that have been notified to you through emails, DingTalk robots, WeChat Work robots, Webhooks, and similar methods, and that are currently unresolved. Once you receive notifications for alert events, the Guance mobile app promptly sends you alerts to ensure you can react and resolve issues swiftly. For more details, please refer to the [Events section](../events/index.md).

> Note: In the "All Events" and "My Events" sections of the Guance mobile app, only up to 1000 event entries are provided. If you need to view more events, please go to the web version for additional access.

**Event Icon Explanations**

- Collapse: Collapse or expand the window for unrecovered events.
- All Events/Unrecovered Events: Switch between viewing all events and unrecovered events.
- Filter: Swiftly filter and view based on event status.
- Search: Quickly search using keywords or fields.
- Share: Share the current event with others for viewing.

<img src="img/1.mobile_event_1.png" width=210px />&nbsp;<img src="img/1.mobile_event_2.png"  width=210px   />&nbsp;<img src="img/1.mobile_event_3.png"  width=210px  />
