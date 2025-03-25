# Log Index
---

<<< custom_key.brand_name >>> features advanced log indexing capabilities. By creating and managing multiple indices, the system automatically archives log data to the corresponding index based on predefined filtering conditions. Additionally, you can customize data storage policies for each index to effectively control and reduce storage costs, achieving dual optimization in data management flexibility and economic efficiency.

Under the log index feature, you can:

- [Create an Index](#create);
- [Bind External Indices](#binding-index).

???+ warning "Note"

    By default, multi-log indices cannot be created, **please contact <<< custom_key.brand_name >>> customer manager to apply for this feature**.

## Start Creating {#create}

1. Navigate to the **Logs > Index > Create Index** page;
2. Customize the name of the index;  
3. Add filtering conditions: supports `in`, `not in`, etc., screening methods;
4. Configure data storage policies, select standard storage duration, low-frequency storage duration, and archive storage duration;
5. Input [key fields](#key_key).
    
???+ warning "Note"

    Deployment Plan users can customize input data storage policy durations here, range: 1d ~ 1800d. 

???+ abstract "Index Rules"

    - The index name must be unique, starting with a letter, containing only lowercase letters, numbers, or “_” characters, unmodifiable, and deleted index names cannot be recreated;
    - Default index: all logs are stored by default in the index named `default`, which only supports modification of key fields; 
    - Log flow: after setting multiple indices, logs flow into the first matching index, and the same log will not be saved across indices;  
    - Index quantity limit: including the `default` index, there can be at most 6 indices, meaning up to 5 custom indices can be created;
    - Member permissions: standard members and read-only members have only viewing rights, while administrators and owners can edit, delete, and drag to reorder.

### Key Fields {#key_key}

Set exclusive key fields under the index dimension to ensure that the display of log data is not affected by column configuration settings, ultimately presenting in the log Explorer > [Stacked Mode](../manag-explorer.md#mode), facilitating efficient differentiation and analysis of data from different log indices.

#### Definition Rules

- Use commas `,` as separators;
- Fields listed in `message` are the key fields configured in the index, in the format `key:value`; if `value` has no value, it displays as “-”;
- Log data configured with key fields in the index is unaffected by display items, targeting only the `message` column.

#### Display Example

1. Define the key fields for `default` as `key1,source,key2,key3,pod_name,container_name,host,service`;
2. In the Viewer, select to view data only from the `default` index;
3. Effect as shown below:

<img src="../img/key_key.png" width="50%" >

<img src="../img/key_key_1.png" width="50%" >

<img src="../img/key_key_2.png" width="50%" >

## Bind External Indices {#binding-index}

![](../img/external_log.png)

<<< custom_key.brand_name >>> supports binding external index data. After successful binding, external index data can be queried and analyzed within the workspace.

Currently supported external indices include:

:material-numeric-1-circle: [SLS Logstore](./sls.md)    
:material-numeric-2-circle: [Elasticsearch](./elasticsearch.md)          
:material-numeric-3-circle: [OpenSearch](./opensearch.md)          
:material-numeric-4-circle: [LogEase](./logease.md)      
:material-numeric-5-circle: [Volcengine TLS](./tls.md)          

**Note**:

- Bound indices only support deletion; after canceling the binding, logs under the index cannot be queried;  
- Other indices cannot have the same name as log indices and cannot duplicate historical log indices.

## Field Mapping {#mapping}

Since <<< custom_key.brand_name >>> and external indices may have inconsistent standard fields, field mapping functionality is provided to ensure normal function usage.

To quickly view and analyze external index log data in <<< custom_key.brand_name >>>, field mapping functionality is offered during external index binding to directly map log fields.

| Field      | Description        |
| ----------- | ----------- |
| `time`      | The reporting time of the log, SLS Logstore maps the `date` field to `time` by default, Elasticsearch, OpenSearch can be filled according to actual data; if this field does not exist, data in the log viewer will appear disordered.        |
| `_docid`      | The unique ID of the log. After mapping, bound log details can be viewed. If the original field is not unique, the log with the earliest time is displayed after refreshing the details page. If this field does not exist, some content will be missing on the log details page.        |
| `message`      | The content of the log. After mapping, the content of the bound log can be viewed and log data can be clustered and analyzed via the `message` field.        |


> For more details, refer to [Log Explorer Cluster Analysis](../explorer.md).

You can also click **Edit** in the external index list to modify the field mappings of the required index.

???+ warning "Note"

    - Each index's mapping rules are independent and separately saved;
    - If a log contains the `_docid` field and another field is mapped to the same name, the original `_docid` in the log will not take effect.

## Manage Indices {#manag}

You can manage the index list through the following operations.

<div class="grid" markdown>

=== "Disable/Enable"

    - After disabling an index, subsequent logs will no longer enter that index and will continue to match and flow into other indices for saving. If no other indices match, they will be saved in the default `default` index.
        
    - After enabling an index, subsequent logs will re-enter that index for saving.

=== "Edit"

    Click the **Edit** icon to modify already created log indices. In the figure below, after successfully creating the current index `index.da`, logs reported with `source` as `datakit` will match and flow into the first matching index for saving.

    **Note**: Changing the storage policy will delete the data in the index, so proceed with caution.

    <img src="../img/6.index_3.png" width="60%" >

=== "Operation Audit"

    Click to view all operation logs for the index.

=== "Delete"

    Click the :fontawesome-regular-trash-can: icon to delete an already created log index.

    **Note**: After deletion, the logs in the index will also be deleted. If there are no other matching indices, subsequent reported logs will be saved in the default `default` index.

    ![](../img/6.index_4.png)

    If the deleted index was authorized for query by other workspaces, the other workspace will no longer be able to query the index after deletion.

    <img src="../img/6.index_5.png" width="60%" >

    After deleting a log index, you can recreate an index with the same name as needed.

=== "Drag"

    Click the :fontawesome-solid-grip-vertical: icon to drag and reorder already created log indices.

    **Note**: Logs will flow into the first matched index. Changing the order of indices might result in logs being redirected.

</div>


## More Reading


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