# Save Snapshot
---


## Save Entry

Enter the page where you want to save a snapshot, adjust the time widget in the top-right corner, and filter out the data you need to save. Then use the following methods to bring up the **Save Snapshot** window.

### Shortcut Keys

:fontawesome-brands-windows: &nbsp; &nbsp; ++ctrl+k++

:fontawesome-brands-apple: &nbsp; &nbsp; ++cmd+k++

???+ warning "Note"

    If shortcut keys in your background program conflict with the above shortcut keys, you will not be able to use the **Save Snapshot** shortcut key feature.

### Explorer
    
Explorer > Top snapshot button (to the left of the search box):

<img src="../../img/snapshot_explorer.png" width="80%" >

### Dashboard

Explorer > Top settings button:

<img src="../../img/snapshot_dashboard.png" width="80%" >



## Start Saving {#begin_save_snapshot}

After successfully bringing up the **Save Snapshot** window, you can set up related configurations for this snapshot.


1. Define the snapshot name;
2. Set visibility scope:
    - Public: All users in the current workspace can view this snapshot;
    - Visible only to yourself: Other users cannot access this snapshot.                     
3. Automatically obtain the selected time range from the current page; you can adjust the time range here.                    

## View Snapshots {#check}

You can view saved snapshots from the following entries:

### View in Snapshot Menu

- **Workspace > Shortcut > Snapshot** menu, to view all snapshots saved in the current workspace.

<img src="../../img/snapshot-3.png" width="50%" >

- Each page can display up to 20 snapshots. By navigating to the next page, you can view more snapshots.

<img src="../../img/snapshot-4.png" width="50%" >

### View on Explorer Page 

Enter **Explorer > Snapshot**, to display <u>snapshots saved by the current explorer</u>. For example, snapshots saved in the **Log Explorer** cannot be viewed in the **APM > Trace** explorer;

- Hover over a historical snapshot, and the corresponding time range and filtering conditions will be displayed in the floating window. The time range is divided into three types based on the selection at the time of saving the snapshot: "Absolute Time", "Relative Time", and "Default".

<img src="../../img/snapshot-5.png" width="60%" >

- If you have already clicked into a historical snapshot and then click **Snapshot** again, clicking the **Return to Explorer** button will take you back to the default explorer before entering that historical snapshot.

<img src="../../img/snapshot-6.png" width="60%" >

### View on Dashboard Page 

Enter **Use Cases > Dashboard**, and in the **Historical Snapshots** section at the top right of the page, you can view all dashboard snapshots saved in the current workspace.

![](../img/snapshot-14.png)


## Manage Snapshots

- In the 🔍 bar, you can input the snapshot name and search for related snapshots using keyword matching;
- On the right side of the snapshot, you can choose to share/delete the snapshot or copy the snapshot link;
- Clicking the **snapshot name** will open the corresponding data copy and restore the data tags when the snapshot was saved;
- If the [visibility scope was set to visible only to yourself](#snapshot-setting) when saving the snapshot, a :material-lock: will appear after the snapshot name, and others will not be able to view it.