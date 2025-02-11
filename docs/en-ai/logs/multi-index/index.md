# Log Indexing
---

Guance provides advanced log indexing capabilities. By creating and managing multiple indexes, the system automatically archives log data to the corresponding indexes based on predefined filtering criteria. Additionally, you can customize storage policies for each index to effectively control and reduce storage costs, achieving flexibility in data management and economic efficiency.

Under log indexing, you can:

:material-numeric-1-circle: [Create an Index](#create);    
:material-numeric-2-circle: [Bind External Index](#binding-index).

???+ warning "Note"

    By default, multi-log indexes cannot be created; **please contact your Guance account manager to enable this feature**.

## Create an Index {#create}

In the Guance workspace, click **Logs > Indexes > Create Index**.

<img src="../img/6.index_2.png" width="70%" >

1. Index Name: Customize the name of the index;
2. Add Filter Conditions: Supports `in`, `not in`, etc.;
3. Configure Data Storage Policy: Options include 3 days, 7 days, 14 days, 30 days, and 60 days.
    - Note: Users with a Deployment Plan can customize the data retention period here, ranging from 1 day to 1800 days.


???+ warning "Note"

    1. The index name must be unique and start with a letter. It can only contain lowercase letters, numbers, or underscores ("_"). Once created, it cannot be modified, and deleted index names cannot be reused;
    2. By default, all logs exist in a default index named `default`. The default index cannot be modified or deleted;
    3. After setting up multi-log indexes, logs will flow into the first matching index, and the same log will not be saved across multiple indexes;
    4. Including the `default` index, there can be at most 6 indexes, meaning you can create up to 5 custom indexes;
    5. Standard members and read-only members have view-only permissions. Administrators and owners can edit, delete, and reorder indexes.


### Example {#example}

In the log index configuration, set the filter condition for `container_name` to `dataflux`. After successfully creating the index, logs that match this filter condition will flow into the first index `test_1`.

<img src="../img/5.log_4.png" width="60%" >


Clicking on the index in the index list will redirect you to the log Explorer to view the corresponding log data. Alternatively, you can go directly to **Logs > Explorer** to select different indexes to view the corresponding log content.

![](../img/create_log_example.png)



## Bind External Index {#binding-index}

![](../img/external_log.png)

Guance supports binding external index data. After successful binding, you can query and analyze external index data within the Guance workspace.

Currently supported external indexes include:

:material-numeric-1-circle: [SLS Logstore](./sls.md)    
:material-numeric-2-circle: [Elasticsearch](./elasticsearch.md)          
:material-numeric-3-circle: [OpenSearch](./opensearch.md)          
:material-numeric-4-circle: [LogEase](./logease.md)      
:material-numeric-5-circle: [Volcengine TLS](./tls.md)          

**Note**:

- Bound indexes only support deletion (deletion means unbinding), and after unbinding, you will no longer be able to query logs under that index;
- Other indexes cannot share the same name as log indexes or historical log indexes.

## Field Mapping {#mapping}

Since the standard fields of Guance and external indexes may differ, missing fields in Guance might cause some functionalities to fail.

To quickly view and analyze external index log data in Guance, field mapping is provided. During the binding process, you can directly map fields for the log data.

1. `time`: Log reporting time. SLS Logstore defaults to mapping the `date` field to `time`. For Elasticsearch and OpenSearch, you can fill in according to actual log data. Without this field, logs will display out of order in the Explorer.
2. `_docid`: Unique ID of the log. After mapping, you can view details of the bound logs. For example, you can map the original field `logid` to `_docid`. If `logid` values are not unique, refreshing the detail page will show the earliest log entry. Without this field, parts of the log detail page may be missing. If the mapped field is not unique, opening the detail page will display the earliest log entry with that ID.
3. `message`: Content of the log. After mapping, you can view the content of the bound logs and perform cluster analysis on the log data using the `message` field.

> For more details, refer to [Log Explorer Cluster Analysis](../explorer.md).

You can also modify field mappings by clicking **Edit** in the external index list and selecting the index you want to modify.

???+ warning "Note"

    - Each index's mapping rules are independent and saved separately;
    - If a log contains a `_docid` field and another field is mapped to `_docid`, the original `_docid` in the log will not take effect.

## Manage Indexes {#manag}

You can manage the index list with the following operations.

:material-numeric-1-circle: Disable/Enable

- Disabling an index prevents subsequent logs from entering it. Logs will continue to match other indexes for storage, defaulting to the `default` index if no matches are found;
    
- Enabling an index allows subsequent logs to enter it for storage.

:material-numeric-2-circle: Edit

Click the **Edit** icon to modify already created log indexes. In the image below, after the index `index.da` is successfully created, logs with `source` as `datakit` will match and be stored in the first matching index.

**Note**: Changing the storage policy will delete data in the index, so proceed with caution.

<img src="../img/6.index_3.png" width="60%" >

:material-numeric-3-circle: Operation Audit: Click to view all operation logs for the index.

:material-numeric-4-circle: Delete

Click the :fontawesome-regular-trash-can: icon to delete a created log index.

**Note**: Deleting an index will also delete the log data within it. If no other matching index exists, subsequent logs will be saved in the default `default` index.

![](../img/6.index_4.png)

If the deleted index has been authorized for querying by other workspaces, they will no longer be able to query that index after deletion.

<img src="../img/6.index_5.png" width="60%" >

After deleting a log index, you can recreate an index with the same name as needed.



:material-numeric-5-circle: Drag

Click the :fontawesome-solid-grip-vertical: icon to drag and reorder created log indexes.

**Note**: Logs will flow into the first matching index. Changing the order of indexes may alter the log flow direction.


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

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Bind Volcengine TLS Index**</font>](./tls.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Log Explorer Cluster Analysis**</font>](../explorer.md#cluster)

</div>



</font>