# Elasticsearch Index Binding  {#es}

Select **Elasticsearch**, and fill in the required information. After completing the form, you can click **Test** to verify the correctness of the username and password.

**Note**: Only Elasticsearch 7.0+ and above versions are supported for binding.

:material-numeric-1-circle-outline: Account Authorization

1. Domain Name: The user access address for Elasticsearch. Ensure it is accessible over the public network.  
2. Username: The username used to access Elasticsearch. 
3. Password: The password required to access Elasticsearch. 

:material-numeric-2-circle-outline: Resource Authorization

1. Elasticsearch Index: The index name in Elasticsearch that needs to be bound and viewed. 
2. Guance Index: The unique index name for the Guance workspace, defined by the user. Duplicate names are not supported. After configuration, this index name can be used to filter indices.
    - **Note**: This index name is unrelated to Elasticsearch and is only used for data filtering within Guance.

:material-numeric-3-circle-outline: [Field Mapping](./index.md#mapping).                 

:material-numeric-4-circle-outline: Click **Confirm** to complete the index binding. You can view the indices by switching them in the **Explorer**.


## Further Reading


<font size=2>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Field Mapping**</font>](./index.md#mapping)

</div>


</font>