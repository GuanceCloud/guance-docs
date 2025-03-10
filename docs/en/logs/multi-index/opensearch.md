# OpenSearch Index Binding {#opensearch}

Select **OpenSearch**, and fill in the required information. After completion, you can click **Test** to verify the correctness of the username and password.

**Note**: Only OpenSearch 1.0.x and above versions are supported for binding.

:material-numeric-1-circle-outline: Account Authorization

1. Domain Name: The access address for OpenSearch. Ensure it is accessible over the public network.
2. Username: The username used to access OpenSearch.
3. Password: The password required to access OpenSearch.

:material-numeric-2-circle-outline: Resource Authorization

1. OpenSearch Index: The index name in OpenSearch that needs to be bound and viewed.
2. <<< custom_key.brand_name >>> Index: The index name uniquely identifying the <<< custom_key.brand_name >>> workspace, defined by the user and must not be duplicated. After configuration, it can be used to filter index names.
    - **Note**: This index name is unrelated to OpenSearch and is only used for data filtering within <<< custom_key.brand_name >>>.

:material-numeric-3-circle-outline: [Field Mapping](./index.md#mapping).

:material-numeric-4-circle-outline: Click **Confirm** to complete the index binding. You can switch indices in the **Explorer** to view them.

## Configuration Instructions for Binding External Indices in Elasticsearch/OpenSearch {#add-up}

Due to the rolling policy in Elasticsearch/OpenSearch, a single `index` may result in multiple index rules or names. This section **mainly describes how to query all data under the current `index` or specific data from a particular index when configuring in <<< custom_key.brand_name >>>**.

### Indices, Aliases, and Shards

- An index alias is an auxiliary name used to reference one or more existing indices.
- One alias can bind multiple indices, and one index can also bind multiple aliases.

<img src="../../img/2.index_out_1.png" width="70%" >

As shown in the figure above, index 1 has 2 shards. If a user needs to query logs within index 1, they only need to bind the index with the index name "index 1" in <<< custom_key.brand_name >>>, without any awareness of the number or size of shards.

### Index Rolling

![](../img/2.index_out_2.jpg)

As shown in the figure above, using ES's daily rolling index rule as an example, `Log-1` is the alias for these indices, and Log-1 - 2022/10/01, etc., are the index names.

- If you need to bind all indices in <<< custom_key.brand_name >>>, bind this index alias. Refer to the following example:

![](../img/3.log_index_4.png)

- If you need to bind a specific index or if there is no rolling policy in the configuration, bind the specific index name. Refer to the following example:

![](../img/3.log_index_5.png)

## Further Reading


<font size=3>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Field Mapping**</font>](./index.md#mapping)

</div>


</font>