# Idle Cloud Resource Inspection

---

## Background

Cloud computing, as a new IT service model, has developed rapidly, providing convenient, fast, and flexible IT infrastructure and application services for enterprises and individuals, bringing high efficiency and cost-effectiveness. However, with cloud resources gradually becoming the main component of enterprise data centers, the significant problem of massive waste of cloud resources has become increasingly prominent. Especially within enterprises, due to demand fluctuations and isolation between departments, some cloud resources cannot be fully utilized, forming a large number of idle resources. This situation can lead to a sharp increase in cloud service costs, reduced resource efficiency, and potential decreases in security and performance levels. To better manage and optimize idle cloud resources and improve the utilization rate and benefits of cloud computing, it is essential to conduct idle cloud resource inspections. Through these inspections, unnecessary resources in current cloud services can be identified and handled promptly, avoiding prolonged unnecessary resource usage that can lead to excessive expenses, data breaches, poor performance, and other issues.

## Prerequisites

1. Set up [DataFlux Func (Automata) Guance Special Edition](https://func.guance.com/#/) or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
2. Create an API Key for operations in the "Management / API Key Management" section of Guance [API Key](../../management/api-key/open-api.md)

> **Note**: If you plan to use a cloud server for offline deployment of DataFlux Func, consider using the same operator and region as your current Guance SaaS deployment [in the same operator and region](../../../getting-started/necessary-for-beginners/select-site/).

## Starting Inspections

In your self-hosted DataFlux Func, install "Guance Self-Hosted Inspection (Idle Cloud Resource Inspection)" from the "Script Market" and configure the Guance API Key to start the inspection.

In the DataFlux Func Script Market, select the inspection scenario you want to activate, click Install, configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

> Note: If you need to inspect idle resources from different cloud providers, additional collectors need to be enabled.
>
> AWS: Guance Integration (AWS-EC2 Collection), Guance Integration (AWS-CloudWatch Collection) - mem
>
> Huawei: Guance Integration (Huawei Cloud Monitoring Collection)
>
> Tencent: Guance Integration (Tencent Cloud Monitoring Collection)
>
> Alibaba: Guance Integration (Alibaba Cloud Monitoring Collection)

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration, which can be viewed directly via the provided link.

![image](../img/success_checker.png)

## Configuring Inspections

Configure the inspection conditions you want to filter in either the Smart Inspection module of Guance Studio or the automatically created startup script in DataFlux Func. Refer to the following two configuration methods:

### Configuring Inspections in Guance

  ![image](../img/cloud_idle_resources02.png)

#### Enable/Disable

Idle cloud resource inspections are by default set to "Enabled" status and can be manually "Disabled." Once enabled, it will inspect the configured cloud providers.

#### Editing

The Smart Inspection "Idle Cloud Resource Inspection" supports users to manually add filtering conditions. Click the **Edit** button under the operation menu on the right side of the Smart Inspection list to edit the inspection template.

* Filtering Conditions: Configure the information of the cloud provider you wish to inspect (it is recommended to configure each cloud provider separately).
* Alert Notifications: Supports selecting and editing alert policies, including event severity, notification targets, and alert mute periods.

Click Edit after configuring the entry parameters in the parameter configuration and fill in the corresponding detection objects, then save and start the inspection:

  ![image](../img/cloud_idle_resources03.png)

You can refer to the following configurations:

  ```json
   // Configuration Example:
       config Parameters:
              aliyun
              aws
              tencentcloud
              huaweicloud
  ```

## Viewing Events

Based on the inspection algorithm of Guance, Smart Inspection will identify idle cloud resources from the corresponding cloud providers. For abnormal resource idleness, Smart Inspection will generate corresponding events. Click the **View Related Events** button under the operation menu on the right side of the Smart Inspection list to view the corresponding abnormal events.

![image](../img/cloud_idle_resources04.png)

### Event Details Page

Click **Event** to view the details page of the Smart Inspection event, including event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, historical records, and related events.

* Click the small icon "View Monitor Configuration" in the upper-right corner of the details page to view and edit the current Smart Inspection configuration details.

#### Basic Attributes

* Detection Dimensions: Based on the filtering conditions configured in the Smart Inspection, it supports copying `key/value`, adding filters, and viewing related logs, containers, processes, Security Checks, traces, RUM, Synthetic Tests, and CI data.
* Extended Attributes: After selecting extended attributes, they can be copied in `key/value` format, allowing forward/reverse filtering.

  ![image](../img/cloud_idle_resources05.png)

#### Event Details

* Event Overview: Describes the object and content of the abnormal inspection event.
* Idle Host Details: View the idle host situation and consumption details under the current cloud account.

> Note: When querying resource catalog data for some hosts in the workspace fails, detailed host information cannot be obtained. Please check whether the resource catalog data reporting is correct.

![image](../img/cloud_idle_resources06.png)

#### Historical Records

Supports viewing the detection object, anomaly/recovery times, and duration.

 ![image](../img/cloud_idle_resources07.png)

#### Related Events

Supports viewing related events through filtered fields and selected time component information.

  ![image](../img/cloud_idle_resources08.png)

## Common Issues

**1. How to configure the inspection frequency for idle cloud resources**

In the self-hosted DataFlux Func, when writing custom inspection handling functions, add `fixed_crontab='0 * * * *', timeout=900` in the decorator, and then configure it in "Management / Auto Trigger Configuration".

**2. Why might there be no anomaly analysis during idle cloud resource inspections**

When there is no anomaly analysis in the inspection report, please check the data collection status of the current `datakit`.

**3. Under what circumstances would idle cloud resource inspection events be generated**

Events are generated when the CPU average utilization over the past 48 hours is less than 1% per hour, and the memory average usage over the past 48 hours is less than 10% per hour, and the total TCP traffic in/out over the past 48 hours is below 10M per hour.

**4. What should I do if previously normal scripts encounter errors during inspection**

Update the referenced script sets in the DataFlux Func Script Market. You can view the update records of the script market through the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script updates.

**5. During script upgrades, why does the Startup script set remain unchanged**

First, delete the corresponding script set, then click the upgrade button to configure the corresponding Guance API Key and complete the upgrade.

**6. How to determine if the inspection is effective after enabling**

In "Management / Auto Trigger Configuration," check the corresponding inspection status. First, ensure the status is enabled, then verify the inspection script by clicking Execute. If it shows "Executed successfully xxx minutes ago," the inspection is running normally and effectively.