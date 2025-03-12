# Snapshots
---

## Overview

Snapshot in Guance supports <u>creating a copy of data immediately copied in custom time period and generating a quick access link with specified viewing permissions</u> for explorers in Dashboards, Infrastructure, Metrics, Logs, Events, APM, RUM, cloud dialing test, Security Check, CI Visualization, etc.

- If there is a similar need to <u>keep data of problems or abnormal moments in business systems</u>, the **Save Snapshot** function can effectively help IT engineers quickly record true and accurate observation data and thus quickly locate problems.
- If there is a need to <u>share some observation data</u> among different teams within the enterprise or with external partners on the premise of ensuring data authority isolation, the function of **Share Snapshot** can effectively improve the cooperation efficiency among members of different division of labor and help the enterprise solve problems quickly.

## Step 1: Save Snapshot  

### Snapshot Permission {#permission}

- For pages that support saving snapshots, only the **Owner** and **Administrator** of the current workspace have the permissions of **Save Snapshot**, **Share Snapshot** and **Snapshot Sharing Management** in the [four default roles](../../management/role-management.md#_3) of members.
- In addition to the default role, you can also grant relevant snapshot permissions and assign the role to the desired member through the [custom role](../../management/role-management.md#_5).

### How to Save

Enter the page where you want to save the snapshot, adjust the time control in the upper right corner and filter out the data to be saved. Use the following method to pop up the **Save Snapshot** window.

<div class="grid" markdown>

=== "Shortcut Keys"

    :fontawesome-brands-windows: &nbsp; &nbsp; ++ctrl+k++

    :fontawesome-brands-apple: &nbsp; &nbsp; ++cmd+k++

    <font color=coral>**Note:**</font> When a shortcut exists in your daemon that conflicts with the shortcut above, **Save Snapshot** shortcut function will not be available.

=== "Explorer > Snapshot Button"
    
    **Save Snapshot** at the top (left of search box), click **Save Snapshot**.

    <img src="../../img/snapshot-1.png" width="60%" >

=== "Explorer > Settings Button"

    **Explorers > Settings** at the top (left side of time control), click **Save Snapshot**.

    <img src="../../img/snapshot-13.png" width="60%" >

</div>

### Snapshot Settings {#snapshot-setting}

After the **Save Snapshot** window pops up successfully, you can set up the snapshot.

<img src="../../img/snapshot-2.png" width="60%" >


| Fields      | Description                          |
| ----------- | ------------------------------------ |
| Visible range      | Includes **Public** and **Private**.<br/>Users who publicly represent the current workspace can view this snapshot; Private only means that other users DO NOT have the right to view the snapshot.                     |
| Time screening      | Save the currently selected time range, and the shared links do not support switching time controls; If it is closed, it will follow the system default, and the shared snapshot can switch the time control.                          |
| Save as absolute time      | Time screening will only be displayed when it is turned on, and when it is turned on, it is selected to save the currently selected absolute time.  |      

## Step 2: View Snapshots

### General Functions

- Support snapshot name keyword search, and match related snapshot names vaguely through keywords.
- Support sharing, copying links and deleting functions.
- Click **Snapshot Name** to open the corresponding data copy and reproduce the data label when the snapshot was saved.
- If, when saving the snapshot, [Private is selected](#snapshot-setting), the snapshot name will be followed by :material-lock:and no one else will be able to view it.  
### Viewing Methods

In addition to the above general functions, the following two ways to view snapshots also have special functions.

<div class="grid" markdown>

=== "View in Snapshot Menu" 

    - **Workspace > Shortcuts** in the lower left corner-Click the **Snapshot** menu to view **all saved snapshots in the current workspace**.

    <img src="../../img/snapshot-3.png" width="60%" >

    - Up to 20 snapshot names can be displayed on each page and you can view more snapshots by jumping to the next page.


=== "View on Explorer Page" 

    - **Explorers > Snapshots** at the top, showing only <u>all saved snapshots in the current explorers</u>. For example, snapshots saved in **Logs> Explorers** cannot be viewed in **Explorers** in **APM > Links**.
    - When hover on the saved history snapshot, the window will be suspended to show the corresponding time range and filter conditions. The time range is divided into **Absolute Time**, **Relative Time** and **Default** according to the choice when saving snapshots.

    <img src="../../img/snapshot-5.png" width="70%" >

    - If you have entered a historical snapshot, click **Snapshot** again, and a **Return** button will emerge to back default explorer before entering the historical snapshot.

    ![](../../img/snapshot-6.gif)

</div>

## Step 3: Share Snapshots

### Sharing Methods {#sharing-method}

Guance supports two snapshot sharing methods: public sharing and encryption, and the shared snapshots will automatically generate corresponding links. You can share the snapshot link to anyone or share it encrypted to someone who owns the key.

???+ info "Data slot description for sharing snapshot links"

    - If you open absolute time when saving snapshots, the absolute time when saving snapshots will be displayed after sharing.<br/>
    For example, if you choose to save a snapshot of the last 15 minutes at `13:30`, open the snapshot link at `14:00` and display the data from `13:15 to 13:30`.
    - If saving as absolute time is selected when saving the snapshot, the relative time when saving the snapshot will be displayed after sharing.<br/>
    For example, if you choose to save a snapshot of the last 15 minutes at `13:30`, open the snapshot link at `14:00` and display the data from `13:45 to 14:00`.

<div class="grid" markdown>

=== "Public Sharing" 
    
    Users who get the sharing link can view the Guance workspace data displayed in this snapshot.

    <img src="../../img/snapshot-7.png" width="50%" >

=== "Password Sharing" 

    Set the password form that conforms to `4 to 8 digits and English combination`, and only users who get the sharing link and corresponding password can view the Guance workspace data displayed in this snapshot.

    <img src="../../img/snapshot-8.png" width="50%" >

</div>

### Advanced settings

<div class="grid" markdown>

=== "Set Effective Time" 

    Snapshot sharing supports setting effective time, and supports selecting "48 hours" or "Permanent".

    <font color=coral>**Note:**</font> Permanently and effectively sharing is prone to data security risks, so please use it carefully.

    <img src="../../img/7.snapshot_1.png" width="50%" >

=== "Show Top Bar" 
    
    - Turn on the effect of sharing in the top bar, and you can see that there will be an introduction to the platform at the top:

    <img src="../../img/snapshot-11.png" width="90%" >

    - Turn off the effect of showing sharing in the top bar:

    <img src="../../img/snapshot-10.png" width="90%" >

=== "Show Watermark"

    When sharing snapshot, it supports the watermark of displaying the name of the sharer in the format of "sharer: name".


</div>

## Shared Snapshot Management

Members with [save, analyze and manage snapshots permissions](#permission) can enter the Share Snapshots management page in the following two ways to view snapshots, view sharing links, cancel sharing and other operations.

> See [Sharing Management](../../management/share-management.md#_3) for more information.

<div class="grid" markdown>

=== "Management" 

    Click **Management > Sharing > Sharing Snapshot** module in the left navigation bar in turn.

    <img src="../../img/snapshot-12.png" width="80%" >

=== "Snapshot Sharing" 

    [Step 3: Snapshot Sharing](#sharing-method). When selecting public sharing or private sharing, you can click **View Sharing List** in the upper right corner to jump to the **Sharing Snapshot** management module.

</div>
