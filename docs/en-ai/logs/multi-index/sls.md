# SLS Logstore Index Binding {#sls}

Select **SLS Logstore**. Guance supports two authorization methods: [RAM Sub-account Authorization](#ram) and [Third-party Quick Authorization](#third-party):

## RAM Sub-account Authorization {#ram}

![SLS Index](../../img/sls-index.png)

:material-numeric-1-circle-outline: Account Authorization:

1. [Obtain the SLS Authorization File](../../plans/sls-grant.md).
2. Fill in AccessKey ID / AccessKey Secret (referred to as AK / AKS).

:material-numeric-2-circle-outline: Resource Authorization:

1. Select the region;
2. Based on the entered AK / AKS, Guance automatically retrieves Project and Logstore.
3. Guance Index: By default, it is consistent with the Logstore name, but you can also customize and edit the name.
    - **Note**: This index name is unrelated to SLS and is used for data filtering within Guance.
4. Access Type: To avoid configuration path errors that may result in data retrieval issues, choose either **Internal Network Access** or **Public Network Access** based on your actual situation.

:material-numeric-3-circle-outline: [Field Mapping](./index.md#mapping).

:material-numeric-4-circle-outline: Click **Confirm** to complete the index binding. You can view the index by switching in the **Explorer**.

???- warning "For Commercial Plan and Exclusive Plan Users"

    - If you are a Guance Commercial Plan user, refer to the documentation [RAM Account Authorization](../../plans/sls-grant.md) to obtain AK / AKS for index binding.
    - If you are a Guance Exclusive Plan user, you can directly use the AK / AKS provided during the activation of the Exclusive Plan for index binding. For details on how to activate the Exclusive Plan, refer to [Alibaba Cloud Market Activation for Guance Exclusive Plan](../../plans/commercial-aliyun-sls.md).
    - If you are a Guance Exclusive Plan user and wish to bind SLS log indexes from other Alibaba Cloud accounts, refer to [RAM Account Authorization](../../plans/sls-grant.md) to obtain AK / AKS for index binding.

## Third-party Quick Authorization {#third-party}

**Note**: This feature is not supported for Hong Kong and overseas regions.

![SLS Index 1](../../img/sls-index-1.png)

:material-numeric-1-circle-outline: Account Authorization:

Click **[Go Now](https://market.console.aliyun.com/auth?role=VendorCrossAccountGUANCEREADONLYRole&token=fe4be994690698821d5f581475e3b441)** to be redirected to Alibaba Cloud, where you can log in and authorize.

![](../img/index-1.png)

Click **Agree to Authorization**, and a **Service Provider UID Verification** window will pop up. You can obtain the UID by clicking **Service Provider Permission Description Page**. After entering the UID, click Confirm to be automatically redirected to **Alibaba Cloud Marketplace > Purchased Services**, indicating that authorization is complete.

![](../img/index-2.png)

:material-numeric-2-circle-outline: Resource Authorization:

1. After authorization is completed, enter your Alibaba Cloud account ID. Once filled out, Guance will automatically retrieve Project and Logstore.
2. Guance Index: By default, it is consistent with the Logstore name, but you can also customize and edit the name.
    - **Note**: This index name is unrelated to SLS and is used for data filtering within Guance.
3. Access Type: To avoid configuration path errors that may result in data retrieval issues, choose either **Internal Network Access** or **Public Network Access** based on your actual situation.

![Index 3](../../img/index-3.png)

:material-numeric-3-circle-outline: [Field Mapping](./index.md#mapping).

:material-numeric-4-circle-outline: Click **Confirm** to complete the index binding. You can view the index by switching in the **Explorer**.

???+ warning "Note"

    1. Cross-account role authorization operations require using an Alibaba Cloud main account or a sub-account authorized with RAM access control permissions such as GetRole, GetPolicy, CreatePolicy, CreatePolicyVersion, CreateRole, UpdateRole, AttachPolicyToRole.
    
    2. During verification, if verifying a sub-account, it will automatically locate the main account associated with the sub-account and retrieve Projects and Logstores under the main account.


## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **How to Confirm Successful Authorization in Alibaba Cloud Marketplace?**</font>](../faq.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Obtain SLS Authorization File**</font>](../../plans/sls-grant.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Field Mapping**</font>](./index.md#mapping)

</div>

</font>