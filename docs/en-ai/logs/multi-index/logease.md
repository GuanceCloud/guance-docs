# LogEase Index Binding {#rizhiyi}

Select **LogEase**, and fill in the required information. After completing the form, you can click **Test** to verify the correctness of the username and password.

**Note**: Only versions 4.0 and above of LogEase are supported.

:material-numeric-1-circle-outline: Account Authorization

1. Domain Name: The user access address for LogEase. Ensure it is accessible on the public network.
2. Username: The username used to access LogEase.
3. Password: The password required to access LogEase.

:material-numeric-2-circle-outline: Resource Authorization

1. Beaver Index: The index name in LogEase that needs to be bound for viewing.
2. Tags: You can input tags in the `key:value` format; <<< custom_key.brand_name >>> will filter data through tags, enabling more granular data query authorization.
    - Multiple tags can be combined using AND & OR. *Example: `field1:value1 AND field2:value2 OR field3:value3`*;
3. <<< custom_key.brand_name >>> Index: The index name uniquely identifying the <<< custom_key.brand_name >>> workspace, defined by the user and must not be duplicated. After configuration, it can be used to filter index names.

:material-numeric-3-circle-outline: [Field Mapping](./index.md#mapping).

:material-numeric-4-circle-outline: Click **Confirm** to complete the index binding. You can then switch indexes in the **Explorer** to view them.

## Further Reading

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Field Mapping**</font>](./index.md#mapping)

</div>

</font>