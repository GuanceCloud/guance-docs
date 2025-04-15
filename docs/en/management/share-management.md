# Share Management
---

<<< custom_key.brand_name >>> supports unified management of shared charts and snapshots within the current workspace through **Management > Share Management**.


## Sharing Charts

<<< custom_key.brand_name >>> allows workspace administrators and standard members to share and manage charts. Chart sharing can be used to embed visualized data for display and analysis in platforms outside <<< custom_key.brand_name >>>.

> For more details, refer to [Chart Sharing](../scene/visual-chart/index.md#share).

After completing chart sharing in the **Scene View**, you can view the list of shared charts in the current workspace through **Management > Share Management > Share Charts** and perform <u>batch operations, chart viewing, viewing embedding codes, and canceling shares</u>.

![](img/share.png)

- **Chart Viewing** helps you quickly preview the corresponding shared chart;

![](img/11_share_01.png)

- **View Embedding Code** helps you quickly obtain the embedding code for the corresponding shared chart;

![](img/11_share_02.png)

- **Cancel Share** will invalidate the already shared chart and cannot be restored. <u>Please carefully confirm the content to cancel sharing</u>. You can also click the :material-crop-square: next to the chart name to select specific charts for batch cancellation of sharing.

![](img/11_share_03.png)

## Share Snapshots {#snapshot}

After sharing a snapshot, you can view the snapshot sharing list through **Management > Share Management > Snapshot Sharing**, including snapshot name, sharing method, sharer, validity period, time range, view snapshot, and view sharing link.

![](img/share-1.png)

| Field      | Description                          |
| ----------- | ------------------------------------ |
| Snapshot Name       | The name set when creating the snapshot, currently not editable.  |
| [Sharing Method](../getting-started/function-details/snapshot.md)      | Includes public sharing and encrypted sharing. Allows sharing with "anyone" who has the link or those who have both the sharing link and the key. |
| Validity Period    | The validity period of the snapshot sharing. <<< custom_key.brand_name >>> defaults the validity period of the sharing link to 48 hours, meaning the link is valid for 48 hours after it is generated. |
| Time Range      | The relative/absolute time range selected for saving the snapshot. For example, the last 15 minutes as a relative time range.                          |
| View Snapshot      | Corresponding to the snapshot, clicking **View Snapshot** will redirect to a new page to view the corresponding data copy.                          |
| View Sharing Link      | Adjust the sharing method (e.g., adding a password to public sharing). After confirming the adjustments, they will take effect. Refer to Figure One below.                          |
| Cancel Share      | Will invalidate the already shared snapshot and cannot be restored. <u>Please carefully confirm the content to cancel sharing</u>. Refer to Figure Two below.<br/>You can also click the :material-crop-square: next to the chart name to select specific charts for batch cancellation of sharing.                        |

<font size=2>*Figure One:*</font>
![](img/11_share_05.png)

<font size=2>*Figure Two:*</font>
![](img/11_share_06.png)