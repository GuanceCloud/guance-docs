# Bind Elasticsearch Index {#es}

Select **Elasticsearch** and fill in the required information. After completion, you can click **Test** to verify the correctness of the username and password.

**Note**: Only Elasticsearch versions 7.0+ and above are supported.

:material-numeric-1-circle-outline: Account Authorization

1. Domain Name: The user access address for Elasticsearch, ensure it is accessible over the public network.
2. Username: The user name for accessing Elasticsearch.
3. Password: The password required for accessing Elasticsearch.

:material-numeric-2-circle-outline: Resource Authorization

1. Elasticsearch Index: The name of the index in Elasticsearch that you wish to bind for viewing.
2. Guance Index: The unique index name identified by the Guance workspace, to be filled in by the user, with no repetition allowed. After configuration, it can be used for filtering index names.
    - **Note**: This index name is unrelated to Elasticsearch and is only used for your subsequent data filtering in Guance.

:material-numeric-3-circle-outline: [Field Mapping](./index.md#mapping).                 

:material-numeric-4-circle-outline: Click **Confirm** to complete the index binding, and you can view it by switching indexes in the **Explorer**.

## More Reading

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Field Mapping**</font>](./index.md#mapping)

</div>

</font>


