# Data Storage Policy
---

As business applications increase, the scope of data observability requirements expands, leading to adjustments in storage duration needs for different types of data. Guance provides multiple data storage policies. You can customize your data retention periods according to your needs, effectively controlling data storage costs and saving expenses.

## Data Retention Periods

| <div style="width: 200px">Type</div> | Duration |
| --- | --- |
| Metrics | This refers to the global data retention policy for metrics. If you have specific retention period requirements for certain Mearsurements, you can make custom modifications via [Configure Storage Policies](../metrics/dictionary.md).<br /><br />3 days / 7 days (default) / 14 days / 30 days / 180 days / 360 days |
| Logs | 3 days / 7 days / 14 days (default) / 30 days / 60 days |
| Data Forwarding - Guance | 180 days (default) / 360 days / 720 days |
| Events | 14 days (default) / 30 days / 60 days |
| APM - Traces / Profiles | 3 days / 7 days / 14 days (default) |
| RUM | 3 days / 7 days / 14 days (default) |
| Security Check | 3 days / 7 days / 14 days (default) / 30 days / 60 days |

### Changing Retention Periods

Owners of Commercial Plan workspaces can adjust data storage policies multiple times on the same day. The first modification takes effect immediately, while subsequent changes will take effect from the next day based on the last adjustment made that day. After the policy change, data will be evaluated against the new configuration for expiration and cleared at midnight the following day.

Steps to change:

1. Go to [**Management > Workspace Settings > Change Data Storage Policy**](../management/settings/index.md#change);
2. Click **Replace**;
3. Select the data type whose storage policy you wish to modify and click **Edit**;
4. Choose the desired retention period;
5. After completing the changes, click **Confirm** to update the data storage duration for the current workspace.

<img src="../img/2.data_storage_2.1.png" width="60%" >

### Important Notes

1. Only owners of Commercial Plan workspaces can perform this operation;  
2. After changing the Metrics data storage policy, old data under the previous policy will be deleted. Please choose carefully.
3. For changes to other data storage policies besides Metrics, the new retention policy takes effect immediately. Old data under the previous policy will not be immediately deleted but will remain billable until it is removed by the rolling deletion process.

    - Shortening the retention period: For example, if APM data retention is changed from 14 days to 7 days, data before the change continues to be billed under the 14-day policy, while data after the change will be indexed and billed under the new 7-day policy.
    - Extending the retention period: For example, if APM data retention is changed from 7 days to 14 days, data before the change continues to be billed under the 7-day policy, while data after the change will be indexed and billed under the new 14-day policy.
        
> For more details, refer to [Guance ES Multi-Tenant Lifecycle Management Practices](../billing-method/es-life-cycle.md).


## Data Storage Methods {#options}

Guance offers two data storage solutions: **Default Storage** and **SLS Storage**:

- Default Storage: Uses Guance's [GuanceDB](./gauncedb.md) to store Metrics data and Elasticsearch / OpenSearch to store Log data;
- SLS Storage: Uses Alibaba Cloud Log Service SLS to store data, with LogStore storing Log data and MetricStore storing Metrics data.


### Regarding Free Plan {#free}

#### Billing Information

1. If any billing items in the Free Plan reach their quota limit, data reporting updates will stop; infrastructure and event data continue to be reported, allowing you to still view infrastructure list data and event data;
2. The Free Plan supports upgrading to the Commercial Plan online. No charges apply unless upgraded. Once upgraded to a paid version, rollback is not possible;
3. After upgrading from the Free Plan to the Commercial Plan, collected data will continue to be reported to the Guance workspace, but data collected during the Free Plan period will no longer be accessible;
4. Time Series and data forwarding statistics are based on total data volume, while other billing items are based on incremental data. Incremental data statistics reset free quotas daily at midnight and are valid for the day.

Guance supports a free-to-start, pay-as-you-go billing model, providing an out-of-the-box cloud platform for comprehensive observability. The Free Plan offers a 7-day data retention policy. To change the data retention policy, you need to [upgrade to the Commercial Plan](../plans/trail.md#upgrade-commercial).

| <div style="width: 160px">**Billing Item**</div>             | **Free Quota**  | <div style="width: 160px">**Data Retention Policy**</div> | **Notes**                                                     |
| ---------------------- | ------------- | ---------------- | ------------------------------------------------------------ |
| Time Series Volume             | 3000 entries       | 7 days             |                                                              |
| Log Data Volume         | 1 million entries per day | 7 days             | Data Scope: Events, Security Check, Logs (excluding logs from Synthetic Tests) |
| Data Forwarding Volume       | /             | /                | ❌                                     |
| APM Trace Volume    | 8000 traces per day  | 7 days             |                                                              |
| APM Profile Volume    | 60 profiles per day  | 7 days             |                                                              |
| RUM PV Volume       | 2000 page views per day  | 7 days             |                                                              |
| Session Replay Volume       | 1000 sessions per day  | 7 days             |                                                              |
| Synthetic Tests Task Frequency | 200,000 tasks per day  | 7 days             |                                                              |
| Trigger Invocation Frequency           | 100,000 invocations per day  | /                |                                                              |
| SMS Sending Frequency           | /             | /                | ❌                                         |