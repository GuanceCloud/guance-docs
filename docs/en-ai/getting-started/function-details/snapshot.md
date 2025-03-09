# Snapshots
---

<<< custom_key.brand_name >>> snapshots support creating custom time-range copies of data for scenario dashboards, infrastructure, metrics, logs, events, APM, RUM, cloud dial testing, security checks, CI visualization, and other Explorers. They also generate shortcut links with specified viewing permissions.

- If there is a need to record data from specific moments when a business system encounters issues or anomalies, the **Save Snapshot** feature can effectively help IT engineers quickly document accurate observation data, aiding in rapid problem identification.
- When different teams within an enterprise or external partners need to share certain observation data while ensuring data permission isolation, the **Share Snapshot** feature can significantly improve collaboration efficiency among members with different responsibilities, helping the enterprise solve problems quickly.

## Save Snapshots {#save}

### Snapshot Permissions {#permission}

- For pages that support saving snapshots, only the **Owner** and **Administrator** of the current workspace have the permissions to **save snapshots, share snapshots, and manage snapshot sharing** among the [four default roles](../../management/role-management.md#_3).
- In addition to default roles, you can grant relevant snapshot permissions through [custom roles](../../management/role-management.md#_5) and assign these roles to required members.

### Saving Methods

Enter the page where you want to save a snapshot, adjust the time widget in the top-right corner, and filter out the data you wish to save. Use the following methods to bring up the **Save Snapshot** window.

<div class="grid" markdown>

=== "Shortcuts"

    :fontawesome-brands-windows: &nbsp; &nbsp; ++ctrl+k++

    :fontawesome-brands-apple: &nbsp; &nbsp; ++cmd+k++

    **Note**: If your backend program has conflicting shortcuts, the **Save Snapshot** shortcut function will not work.

=== "Explorer Page Snapshot Button"
    
    **Explorer > Top Snapshot Button** (left of the search box), click **Save Snapshot**.

    <img src="../../img/snapshot-1.png" width="80%" >

=== "Dashboard Settings Button"

    **Explorer > Top Settings Button** (left of the time widget), click **Save Snapshot**.

    ![](../../img/snapshot-13.png)

</div>

### Snapshot Settings {#snapshot-setting}

After successfully bringing up the **Save Snapshot** window, you can configure the settings for this snapshot.

<img src="../../img/snapshot-2.png" width="60%" >

1. Enter the snapshot name;
2. Visibility scope: including **Public** and **Private**.
    - Public: All users in the current workspace can view this snapshot;
    - Private: Only the user who saved the snapshot can view it.                     
3. Automatically retrieves the selected time range from the current page; you can adjust the time range here.                    

## View Snapshots

### Viewing Methods {#check}

You can view saved snapshots via the following entry points:

#### :material-numeric-1-circle: In the Snapshot Menu

- **Workspace > Shortcut > Snapshot** menu, view all snapshots saved in the current workspace.

<img src="../../img/snapshot-3.png" width="50%" >

- Each page can display up to 20 snapshots; navigate to the next page to see more.

<img src="../../img/snapshot-4.png" width="50%" >

#### :material-numeric-2-circle: In the Explorer Page 

Enter **Explorer > Snapshots**, which displays **snapshots saved by the current Explorer**. For example, snapshots saved in the **Log Explorer** cannot be viewed in the **APM > Trace** Explorer;

- Hover over historical snapshots to display the corresponding time range and filters in a floating window. The time range can be "Absolute Time," "Relative Time," or "Default" based on the selection at the time of snapshot creation.

<img src="../../img/snapshot-5.png" width="60%" >

- If you have clicked into a specific historical snapshot, clicking **Snapshot** again and then **Return to Explorer** will take you back to the default Explorer before entering the historical snapshot.

<img src="../../img/snapshot-6.png" width="60%" >

#### :material-numeric-3-circle: In the Dashboard Page 

Enter **Scenarios > Dashboard**, and in the upper right-hand corner under **Historical Snapshots**, view all dashboard snapshots saved in the current workspace.

![](../img/snapshot-14.png)

### Snapshot List Operations

- In the 🔍 bar, you can input the snapshot name to search for related snapshots by keyword;
- On the right side of each snapshot, you can choose to share/delete the snapshot or copy the snapshot link;
- Clicking the **Snapshot Name** opens the corresponding data copy and restores the data tags as they were when the snapshot was saved;
- If the visibility scope was set to **Private** during snapshot creation, a :material-lock: icon will appear after the snapshot name, indicating that others cannot view it.

## Share Snapshots {#share}

In the snapshot list on the right, click :octicons-share-android-16:, to share the current specific snapshot.

<!--
<img src="../../img/snapshot-0724.png" width="60%" >
-->

### Basic Configuration

<!--
In the share snapshot window, the snapshot name is the one entered when [saving the snapshot](#save); it is not editable by default.
-->

<img src="../../img/snapshot-basis.png" width="60%" >

#### Time Range

After saving the snapshot, it retains the time range selected at the time of saving. You can choose whether the recipient can change the time range on the snapshot page.

#### Validity Period

Options include 1 day, 3 days, 7 days, and permanent validity; the default is 1 day.

**Note**: If you select "Permanent Validity," it may pose data security risks, so please consider carefully.

#### Sharing Method {#sharing-method}

<<< custom_key.brand_name >>> supports two snapshot sharing methods: public sharing and encrypted sharing. Shared snapshots automatically generate corresponding links. You can share the snapshot link with "anyone" or encrypt it for those with the key.

???+ abstract "Explanation of Data Time Range in Shared Snapshot Links"

    - If **Absolute Time** was enabled when saving the snapshot, the shared link will show the absolute time at which the snapshot was saved.

    For example: if you save a snapshot of the last 15 minutes of data at `13:30`, opening the snapshot link at `14:00` will display data from `13:15 ~ 13:30`.

    - If **Absolute Time** was disabled when saving the snapshot, the shared link will show the relative time from the moment the snapshot was saved.
    
    For example: if you save a snapshot of the last 15 minutes of data at `13:30`, opening the snapshot link at `14:00` will display data from `13:45 ~ 14:00`.

:material-numeric-1-circle: Public Sharing
    
Users with the share link can view the <<< custom_key.brand_name >>> workspace data displayed by this snapshot.    
    
**Note**: In the Log Explorer, users with [snapshot viewing](../../management/logdata-access.md#snapshot) permissions can view the filtering conditions in the search bar above the snapshot page and add additional search criteria.

<img src="../../img/snapshot-7.png" width="50%" >

:material-numeric-2-circle: Encrypted Sharing

Set a password conforming to `4-8 digits and English letters`. Users with both the share link and the corresponding password can view the <<< custom_key.brand_name >>> workspace data displayed by this snapshot.

<img src="../../img/snapshot-8.png" width="50%" >

#### Additional Options

:material-numeric-1-circle: Display Top Bar 
    
- Enabling the top bar shows platform introduction text at the top.

<img src="../../img/snapshot-11.png" width="90%" >

- Disabling the top bar hides the platform introduction text.

<img src="../../img/snapshot-10.png" width="90%" >

:material-numeric-2-circle: Display Watermark

Snapshots can display a watermark with the sharer's name in the format "Shared by: Name".

<img src="../../img/7.snapshot_3.png" width="90%" >

### Data Masking {#sensitive}

You can configure masking rules for field values within the snapshot. Input the masking fields and regular expressions, click preview, and matched content will be displayed as `*`.

- Masking fields: multiple selections supported;
- Regular expressions: use regex syntax for masking; refer to [Data Access](../../management/logdata-access.md#config) for more operations.

<img src="../../img/snapshot-mask.png" width="60%" >


<!--
**Note**:  

- If the regex configuration includes groups, only the content within the group will be masked;   
- If the regex configuration does not include groups, the entire match will be masked.
  
*Example: Need to share a snapshot of log data with a member while hiding UID.*

Configure data masking rules with regex. Here, no groups are used:

<img src="../../img/0727-sensitive.png" width="50%" >

After setting the sharing method, validity period, etc., click **Confirm**. Check the [View Snapshot](#view) page, and the UID information will be hidden:

For example, the `message` field contains: `2023-07-27 07:20:56.240 [INFO][65]  UID:"9e269876-361b-4ba4-a566-8f8ccae74d68"`, after configuration, it displays as `2023-07-27 07:20:56.240 [INFO][65] *** `.

![](../img/0727-sensitive-1.png)



If the regex configuration includes groups `UID:(".*?")`, i.e.:

<img src="../../img/0727-sensitive-2.png" >

The masked effect is:

For example, after configuration, it displays as `2023-07-27 07:20:56.240 [INFO][65] UID:***`.

![](../img/0727-sensitive-3.png)
-->


### IP Restrictions {#ip}

Enable IP whitelist: This adds an extra layer of protection to snapshot sharing.

<img src="../../img/snapshot-ip.png" width="60%" >

When enabling the IP whitelist, you can choose to use the current workspace's IP whitelist or customize the input:

- Workspace IP Whitelist: Uses the current workspace's IP whitelist, which changes according to the workspace's IP whitelist configuration and cannot be edited in the snapshot sharing settings;
- Custom Input: You can input custom IP access whitelists. IPs not listed will not be able to view the shared snapshot.

> For more details, refer to [How to Configure IP Whitelist](../../management/settings/index.md#ip).

### Preview Snapshot

After completing all configurations for sharing the snapshot, you can choose to preview the snapshot effect:

<img src="../../img/snapshot-preview.png" width="60%" >

The masking effect in the snapshot is shown below:

<img src="../../img/snapshot-preview-page.png" width="70%" >

**Note**: This preview mirrors the actual sharing process. For example, if you set IP whitelist restrictions in the [configuration steps](#share), IPs outside the whitelist will also be unable to view the preview snapshot.

### Manage Shared Snapshots {#view}

Members with permissions to [save, analyze, and manage snapshots](#permission) can enter the **Manage Shared Snapshots** page via the following two methods to view snapshots, check share links, cancel shares, etc.

> Refer to [Share Management](../../management/share-management.md#_3) for more details.

<div class="grid" markdown>

=== "Management Module" 

    Enter **Management > Share Management > Shared Snapshots** module.

    <img src="../../img/snapshot-12.png" width="80%" >

=== "Snapshot Share Window" 

    When performing [snapshot sharing](#sharing-method), click **View Share List** in the top-right corner to navigate to the **Shared Snapshots** management module.

    <img src="../../img/snapshot-12-1.png" width="60%" >

</div>