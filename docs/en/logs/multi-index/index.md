# Indexes

---

Guance features advanced log indexing capabilities, allowing you to create and manage multiple indexes. The system automatically archives log data into the corresponding indexes based on predefined filtering conditions. Additionally, you can customize data storage strategies for each index to effectively control and reduce storage costs, achieving a dual optimization of data management flexibility and economic efficiency.

Under log indexing, you can:

:material-numeric-1-circle: [Create a New Index](#create);    
:material-numeric-2-circle: [Bind External Indexes](#binding-index).

**Note**: By default, the creation of multiple log indexes is not available, **please contact your Guance account manager to request this feature**.

## Create a New Index {#create}

In the Guance workspace, click on **Logs > Indexes > Create New Index**.

<img src="../img/5.log_4.png" width="60%" >


1. Index Name: Customize the name of the index;  
2. Add Filtering Conditions: Support filtering methods such as `in`, `not in`, `match`, `not match`, etc.;
3. Equip Data Storage Strategy: Support selection of 3 days, 7 days, 14 days, 30 days, and 60 days.
    - Note: Users of the Deployment Plan can customize the data storage strategy duration here, range: 1d ~ 1800d. 

???+ warning "Note"

    1. The index name must be unique, must start with a letter, and can only contain lowercase letters, numbers, or "_" characters; it cannot be modified, and deleted index names cannot be recreated;
    2. By default, all logs are stored in a default index named `default`, and the default index cannot be modified or deleted;  
    3. After setting up multiple log indexes, logs will flow into the first matching index, and the same log will not be saved repeatedly across indexes;  
    4. Including the `default` index, there can be a maximum of 6 log indexes, meaning a maximum of 5 custom indexes can be created;
    5. Standard members and read-only members only have viewing permissions, while administrators and owners can edit, delete, and drag to sort.

### Example {#example}

In the log index, configure the index filtering condition to be `source` in `gin`. After the index is successfully created, log data that matches this filtering condition will flow into the first index `rp70` upon reporting.

<img src="../img/6.index_2.png" width="70%" >

In the index list, clicking on the index will take you directly to the log explorer to view the corresponding log data. Alternatively, you can go directly to **Logs > Explorer** to select different indexes and view the corresponding log content.

<img src="../img/5.log_5.png" width="60%" >



## Bind External Index {#binding-index}

![](../img/log01.png)

Guance supports binding external index data. Once bound, you can query and analyze external index data in the Guance workspace.

Currently supported external indexes include:

:material-numeric-1-circle: [SLS Logstore](./sls.md)           
:material-numeric-2-circle: [Elasticsearch](./elasticsearch.md)        
:material-numeric-3-circle: [OpenSearch](./opensearch.md)       
:material-numeric-4-circle: [LogEase](./logease.md)        
:material-numeric-5-circle: [Volcengine TLS](./tls.md)       

**Note**:

- Bound indexes only support deletion (deletion means unbinding), and after unbinding, you cannot query logs under that index;
- Other indexes cannot have the same name as the log index, nor can they have the same name as historical log indexes.

## Field Mapping {#mapping}

Due to potential inconsistencies between standard fields in Guance and external indexes, missing some fields in Guance may cause some functions to not work properly.

To quickly view and analyze external index log data in Guance, Guance provides a field mapping feature. You can map log fields directly when binding an external index.

1. `time`: The reporting time of the log. SLS Logstore defaults to mapping the `date` field as `time`. Elasticsearch, OpenSearch can be filled in according to the actual log data; if this field is not present, the data will be displayed out of order in the log explorer.
2. `_docid`: The unique ID of the log. After mapping, you can view the details of the bound log, for example: You can map the original field `logid` as `_docid`. If in this part of the log, the `value` of `logid` is not unique, at this time if you do not refresh the details page, there will be no impact; if you refresh the details page, the log with the earliest time will be displayed. If this field is not present, some content will be missing on the log details page. If the mapped field is not unique, when opening the details page, the log with the earliest time corresponding to this ID will be displayed.

3. `message`: The content of the log. After mapping, you can view the content of the bound log and cluster analyze log data through the `message` field.

> For more details, see [Log Explorer Cluster Analysis](../explorer.md#cluster).

You can also go to External Index list, select the index you need to modify the field mapping for, click **Edit**, and modify the mapping fields for that index.

???+ warning "Note"

    - The mapping rules for each index are not interconnected and are saved independently;
    - If a log contains a `_docid` field and another field is mapped with the same name, the original `_docid` in the log will not take effect.

## Manage Indexes {#manag}

You can manage the index list through the following operations.

:material-numeric-1-circle: Disable/Enable

- After disabling an index, subsequent logs will no longer enter that index and will continue to match and be saved in other indexes. If there are no other matching indexes, they will be saved in the default `default` index;
    
- After enabling an index, subsequent logs will be saved in that index again.

:material-numeric-2-circle: Edit

Click the **Edit** icon under the **Options** menu on the right side of the log index to edit the created log index. In the figure below, after the current index `index.da` is successfully created, log data reported by `source` as `datakit` will match and be saved in the first matching index.

**Note**: Changing the storage strategy will delete the data in the index, please proceed with caution.

<img src="../img/6.index_3.png" width="60%" >

:material-numeric-3-circle: Delete

Click the :fontawesome-regular-trash-can: icon under the **Options** menu on the right side of the log index to delete the created log index.

**Note**: Deleting an index will also delete the log data in that index. If there are no other matching indexes, subsequent reported log data will be saved in the default index `default`.

<img src="../img/6.index_5.png" width="60%" >


If the index being deleted has been authorized for query by other workspaces, they will no longer be able to query that index after deletion.

<img src="../img/6.index_4.png" width="60%" >

After deleting the log index, you can create an index with the same name as needed.

:material-numeric-4-circle: Audit: Click to view all audit logs for this index.



:material-numeric-5-circle: Drag and Drop

Click the :fontawesome-solid-grip-vertical: icon under the **Options** menu on the right side of the log index to drag and drop the created log index up and down.

**Note**: Logs will flow into the first matching index, and changing the index order may cause logs to change their flow direction.


## More Reading


<font size=3>

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
