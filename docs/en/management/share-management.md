# Share Management
---

<<< custom_key.brand_name >>> supports the unified management of shared charts and snapshots within the current space through **Management > Share Management**.

## Sharing Charts

<<< custom_key.brand_name >>> allows space administrators and standard members to share and manage charts. Chart sharing can be used to embed charts in external platform code for visual data presentation and analysis outside <<< custom_key.brand_name >>>.

> For more details, refer to [Chart Sharing](../scene/visual-chart/index.md#share).

After completing chart sharing in the **Scene View**, you can view the list of shared charts within the current space via **Management > Share Management > Shared Charts** and perform <u>batch operations, chart viewing, viewing embedding codes, and canceling shares</u>.

![](img/share.png)

- **Chart Viewing** helps you quickly preview the corresponding shared chart;

![](img/11_share_01.png)

- **View Embedding Code** helps you quickly obtain the embedding code for the corresponding shared chart;

![](img/11_share_02.png)

- **Cancel Share** will invalidate the shared chart and cannot be restored. <u>Please carefully confirm the content to cancel sharing</u>. You can also click the :material-crop-square: next to the chart name to select specific charts for batch cancellation of shares.

![](img/11_share_03.png)

## Sharing Snapshots

After sharing a snapshot, you can view the snapshot sharing list through **Management > Share Management > Snapshot Sharing**, including snapshot name, sharing method, sharer, validity period, time range, view snapshot, and view sharing link.

![](img/share-1.png)

| Field         | Description                                                                 |
|---------------|-----------------------------------------------------------------------------|
| Snapshot Name | The name set when creating the snapshot, which is not currently editable.   |
| [Sharing Method](../getting-started/function-details/snapshot.md) | Includes public sharing and encrypted sharing. It supports sharing with "anyone" who has the link or those who have both the sharing link and the key. |
| Validity Period | The validity period of the snapshot share. <<< custom_key.brand_name >>> defaults the share link's validity to 48 hours from creation. |
| Time Range    | The relative or absolute time range selected for the snapshot. For example, the last 15 minutes as a relative time range. |
| View Snapshot | Click **View Snapshot** to redirect to a new page to view the corresponding data copy. |
| View Sharing Link | Adjust the sharing method (e.g., add a password to public sharing). Confirm adjustments for them to take effect. Refer to Image One below. |
| Cancel Share  | This will invalidate the shared snapshot and cannot be restored. <u>Please carefully confirm the content to cancel sharing</u>. Refer to Image Two below.<br/>You can also click the :material-crop-square: next to the snapshot name to select specific snapshots for batch cancellation of shares. |

<font size=2>*Image One:*</font>
![](img/11_share_05.png)

<font size=2>*Image Two:*</font>
![](img/11_share_06.png)