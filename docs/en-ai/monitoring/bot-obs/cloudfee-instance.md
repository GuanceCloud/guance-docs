# Cloud Account Instance-Level Billing Inspection

---

## Background

Cloud account instance-level billing inspection helps users manage anomaly cost warnings at the cloud service instance level, predict cost trends, and provides alerts for high-growth, high-consumption instances. It also offers bill visualization capabilities and supports multi-dimensional visualization of cloud service resource consumption.

## Prerequisites

1. Self-host [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://func.guance.com/#/) or enable [DataFlux Func (Automata)](../../dataflux-func/index.md)
2. Create an [API Key](../../management/api-key/open-api.md) in <<< custom_key.brand_name >>> under "Management / API Key Management" for performing operations.

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, consider deploying it with your current <<< custom_key.brand_name >>> SaaS on the [same provider and region](../../../getting-started/necessary-for-beginners/select-site/).
>
> **Note 2**: Since instance-level billing data is stored as logs, <<< custom_key.brand_name >>> SaaS log data has a default retention period of 15 days. To ensure accurate inspections, extend the log retention period to the maximum.

## Enable Inspection

In your self-hosted DataFlux Func, install and enable ["<<< custom_key.brand_name >>> Integration (Huawei Cloud - Billing Collection - Instance Level)"](https://func.guance.com/doc/script-market-guance-huaweicloud-billing-by-instance/), ["<<< custom_key.brand_name >>> Integration (Alibaba Cloud - Billing Collection - Instance Level)"](https://func.guance.com/doc/script-market-guance-aliyun-billing/), and ["<<< custom_key.brand_name >>> Integration (Tencent Cloud - Billing Collection - Instance Level)"](https://func.guance.com/doc/script-market-guance-tencentcloud-billing-by-instance/). Collect data for more than 15 days, then install "<<< custom_key.brand_name >>> Self-hosted Inspection (Billing - Instance Level)" and configure the <<< custom_key.brand_name >>> API Key to complete the setup.

In the DataFlux Func script market, select the inspection scenario you want to enable, click install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create and trigger configurations. You can view the corresponding configurations directly via the provided link.

![image](../img/success_checker.png)

## Configure Inspection

### Configuration in <<< custom_key.brand_name >>>

![image](../img/cloudfee_instacne02.png)

#### Enable/Disable
The cloud account instance-level billing inspection is enabled by default but can be manually disabled. Once enabled, it will inspect the configured list of cloud accounts.

#### Edit
The "Cloud Account Instance-Level Billing Inspection" supports manual addition of filtering conditions. In the smart inspection list's operation menu on the right, click the **Edit** button to edit the inspection template.

* Filtering Conditions: Configure corresponding cloud provider and cloud account information.
* Alert Notifications: Supports selecting and editing alert strategies, including event severity levels, notification targets, and alert silence periods.

To configure entry parameters, click **Edit**, fill in the corresponding detection objects in the parameter configuration, and save to start the inspection:

![image](../img/cloudfee_instacne03.png)

You can reference the following configuration for multiple application information:

```json
// Configuration Example:
configs configuration example:
    account_id:cloud_provider
    account_id:cloud_provider
```

## View Events

Based on <<< custom_key.brand_name >>> intelligent algorithms, the smart inspection identifies anomalies in cloud asset costs. If there are sudden anomalies in cloud asset costs, the smart inspection generates corresponding events. In the smart inspection list's operation menu on the right, click the **View Related Events** button to view the corresponding anomaly events.

![image](../img/cloudfee_instacne04.png)

### Event Details Page
Clicking **Event** allows you to view the details page of the smart inspection event, including event status, anomaly occurrence time, anomaly name, basic attributes, event details, alert notifications, historical records, and associated events.

* Click the small icon labeled "View Monitor Configuration" in the top-right corner of the details page to view and edit the current smart inspection configuration details.

#### Basic Attributes
* Detection Dimensions: Based on the configured filtering conditions of the smart inspection, support copying `key/value`, adding filters, and viewing related logs, containers, processes, security checks, traces, user access monitoring, availability monitoring, and CI data.
* Extended Attributes: After selecting extended attributes, support copying in `key/value` format and forward/reverse filtering.

![image](../img/cloudfee_instacne05.png)

#### Event Details
* Event Overview: Describes the object and content of the abnormal inspection event.
* Cost Analysis: View the consumption trend of the current abnormal cloud account over the past 30 days.
  * Abnormal Interval: The start and end times of the abnormality in the smart inspection data.
  
* Consumption Amount Increase Product Ranking: View the ranking of product costs for the current cloud account.
* Consumption Amount Increase Instance Ranking: View the ranking of instance costs for the current cloud account.
* Cost Forecast: Predict the remaining monthly consumption amount for the cloud account.
  * Confidence Interval: The accuracy range of the forecast trend line.

![image](../img/cloudfee_instacne06.png)

#### Historical Records
Supports viewing detected objects, anomaly/recovery times, and duration.

![image](../img/cloudfee_instacne07.png)

#### Associated Events
Supports viewing associated events through selected fields and time component information.

![image](../img/cloudfee_instacne08.png)

#### View Links

You can view more granular information and potential influencing factors of the corresponding anomalies through the cloud billing instance cost monitoring views in the event list.
![image](../img/cloudfee_instacne09.png)

## Common Issues

**1. How to configure the inspection frequency for cloud account instance-level billing**

* In your self-hosted DataFlux Func, add `fixed_crontab='0 0 * * *', timeout=900` in the decorator when writing the inspection processing function, then configure it in "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis during inspection**

If the inspection report lacks anomaly analysis, check the data collection status of the current `datakit`.

**3. What if previously running scripts encounter errors during inspection**

Update the referenced script sets in the DataFlux Func script market. You can review the update records via the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate timely updates.

**4. Under what circumstances will cloud account instance-level billing inspection events be generated**

Using the total cost of specified cloud provider products as the entry point, events are triggered when there is a significant change in cost information or when the total cost exceeds the configured budget.

* Tracking Threshold: For example, if the current cost increases by more than 100% year-over-year or month-over-month.

**5. Why hasn't the cloud account instance-level billing inspection been triggered for a long time**

If you notice billing anomalies in online views but the inspection does not detect them, first check whether the inspection has been active for more than 15 days. Next, check if the log data retention policy exceeds 15 days. Finally, verify that automatic trigger tasks are correctly configured in DataFlux Func.

**6. During script upgrades, why do the corresponding script sets in Startup remain unchanged**

First, delete the corresponding script set, then click the upgrade button and configure the <<< custom_key.brand_name >>> API key to complete the upgrade.

**7. How to determine if the inspection is effective after enabling**

In "Management / Automatic Trigger Configuration," check the inspection status. It should be enabled, and you can validate the inspection script by clicking execute. If it shows "Executed Successfully xx minutes ago," the inspection is running normally and effectively.