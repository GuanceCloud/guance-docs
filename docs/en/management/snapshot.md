# Snapshot
---


## Introduction

Guance Snapshot supports creating quickly accessible data copies for explorers such as scenarios and inner views, infrastructure, indicators, logs, events, application performance monitoring, user access monitoring, cloud dialing, security check, and CI visualization. With the Snapshot function, you can quickly reproduce the instantaneous copy of the data copy information, and restore the data to a certain point in time and a certain data display logic.


## Save Snapshot

Guance supports you to quickly save snapshots through page function buttons and shortcut keys (Windows: Ctrl+K/Mac OS: Cmd+K), enter snapshot name, select "Visible Range", select "Time Filter" on/off, and click "OK" to create a new snapshot.

- Visible scope: including public and self-visible, and users who publicly represent the current workspace can view the saved snapshot; Self-visible only means that no user except the current user can view the saved snapshot
- Including time filtering: that is, save the currently selected time range, and the shared links do not support switching time controls; If it is closed, it will follow the system default, and the shared snapshot can switch the time control
- Lock Absolute Time: "Include Time Filter" will only be displayed when it is turned on. When it is turned on, you can choose to save the currently selected absolute time

**注意**: You will not be able to use the Save Snapshot shortcut when your daemon has other shortcuts that conflict with the shortcut (Ctrl+K/Cmd+K).

![](img/6.snapshot_0.png)


### Save Snapshot in Explorer

In metrics, logs, events, application performance monitoring, user access monitoring, cloud dialing test, security check and other explorers, You can label the currently displayed data, filter the time range, add viewing columns and other operations, then click the "Snapshot" icon in the upper left corner of the explorer, and click "Save Snapshot" to save the data displayed in the current explorer. You can directly use the shortcut keys (Windows: Ctrl+K/Mac OS: Cmd+K) to save the snapshot.

![](img/6.snapshot_1.png)

### Save Snapshot in Scene

From the dashboard, notes, or inner view in the scenario, use the shortcut keys (Windows: Ctrl+K/Mac OS: Cmd+K) to save the data contents displayed in the current view or notes as a snapshot.

![](img/6.snapshot_3.png)


## View Snapshot

Guance supports viewing saved snapshots in the current explorer or in the "Snapshot" menu of the shortcut portal.

Note: All saved snapshots can be viewed in the "Snapshot" menu of the shortcut entry. The current explorer can only view the snapshots held by the current explorer. For example, the snapshots held in the log explorer cannot be viewed in the link explorer.

### View Snapshot in Explorer

After the explorer saves the snapshot, such as infrastructure, indicators, logs, events, application performance monitoring, user access monitoring, cloud dialing test, security check and CI visualization, click the icon in the upper left corner to skid and expand to view the saved snapshot.

- Support snapshot name keyword search, and match related snapshot names vaguely through keywords
- Support sharing, copying links and deleting functions. Click "Snapshot Name" to open the corresponding data copy in the current explorer
- If "Visible Range Only" is selected when saving the snapshot, the "Lock" button will be displayed after the snapshot name, and other users can't view it except the current user

![](img/6.snapshot_4.png)

- In the explorer snapshot list, the mouse is placed on the saved historical snapshot to view the time range and filter criteria of the historical snapshot. The time range is divided into three types: "absolute time", "relative time" and "default" according to the selection when saving the snapshot

![](img/6.snapshot_5.png)

- In the explorer snapshot list, select the saved history snapshot, and the "Return to Explorer" button appears. Click to return to the default explorer

![](img/6.snapshot_1.1.png)



### View a Snapshot on the Snapshot Menu

After the snapshot is saved, it can be viewed by clicking "Shortcut Entry"-"Snapshot" in the left navigation bar.

- Support snapshot name keyword search, and match related snapshot names vaguely through keywords
- Click "Snapshot Name" to open the corresponding data copy in a new window and reproduce the data label when the snapshot was saved
- Up to 20 snapshot names can be displayed per page, and you can view more snapshots by jumping to the next page
- If "Visible Range Only" is selected when saving the snapshot, the "Lock" button will be displayed after the snapshot name, and other users can't view it except the current user

![](img/6.snapshot_6.png)


## Delete Snapshot

After the snapshot is saved, you can delete the corresponding "snapshot" by clicking "Quick Entry"-"Snapshot" in the left navigation bar and using the "Delete" button.


## Share Snapshot

Guance supports two snapshot sharing methods: public sharing and encrypted sharing, and shared snapshots will automatically generate sharing links. You can share the snapshot link to "anyone" or share it encrypted to someone who owns the key. With「[snapshot management](../management/snapshot.md)」, you can manage all snapshots shared in the current space in a unified way, including viewing, canceling sharing, and so on.

Note:

- If you choose to turn on absolute time when saving snapshots, the absolute time when saving snapshots will be displayed after sharing. For example, when saving a snapshot, select the last 15 minutes, and you click on the snapshot link at 14:00 to display the data of the previous absolute time;
- If you choose to close the absolute time when saving the snapshot, the relative time when saving the snapshot will be displayed after sharing. For example, when saving a snapshot, select the last 15 minutes, and you click on the snapshot link at 14:00 to display the data from 13:45 to 14:00.

![](img/8.snap_5.png)

**Note**: You can view the expiration date and time range of snapshot sharing through Snapshot Management. See [snapshot management](../management/snapshot.md).

![](img/8.snap_6.png)


### Open Sharing

Open sharing enables users with sharing links to view shared data in Guance workspace. That is, you only need to share the link, and other users can see the snapshot you shared.

![](img/6.share_1.png)


### Private Sharing

Private sharing is a form of sharing with some people. When sharing snapshots, you need to set the extraction password, and require the password form of **4-8 digits and English combination**. Other users can access the snapshot only if they provide a sharing link and password.

![](img/6.share_2.png)

### Advanced Settings


#### Hide Top Bar

Snapshot sharing supports hiding the top bar of the sharing page. In the Snapshot list, click the Share button to set the advanced setting "Hide the Top Bar" in the pop-up dialog box.

![](img/6.share_3.png)

- Turn on the effect of hiding the top bar sharing

![](img/12.share_pic_2.png)

- Turn off the effect of hiding the sharing in the top bar, and you can see that there will be an introduction to the platform at the top.

![](img/12.share_pic_3.png)

#### Set Valid Time

Snapshot sharing supports setting effective time, and supports selecting "48 hours" or "permanent effective". In the snapshot list, click the Share button, and you can make advanced settings "Hide Top Bar" in the pop-up dialog box.

Note: Permanently and effectively sharing is prone to data security risks, so please use it carefully.

![](img/6.share_4.png)


### Snapshot Sharing Management

On the snapshot sharing page, click "View Sharing List" in the upper right corner to jump directly to "Management"-"Sharing Management"-"Snapshot Sharing" to view the snapshot sharing list, including snapshot name, sharing method, sharer, expiration date, view snapshot and view sharing link. See [share management](../management/share-management.md).

![](img/6.share_1.png)



