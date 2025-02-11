# LogEasy Index Binding {#rizhiyi}

Select **LogEasy**, fill in the required information. After completion, you can click **Test** to verify the correctness of the username and password.

**Note**: Only LogEasy 4.0 and above versions are supported for binding.

:material-numeric-1-circle-outline: Account Authorization

1. Domain: The user access address for LogEasy. Ensure it is accessible on the public network.
2. Username: The username used to access LogEasy.
3. Password: The password required to access LogEasy.

:material-numeric-2-circle-outline: Resource Authorization

1. Beaver Index: The index name in LogEasy that needs to be bound for viewing.
2. Tags: You can input tags in the format `key:value`; Guance will filter data through tags, enabling more granular data scope query authorization.
    - Multiple tags can be combined using AND & OR. *Example: `field1:value1 AND field2:value2 OR field3:value3`*;
3. Guance Index: The index name uniquely identifying the Guance workspace, defined by the user and not supporting duplicate names. After configuration, it can be used to filter index names.

:material-numeric-3-circle-outline: [Field Mapping](./index.md#mapping).


:material-numeric-4-circle-outline: Click **Confirm** to complete the index binding. You can switch indexes in the **Explorer** to view them.


## Further Reading


<font size=3>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Field Mapping**</font>](./index.md#mapping)

</div>


</font>