# Log Indexing
---

<<< custom_key.brand_name >>> offers advanced log indexing capabilities. By creating and managing multiple indexes, the system automatically archives log data into the corresponding indexes based on predefined filtering conditions. Additionally, you can customize data retention policies for each index to effectively control and reduce storage costs, achieving flexibility in data management and economic efficiency.

Under log indexing, you can:

:material-numeric-1-circle: [Create an Index](#create);  
:material-numeric-2-circle: [Bind External Index](#binding-index).

???+ warning "Note"

    By default, multi-log indexing cannot be created. **Please contact <<< custom_key.brand_name >>> customer manager to apply for this feature**.

## Create an Index {#create}

In the <<< custom_key.brand_name >>> workspace, click **Logs > Indexes > Create Index**.

<img src="../img/6.index_2.png" width="70%" >

1. Index Name: Customize the name of the index;  
2. Add Filter Conditions: Supports `in`, `not in` and other filtering methods;
3. Set Data Retention Policy: Options include 3 days, 7 days, 14 days, 30 days, and 60 days.
    - Note: Deployment Plan users can customize the data retention period here, ranging from 1 day to 1800 days.


???+ warning "Note"

    1. The index name must be unique, start with a letter, and only contain lowercase letters, numbers, or "_" characters; it cannot be modified, and deleted index names cannot be reused;
    2. By default, all logs exist in a default index named `default`. The default index cannot be modified or deleted;  
    3. After setting up multi-log indexes, logs will flow into the first matching index, and the same log will not be saved across multiple indexes;  
    4. Multi-log indexes, including the `default` index, can have a maximum of 6 indexes, meaning up to 5 custom indexes can be created;
    5. Standard members and read-only members have view-only permissions, while administrators and owners can edit, delete, and reorder indexes.


### Example {#example}

In the log index, configure the index filter condition as `container_name` equals `dataflux`. After successfully creating the index, logs that match this filter condition will be routed to the first matching index `test_1`.

<img src="../img/5.log_4.png" width="60%" >

Clicking on the index in the index list will redirect you to the log Explorer to view the corresponding log data. Alternatively, you can go directly to **Logs > Explorer** to choose different indexes to view the corresponding log content.

![](../img/create_log_example.png)


## Bind External Index {#binding-index}

![](../img/external_log.png)

<<< custom_key.brand_name >>> supports binding external index data. After successful binding, you can query and analyze external index data within the <<< custom_key.brand_name >>> workspace.

Currently supported external indexes include:

:material-numeric-1-circle: [SLS Logstore](./sls.md)  
:material-numeric-2-circle: [Elasticsearch](./elasticsearch.md)  
:material-numeric-3-circle: [OpenSearch](./opensearch.md)  
:material-numeric-4-circle: [LogEase](./logease.md)  
:material-numeric-5-circle: [VolcEngine TLS](./tls.md)  

**Note**:

- Bound indexes only support deletion (deletion means unbinding), and after unbinding, you cannot query logs under that index;
- Other indexes cannot have the same name as log indexes or historical log indexes.

## Field Mapping {#mapping}

Due to potential inconsistencies between <<< custom_key.brand_name >>> and external index standard fields, missing fields in <<< custom_key.brand_name >>> may cause some features to not function properly.

To facilitate quick viewing and analysis of external index log data in <<< custom_key.brand_name >>>, field mapping is provided during external index binding.

1. `time`: Log reporting time. SLS Logstore defaults to mapping the `date` field to `time`, Elasticsearch and OpenSearch can be customized according to actual log data; if this field does not exist, data in the log Explorer will display out of order.
2. `_docid`: Unique ID of the log. Mapping allows you to view details of the bound logs. For example, you can map the original field `logid` to `_docid`. If `logid` is not unique in these logs, refreshing the detail page will not affect it; however, refreshing the detail page will display the earliest log entry. Without this field, parts of the log detail page may be missing. If the mapped field is not unique, opening the detail page will display the earliest log entry corresponding to that ID.
3. `message`: Content of the log. Mapping allows you to view the content of the bound logs and perform cluster analysis on log data.

> For more details, refer to [Log Explorer Cluster Analysis](../explorer.md).

You can also modify field mappings by clicking **Edit** in the external index list and entering the index whose mappings need to be changed.

???+ warning "Note"

    - Each index's mapping rules are independent and stored separately;
    - If a log already has a `_docid` field and another identical field is mapped, the original `_docid` in the log will not take effect.

## Manage Indexes {#manag}

You can manage the index list through the following operations.

:material-numeric-1-circle: Disable/Enable

- Disabling an index prevents subsequent logs from being saved to it. Logs will continue to flow into other indexes for storage, or if no other indexes match, they will be saved in the default `default` index;

- Enabling an index allows subsequent logs to be saved to it again.

:material-numeric-2-circle: Edit

Click the **Edit** icon to modify an existing log index. In the figure below, after successfully creating the current index `index.da`, logs with `source` as `datakit` will be routed to the first matching index for storage.

**Note**: Changing the retention policy will delete data in the index, so proceed with caution.

<img src="../img/6.index_3.png" width="60%" >

:material-numeric-3-circle: Audit Operations: Click to view all operation logs for the index.

:material-numeric-4-circle: Delete

Click the :fontawesome-regular-trash-can: icon to delete an existing log index.

**Note**: Deleting an index will also delete the logs within it. If there are no other matching indexes, subsequent logs will be saved in the default `default` index.

![](../img/6.index_4.png)

If the deleted index was authorized for querying by other workspaces, deleting it will prevent those workspaces from continuing to query the index.

<img src="../img/6.index_5.png" width="60%" >

After deleting a log index, you can create an index with the same name as needed.

:material-numeric-5-circle: Drag

Click the :fontawesome-solid-grip-vertical: icon to drag and reorder existing log indexes.

**Note**: Logs will flow into the first matching index. Changing the order of indexes may alter the log flow.

## Further Reading


<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Bind SLS Logstore Index**</font>](./sls.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Bind Elasticsearch Index**</font>](./elasticsearch.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Bind OpenSearch Index**</font>](./opensearch.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Bind LogEase Index**</font>](./logease.md)

</div>



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Bind VolcEngine TLS Index**</font>](./tls.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Log Explorer Cluster Analysis**</font>](../explorer.md#cluster)

</div>



</font>