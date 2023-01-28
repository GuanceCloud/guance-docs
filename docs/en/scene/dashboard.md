# Dashboard
---

## Overview

Under Scence, you can create multiple dashboards to build data insight scence, search for dashboards by keywords, add visual charts to dashboards for data analysis, and quickly filter from 「My Favorites」, 「Import Items」, 「My Created」, 「Visible Only」, and 「Frequently Viewed」 to find the corresponding dashboard. 「My Created」, 「Visible Only」 and 「Frequently Viewed」 to quickly filter and find the corresponding dashboard. Supports quick filtering of dashboards by setting labels for them.


## New Dashboard

After entering the scene, in 「Dashboard」, click 「+New Dashboard」to create a new view template.

![](img/dashboard001.png)

**Selecting a view template**

- Blank dashboard: create a blank dashboard and subsequently customize the charts in that dashboard
- Custom Template: Import a custom view template for use, and paste the view template code into the specified location.
> **The view template code：**Usually it is the exported template text. In the dashboard, click 「Settings」- 「Export Dashboard JSON」to export the corresponding view template json file to local, and open the json file to see the "view template code"; click 「Settings」 - 「Import Dashboard JSON」 to import the view template json file to the corresponding dashboard.

- Built-in template library: The system provides built-in views, including "System View" and "User View". Users can select existing System View and User View to create a new dashboard, which is ready to use and supports custom configuration changes. The keyword search bar on the right side also allows you to quickly search for the desired template among the existing templates.

![](img/8.dashboard_1.png)

**Custom Labels**

When creating/modifying a dashboard view, users can add custom labels to the dashboard to facilitate grouping and managing related dashboards.

**Select visible range**

Dashboard "Creator" can customize the viewing permissions of the current dashboard, including "Public" and "Only visible to you".

- Public: A dashboard that is open to all members in the space, with viewing and editing privileges for other members unaffected.
- Visible only to yourself: only the dashboard "creator" can view the **non-public dashboard**, other members do not have viewing rights

Note: **Non-public dashboard** shared as a link is not visible to non-creators.

![](img/1.dashboard_2.png)

**Creating Dashboards**

Click "OK" to create a dashboard directly.

![](img/3.dashboard_2.png)

### Add chart

After the dashboard is created, you can add new charts to the dashboard by clicking "Add Chart" in the upper right corner. You can add global variables to the charts to complete dynamic filtering of the charts. For details, please click [view-variable.md](view-variable.md).

![](img/2.dashboard_4.png)

### Time Controls

"You can enter the time range manually, or quickly select the built-in time range of the current dashboard, or set the time range through customization. For more details, please refer to [Time control description](../getting-started/necessary-for-beginners/explorer-search.md#time) 

![](img/dashboard002.png)

### Big screen mode

In the dashboard, after clicking the 「Preview」 - 「Big Screen Mode」 button, Observation Cloud will automatically help you to put away the left and top navigation bar and display the view in full screen. Click the [ESC] button to exit the big screen mode.

![](img/2.dashboard_2.png)

### Dashboard Settings

After the dashboard is created, click the "Settings" button to "Save to built-in view", "Set refresh frequency", "Import/Export dashboard JSON", "Copy dashboard", "Save snapshot", etc. for the dashboard.

![](img/2.dashboard_3.png)

#### Save dashboard as built-in view

In the Dashboard, click the "Settings" button and select "Save to built-in view" to save the dashboard view such as "CPU Monitor View" to the built-in view of "User View" in the built-in view. When you save the dashboard view to the built-in view, you can select the binding relationship, and select the binding relationship "label".

![](img/9.dashboard_2.png)

After saving to the built-in view, you can view the saved dashboard view 「CPU Monitor View」 in the 「User View」 of 「Management」 - 「Built-in View」 of Observation Cloud Workspace.<br />Note: Renaming of user views under the same workspace is not allowed.
![](img/2.dashboard_5.png)

Also, since the binding relationship `label:*` is set, the built-in view of the binding "CPU Monitor View" can be viewed on the details page of the hosts and containers whose infrastructure has set the "Label property".

![](img/2.dashboard_6.png)

#### Set refresh frequency

In the Dashboard, click the "Settings" button and select 「Set Refresh Frequency」 to manually configure the refresh frequency of the chart data. The initial refresh frequency is set to 30 seconds by default. 10 seconds, 30 seconds and 60 seconds options are supported.

![](img/9.dashboard_3.png)

#### Import/Export Dashboard JSON

In the dashboard, click "Settings" button, select "Export Dashboard JSON" to export the JSON file of the current dashboard; select "Import Dashboard JSON" to import the JSON file to overwrite the current dashboard.<br />Note: Importing dashboard JSON will overwrite the original dashboard, which can't be recovered by overwriting easily.
![](img/2.dashboard_7.png)

#### Copy Dashboard

In the Dashboard, click the "Settings" button and select 「Copy Dashboard」to copy the dashboard.

![](img/2.dashboard_8.png)

Enter the name of the copied dashboard in the pop-up dialog and click OK to view the copied dashboard view in the dashboard list.

![](img/dashboard003.png)

#### Save Snapshot

You can save a snapshot for the current dashboard by using the shortcut key (Windows: Ctrl+K / Mac OS: Cmd+K) in the dashboard to quickly save the snapshot, or choose to save it by clicking 「Save Snapshot」 in the 「Settings」 button. For more information, please refer to the document [Snapshot](../management/snapshot.md).

![](img/dashboard004.png)

## Modify/export/delete dashboards

Click the drop-down button to the right of the dashboard to support changing the name for the dashboard, exporting the dashboard to a json file, and deleting the dashboard.

![](img/dashboard005.png)

## Filter/filter dashboard

On the left side of the dashboard, you can quickly filter the dashboard by "My Favorites", "Import Items", "My Creation", "Visible Only" and "Frequently Viewed"; you can quickly filter the dashboard by setting tabs for the dashboard.

- My Favorites: the current user's favorite dashboards, click the Favorites icon on the right side of the dashboard.
- Imported Items: all the dashboards created by "Import Custom Template" in the current workspace.
- My Created: all the dashboards created by the current user, including the imported dashboards.
- Visible only to you: Only the dashboard "creator" can view the **non-public dashboards**, other members do not have the right to view them.
- Frequently Viewed: Dashboards that the current user has viewed more than 5 times in a week.

![](img/dashboard006.png)

## Rotating Dashboard {#player}

Guance provides rotations for multiple associated business dashboards, and after setting them up, you can display them on a large screen.

In the Guance workspace 「Scene」 - 「Dashboard」, click 「Rotation List」on the right side to create a new rotation.

![](img/1.dashboard_player_4.png)



In the 「New Rotation」 pop-up dialog box, enter a name, select the dashboard to be rotated, and set the rotation frequency.

![](img/1.dashboard_player_2.png)

Once the configuration is complete, you can view the set up dashboard in the 「Rotation List」.

![](img/1.dashboard_player_3.png)

Click the 「Play」 button on the right, and the configured dashboard will play according to the set frequency.
![](img/1.dashboard_player_5.png)







