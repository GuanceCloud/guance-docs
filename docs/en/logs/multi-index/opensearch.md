# Bind OpenSearch Index {#opensearch}

Select **OpenSearch** and fill in the required information. After completion, you can click **Test** to verify the correctness of the username and password.

**Note**: Only OpenSearch versions 1.0.x and above are supported.

:material-numeric-1-circle-outline: Account Authorization

1. Domain Name: The user access address for OpenSearch, ensure it is accessible over the public network.
2. Username: The user name for accessing OpenSearch.
3. Password: The password required for accessing OpenSearch.

:material-numeric-2-circle-outline: Resource Authorization

1. OpenSearch Index: The name of the index in OpenSearch that you wish to bind for viewing.
2. Guance Index: The unique index name identified by the Guance workspace, to be filled in by the user, with no repetition allowed. After configuration, it can be used for filtering index names.
    - **Note**: This index name is unrelated to OpenSearch and is only used for your subsequent data filtering in Guance.

:material-numeric-3-circle-outline: [Field Mapping](./index.md#mapping).

:material-numeric-4-circle-outline: Click **Confirm** to complete the index binding, and you can view it by switching indexes in the **Viewer**.

## Elasticsearch/OpenSearch Binding Guide {#add-up}

Due to the `index` in Elasticsearch/OpenSearch being subject to rolling policies that result in multiple index rules or names for a single `index`, this configuration guide **mainly introduces how to configure in Guance when you need to query all data under the current `index` or query data corresponding to a specific index under the current `index`**.

### Index, Aliases and Shards

- An index alias is an auxiliary name used to reference one or more existing indexes;
- An alias can bind multiple indexes, and an index can also bind multiple aliases.

<img src="../../img/2.index_out_1.png" width="70%" >

As shown in the figure above, there are 2 shards in this index named index 1. If the user needs to query the log content in index 1, they only need to bind the index with the index name index 1 in Guance, with no perception of the number or size of shards.

### Index Rolling

![](../img/2.index_out_2.jpg)

As shown in the figure above, taking ES as an example with a rolling index rule of one per day, `Log-1` is the alias for these indexes, and `Log-1 - 2022/10/01` etc. are the index names.

- If you need to bind all indexes in Guance, you need to bind this index alias, as shown in the following example:

![](../img/3.log_index_4.png)

- If you need to bind a specific index in Guance, or if there is no rolling policy in the configuration, you only need to bind the specific index name, as shown in the following example:

![](../img/3.log_index_5.png)

## More Reading

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Field Mapping**</font>](./index.md#mapping)

</div>

</font>
