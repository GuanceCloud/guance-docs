---
icon: zy/billing
---
# Billing
---

## Plan Instructions

There are three plans of Guance: Experience Plan, Commercial Plan and private cloud deployment plan.

- The Experience Plan and Commercial Plan provided by the public cloud all adopt the billing method of **pay-per-use**, and there is no difference in core functions.

    [Experience Plan of the available data size](trail.md#trail-vs-commercial)is limited, **Commercial Plan of users support access to a larger amount of data, and more flexible data storage time**.

- Private cloud deployment plan, community plan (i.e. Experience Plan) and Commercial Plan are also provided.

    Commercial Plan can flexibly choose **pay-per-use, subscription system, license system** and other billing methods.

???+ info "How the current workspace version is viewed"

    - All member roles: can be viewed in **Guance Studio > Management > Settings > Basic Information > Current Version**.
    - Owner and administrator: it can also be viewed in **Guance Studio > Billing**.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Public cloud Commercial Plan doc</font>](commercial.md)

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Public cloud Experience Plan doc</font>](trail.md)

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Private cloud deployment plan doc</font>](../deployment/deployment-description.md#_4)

</div>

## Billing Center

At present, there are two sets of account systems that operate independently and have related statistical data, which jointly realize the usage billing and expense settlement process for **Commercial Plan users**:

- [Guance studio](https://console.guance.com/) account, which can count the data volume, access scale and bill details of the current workspace and synchronize to the designated Billing Center account.
- [Guance Billing Center](https://boss.guance.com/) account, which can be bound through `workspace ID` **to realize unified expense management at workspace level** and provide a variety of expense settlement methods for you to choose from.

![](img/billing-index-1.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Billing Center doc</font>](./cost-center/index.md)

<br/>

</div>

## Usage Billing Method

The Commercial Plan users of the Guance workspace adopt the billing method of **pay-per-use**, and comprehensively calculate the current cost situation through different latitudes such as billing cycle, billing item, billing price and billing mode.

The owner and administrator of the workspace can view the data access of the workspace and the corresponding bill details in the **Guance Studio > Billing** module; For other member roles, the **Billing** module is temporarily closed.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Usage billing method doc</font>](./billing-method/index.md)

<br/>

</div>

## Expense Settlement Method

After calculating the bill details of the current workspace, Guance studio will push them to the bound Guance Billing Center account for subsequent expense settlement process.

At present, it supports various settlement methods such as observing cloud enterprise accounts and cloud accounts. Cloud account settlement includes Alibaba Cloud account and AWS account settlement. In the cloud account settlement mode, it supports the merger of cloud bills from multiple sites into one cloud account for settlement.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Expense settlement method doc</font>](./billing-account/index.md)

<br/>

</div>