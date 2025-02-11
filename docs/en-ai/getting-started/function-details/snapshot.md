# Snapshot
---

Guance Snapshots support creating custom time-range data copies for scene dashboards, infrastructure, metrics, logs, events, APM, RUM, dial testing, security checks, CI visualization, and other Explorers. These snapshots generate quick-access links with specified viewing permissions.

- When there is a need to record data from problematic or abnormal moments in retention business systems, the **Save Snapshot** feature can effectively help IT engineers quickly document real and accurate observation data, aiding in rapid issue localization.
- When different teams within an enterprise or external partners need to share certain observation data while ensuring data permission isolation, the **Share Snapshot** feature can significantly improve collaboration efficiency among members with different responsibilities, helping enterprises solve problems quickly.

## Save Snapshot {#save}

### Snapshot Permissions {#permission}

- For pages that support saving snapshots, only members with the **Owner** or **Administrator** roles of the current workspace have the permissions to **save snapshots, share snapshots, and manage snapshot sharing**;
- Besides default roles, you can also grant relevant snapshot permissions through [custom roles](../../management/role-management.md#_5) and assign these roles to required members.

### Saving Methods

Enter the page you wish to save a snapshot from, adjust the time control in the top-right corner, and filter out the data you want to save. Use the following methods to bring up the **Save Snapshot** window.

<div class="grid" markdown>

=== "Shortcuts"

    :fontawesome-brands-windows: &nbsp; &nbsp; ++ctrl+k++

    :fontawesome-brands-apple: &nbsp; &nbsp; ++cmd+k++

    **Note**: If your backend program has conflicting shortcuts with the ones listed above, you will not be able to use the **Save Snapshot** shortcut functionality.

=== "Explorer Page Snapshot Button"
    
    **Explorer > Top Snapshot Button** (left of the search box), click **Save Snapshot**.

    <img src="../../img/snapshot-1.png" width="80%" >

=== "Dashboard Settings Button"

    **Explorer > Top Settings Button** (left of the time control), click **Save Snapshot**.

    ![](../../img/snapshot-13.png)

</div>

### Snapshot Settings {#snapshot-setting}

After successfully bringing up the **Save Snapshot** window, you can set up the snapshot accordingly.

<img src="../../img/snapshot-2.png" width="60%" >

1. Enter the snapshot name;
2. Visibility Scope: includes **Public** and **Private**.
    - Public: all users in the current workspace can view this snapshot;
    - Private: only the owner can view this snapshot.                     
3. Automatically fetches the selected time range on the current page; you can adjust the time range here.                    

## View Snapshot

### Viewing Methods {#check}

You can view saved snapshots through the following entries:

#### :material-numeric-1-circle: In Snapshot Menu

- **Workspace > Shortcut > Snapshot** menu, view all snapshots saved in the current workspace.

<img src="../../img/snapshot-3.png" width="50%" >

- Each page can display up to 20 snapshots; navigate to the next page to see more snapshots.

<img src="../../img/snapshot-4.png" width="50%" >

#### :material-numeric-2-circle: In Explorer Page 

Enter **Explorer > Snapshot**, showing snapshots saved in the current explorer. For example, snapshots saved in the **Log Explorer** cannot be viewed in the **APM > Trace** Explorer;

- Hover over a historical snapshot to display the corresponding time range and filtering conditions in a floating window. Time ranges are categorized into "Absolute Time," "Relative Time," and "Default" based on the selection when saving the snapshot.

<img src="../../img/snapshot-5.png" width="60%" >

- If you have clicked into a specific historical snapshot and then click **Snapshot** again, clicking the **Return to Explorer** button will take you back to the default Explorer before entering that historical snapshot.

<img src="../../img/snapshot-6.png" width="60%" >

#### :material-numeric-3-circle: In Dashboard Page 

Enter **Scene > Dashboard**, and at the top-right **Historical Snapshots**, view all dashboard snapshots saved in the current workspace.

![](../img/snapshot-14.png)

### Snapshot List Operations

- In the 🔍 bar, you can input the snapshot name to search for related snapshots by keyword;
- On the right side of the snapshot, you can choose to share/delete the snapshot or copy the snapshot link;
- Clicking the **Snapshot Name** opens the corresponding data copy and reproduces the data labels present when the snapshot was saved;
- If the visibility scope was set to **Private** during snapshot saving, a :material-lock: icon will appear after the snapshot name, indicating others cannot view it.

## Share Snapshot {#share}

On the right side of the snapshot list, click :octicons-share-android-16:, to share the current specific snapshot.

<!--
<img src="../../img/snapshot-0724.png" width="60%" >
-->

### Basic Configuration

<!--
In the share snapshot window, the snapshot name is the one entered when [saving the snapshot](#save); it is not editable by default.
-->

<img src="../../img/snapshot-basis.png" width="60%" >

#### Time Range

After saving a snapshot, it captures the selected time range at the moment of saving. You can choose whether the recipient can modify the time range on the snapshot page.

#### Validity Period

Options include 1 day, 3 days, 7 days, and permanent validity; the default selection is 1 day.

**Note**: Selecting "Permanent Validity" may pose data security risks, please consider carefully.

#### Sharing Method {#sharing-method}

Guance supports two types of snapshot sharing methods: public sharing and encrypted sharing. Shared snapshots automatically generate corresponding links. You can share the snapshot link with "anyone," or encrypt it for those who have the key.

???+ abstract "Explanation of Data Time Range in Shared Snapshot Links"

    - If you select **Enable Absolute Time** when saving the snapshot, the shared link will show the absolute time when the snapshot was saved.

    For example, if you save a snapshot of the last 15 minutes at `13:30`, opening the snapshot link at `14:00` will display data from `13:15 ~ 13:30`.

    - If you select **Disable Absolute Time** when saving the snapshot, the shared link will show relative time based on when the snapshot was opened.
    
    For example, if you save a snapshot of the last 15 minutes at `13:30`, opening the snapshot link at `14:00` will display data from `13:45 ~ 14:00`.

:material-numeric-1-circle: Public Sharing
    
Users who receive the sharing link can view the Guance workspace data displayed in this snapshot.    
    
**Note**: In the Log Explorer, users with [snapshot viewing](../../management/logdata-access.md#snapshot) permissions can see the filtering conditions of the data list in the search bar at the top of the snapshot page and add search conditions.

<img src="../../img/snapshot-7.png" width="50%" >

:material-numeric-2-circle: Encrypted Sharing

Set a password conforming to the format of `4-8 digits and English letters`. Only users with both the sharing link and the corresponding password can view the Guance workspace data displayed in this snapshot.

<img src="../../img/snapshot-8.png" width="50%" >

#### Additional Options

:material-numeric-1-circle: Show Top Bar 
    
- Enabling the top bar share effect shows an introduction to the platform at the top.

<img src="../../img/snapshot-11.png" width="90%" >

- Disabling the top bar share effect:

<img src="../../img/snapshot-10.png" width="90%" >

:material-numeric-2-circle: Show Watermark

Snapshot sharing supports displaying a watermark with the sharer's name, formatted as “Sharer: Name”.

<img src="../../img/7.snapshot_3.png" width="90%" >

### Data Masking {#sensitive}

You can configure masking rules for field values in the snapshot. Input the masking fields and regular expressions, click preview, and matched content will be shown as `*` in the current snapshot.

- Masking Fields: multiple selections supported;
- Regular Expressions: achieve masking using regex syntax; refer to [Data Access](../../management/logdata-access.md#config) for more operations.

<img src="../../img/snapshot-mask.png" width="60%" >


<!--
**Note**:

- If the regex configuration contains groups, only the content within the group will be masked;
- If the regex configuration does not contain groups, the entire match will be masked.

*Example: Need to share a snapshot of log data with a member and hide the UID.*

Configure the data masking rule with regex. Here no grouping is used:

<img src="../../img/0727-sensitive.png" width="50%" >

After setting the sharing method, validity period, etc., click **Confirm**. Go to the [Snapshot View](#view) page to check, and the UID information is hidden:

For example: The `message` field information is: `2023-07-27 07:20:56.240 [INFO][65]  UID:"9e269876-361b-4ba4-a566-8f8ccae74d68"`, after configuration, it displays as `2023-07-27 07:20:56.240 [INFO][65] *** `.

![](../img/0727-sensitive-1.png)


If the regex configuration contains a group `UID:(".*?")`, i.e.:

<img src="../../img/0727-sensitive-2.png" >

The masked result is:

For example, after configuration, it displays as `2023-07-27 07:20:56.240 [INFO][65] UID:***`.

![](../img/0727-sensitive-3.png)
-->


### Access Restrictions {#ip}

Enable IP Whitelist: This adds an extra layer of protection to snapshot sharing.

<img src="../../img/snapshot-ip.png" width="60%" >

When you enable the IP whitelist, you can choose to directly use the current workspace's IP whitelist or customize input:

- Workspace IP Whitelist: follows the changes in the current workspace's IP whitelist configuration and cannot be edited under snapshot sharing;
- Custom Input: you can define your own IP access whitelist. IPs not in this list cannot view the shared snapshot.

> Refer to [How to Configure IP Whitelist](../../management/settings/index.md#ip) for more details.

### Preview Snapshot

When you complete all configurations for sharing the snapshot, you can choose to preview the snapshot effect:

<img src="../../img/snapshot-preview.png" width="60%" >

The masking effect in the snapshot is shown in the following image:

<img src="../../img/snapshot-preview-page.png" width="70%" >

**Note**: This preview is identical to the actual sharing process in a real environment. For example, if you set IP whitelist restrictions in the [configuration steps](#share), IPs outside the whitelist will not be able to view the preview snapshot.

### Manage Shared Snapshots {#view}

Members with [permissions to save, analyze, and manage snapshots](#permission) can enter the **Manage Shared Snapshots** page via the following two methods to view snapshots, view sharing links, cancel sharing, etc.

> Refer to [Share Management](../../management/share-management.md#_3) for more details.

<div class="grid" markdown>

=== "Management Module" 

    Enter **Management > Share Management > Shared Snapshots** module.

    <img src="../../img/snapshot-12.png" width="80%" >

=== "Snapshot Sharing Window" 

    When you perform [snapshot sharing](#sharing-method), click **View Share List** in the top-right corner to jump to the **Shared Snapshots** management module.

    <img src="../../img/snapshot-12-1.png" width="60%" >

</div>