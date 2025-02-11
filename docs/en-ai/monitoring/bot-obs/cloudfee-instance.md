# Cloud Account Instance-Level Billing Inspection

---

## Background

Cloud account instance-level billing inspection helps users manage abnormal cost alerts and predict expenses at the cloud service instance level. It provides users with insights into high-growth, high-consumption instances and offers bill visualization capabilities. It supports multi-dimensional visualization of cloud service resource consumption.

## Prerequisites

1. Deploy [DataFlux Func (Automata)](https://func.guance.com/#/) or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
3. Create an [API Key](../../management/api-key/open-api.md) in Guance's "Management / API Key Management" for performing operations

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, consider deploying it with the same operator and region as your current Guance SaaS deployment [in the same location](../../../getting-started/necessary-for-beginners/select-site/).
>
> **Note 2:** Since instance-level billing data is stored as logs, the default log storage duration for Guance SaaS is 15 days. To ensure accurate inspections, extend the log storage duration to the maximum.

## Enabling Inspection

In your self-hosted DataFlux Func, enable the following through the "Script Market":
- [Guance Integration (Huawei Cloud - Billing Collection - Instance Level)](https://func.guance.com/doc/script-market-guance-huaweicloud-billing-by-instance/)
- [Guance Integration (Alibaba Cloud - Billing Collection - Instance Level)](https://func.guance.com/doc/script-market-guance-aliyun-billing/)
- [Guance Integration (Tencent Cloud - Billing Collection - Instance Level)](https://func.guance.com/doc/script-market-guance-tencentcloud-billing-by-instance/)

After collecting data for more than 15 days, install the "Guance Self-hosted Inspection (Billing - Instance Level)" and configure the Guance API Key as prompted to complete the setup.

In the DataFlux Func Script Market, select the inspection scenario you want to enable, click Install, configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

![image](../img/create_checker.png)

Once the script deployment is successful, it will automatically create startup scripts and auto-trigger configurations. You can view the corresponding configuration directly via the provided link.

![image](../img/success_checker.png)

## Configuring Inspection

### Configuring Inspection in Guance

![image](../img/cloudfee_instacne02.png)

#### Enable/Disable
The cloud account instance-level billing inspection is enabled by default. You can manually disable it. Once enabled, it will inspect the configured list of cloud accounts.

#### Editing
The intelligent inspection "Cloud Account Instance-Level Billing Inspection" supports manual addition of filter conditions. In the intelligent inspection list's right-side operation menu, click the **Edit** button to edit the inspection template.

* Filter Conditions: Configure corresponding cloud provider and cloud account information.
* Alert Notifications: Supports selecting and editing alert policies, including event severity levels, notification targets, and alert silence periods.

To configure entry parameters, click Edit and fill in the corresponding detection objects in the parameter configuration, then save to start the inspection:

![image](../img/cloudfee_instacne03.png)

You can reference the following configuration for multiple application information:

```json
 // Configuration Example:
    configs Configuration Example:
        account_id:cloud_provider
        account_id:cloud_provider
```

## Viewing Events

Based on Guance's intelligent algorithms, the intelligent inspection identifies anomalies in cloud asset costs. If there are sudden anomalies in cloud asset costs, the intelligent inspection will generate corresponding events. In the intelligent inspection list's right-side operation menu, click the **View Related Events** button to view the corresponding anomaly events.

![image](../img/cloudfee_instacne04.png)

### Event Details Page
Clicking **Event** allows you to view the detailed page of the intelligent inspection event, which includes event status, occurrence time, anomaly name, basic attributes, event details, alert notifications, history records, and related events.

* Clicking the small icon labeled "View Monitor Configuration" in the top-right corner of the detail page allows you to view and edit the current intelligent inspection configuration details.

#### Basic Attributes
* Detection Dimensions: Based on the intelligent inspection configuration's filter conditions, it supports copying `key/value`, adding filters, and viewing related logs, containers, processes, security checks, traces, user access monitoring, synthetic tests, and CI data.
* Extended Attributes: After selecting extended attributes, it supports copying in `key/value` format and forward/reverse filtering.

![image](../img/cloudfee_instacne05.png)

#### Event Details
* Event Overview: Describes the object and content of the anomaly inspection event.
* Cost Analysis: View the last 30 days' spending trend for the current anomalous cloud account.
  * Anomaly Interval: The start and end times of anomalies in the intelligent inspection data.
  
* Product Ranking by Spending Increase: View the ranking of product costs for the current cloud account.
* Instance Ranking by Spending Increase: View the ranking of instance costs for the current cloud account.
* Expense Forecast: Predict the remaining monthly expenses for the cloud account.
  * Confidence Interval: The accuracy range of the predicted trend line.

![image](../img/cloudfee_instacne06.png)

#### History Records
Supports viewing detected objects, anomaly/recovery times, and duration.

![image](../img/cloudfee_instacne07.png)

#### Related Events
Supports viewing related events through selected filter fields and time component information.

![image](../img/cloudfee_instacne08.png)

#### View Links

You can view more granular information about corresponding anomalies and potential influencing factors using the cloud billing instance expense monitoring views in the event list.
![image](../img/cloudfee_instacne09.png)

## FAQs

**1. How is the inspection frequency configured for cloud account instance-level billing inspection?**

* In the self-hosted DataFlux Func, add `fixed_crontab='0 0 * * *', timeout=900` in the decorator when writing custom inspection handling functions. Then configure it in "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis when the cloud account instance-level billing inspection is triggered?**

If there is no anomaly analysis in the inspection report, check the data collection status of the current `datakit`.

**3. What should I do if previously running scripts fail during the inspection process?**

Update the referenced script sets in the DataFlux Func Script Market. You can refer to the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to view the update records of the script market for timely updates.

**4. Under what circumstances would cloud account instance-level billing inspection events be generated?**

Using the total cost of specified cloud provider products as the entry point, events are triggered when significant changes occur in the cost information or when the total budget exceeds the configured budget.

* Tracking Threshold: For example, if the current cost is greater than 100% compared to the previous period.

**5. Why might the cloud account instance-level billing inspection not trigger for a long time?**

If you notice billing anomalies in the online view but the inspection does not detect them, first check whether the inspection has been active for more than 15 days, then verify that the log data retention policy is set to more than 15 days. Finally, check in DataFlux Func to ensure the automatic trigger task is correctly configured.

**6. Why do the script sets in Startup remain unchanged during script upgrades?**

First, delete the corresponding script set, then click the upgrade button and configure the corresponding Guance API Key to complete the upgrade.

**7. How do I determine if the inspection is effective after enabling it?**

In "Management / Automatic Trigger Configuration," check the inspection status. It should be enabled, and you can validate the inspection script by clicking Execute. If it shows "Executed successfully X minutes ago," the inspection is running normally and effectively.