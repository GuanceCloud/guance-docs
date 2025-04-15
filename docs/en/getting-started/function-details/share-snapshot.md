# Share Snapshot 
---

In the [Snapshot List](./save-snapshot.md#check), click :octicons-share-android-16: on the right side of the target snapshot to share it.


## Basic Configuration

<img src="../../img/snapshot_basic_settings.png" width="60%" >

### Time Range

When saving a snapshot, the selected time range is recorded. You can decide whether the recipient is allowed to change the time interval on the snapshot page.

### Validity Period

Four options are provided:

- 1 day (default)
- 3 days
- 7 days
- Permanent

???+ warning "Note"

    If you select "Permanent", there may be data security risks. Please consider carefully.

### Sharing Method {#sharing-method}

Two snapshot sharing methods are supported:

- [Public Sharing](#public)
- [Encrypted Sharing](#private)

After sharing, a corresponding link will be generated. You can share this link with "anyone," or use an encrypted method to share it with people who have the key.

???+ abstract "Data Time Segment Description for Shared Snapshot Links"

    - If "Absolute Time" is enabled when saving the snapshot, the absolute time of the snapshot will be displayed after sharing.

    For example: if at `13:30` you choose to save a snapshot of the last 15 minutes of data, then at `14:00`, opening the snapshot link will display data from `13:15 ~ 13:30`.

    - If "Absolute Time" is disabled when saving the snapshot, the relative time of the snapshot will be displayed after sharing.

    For example: if at `13:30` you choose to save a snapshot of the last 15 minutes of data, then at `14:00`, opening the snapshot link will display data from `13:45 ~ 14:00`.

???+ warning "Dashboard and Snapshot Permission Cross Reference Description"

    - Dashboard permissions determine the initial visibility scope of snapshots, and the sharing method selected when saving a snapshot only affects the viewing permissions within the current workspace; it does not affect the permissions after sharing.
    - After sharing, the snapshot permissions are mainly determined by dashboard permissions:
        - Public or custom dashboards: Snapshots shared after are default public.
        - Dashboards visible only to yourself: Snapshots shared after remain visible only to yourself.
    - Special cases:
        - The "visible only to yourself" permission for dashboards takes precedence, but dashboards with "public" visibility will still become public after snapshot sharing;
        - If the visibility scope of the dashboard changes later, the shared snapshot will be updated synchronously.

    > For more details, please refer to [Dashboard Visibility Scope Configuration](../../scene/dashboard/index.md#range).

#### Public Sharing {#public}
    
Users who receive the sharing link can view the workspace data displayed in the snapshot.    
    
???+ warning "Note"

    In the log explorer, users with [snapshot viewing](../../management/logdata-access.md#snapshot) permissions can see filtering conditions in the search bar at the top of the snapshot page and support adding search conditions.


#### Encrypted Sharing {#private}

Set a password that conforms to the `4-8 digit and English letter combination` format. Only users who obtain both the sharing link and password can view the snapshot data.


### More Options

1. Show Top Bar: When enabled, the top of the sharing page will display a platform introduction.
2. Show Watermark: When enabled, the watermark showing the name of the sharer will be displayed in the format "Shared by: Name".



## Data Desensitization {#sensitive}

You can configure desensitization for field values within the snapshot. Input the desensitized fields and regular expressions, click preview, and the content matched by the regular expression will be displayed as `*` in the current snapshot.

- Input desensitized fields (supports multiple selections);
- Regular Expression: Achieve desensitization through regular expression syntax.

> For more operations, please refer to [Sensitive Data Desensitization](../../management/data-mask.md).

<img src="../../img/snapshot_mask.png" width="60%" >



## Access Restrictions {#ip}

Enabling the IP whitelist adds extra protection to snapshot sharing.

<img src="../../img/snapshot_ip.png" width="60%" >

- Workspace IP Whitelist: Follows changes in the workspace's IP whitelist configuration and cannot be edited or modified under snapshot sharing;
- Custom Input: You can input a custom IP access whitelist. IPs not included will not be able to view the snapshot.

> For more details, please refer to [How to Configure IP Whitelist](../../management/settings/index.md#ip).

## Preview Snapshot

After completing all configurations, you can click "Preview Snapshot" to check the effect.


???+ warning "Note"

    This preview is exactly the same as the entire process of sharing snapshots in your real environment. For example, if an IP whitelist access restriction was set in the previous [configuration steps](#share), IPs outside the whitelist will also be unable to view the previewed snapshot.

## Manage Sharing {#view}

Members with [Save, Analyze, and Manage Snapshot Permissions](#permission) can enter the snapshot sharing management page via the following methods to view snapshots, view sharing links, cancel sharing, etc.:

> For more details, please refer to [Sharing Management](../../management/share-management.md#snapshot).

<div class="grid" markdown>

### Manage

Enter the **Manage > Sharing Management > Snapshot Sharing** module.

<img src="../../img/sharing_snapshot_manag_entry.png" width="80%" >

### Snapshot Sharing Window

When [sharing snapshots](#sharing-method), click "View Sharing List" in the upper-right corner to navigate to the **Snapshot Sharing** management module.

<img src="../../img/sharing_snapshot_list.png" width="60%" >


</div>