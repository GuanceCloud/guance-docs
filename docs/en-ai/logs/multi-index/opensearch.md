# OpenSearch Index Binding  {#opensearch}

Select **OpenSearch**, and fill in the required information. After completing the form, you can click **Test** to verify the correctness of the username and password.

**Note**: Only OpenSearch version 1.0.x and above are supported for binding.

:material-numeric-1-circle-outline: Account Authorization

1. Domain Name: The access address for OpenSearch. Ensure it is accessible over the public network.
2. Username: The username used to access OpenSearch.
3. Password: The password required to access OpenSearch.

:material-numeric-2-circle-outline: Resource Authorization

1. OpenSearch Index: The index name in OpenSearch that needs to be bound and viewed.
2. Guance Index: The index name uniquely identifying the Guance workspace, defined by the user. Duplicate names are not allowed. After configuration, this can be used to filter index names.
    - **Note**: This index name is unrelated to OpenSearch and is only used for data filtering within Guance.

:material-numeric-3-circle-outline: [Field Mapping](./index.md#mapping).

:material-numeric-4-circle-outline: Click **Confirm** to complete the index binding. You can switch indices in the **Explorer** to view them.

## Configuration Instructions for Binding External Indices in Elasticsearch/OpenSearch {#add-up}

Due to the rolling policy in Elasticsearch/OpenSearch, a single `index` may result in multiple index rules or names. This section **mainly explains how to configure querying all data under the current `index` or specific data from a particular index in Guance**.

### Indices, Aliases, and Shards

- An index alias is an auxiliary name used to reference one or more existing indices.
- One alias can bind to multiple indices, and one index can also bind to multiple aliases.

<img src="../../img/2.index_out_1.png" width="70%" >

As shown in the figure above, index 1 has 2 shards. If you need to query log content from index 1, you only need to bind the index with the index name "index 1" in Guance. The number and size of shards are irrelevant.

### Index Rolling

![](../img/2.index_out_2.jpg)

As shown in the figure above, ES follows a daily rolling index rule, where `Log-1` is the alias for these indices, and Log-1 - 2022/10/01, etc., are index names.

- To bind all indices in Guance, bind the index alias as shown in the example below:

![](../img/3.log_index_4.png)

- To bind a specific index or if there is no rolling policy, bind the specific index name as shown in the example below:

![](../img/3.log_index_5.png)

## Further Reading


<font size=3>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Field Mapping**</font>](./index.md#mapping)

</div>


</font>