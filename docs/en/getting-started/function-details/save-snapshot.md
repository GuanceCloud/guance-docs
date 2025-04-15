# Save Snapshot
---


## Save Entry

Enter the page where you want to save a snapshot, adjust the time widget in the top-right corner, and filter out the data you need to save. Use the following methods to bring up the **Save Snapshot** window.

<div class="grid" markdown>

=== ":material-numeric-1-circle: Shortcut Key"

    :fontawesome-brands-windows: &nbsp; &nbsp; ++ctrl+k++

    :fontawesome-brands-apple: &nbsp; &nbsp; ++cmd+k++

    ???+ warning "Note"

        If your backend program has shortcut keys that conflict with the ones above, the shortcut key function for **Save Snapshot** will not be available.

    ---

=== ":material-numeric-2-circle: Explorer"
        
    Explorer > Top snapshot button (to the left of the search box):

    <img src="../../img/snapshot_explorer.png" width="80%" >

    ---

=== ":material-numeric-3-circle: Dashboard"

    Explorer > Top settings button:

    <img src="../../img/snapshot_dashboard.png" width="80%" >

    ---

</div>


## Start Saving {#begin-save-snapshot}

After successfully bringing up the **Save Snapshot** window, you can set up the snapshot accordingly.


1. Define the snapshot name;
2. Set visibility scope:
    - Public: All users in the current workspace can view this snapshot;
    - Only visible to yourself: Other user permissions cannot view this snapshot.                     
3. Automatically obtain the selected time range from the current page; you can adjust the time range here.                    

## View Snapshot {#check}

You can view saved snapshots through the following entries:

<div class="grid" markdown>

=== ":material-numeric-1-circle: View in Snapshot Menu"

    **Workspace > Shortcut > Snapshot** menu, you can view all snapshots saved in the current workspace.

    <img src="../../img/snapshot_in_bar.png" width="50%" >

    ---

=== ":material-numeric-2-circle: View on Explorer Page" 

    Enter **Explorer > Snapshot**, the system will display the snapshots saved by this explorer. Snapshots are only visible in the explorer they were saved in. For example, snapshots saved in the log explorer cannot be viewed in the RUM link explorer;

    - Hover over historical snapshots to display the time range and filtering conditions of the snapshot. Time ranges are divided into the following three types:

        - Absolute time: Fixed time intervals.
        - Relative time: Dynamic intervals based on the current time.
        - Default: System default time settings.

    ![](../img/snapshot_in_explorer.png)

    ---

=== ":material-numeric-3-circle: View on Dashboard Page"

    Enter **Use Cases > Dashboard**, at the **Historical Snapshots** area in the top-right of the page, you can view all dashboard snapshots saved in the current workspace.

    <img src="../../img/snapshot_in_dashboard.png" width="80%" >


## Manage Snapshots

For saved snapshots, you can perform the following operations:

<img src="../../img/manag_snapshot.png" width="60%" >

- In the search bar, input the snapshot name to perform a fuzzy match via keywords;       
- On the right side of the snapshot, you can choose the following actions:  
    - **Share/Delete Snapshot**: Manage the visibility of snapshots or delete those no longer needed.    
    - **Copy Snapshot Link**: Obtain a direct link to the snapshot for easy sharing or reference.      
- Clicking the **Snapshot Name** opens the corresponding data copy and reproduces the data tags when the snapshot was saved.       
- If the visibility scope is set to [**Only Visible to Yourself**](#begin-save-snapshot) when saving the snapshot, a :material-lock: icon will appear after the snapshot name, and others will not be able to view the snapshot.