# Cloud Account Instance-level Billing Inspection
---

## Background

The cloud account instance-level billing inspection helps users manage abnormal cost warnings at the cloud service instance level, predict cost situations, and provides users with prompts for high-growth, high-consumption instances along with bill visualization capabilities. It supports multi-dimensional visualizations of cloud service resource consumption.

## Prerequisites

1. Self-built [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. In <<< custom_key.brand_name >>> "Manage / API Key Management," create an [API Key](../../management/api-key/open-api.md) used for operations.

> **Note**: If you consider using a cloud server for offline deployment of DataFlux Func, ensure that it is deployed with the current SaaS version of <<< custom_key.brand_name >>> on the [same provider and in the same region](../../../getting-started/necessary-for-beginners/select-site/).
>
> **Note 2:** Since instance-level billing data is stored as logs, the default log retention period for <<< custom_key.brand_name >>> SaaS logs is only 15 days. To ensure accurate inspections, adjust the log storage time to the maximum duration.

## Starting the Inspection

In your self-built DataFlux Func, install and enable via "Script Market" [<<< custom_key.brand_name >>> Integration (Huawei Cloud - Billing Collection - Instance Level)](https://<<< custom_key.func_domain >>>/doc/script-market-guance-huaweicloud-billing-by-instance/), [<<< custom_key.brand_name >>> Integration (Alibaba Cloud - Billing Collection - Instance Level)](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-billing/), [<<< custom_key.brand_name >>> Integration (Tencent Cloud - Billing Collection - Instance Level)](https://<<< custom_key.func_domain >>>/doc/script-market-guance-tencentcloud-billing-by-instance/). Collect data over 15 days, then install "<<< custom_key.brand_name >>> Self-built Inspection (Billing - Instance Level)" and configure the <<< custom_key.brand_name >>> API Key to complete the setup.

In the DataFlux Func Script Market, select the required inspection scenario, click Install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/) connection, then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and automatic trigger configurations, which can be viewed directly through the link.

![image](../img/success_checker.png)

## Configuring the Inspection

### Configuring Inspection in <<< custom_key.brand_name >>>

![image](../img/cloudfee_instacne02.png)

#### Enable/Disable
Cloud account instance-level billing inspection is by default "Enabled." You can manually "Disable" it. After enabling, it will inspect the configured list of cloud accounts.

#### Editing
The "Cloud Account Instance-level Billing Inspection" supports manual addition of filter conditions. Under the operation menu on the right side of the intelligent inspection list, click the **Edit** button to edit the inspection template.

* Filter Conditions: Configure corresponding cloud providers and cloud account information.
* Alert Notifications: Supports selecting and editing alert strategies, including event levels to notify, notification targets, and alert silence cycles.

After clicking Edit on the configuration entry parameters, fill in the corresponding detection objects in the parameter configuration and click Save to start the inspection:

![image](../img/cloudfee_instacne03.png)

You can refer to the following configuration for multiple application information:

```json
 // Configuration Example:
    configs Configuration Example:
        account_id:cloud_provider
        account_id:cloud_provider
```

## Viewing Events

Based on <<< custom_key.brand_name >>> intelligent algorithms, Intelligent Inspection identifies anomalies in cloud asset costs. If an anomaly occurs in cloud asset costs, Intelligent Inspection generates corresponding events. Under the operation menu on the right side of the Intelligent Inspection list, click the **View Related Events** button to view corresponding abnormal events.

![image](../img/cloudfee_instacne04.png)

### Event Details Page
Clicking **Event**, you can view the details page of the Intelligent Inspection event, including event status, the time when the anomaly occurred, the anomaly name, basic attributes, event details, alert notifications, historical records, and related events.

* Clicking the small icon labeled "View Monitor Configuration" in the upper-right corner of the details page allows you to view and edit the current Intelligent Inspection configuration details.

#### Basic Attributes
* Detection Dimensions: Based on the filtering conditions set in the Intelligent Inspection configuration, support copying `key/value` pairs, adding them to filters, and viewing related logs, containers, processes, security checks, traces, user access monitoring, availability monitoring, and CI data.
* Extended Attributes: After selecting extended attributes, you can copy them in `key/value` form and perform forward/reverse filtering.

![image](../img/cloudfee_instacne05.png)

#### Event Details
* Event Overview: Describes the object and content of the abnormal inspection event.
* Cost Analysis: View the consumption trend of the current abnormal cloud account over the past 30 days.
  * Abnormal Range: The start time to end time of anomalies in the Intelligent Inspection data.
  
* Consumption Amount Increase Product Ranking: View the ranking of product costs for the current cloud account.
* Consumption Amount Increase Instance Ranking: View the ranking of instance costs for the current cloud account.
* Cost Prediction: Predicts the remaining monthly consumption amount for the cloud account.
  * Confidence Interval: The accuracy range of the predicted trend line.

![image](../img/cloudfee_instacne06.png)

#### Historical Records
Supports viewing the detected objects, abnormal/recovery times, and duration.

![image](../img/cloudfee_instacne07.png)

#### Related Events
Supports viewing related events through filtered fields and selected time component information.

![image](../img/cloudfee_instacne08.png)

#### View Links

Through the cloud billing instance cost monitoring view in the event list, you can check more detailed information about the corresponding abnormal information and possible influencing factors.
![image](../img/cloudfee_instacne09.png)

## Common Issues

**1. How to configure the inspection frequency for cloud account instance-level billing**

* In the self-built DataFlux Func, add `fixed_crontab='0 0 * * *', timeout=900` in the decorator while writing the self-built inspection processing function, then configure it in "Manage / Automatic Trigger Configuration."

**2. Why might there be no abnormal analysis when the cloud account instance-level billing inspection is triggered**

When there is no abnormal analysis in the inspection report, check the data collection status of the current `datakit`.

**3. What if scripts that previously ran normally during inspection now show abnormal errors**

Update the referenced script sets in the DataFlux Func Script Market. You can view the update records of the Script Market through the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to facilitate timely updates of the scripts.

**4. Under what circumstances would cloud account instance-level billing inspection events occur**

Using the total cost of specified cloud provider products as the entry point, an event logic for root cause analysis is triggered when there is a significant change in cost information or when the total cost exceeds the configured budget, generating an inspection event.

* Tracking Threshold: For example, when the current period's cost increases > 100% compared to the previous period.

**5. Why does the cloud account instance-level billing inspection not trigger for a long time**

If abnormalities in the bill are found in online views but the inspection does not detect them, first check whether the inspection has been running for more than 15 days. Second, verify whether the log data expiration strategy is greater than 15 days. Finally, check whether the automatic trigger task is correctly configured in DataFlux Func.

**6. Why does the corresponding script set in Startup remain unchanged during the upgrade of the inspection script**

First, delete the corresponding script set, then click the Upgrade button to configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**7. How to determine if the inspection has taken effect after enabling it**

In "Manage / Automatic Trigger Configuration," check the status of the corresponding inspection. First, the status should be enabled, secondly, you can validate the inspection script by clicking Execute. If the message indicates successful execution X minutes ago, the inspection is functioning properly.