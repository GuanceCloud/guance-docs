# Key Metrics Management (Warroom)
---

<<< custom_key.brand_name >>> provides a **Warroom** dashboard where you can overview the key metrics trends of all workspaces, helping you quickly understand the critical data situation of each workspace and promptly identify and resolve anomalies.

## View Warroom Key Metrics

In <<< custom_key.brand_name >>> workspace, click the workspace name in the top-left corner. In the pop-up dialog box, click **Enter Warroom**.

![](../img/3.key_metrics_4.png)

After entering the Warroom, you can view the key metrics trends of all workspaces associated with your account. In the Warroom, you can view key metrics trends in the form of charts and lists, and sort workspaces by multiple dimensions such as **event urgency**, **workspace**, and **number of unresolved events**.

- Event Urgency: Sorted by Critical > Important > Warning > Data Disruption;
- Workspace: Sorted by Alias > Workspace Name;
- Number of Unresolved Events: Sorted by the number of unresolved events in the last 48 hours from high to low.

Viewing metrics trends in chart form:

![](../img/3.key_metrics_5.2.png)

Viewing metrics trends in list form:

![](../img/3.key_metrics_6.1.png)


## Configure Warroom Key Metrics

In <<< custom_key.brand_name >>> workspace **Manage > Settings > Advanced Settings > Key Metrics**, you can view already configured key metrics. Click **Add Key Metric** to configure new key metrics.

![](../img/3.key_metrics_2.png)

After clicking **Add Key Metric**, you will be redirected to **[Metrics Explorer](../../metrics/explorer.md)** for metric queries. After configuring the query statement, click the :heavy_plus_sign: button on the right, enter the key metric name, and click **Confirm** to add a new key metric.

**Note**: You can configure up to 3 DQL queries for key metrics. If you need to view other key metrics, you can delete the current DQL queries and reconfigure them.

![](../img/3.key_metrics_1.png)


### View Key Metrics

In **Manage > Settings > Key Metrics**, click the view icon on the right to redirect to **Metrics Explorer** to view the query statements. If there are fewer than 3 key metrics, you can modify the query statements and add new key metrics.

![](../img/3.key_metrics_3.gif)


### Delete Key Metrics

Click the delete icon next to the key metric to delete the current key metric.