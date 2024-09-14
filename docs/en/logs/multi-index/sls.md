# Bind SLS Logstore Index {#sls}

Select **SLS Logstore**. Guance supports two authorization methods: [RAM-account Authorization](#ram) and [Cross-account Authorization](#third-party):

## RAM-account Authorization {#ram}

<img src="../../img/sls-index.png" width="60%" >

:material-numeric-1-circle-outline: Account Authorization:

1. [Obtain the SLS Authorization File](../../billing/billing-method/sls-grant.md).
2. Fill in AccessKey ID / AccessKey Secret (referred to as AK/AKS).

:material-numeric-2-circle-outline: Resource Authorization:

1. Select the region.
2. Based on the AK/AKS filled in above, Guance automatically obtains the Project and Logstore.
3. Guance Index: Defaults to the name of the Logstore, but you can also customize the name.
    - **Note**: This index name is unrelated to SLS and is used for your subsequent data filtering in Guance.
4. Access Type: To avoid configuration path errors that may result in data retrieval issues, choose either **Internal Network Access** or **Public Network Access** based on your actual situation.

:material-numeric-3-circle-outline: [Field Mapping](./index.md#mapping).

:material-numeric-4-circle-outline: Click **Confirm** to complete the index binding, and you can view it by switching indexes in the **Explorer**.

???- warning "For Commercial and Dedicated Editions"

    - If you are a Guance Commercial Edition user, you can refer to the documentation [RAM Account Authorization](../../billing/billing-method/sls-grant.md) to obtain AK/AKS for index binding;       
    - If you are a Guance Exclusive Plan user, you can directly use the AK/AKS provided when you activated the Exclusive Plan for index binding. For information on how to activate the Exclusive Plan, refer to [Activating Guance Exclusive Plan on Alibaba Cloud Marketplace](../../plans/commercial-aliyun-sls.md);     
    - If you are a Guance Exclusive Plan user and wish to bind SLS log indexes from other Alibaba Cloud accounts, refer to [RAM Account Authorization](../../billing/billing-method/sls-grant.md) to obtain AK/AKS for index binding.

## Cross-account Authorization {#third-party}

**Note**: This feature is not supported for Hong Kong(China), and overseas sites.

<img src="../../img/sls-index-1.png" width="60%" >

:material-numeric-1-circle-outline: Account Authorization:

Click **[Go Now](https://market.console.aliyun.com/auth?role=VendorCrossAccountGUANCEREADONLYRole&token=fe4be994690698821d5f581475e3b441)** to be redirected to Alibaba Cloud for authorization after logging in.

![](../img/index-1.png)

Click **Agree to Authorization**, and a **Service Provider UID Verification** window will pop up. You can view the UID retrieval by clicking on the **Service Provider Permissions Explanation Page**. After entering the UID, click Confirm, and you will be automatically redirected to **Alibaba Cloud Marketplace > Services Purchased**, at which point the authorization is complete.

![](../img/index-2.png)

:material-numeric-2-circle-outline: Resource Authorization:

1. After authorization, fill in your Alibaba Cloud account ID. After completion, Guance will automatically obtain the Project and Logstore.

2. Guance Index: Defaults to the name of the Logstore, but you can also customize the name.

    - **Note**: This index name is unrelated to SLS and is used for your subsequent data filtering in Guance.

3. Access Type: To avoid configuration path errors that may result in data retrieval issues, choose either **Internal Network Access** or **Public Network Access** based on your actual situation.

<img src="../../img/index-3.png" width="70%" >

:material-numeric-3-circle-outline: [Field Mapping](./index.md#mapping).

:material-numeric-4-circle-outline: Click **Confirm** to complete the index binding, and you can view it by switching indexes in the **Explorer**.

???+ warning "Note"

    1. To perform cross-account role authorization, you must use an Alibaba Cloud **main account or a sub-account authorized with RAM Access Control GetRole, GetPolicy, CreatePolicy, CreatePolicyVersion, CreateRole, UpdateRole, AttachPolicyToRole permissions**.

    2. During the verification process, if the verified account is a sub-account with authorization, it will automatically locate the main account to which the sub-account belongs and retrieve the Projects and Logstores under the main account.

## FAQ {#FAQ}

:material-chat-question: How to confirm successful authorization in the Alibaba Cloud Marketplace?

You can go to the **RAM Console** from the authorization request page;

![](../img/index-4.png)

You can view the authorized roles in **Roles** and the authorized entities and permission strategies in **Grants**.

![](../img/index-role.png)

![](../img/index-auth.png)

:material-chat-question: Why can't I automatically obtain Projects and Logstores after entering the Alibaba Cloud account ID?

**Only if your Alibaba Cloud account has activated the SLS Log Service and completed the authorization**, will it automatically obtain Projects and Logstores.

**Note**: Projects prefixed with `/guance-wksp-` will be automatically filtered out and not listed; if your Project does not have any associated Logstores, they will not be automatically obtained.

## More Reading

<font size=3>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Obtain SLS Authorization File**</font>](../../billing/billing-method/sls-grant.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Field Mapping**</font>](./index.md#mapping)

</div>

</font>
