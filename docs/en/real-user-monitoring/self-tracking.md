# Create Triggers
---

## Introduction

<<< custom_key.brand_name >>> supports you to create trigger tasks via **User Analysis**, enabling real-time monitoring of custom-defined chain tracing paths. By pre-setting chain tracing paths, you can filter chain data centrally and accurately query user experience, promptly identifying vulnerabilities, anomalies, and risks.

## Application Support

The trigger function currently only supports the introduction of Web, Android, and iOS applications.

## Create Trigger

In the <<< custom_key.brand_name >>> workspace's **User Analysis**, click on the **application name** to enter the specified application, and then create a trace path through **Triggers**.

When performing **Create Triggers**, you need to set the name and fields, and after generating the trigger ID, complete the configuration integration.

| Field      | Description                          |
| ----------- | ------------------------------------ |
| Trigger Name       | The name of the current trigger task. Supports mixed writing in Chinese and English, supports underscores as separators, does not support other special characters, and supports up to 64 strings.  |
| Tags       | Defines chain tracing fields. Supports selecting tags (key:value) under the current application (app_id) from a dropdown box, and supports multiple selections. |
| Trigger ID    | A system-generated unique trigger ID identifier that supports one-click copying by users. |
| Integration Method     | After generating the trigger ID, you need to integrate code in the application based on the trigger ID information.                          |


![](img/image_2.png)

## Manage Trigger Tasks

After creating a trigger task, it is enabled by default. You can view performance data under the specified trigger ID in the Session Explorer of the current application; you can also view the data generated by the trigger by clicking the trigger **name**. At the same time, you can view or delete the trigger task.


## Automated Tracing {#auto-tracking}

<<< custom_key.brand_name >>> supports implementing **browser plugins** to record user access behavior using browsers, thereby creating codeless end-to-end tests.

### Steps Description

#### Step One: Download Browser Plugin

1. If you have already integrated a Web application, you can directly download and install the [browser plugin](https://static.<<< custom_key.brand_main_domain >>>/guance-plugin/guance-rum-plugin.zip).

2. If you haven't started using <<< custom_key.brand_name >>> yet, you can first complete the following steps:

 - [Register for a <<< custom_key.brand_name >>> account](https://<<< custom_key.brand_main_domain >>>/);
 - [Install DataKit](../datakit/datakit-install.md);
 - [Enable User Analysis Collector](../integrations/rum.md);
 - [Integrate Web Applications](web/app-access.md).

#### Step Two: Install Plugin

1. After downloading the plugin, visit `chrome://extensions/` via your browser;

**Note**: Automated tracing currently supports Chrome and Edge browsers.

2. Enable **Developer Mode**;
 
3. Unzip the downloaded browser plugin [guance-rum-plugin.zip](https://static.<<< custom_key.brand_main_domain >>>/guance-plugin/guance-rum-plugin.zip);

4. Click **Load unpacked extension**;

5. Select the unzipped folder.

![](img/8.auto-tracking_1.png)

#### Step Three: Use Plugin

1. In the top-right corner, click the **Extensions** icon, find **Guance Cloud Plugin**, and open the plugin;

![](img/8.auto-tracking_2.png)

2. Upon activation, a trigger ID will be generated.

- Click **Activate** to use the current trigger ID;
- Click :octicons-sync-24: to generate a new trigger ID;
- Click :fontawesome-solid-clock-rotate-left: icon to view the history of generated trigger IDs;
- Click **Language** icon to check the current language or switch languages;
- Click :octicons-question-24: icon to view help documentation.

![](img/8.auto-tracking_3.png)

#### Step Four: Filter and View Data in <<< custom_key.brand_name >>>

In the User Analysis application list, select the integrated Web application, and you can filter and view user access data using the trigger ID (`track_id`) generated by the plugin.

![](img/8.auto-tracking_4.png)