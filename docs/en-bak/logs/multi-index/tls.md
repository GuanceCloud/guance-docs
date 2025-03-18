# Volcengine TLS Index Binding
---

Select **Volcengine TLS** and fill in the required information. After completion, you can click **Test** to verify the correctness of the username and password.

:material-numeric-1-circle-outline: Account Authorization:

1. [Obtain the TLS Authorization File](../authorize-tls.md).
2. Fill in AccessKey ID / AccessKey Secret (referred to as AK / AKS).

:material-numeric-2-circle-outline: Resource Authorization:

1. Select the region.
2. Based on the AK / AKS filled in above, Guance automatically obtains the Project, log project, and log topic.
3. Guance Index: Defaults to the name of TLS, but you can also customize the name.
    - **Note**: This index name is unrelated to TLS and is used for your subsequent data filtering in Guance.
4. Access Type: To avoid configuration path errors that may result in data retrieval issues, choose either **Intranet Access** or **Public Network Access** based on your actual situation.

:material-numeric-3-circle-outline: [Field Mapping](./index.md#mapping).

:material-numeric-4-circle-outline: Click **Confirm** to complete the index binding, and you can view it by switching indexes in the **Explorer**.

## More Reading

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Obtain TLS Authorization File**</font>](../authorize-tls.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Field Mapping**</font>](./index.md#mapping)

</div>

</font>
