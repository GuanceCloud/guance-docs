# Log Index
---

By creating and managing multiple indices, the system automatically archives log data to the corresponding index based on predefined filtering conditions. Additionally, you can customize the data storage strategy for each index to effectively control and reduce storage costs, achieving flexibility in data management and economic efficiency.

Under the log index, you can:

- [Create an index](#create);
- [Bind external index](#binding-index).

???+ warning "Note"

    By default, multi-log indexing cannot be created, **please contact your account manager to enable this feature**.

## Start Creating {#create}

1. Navigate to the **Log > Index > Create Index** page;
2. Customize the name of the index;
3. Add filter conditions: supports `in`, `not in` and other filtering methods;
4. Configure the data storage strategy, select standard storage duration, infrequent access storage duration, and archive storage duration;
5. Input [key fields](#key_key).

???+ warning "Note"

    Deployment Plan users can customize the data retention period here, range: 1d ~ 1800d.

???+ abstract "Index Rules"

    - The index name must be unique, start with a letter, and only contain lowercase letters, numbers, or “_” characters. It cannot be modified, and once deleted, the index name cannot be recreated;
    - Default index: all logs are stored by default in an index named `default`. This index only supports modification of key fields;
    - Log flow: after setting up multiple indices, logs will flow into the first matching index. A single log will not be saved across different indices;
    - Index quantity limit: including the `default` index, there can be a maximum of 6 indices, meaning up to 5 custom indices can be created;
    - Member permissions: standard members and read-only members have view permissions only, while administrators and owners can edit, delete, and drag to reorder.

### Key Fields {#key_key}

Set exclusive key fields under the index dimension to ensure that the display of log data is not affected by column configuration settings, ultimately presented in the log Explorer > [Stacked Mode](../manag-explorer.md#mode), facilitating efficient differentiation and analysis of data under different log indices.


#### Definition Rules

- Use a comma `,` as the delimiter;
- Fields listed in `message` are configured as key fields for the index, in the format `key:value`. If `value` has no value, it displays as “-”;
- Log data configured with key fields in the index is unaffected by display items, targeting only the `message` column.

#### One-click Acquisition {#extract}

- When data is archived to this index, click the button and the system will automatically extract the key fields from the most recent day's reported data; at this point, the input box content will be overwritten by the newly obtained `key`;
- If no data is reported for the current index, clicking the button will not change the input box content.

???+ warning "Note"

    If there are too many fields under the index, the input box will only extract the first 50 key fields.


#### Display Example

1. Define the key fields for `default` as `key1,source,key2,key3,pod_name,container_name,host,service`;
2. In the Viewer, select to view only the data from the `default` index;
3. Effect as shown below:

<img src="../img/key_key.png" width="50%" >

<img src="../img/key_key_1.png" width="50%" >

<img src="../img/key_key_2.png" width="50%" >

## Bind External Index {#binding-index}

![](../img/external_log.png)

After binding successfully, you can query and analyze external index data within the workspace.

Currently supported external indices include:

:material-numeric-1-circle: [SLS Logstore](./sls.md)    
:material-numeric-2-circle: [Elasticsearch](./elasticsearch.md)          
:material-numeric-3-circle: [OpenSearch](./opensearch.md)          
:material-numeric-4-circle: [LogEase](./logease.md)      
:material-numeric-5-circle: [Volcengine TLS](./tls.md)          

???+ warning "Note"

    - Bound indices only support deletion. After unbinding, logs under that index cannot be queried;
    - Other indices cannot have the same name as log indices or historical log indices.

## Field Mapping {#mapping}

Since <<< custom_key.brand_name >>> and external indices may have inconsistent standard fields, we provide field mapping functionality to ensure normal function usage.

To quickly view and analyze log data from external indices in <<< custom_key.brand_name >>>, <<< custom_key.brand_name >>> provides a field mapping feature that allows direct mapping of log fields when binding external indices.

| Field      | Description        |
| ----------- | ----------- |
| `time`      | The reporting time of the log. SLS Logstore maps the `date` field to `time` by default. For Elasticsearch and OpenSearch, you can fill in according to actual data. Without this field, data in the log viewer will be displayed out of order.        |
| `_docid`      | The unique ID of the log. After mapping, you can view detailed information of the bound log. If the original field is not unique, the log with the earliest time is displayed upon refreshing the details page. Without this field, some content will be missing from the log detail page.        |
| `message`      | The content of the log. After mapping, you can view the content of the bound log and cluster analyze log data through the `message` field.        |


> For more details, refer to [Log Explorer Cluster Analysis](../explorer.md).

You can also click **Edit** in the external index list to modify the field mapping of the index you need.

???+ warning "Note"

    - Each index's mapping rules are independent and saved separately;
    - If a log contains a `_docid` field and the same field is mapped, the original `_docid` in the log will not take effect.

## Manage Indices {#manag}

You can manage the index list via the following operations.

<div class="grid" markdown>

=== "Disable/Enable"

    - After disabling an index, subsequent logs will no longer enter this index but will continue to match and save in other indices. If no other indices match, they will be saved in the default `default` index;
        
    - After enabling an index, subsequent logs will re-enter this index for saving.

=== "Edit"

    Click the **Edit** icon to modify already created log indices. As shown in the figure below, after the current index `index.da` is successfully created, log data with `source` as `datakit` will be matched and saved in the first applicable index.

    ???+ warning "Note"

        Changing the storage strategy will delete data in the index, please proceed with caution.

    <img src="../img/6.index_3.png" width="60%" >

=== "Audit Operations"

    Click to view all operation logs for the index.

=== "Delete"

    Click the :fontawesome-regular-trash-can: icon to delete the created log index.

    ???+ warning "Note"

        After deletion, the log data in this index will also be deleted. If no other indices match, subsequent reported logs will be saved in the default `default` index.

    ![](../img/6.index_4.png)

    If the deleted index was authorized for querying by another workspace, the other workspace will no longer be able to query this index after deletion.

    <img src="../img/6.index_5.png" width="60%" >

    After deleting a log index, you can create an index with the same name if needed.

=== "Drag"

    Click the :fontawesome-solid-grip-vertical: icon to drag and reorder created log indices.

    ???+ warning "Note"

        Logs will flow into the first matching index. Changing the index order might cause logs to change their flow direction.

</div>


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