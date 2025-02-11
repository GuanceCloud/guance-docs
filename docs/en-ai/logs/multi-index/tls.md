# Volcano Engine TLS Index Binding 
---

Select **Volcano Engine TLS**, and fill in the required information. After completion, you can click **Test** to verify the correctness of the username and password.

:material-numeric-1-circle-outline: Account Authorization:

1. [Obtain TLS Authorization File](../authorize-tls.md).
2. Fill in AccessKey ID / AccessKey Secret (referred to as AK / AKS).

:material-numeric-2-circle-outline: Resource Authorization:

1. Select the region;
2. Based on the AK / AKS entered above, Guance automatically retrieves Project, log project, and log topic.
3. Guance Index: By default, it is consistent with the name of TLS, but you can also customize and edit the name.
    - **Note**: This index name is unrelated to TLS and is used for data filtering in Guance.
4. Access Type: To avoid configuration path errors that may result in data retrieval issues, choose either **Internal Network Access** or **Public Network Access** based on actual conditions.


:material-numeric-3-circle-outline: [Field Mapping](./index.md#mapping).    

:material-numeric-4-circle-outline: Click **Confirm** to complete the index binding. You can switch indexes in the **Explorer** to view the data.

## Further Reading


<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Obtain TLS Authorization File**</font>](../authorize-tls.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Field Mapping**</font>](./index.md#mapping)

</div>


</font>