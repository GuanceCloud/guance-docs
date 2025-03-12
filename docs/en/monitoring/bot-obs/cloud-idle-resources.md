# Idle Cloud Resource Inspection

---

## Background

Cloud computing, as a brand-new IT service model, has developed rapidly and provided convenient, fast, and flexible IT infrastructure and application services for enterprises and individuals, bringing high efficiency and cost-effectiveness. However, with cloud resources gradually becoming the main component of enterprise data centers, the significant waste of cloud resources has become increasingly prominent. Especially within enterprises, due to demand fluctuations and isolation between departments, some cloud resources cannot be fully utilized, forming a large amount of idle resources. This situation can cause the cloud service costs of enterprises to skyrocket, reduce resource efficiency, and possibly lower security and performance levels. To better manage and optimize idle cloud resources and improve the benefits and utilization rate of cloud computing, it is very necessary to conduct inspections on idle cloud resources. Through inspections, unnecessary resources in current cloud services can be identified and promptly handled, avoiding unnecessary expenses, data leaks, poor performance, and other issues caused by long-term use of these resources.

## Prerequisites

1. Self-host [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://<<< custom_key.func_domain >>>/#/) or activate [DataFlux Func (Automata)](../../dataflux-func/index.md)
2. Create an [API Key](../../management/api-key/open-api.md) for operations in <<< custom_key.brand_name >>> under 「Manage / API Key Management」

> **Note**: If considering using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with the current SaaS <<< custom_key.brand_name >>> in the [same operator and region](../../../getting-started/necessary-for-beginners/select-site/).

## Initiating Inspection

In your self-hosted DataFlux Func, install the 「<<< custom_key.brand_name >>> Self-built Inspection (Idle Cloud Resource Inspection)」from the 「Script Market」and configure the <<< custom_key.brand_name >>> API Key to complete the activation.

In the DataFlux Func Script Market, select the inspection scenario you need to initiate, click Install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://<<< custom_key.func_domain >>>/doc/script-market-guance-monitor-connect-to-other-guance-node/), then choose to deploy and start the script.

> Note: If inspecting idle resources from different cloud providers, additional collectors need to be enabled.
>
> AWS: <<< custom_key.brand_name >>> Integration (AWS-EC2 Collection), <<< custom_key.brand_name >>> Integration (AWS-CloudWatch Collection) - mem
>
> Huawei: <<< custom_key.brand_name >>> Integration (Huawei Cloud Monitoring Collection)
>
> Tencent: <<< custom_key.brand_name >>> Integration (Tencent Cloud Monitoring Collection)
>
> Alibaba: <<< custom_key.brand_name >>> Integration (Alibaba Cloud Monitoring Collection)

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration, which can be viewed directly via the link.

![image](../img/success_checker.png)

## Configuring Inspection

Configure the inspection conditions you want to filter in either the <<< custom_key.brand_name >>> studio's Monitoring - Smart Inspection module or the automatically created startup script in DataFlux Func. You can refer to the following two configuration methods:

### Configuration in <<< custom_key.brand_name >>>

  ![image](../img/cloud_idle_resources02.png)

#### Enable/Disable

Idle cloud resource inspection is by default 「Enabled」and can be manually 「Disabled」. Once enabled, it will inspect the configured cloud providers.

#### Edit

Smart Inspection 「Idle Cloud Resource Inspection」supports manual addition of filtering criteria. Click the **Edit** button under the operation menu on the right side of the Smart Inspection list to edit the inspection template.

* Filtering Criteria: Configure information for the cloud provider you wish to inspect (it is recommended to configure different providers separately).
* Alert Notifications: Supports selection and editing of alert strategies, including event severity, notification targets, and alert silence periods.

Click edit in the entry parameter configuration and fill in the corresponding detection object in the parameter configuration, then save and start the inspection:

  ![image](../img/cloud_idle_resources03.png)

You can reference multiple configurations like the following:

  ```json
   // Example configuration:
       config parameters:
              aliyun
              aws
              tencentcloud
              huaweicloud
  ```

## Viewing Events

Based on <<< custom_key.brand_name >>> inspection algorithms, smart inspections will find idle cloud resources from the corresponding cloud providers. For abnormal idle resource situations, smart inspections will generate corresponding events. Click the **View Related Events** button under the operation menu on the right side of the Smart Inspection list to view relevant anomaly events.

![image](../img/cloud_idle_resources04.png)

### Event Details Page

Clicking **Event**, you can view the detailed page of the smart inspection event, including event status, time of anomaly occurrence, anomaly name, basic attributes, event details, alert notifications, history records, and related events.

* Click the small icon labeled 「View Monitor Configuration」in the top-right corner of the detail page to view and edit the current smart inspection configuration.

#### Basic Attributes

* Detection Dimensions: Based on the filtering criteria set in the smart inspection configuration, supports copying `key/value`, adding to filters, and viewing related logs, containers, processes, security checks, traces, user access monitoring, availability monitoring, and CI data.
* Extended Attributes: After selecting extended attributes, supports copying in `key/value` format, forward/reverse filtering.

  ![image](../img/cloud_idle_resources05.png)

#### Event Details

* Event Overview: Describes the object and content of the abnormal inspection event.
* Idle Host Details: View the idle host situation and consumption status under the current cloud account.

> Note: When query of some host resource catalog data fails and detailed host information cannot be obtained, please check if the resource catalog data reporting is correct.

![image](../img/cloud_idle_resources06.png)

#### History Records

Supports viewing the detection object, anomaly/recovery times, and duration.

![image](../img/cloud_idle_resources07.png)

#### Related Events

Supports viewing related events through filtered fields and selected time components.

![image](../img/cloud_idle_resources08.png)

## Common Issues

**1. How to configure the inspection frequency of idle cloud resources**

In your self-hosted DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator when writing the self-built inspection processing function, then configure it in 「Manage / Auto Trigger Configuration」.

**2. Why might there be no anomaly analysis during inspection**

When the inspection report lacks anomaly analysis, please check the data collection status of the current `datakit`.

**3. Under what circumstances would idle cloud resource inspection events occur**

When it detects that within the past 48 hours, the average hourly CPU utilization < 1% and the average hourly memory usage < 10% and the total hourly TCP traffic in/out is less than 10M.

**4. What should be done if a previously normally running script encounters errors during inspection**

Please update the referenced script set in the DataFlux Func Script Market. You can view the update records of the script market via the [**Change Log**](https://<<< custom_key.func_domain >>>/doc/script-market-guance-changelog/) to facilitate immediate script updates.

**5. What should be done if the script set in Startup remains unchanged during script upgrade**

Please first delete the corresponding script set, then click the upgrade button to configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**6. How to determine if the inspection is effective after enabling**

Check the corresponding inspection status in 「Manage / Auto Trigger Configuration」. First, the status should be enabled, then verify if the inspection script works by clicking execute. If it shows "Executed successfully xxx minutes ago," the inspection is running effectively.