# Share Snapshot 
---

In the [Snapshot List](./save-snapshot.md#check), click :octicons-share-android-16: on the right side of the target snapshot to perform a sharing operation for that snapshot.


## Basic Configuration

<img src="../../img/snapshot_basic_settings.png" width="60%" >

### Time Range

When saving a snapshot, the selected time range is recorded. You can decide whether the recipients are allowed to change the time interval of the snapshot page.

### Validity Period

Four options are provided:

- 1 day (default)
- 3 days
- 7 days
- Permanent

???+ warning "Note"

    If you select "Permanent validity," there may be data security risks. Please consider carefully.

### Sharing Method {#sharing-method}

Two snapshot sharing methods are supported:

- [Public Sharing](#public)
- [Encrypted Sharing](#private)

After sharing, corresponding links will be generated, which you can share with "anyone" or through encryption with those who have the key.

???+ abstract "Data Time Segment Description for Shared Snapshot Links"

    - If "Absolute Time" is selected when saving the snapshot, the shared link will display the absolute time at the moment of saving the snapshot.

    For example: If you choose to save a snapshot of the last 15 minutes of data at `13:30`, then opening the snapshot link at `14:00` will show data from `13:15 ~ 13:30`.

    - If "Absolute Time" is not selected when saving the snapshot, the relative time at the moment of saving the snapshot will be displayed after sharing.

    For example: If you choose to save a snapshot of the last 15 minutes of data at `13:30`, then opening the snapshot link at `14:00` will show data from `13:45 ~ 14:00`.

???+ warning "Dashboard and Snapshot Permission Intersections"

    - Dashboard permissions determine the initial visibility scope of snapshots, but the sharing method chosen when saving snapshots only affects viewing permissions within the current workspace and does not affect permissions after sharing.
    - After sharing, snapshot permissions are primarily determined by dashboard permissions:
        - Public or custom dashboards: Snapshots shared afterward default to public.
        - Dashboards visible only to yourself: Snapshots shared afterward remain visible only to yourself.
    - Special cases:
        - The "visible only to yourself" permission of the dashboard takes precedence, but if the dashboard's visibility is set to "public", the snapshot will still become public after sharing;
        - If the visibility of the dashboard changes later, the shared snapshot will update accordingly.

    > For more details, refer to [Dashboard Visibility Configuration](../../scene/dashboard/index.md#range).

#### Public Sharing {#public}
    
Users who obtain the sharing link can view the workspace data displayed in the snapshot.    


#### Encrypted Sharing {#private}

Set a password in the form of `4-8 digits and English letters combination`. Only users who obtain both the sharing link and the password can view the snapshot data.


### More Options

1. Display Top Bar: When enabled, the top of the shared page will display a platform introduction note.
2. Display Watermark: When enabled, a watermark showing the sharer’s name will be displayed in the format "Sharer: Name".


## Data Desensitization {#sensitive}

You can configure desensitization for field values within the snapshot. Input desensitization fields and regular expressions, click preview, and the content matched by the regular expression will be displayed as `*` in the current snapshot.

- Input desensitization fields (multi-select supported);
- Regular Expression: Achieve desensitization through regular expression syntax.

> For more operations, refer to [Sensitive Data Desensitization](../../management/data-mask.md).

<img src="../../img/snapshot_mask.png" width="60%" >



## Access Restrictions {#ip}

Enabling an IP whitelist adds extra protection to snapshot sharing.

<img src="../../img/snapshot_ip.png" width="60%" >

- Workspace IP Whitelist: Follows changes in the workspace IP whitelist configuration; editing is not supported under snapshot sharing;
- Custom Input: Allows custom input of IP access whitelists; IPs not included cannot view the snapshot.

> For more details, refer to [How to Configure IP Whitelist](../../management/settings/index.md#ip).

## Preview Snapshot

After completing all configurations, you can click "Preview Snapshot" to check the effect.


???+ warning "Note"

    The preview here is entirely consistent with the actual process of sharing snapshots in your environment. For example, if an IP whitelist restriction was set in the preceding [Configuration Steps](#ip), IPs outside the whitelist will also be unable to view the preview of the snapshot.

## Manage Sharing {#view}

Members with [Save, Analyze, and Manage Snapshot Permissions](./snapshot.md#permission) can enter the shared snapshot management page via the following methods to view snapshots, view sharing links, cancel sharing, etc.:

> For more details, refer to [Share Management](../../management/share-management.md#snapshot).


### Manage

Enter the **Manage > Share Management > Share Snapshot** module:

<img src="../../img/sharing_snapshot_manag_entry.png" width="80%" >

### Snapshot Sharing Window

When [Sharing Snapshots](#sharing-method), click "View Sharing List" in the upper-right corner to jump to the **Share Snapshot** management module.

<img src="../../img/sharing_snapshot_list.png" width="60%" >