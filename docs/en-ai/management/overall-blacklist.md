# Blacklist
---

By setting up a blacklist, you can filter out various types of data that meet certain conditions. Once the blacklist is configured, data that meets these conditions will no longer be reported to the Guance workspace, helping you save on data storage costs.


## Prerequisites

- [Install DataKit](../datakit/datakit-install.md);
- For configuring data other than logs, the DataKit version must be higher than 1.4.7.

## Create a New Blacklist

![Create Blacklist](../img/black-3.png)

1. Click **Management > Blacklist > Create New Blacklist**;
2. Define the name and description of the current blacklist rule;
3. Select the data source type;
4. Add one or more filtering rules;
5. Click **Confirm** to activate the data blacklist filtering rule.

### Data Sources

The blacklist name is automatically generated based on the data source and includes logs, base objects, resource catalogs, network, APM, RUM, security checks, events, metrics, Profile.

After entering field names, field values, etc., the rules will take effect once you configure the data sources and fields through DataKit and report the data.

| Data Type | Data Source (Supports Custom Presets) |
| :-------- | :------------------------------------ |
| Logs      | Log source (`source`), e.g., `nginx`   |
| Base Objects | Category (`class`), e.g., `HOST`    |
| Resource Catalog | Category (`class`), e.g., `MySQL` |
| Network   | Source (`source`), e.g., `netflow`, `httpflow` |
| APM       | Service (`service`), e.g., `redis`; can choose "All Services" |
| RUM       | Application (`app_id`)                 |
| Security Check | Category (`category`), e.g., `system` |
| Events    | Source (`source`), e.g., `monitor`     |
| Metrics   | Measurement set, e.g., `cpu`           |
| Profile   | Service (`service`)                    |

### Filtering

Two condition options are supported: "Any" and "All." "Any" means "or (OR)" conditions, while "All" means "and (AND)" conditions.

- Field Name: Supports manual entry of field names, which must be exact matches. You can view the field names to match in the Explorer's "Display Columns."
- Field Value: Supports manual entry of field values, allowing single or multiple values and regular expression syntax.
- Operator: Supports four modes: `in / not in / match / not match`. `in / not in` are for exact matches, while `match / not match` are for regex matching.

| <div style="width: 150px">Operator</div> | <div style="width: 140px">Supported Types</div> | Description                                                                                           | Example             |
| :-------------------------------------- | :--------------------------------------------- | :----------------------------------------------------------------------------------------------------- | :------------------ |
| `in / not in`                           | Numeric                                       | Checks if the specified field is in the list; the list supports mixed types                            | `1,2,"foo",3.5`     |
| `match / not match`                     | Regular Expression                            | Checks if the specified field matches the regex in the list; the list only supports string types        | `"foo.*","bar.*"`   |

**Note**:

- If you only need to create a blacklist for log data, go to **Logs > Blacklist** for configuration.
- Data types support string, integer, and float.
- If the data source is logs, a log filtering rule will be created synchronously under the menu **Logs > Blacklist**, and vice versa.

### Example

In the following example, the blacklist is named "Conditional Filtering." It selects logs from all sources where `status` is `ok` or `info`, and `host` is not `hz-dataflux-saas-daily-01`, and `service` does not contain the word `kodo`. Data meeting all three matching rules will be filtered out and not reported to the workspace.

![Example Blacklist](../img/5.blacklist_2.png)

After setting up the blacklist, you can check its effectiveness in the Explorer based on the filtering conditions. Once the blacklist takes effect, data that meets the filtering conditions will no longer be reported to the workspace.

![](img/5.blacklist_4.png)


## List Management

You can manage the blacklist list with the following operations:

1. Filter by different data types;
2. Search for blacklist names in the search bar to locate them.
3. Modify already created data filtering rules;
4. Delete existing filtering rules. After deletion, data will be reported to the workspace as usual.
5. Batch Operations: Click :material-crop-square:, to batch export or delete blacklists.

    **Note**: This feature is only visible to workspace owners, administrators, and regular members, not read-only members.
6. You can create blacklists by importing JSON files, and the imported JSON file must be a configuration JSON file from Guance.

## Precautions

1. If you have configured [blacklist filtering](../datakit/datakit-filter.md#manual) in the `datakit.conf` file during DataKit installation, the blacklist rules configured in Guance will not apply;
2. DataKit pulls data every 10 seconds, so blacklist configurations will not take effect immediately but require at least 10 seconds;
3. After completing the blacklist configuration, it will be saved uniformly in the `.pull` file under the `/usr/local/datakit/data` directory of DataKit.

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **View Blacklist**</font>](../datakit/dca.md)

</div>

</font>