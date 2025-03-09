# Blacklist
---

By setting up a blacklist, you can filter out different types of data that meet certain conditions. After configuring the blacklist, data that meets the criteria will no longer be reported to the <<< custom_key.brand_name >>> workspace, helping you save on data storage costs.


## Prerequisites

- [Install DataKit](../datakit/datakit-install.md);
- If you need to configure data types other than logs, the DataKit version must be higher than 1.4.7.

## Create a New Blacklist

![Blacklist](../img/black-3.png)

1. Click **Manage > Blacklist > Create Blacklist**;
2. Define the name and description of the current blacklist rule;
3. Select the type of data source;
4. Add one or more filtering rules;
5. Click **Confirm** to enable the data blacklist filtering rule.

### Data Sources

The blacklist name is automatically generated based on the data source, including logs, basic objects, resource catalogs, networks, APM, RUM, security checks, events, metrics, Profile.

After entering field names, field values, etc., the rules will take effect once you configure the data sources and fields via DataKit and report the data.

| Data Type     | Data Source (Supports Custom Presets)                       |
| :------------ | :---------------------------------------------------------- |
| Logs          | Log source (`source`), e.g., `nginx`                        |
| Basic Objects | Category (`class`), e.g., `HOST`                            |
| Resource Catalog | Category (`class`), e.g., `MySQL`                        |
| Network       | Source (`source`), e.g., `netflow`, `httpflow`              |
| APM           | Service (`service`), e.g., `redis`; can choose "All Services" |
| RUM           | Application (`app_id`)                                      |
| Security Check | Category (`category`), e.g., `system`                      |
| Events        | Source (`source`), e.g., `monitor`                          |
| Metrics       | Mearsurement, e.g., `cpu`                                   |
| Profile       | Service (`service`)                                         |

### Filtering

Two condition options are supported: "Any" and "All". "Any" means "OR" conditions, while "All" means "AND" conditions.

- Field Name: Supports manual entry of field names, which must be exact matches. You can check the field names to match in the Explorer's "Display Columns".

- Field Value: Supports manual entry of field values, allowing single or multiple values, and supports regular expression syntax.

- Operator: Supports `in / not in / match / not match` four modes. `in / not in` are for exact matches, while `match / not match` are for regex matches.

| <div style="width: 150px">Operator</div>              | <div style="width: 140px">Supported Types</div>   | Description                                                   | Example              |
| :------------------ | :------------- | :----------------------------------------------------- | :---------------- |
| `in / not in`       | Numeric       | Whether the specified field is in the list, supporting mixed types | `1,2,"foo",3.5`   |
| `match / not match` | Regular Expression | Whether the specified field matches the regex in the list, supporting only string types | `"foo.*","bar.*"` |

**Note**:

- If you only need to create a blacklist for log data, go to **Logs > Blacklist** for configuration.
- Data types support string, integer, and float.
- If the data source is logs, a log filtering rule will be created under the **Logs > Blacklist** menu, and vice versa.

### Examples

In the following example, the blacklist is named "Conditional Filtering." It selects all log sources where `status` is either `ok` or `info`, and `host` is not `hz-dataflux-saas-daily-01`, and `service` does not contain the word `kodo`. Data that meets all three matching rules will be filtered out and not reported to the workspace.

![Blacklist Example](../img/5.blacklist_2.png)

After setting up the blacklist, you can verify its effectiveness using the Explorer based on the filtering conditions. Once the blacklist takes effect, data that meets the filtering conditions will no longer be reported to the workspace.

![Verification](img/5.blacklist_4.png)

## Options

You can manage the blacklist list with the following operations:

1. Filter by different data types;
2. Search for a specific blacklist by entering its name in the search bar.
3. Modify existing data filtering rules;
4. Delete existing filtering rules. After deletion, data will be reported to the workspace normally.
5. Batch Operations: Click :material-crop-square:, to batch export or delete blacklists.

    **Note**: This feature is only visible to workspace owners, administrators, and regular members, not read-only members.

6. You can create a blacklist by importing a JSON file, and the imported JSON file must be from <<< custom_key.brand_name >>>'s configuration JSON file.

## Notes

1. If you configured [blacklist filtering](../datakit/datakit-filter.md#manual) in the `datakit.conf` file during DataKit installation, the blacklist rules configured in <<< custom_key.brand_name >>> will not take effect;

2. DataKit pulls data every 10 seconds, so the blacklist configuration will not take effect immediately; it requires at least 10 seconds to apply;

3. After the blacklist configuration is completed, it is uniformly saved in the `.pull` file under the DataKit directory `/usr/local/datakit/data`.

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **View Blacklist**</font>](../datakit/dca.md)

</div>

</font>