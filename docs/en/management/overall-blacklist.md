# Blacklist
---

Guance supports filtering out different types of qualified data by setting blacklist, that is, after configuring blacklist, qualified data will no longer be reported to Guance workspace, which helps you save data storage costs.

## Preconditions

- [Install DataKit](../datakit/datakit-install.md)
- If you need to configure other data besides logs, the DataKit version must be higher than 1.4.7.


## Create

In Guance workspace, click **Manage > Blacklist > Create**.

![](img/5.blacklist_1.png)

In **Data Source**, select the data type, add one or more filtering rules in **Filter** and click **Confirm** to open the data blacklist filtering rules.

- Data source: Blacklist names are automatically generated according to data sources, Support the selection of Logs, Basic Object, Custom Object, Network, APM, RUM, Security Check, Event, Metrics and Profile, and support the manual input of preset blacklist, package data source and field name, which will take effect after configuring data source and field through DataKit and reporting data.
  
| Data Type     | Data source (support custom preset)                       |
| :----------- | :----------------------------------------------- |
| Log         | log source, such as nginx, etc.                 |
| Basic object     | class, such as HOOT, etc.                        |
| Custom object   | class, such as MySQL, etc                       |
| Network         | source, such as netflow and httpflow            |
| APM | services, such as redis, support the selection of all service |
| RUM | apply (app_id)                                   |
| Scheck     | category, such as system, etc.                   |
| Events         | source, such as monitor, etc                    |
| Metrics         | measurement, such as cpu, etc.                             |
| Profile      | service                                 |

- Filtering: Support two conditional choices, "any" and "all". "Any" is an OR (OR) condition AND "All" is an AND (AND "condition.

- Field name: Manual input of field name is supported, which must be an accurate value. You can view the field name to be matched in the "Display Column" of the explorer.

- Field value: Support manual input of field value, input of single value, multi-value and regular syntax.

- Operator: Four modes of `in / not in / match / not match` are supported, `in / not in` is precise match, and `match / not match` is regular match.

| Operator              | Available numeric types   | Description                                                   | Example              |
| :------------------ | :------------- | :----------------------------------------------------- | :---------------- |
| `in / not in`       | Numeric List       | Whether the specified field is in a list, and multi-type cluttering is supported in the list.           | `1,2,"foo",3.5`   |
| `match / not match` | Regular expression list | Whether the specified field matches the regular in the list, which only supports string types. | `"foo.*","bar.*"` |

**Note**: Data types support string, integer and floating point types.

![](img/5.blacklist_1.2.png)

If the selected data source is "log", create a log filtering rule synchronously under the function menu **Log > Blacklist**, and vice versa.

![](img/5.blacklist_1.1.png)





### Example

In the following example, a new blacklist is created, a log that selects **All Sources**, satisfies `status` as `ok or info`, and `host` is not `hz-dataflux-saas-daily-01`, and the `service` does not contain the word `kodo`, meaning that data that meets all three matching rules will be filtered and no longer reported to the workspace.

![](img/5.blacklist_2.png)

After setting the blacklist, you can check whether the blacklist is effective according to the filter criteria in the explorer. After the blacklist is created and takes effect, the data that meets the filtering conditions will no longer be reported to the workspace.



![](img/5.blacklist_4.png)

## Related Operations

![](img/5.blacklist_3.png)

### Edit

On the right side of the blacklist, click **Edit** to edit the created data filtering rules. In the following example, when the blacklist is set, the log for **All Sources** satisfies `status` as `ok or info`, or `host` as `hz-dataflux-saas-daily-01`, or `service` does not contain the word `kodo`, i.e. data satisfying any of these three matching rules is filtered and no longer reported to the workspace.


### Delete

On the right side of the blacklist, click **Delete** to delete the existing filtering rules. After the filtering rules are deleted, the data will be reported to the workspace normally.


### Batch

In the Guance workspace **Manage > Blacklist**, click **Batch** to **Batch Export** or **Batch Delete** blacklist.

**Note**: This function is only displayed for workspace Owner, Administrators and Standard members.


### Import/Export

Support **Import/Export Blacklist** in **Manage > Blacklist** of Guance workspace, that is, create blacklist by importing/exporting JSON files.

**Note**: The imported JSON file needs to be the configuration JSON file from Guance.

## Notes

- Blacklist rules configured in Guance will not take effect if the blacklist is configured in the file `datakit.conf` under the directory `/usr/local/datakit/conf.d` when installing and configuring the datakit;
- DataKit pulls data every 10 seconds, and the blacklist will not take effect immediately after configuration, so it needs to wait at least 10 seconds.
- After the blacklist is configured, it is stored in the `.pull` file under the datakit directory `/usr/local/datakit/data`, and more can be found in the documentation [view blacklist](../datakit/dca.md).
