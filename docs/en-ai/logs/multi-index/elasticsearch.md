# Elasticsearch Index Binding  {#es}

Select **Elasticsearch**, and fill in the required information. After completing the form, you can click **Test** to verify the correctness of the username and password.

**Note**: Only Elasticsearch 7.0+ versions are supported for binding.

:material-numeric-1-circle-outline: Account Authorization

1. Domain Name: The access address for Elasticsearch users. Ensure it is accessible via the public network.
2. Username: The username required to access Elasticsearch.
3. Password: The password required to access Elasticsearch.

:material-numeric-2-circle-outline: Resource Authorization

1. Elasticsearch Index: The index name in Elasticsearch that needs to be bound for viewing.
2. <<< custom_key.brand_name >>> Index: The index name uniquely identifying the <<< custom_key.brand_name >>> workspace, defined by the user. Duplicate names are not supported. After configuration, this can be used to filter index names.
    - **Note**: This index name is unrelated to Elasticsearch and is only used for data filtering within <<< custom_key.brand_name >>>.

:material-numeric-3-circle-outline: [Field Mapping](./index.md#mapping).

:material-numeric-4-circle-outline: Click **Confirm** to complete the index binding. You can view the bound index by switching indexes in the **Explorer**.


## Further Reading


<font size=2>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Field Mapping**</font>](./index.md#mapping)

</div>


</font>