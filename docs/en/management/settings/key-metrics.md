# Key Metric Management (Warroom)
---

Guance provides **Warroom**, where you can look at the key metric trends of all workspaces, helping you quickly understand the key data of each workspace, and discover and solve abnormal problems in time.

## View Warroom Key Metrics

In the Guance workspace, click the workspace name in the upper left corner, and in the pop-up dialog box, click **Enter Warroom**.

![](../img/3.key_metrics_4.png)

After entering the warroom, you can view the key metric trends of all workspaces to which the current account belongs. In the warroom, you can view the trends of key metrics in the form of icons and lists, and you can sort and view the workspaces according to the dimensions of **Event Urgency**, **Workspace** and **Number of Unrecovered Events**.

- Event urgency: Sort by Critical > Error > Warning > No data.
- Workspace: Sort by Alias > Workspace Name.
- Number of unrecovered events: sorted according to the number of unrecovered events in the workspace for 48 hours.

The following chart shows the metric trend in the form of icons:

![](../img/3.key_metrics_5.2.png)

The following schematic chart shows the metric trend in the form of a list:

![](../img/3.key_metrics_6.1.png)


## Configure Warroom Key Metrics

In the Guance workspace **Management > Settings > Advanced > Key Metrics**, you can view the configured key metrics, and click **Add** to configure new key metrics.

![](../img/3.key_metrics_2.png)

After clicking **Add**, you will jump to [metric analysis](../metrics/explorer.md) to query metrics. After configuring the query statement, click "+" on the right side, enter the name of key metrics, and click OK to add a new key metric.

**Note**: You can configure up to 3 DQL queries for key metrics. If you need to view other key metrics, you can delete the current DQL query and reconfigure it.

![](../img/3.key_metrics_1.png)



### View Key Metrics

Click the View icon to the right of the key metric![](../img/3.key_metrics_7.png), you can jump to **Metric Analysis** to view the query statement. If there are less than 3 key metrics, you can modify the query statement and add new key metrics.

![](../img/3.key_metrics_3.png)



### Delete Key Metrics

Click the Delete icon on the right side of the key metric to delete the current key metric.
