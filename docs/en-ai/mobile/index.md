---
icon: fontawesome/solid/mobile-screen
---
# Mobile

---

The Guance App helps you view event data, log data, scene views, and more from Guance on your mobile device anytime, anywhere.

## Installation {#app-install}

Within the Guance workspace, you can download the app via "Integration" - "Mobile", or by scanning the QR code below.

<img src="img/1.mobile_qrcode.png" width=300px  />

Alternatively, you can directly click the following links to download.

- [Download for iOS](https://apps.apple.com/cn/app/dataflux-mobile/id1494097190)

- [Download for Android](https://android.myapp.com/myapp/detail.htm?apkName=com.cloudcare.ft.dataflux.mobile&info=BC6B6D70A723FAA93DB84F11BF50AE8A)

## Login

Existing Free Plan or Commercial Plan users of Guance can log in using their registered account credentials or phone verification codes. Select the corresponding site for your account to log in to the Guance App. If you don't have a Guance account yet, visit the official Guance website to [apply now](https://auth.guance.com/register) and choose a suitable site account.

## Account Management

After logging into the Guance App, you can switch workspaces, enable push notifications, configure dashboard shortcuts, clear cache, view service agreements, privacy policies, and the current mobile version under the "My" menu. To switch accounts, log out of the current user first.

![](img/1.mobile_account.png)


### Switching Workspaces

The Guance App supports viewing data from all workspaces associated with your account. By switching workspaces, you can view logs, events, scenes & views within different workspaces.

After logging into the Guance App, you need to select a default workspace to view corresponding data; during use, if you need to switch to another workspace, you can change it via "My" - "Switch Workspace".

If you do not currently have a workspace, you can create a new workspace on the web version of Guance [here](../management/space-management.md), or be invited by other workspace administrators to become a new member of other workspaces [here](../management/member-management.md).

### Notifications {#notification}

The Guance App provides intelligent mobile push notifications based on alerts from the Guance dashboard, helping you quickly integrate notifications into your alert events for efficient, precise, and real-time information delivery. You can enable or disable alert notifications via "My" - "Notification Toggle".

### Configuring Dashboard Shortcuts {#shortcut-entry}

The Guance App allows you to configure shortcuts for dashboards, enabling quick access to key dashboard data. You can configure the necessary dashboard shortcuts via "My" - "Configure Dashboard Shortcuts".

![](img/1.mobile_board_shortcut.png)

### Clearing Cache

Cache files in the Guance App include temporary application files that may slow down the app. You can clear these caches via "My" - "Clear Cache".

## Common Components

The Guance App supports searching and filtering data. You can choose different time ranges to quickly locate data, promptly identify, investigate, and resolve issues. Additionally, you can share the data you are currently viewing or sync data between mobile and desktop devices using macOS's Handoff feature.

### Time Control

The Guance App allows you to set the time range for scene views, logs, and event data using the time component. You can quickly select preset time ranges or define custom start and end times.

![](img/1.mobile_time_1.png) &nbsp;![](img/1.mobile_time_2.png)

### Search and Filter {#search-filter}

The Guance App supports searching and filtering in scene views, logs, and event explorers. You can perform quick searches using keywords or `key:value` field filters. For more details on field filtering, refer to the documentation [Search Instructions](../getting-started/function-details/explorer-search.md#filter).

![](img/1.mobile_filter.png) &nbsp;![](img/1.mobile_search.png)

### Sharing {#share}

The Guance App provides sharing functionality for event details, log details, dashboards, notes, and explorers. Click the "Share" button in the top-right corner to share links with others.

> Note: Viewing shared links requires you to have permissions for the workspace containing the shared content.

![](img/1.mobile_share.png)

**Scenario One: Sharing to PC**

In this scenario, clicking the received share link will allow you to view the corresponding data on a PC.

**Scenario Two: Sharing to Android or iOS Devices with the Guance App Installed**

In this scenario, clicking the received share link will open the corresponding data in the Guance App.

#### Links {#link}
If the Guance App is installed on your iOS or Android device, opening any webpage link from Guance will redirect you to the corresponding page in the Guance App, including [alert notifications](../monitoring/alert-setting.md) in DingTalk, Feishu, or emails.
> Currently supported only for events, scene details, and log pages.


### Handoff {#hand-off}

The Guance App supports Handoff, allowing you to sync data between mobile and desktop devices, enabling quick switching between devices when needed.

> Note: Using Handoff requires a macOS system on the desktop and an iOS system on the mobile device, with Handoff enabled on each device and logged in with the same Apple ID on iCloud. For more settings, refer to the documentation [How to Use Handoff](https://support.apple.com/zh-cn/HT209455).

**Scenario One: Viewing Events on Mobile, Prompting Sync View on Desktop**

In this scenario, when viewing events on your mobile device, a prompt will appear in your desktop browser to view the corresponding event. Clicking the browser will open the event content. See the following diagram.

<img src="img/1.mobile_handoff_2.jpg" width=240px border=1px/>
<img src="img/1.mobile_handoff_1.1.png" width=370px />

**Scenario Two: Viewing Events on Desktop, Prompting Sync View on Mobile**

In this scenario, when viewing events on your desktop, a prompt will appear at the bottom of your mobile device. Clicking it will open the corresponding event content in the mobile app. See the following diagram.

<img src="img/1.mobile_handoff_3.png" width=640px/>

### Widget Functionality {#widget}

Guance supports widget functionality, allowing you to add Guance widgets to your home screen for quick access to relevant data.

> Note: Using widget functionality requires iOS 14 or later.

You can add Guance widgets as follows:

1. Download and install the Guance App, and log in to the workspace you want to view.
2. In the widget search, enter "Guance".
3. Open Guance and click "Add Widget".
4. After adding, you can view relevant data in real-time on your mobile home screen.

<img src="img/1.mobile_widget_1.png" width=210px border=1px/>&nbsp;<img src="img/1.mobile_widget_2.png" width=210px border=1px />&nbsp;<img src="img/1.mobile_widget_3.png" width=210px border=1px/>

## Scenes {#scene}

The Scenes module allows users to view all accessible dashboards, notes, and explorers within their workspace.

### Dashboards {#board}

**Dashboards** provide data insights with various visual charts, helping users track, analyze, and display key performance indicators (KPIs) and overall operations. Switching the viewer to "Dashboard" lets you view all dashboards that meet different business needs in the current workspace.

Guance supports switching between "All Dashboards," "My Favorites," "Imported Projects," "My Creations," and "Frequently Viewed" via the dropdown menu for quick filtering. Dashboards are synchronized with the web version. For more details, refer to [Dashboards](../scene/dashboard/index.md).

**Dashboard Icon Descriptions**

- Search: Quick search using keywords or fields.
- Filter: Quickly switch views using scene dashboard variables.
- Share: Share the current dashboard with others.
- Dropdown Switch: Switch between different charts in the dashboard view.

​        

<img src="img/1.mobile_board_1.png"/>&nbsp;<img src="img/1.mobile_board_2.png"  />

### Notes {#note}

Notes support inserting real-time visual charts and text documents for data analysis and report creation, assisting in problem tracing, location, and resolution. Switching the viewer to "Notes" lets you view all notes within the current workspace that you have permission to view.

Guance supports switching between "All Notes," "My Favorites," and "My Creations" via the dropdown menu for quick filtering. Notes are synchronized with the web version. For more details, refer to [Notes](../scene/note.md).

**Note Icon Descriptions**

- Search: Quick search using keywords or fields.
- Share: Share the current note with others.

<img src="img/1.mobile_note_1.png"  />&nbsp;<img src="img/1.mobile_note_2.png"  />

### Explorers {#explorer}

**Explorers** are custom log viewers that support viewing customized log requirements within the workspace. Switching to "Explorer" lets you view all explorers within the current workspace that you have permission to view.

Guance supports switching between "All Explorers," "My Favorites," "Imported Projects," "My Creations," and "Frequently Viewed" via the dropdown menu for quick filtering. Explorers are synchronized with the web version. For more details, refer to [Explorers](../scene/explorer/custom-explorer.md).

**Explorer Icon Descriptions**

- Search: Quick search using keywords or fields.
- Filter: Quickly filter data states in the explorer.
- Share: Share the current explorer with others.

<img src="img/1.mobile_viewer_1.png"  />&nbsp;<img src="img/1.mobile_viewer_2.png"  />

## Log Data {#log}

In the "Logs" section, you can view log data from the Guance dashboard. By selecting different log sources, you can query and analyze log data within the workspace. The Guance mobile app defaults to displaying the most recent 15 minutes of log data. To view more log data, you can select a time range to search and view related data. For more details, refer to [Log Explorer](../logs/explorer.md).

**Log Icon Descriptions**

- Search: Quick search using keywords or fields.
- Filter: Quickly filter log states.
- Share: Share the current log with others.

<img src="img/1.mobile_log_1.png"  width=210px/>&nbsp;<img src="img/1.mobile_log_2.png"  width=210px />&nbsp;<img src="img/1.mobile_log_3.png"  width=210px />

## Events {#event}

The Guance mobile app keeps you connected to the Guance dashboard anytime, anywhere. You can view, search, and filter all unresolved events, critical events, important events, warning events, etc., triggered by **monitors** via "All Events". Via "My Events," you can view events notified to you through email, DingTalk bots, WeChat Enterprise bots, Webhooks, etc., which are still unresolved. When an alert event is notified to you, the Guance mobile app will promptly send you a notification to ensure quick response and resolution of issues. For more details, refer to [Events](../events/index.md).

> Note: The Guance mobile app provides only 1000 event records in "All Events" / "My Events". For more events, please visit the web version.

**Event Icon Descriptions**

- Collapse: Expand/collapse the window function of unresolved events.
- All Events / Unresolved Events: Switch between viewing all events and unresolved events.
- Filter: Quickly filter event states.
- Search: Quick search using keywords or fields.
- Share: Share the current event with others.

<img src="img/1.mobile_event_1.png" width=210px />&nbsp;<img src="img/1.mobile_event_2.png"  width=210px   />&nbsp;<img src="img/1.mobile_event_3.png"  width=210px  />