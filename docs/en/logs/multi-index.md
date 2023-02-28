# Index
---

Guance supports setting log multiple indexes, filtering qualified logs and saving them in different log indexes, and helping users save log data storage costs by selecting different data storage strategies for log indexes.

???+ attention

    Please contact Guance Account Manager to activate multiple indexes of workspace logs

## New Index

Into workspace, click "Log"-"Index"-"New Index".

![](img/log-index-en-1.png)

On the New Index page, enter "Index Name", set "Filter Criteria", select "Data Storage Policy", and click "OK" to create a new index. 

- Index name: the name of the custom index. The index name must be unique and unmodifiable, and the deleted index name cannot be created again 
- Filter criteria: Support filtering methods such as ` in `, ` not in `, ` match `, ` not match `
- Data storage policy: Support selection of 7 days, 14 days, 30 days and 60 days 


![](img/log-index-en-2.png)

???+ attention

    - all logs exist in a default index named default, which does not allow modification and deletion 
    
    - After setting multiple indexes of logs, logs will be matched according to the order rule. Once matched, they will be stored in the corresponding index, and no further matching will be continued. (The same log will not be saved repeatedly across indexes.)
    
    - Log multiple indexes, including default indexes, can exist at most 3, custom indexes can be created at most 2 
    
    - Standard members and read-only members only have view permissions, and administrators and owners can edit, delete, drag and sort 




### Example

In the following picture, after the index is successfully created, log data with ` source ` ` datakit ` will match the inflow to the first index ` index.d ` when it is reported.

![](img/log-index-en-3.png)



## Bind index {#binding-index}

Guance supports binding external index data, including SLS, Elasticsearch and OpenSearch index data. After successful binding, you can query and analyze external index data in guance workspace.

???+ attention

    -The bound index only supports deletion (deletion means unbinding), and the log under the index cannot be queried after unbinding; 
    
    -'Other indexes' cannot have the same name as the log index or the historical log index. 


![](img/log-index-en-4.png)

### SLS Logstore {#sls}

Into "Log"-"Index", click "Bind Index". Select SLS in the pop-up dialog box, fill in AccessKey ID/AccessKey Secret (AK/AKS for short), and automatically get Project and Logstore. The index name is the same as the Logstore name by default, or you can customize the edit name. After clicking "OK", the index binding can be completed, and you can view it by switching indexes in the "Explorer". 

For information on how to open the SLS storage solution, please refer to the document [Alibaba Cloud Market Launches Guance Exclusive Edition](../billing/commercial-aliyun-sls.md). 

-If you are a commercial user of Guance, you can refer to the document [RAM Account Authorization](../billing/billing-method/sls-grant.md) to obtain AK/AKS for index binding; 
-If you are a user of the exclusive version of Guance, you can directly use AK/AKS when opening the exclusive version for index binding. For how to open the exclusive version, you can refer to the document [Alibaba Cloud Market opens the exclusive version of guance](../billing/commercial-aliyun-sls.md); 
-If you are an exclusive user of Guance and want to bind SLS log indexes under other Alibaba Cloud accounts, you can refer to the document [RAM Account Authorization](../billing/billing-method/sls-grant.md) to obtain AK/AKS for index binding. 


![](img/log-index-en-5.png)

### Elasticsearch  {#es}

Into "Log"-"Index", click "Bind Index". Select Elasticsearch page in the pop-up dialog box, fill in the configuration, and click "Test" the correctness of the user name and password.
 - URL:The user's Elasticsearch access address, please make sure it is accessible on the public network
 - User name: Access user name 
 - Password: Password required for access 
 - Bind index: The name of the index in Elasticsearch that needs to be bound to view 
 - Index name: the unique index name identified by Guance. This configuration is user-defined and filled in. Duplicate names are not supported in the workspace 

![](img/log-index-en-6.png)



### OpenSearch  {#opensearch}

Into "Log"-"Index", click "Bind Index". Select OpenSearch page in the pop-up dialog box, fill in the configuration, and click "Test" the correctness of the user name and password.

 - URL:The user's OpenSearch access address, please make sure it is accessible on the public network
 - User name: Access user name 
 - Password: Password required for access 
 - Bind index: The name of the index in OpenSearch that needs to be bound to view 
 - Index name: the unique index name identified by Guance. This configuration is user-defined and filled in. Duplicate names are not supported in the workspace 

![](img/log-index-en-7.png)

### Field mapping 

Because the standard fields of Guance are inconsistent with those of SLS, Elasticsearch and OpenSearch, in order to better enable users to view and analyze the log data of external indexes in Guance, Guance provides the function of field mapping, and you can directly map the fields of logs when binding indexes (see the above picture). 

-` time `: the reporting time of the log. The default mapping ` date ` field of Log Service is ` time `, and Elasticsearch and OpenSearch can be filled in by themselves according to the actual log data; 
-` _ docid `: The unique ID of the log so you can view the bound log details after mapping, for example, you can map the original field ` logid ` to ` _ docid `; 
-` message `: The contents of the log. After mapping, you can view the bound log contents and use the ` message ` field to help you cluster and analyze your log data. For example, you can map the original ` content ` field to ` message `. For more details, please refer to the document Log Explorer Clustering (explorer. md). 

You can also select the index that needs to modify the field mapping in "Bind Index"-"Other Indexes", and click "Edit" to modify the mapped fields of the index. 

? ? ? + attention 

    - The mapping rules of each index are not interlinked and are stored independently; 
    - If the ` _ docid ` field exists in a log and the same field is mapped, the ` _ docid ` in the original log does not take effect; 
    - If in a part of the log you map ` xxx ` to ` _ docid `, but in that part of the log the ` value ` of ` xxx ` is not unique, only one of the logs is displayed. 


## Operation

### Enable / Disable

Enable / Disable the currently customized index under the Action menu on the right side of the log index. 

? ? ? + attention 

    - After the index is disabled, the subsequent logs will not enter the index again, and will continue to match and flow into other indexes for saving. If there is no matching other indexes, they will be saved in the default index; 
    
    - After the index is enabled, subsequent logs are re-entered into the index for saving. 


### Edit

Under the "Operation" menu on the right side of the log index, click the "Edit" icon to edit the created log index. In the following picture, after the current index ` index.da ` is successfully created, when the log data with ` source ` as ` datakit ` is reported, it will match and flow into the first matching index for saving. 

Note: Changing the storage policy will delete the data in the index, so please be careful. 

![](img/log-index-en-8.png)

### Delete

Under the "Operation" menu on the right side of the log index, click the "Delete" icon to delete the created log index. 

Note: Deleting an index will delete the log data in the index at the same time, and no index with the same name can be created. If there is no other matching index, the log data reported later will be saved in the default index. 


![](img/log-index-en-9.png)

### Drag

Under the "Operation" menu on the right side of the log index, click the "Drag" icon to drag and drop the created log index up and down. 

? ? ? + attention 

    Log may match another index rule if you change the index order. 


