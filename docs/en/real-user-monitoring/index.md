---
icon: zy/real-user-monitoring
---
# Real User Monitoring (RUM)
---

<video controls="controls" poster="https://static.<<< custom_key.brand_main_domain >>>/dataflux/help/video/rum.png" >
      <source id="mp4" src="https://static.<<< custom_key.brand_main_domain >>>/dataflux/help/video/rum.mp4" type="video/mp4">
</video>


## Why Do You Need Real User Monitoring (RUM)?

In the cloud-native era, how to enhance user experience has become a new focus for enterprises. Companies not only need comprehensive and real data to ensure the stability and reliability of their systems but also need to quickly monitor user behavior and issues encountered.

Therefore, <<< custom_key.brand_name >>> provides RUM functionality, aiming to fully track each user visit, understand the true needs behind each request, and efficiently optimize product performance.

## Where Does the Data Come From?

<<< custom_key.brand_name >>> RUM collects user access data from Web, Android, iOS, Mini Programs, and third-party frameworks through automated deployment with RUM Headless. You can view and analyze user access data in real-time, gain insights into user access environments, trace user operation paths, and break down response times. Additionally, you can understand the APM metrics resulting from user operations, achieving end-to-end comprehensive monitoring to improve application performance and user experience.


![](img/rum-arch_1.png)

## How to Enable Real User Monitoring (RUM)?

To enable the RUM feature, **first deploy a public DataKit as an Agent**, through which client-side user access data will be reported to the <<< custom_key.brand_name >>> workspace.

> For specific DataKit installation and configuration methods, refer to [DataKit Installation](../datakit/datakit-install.md).

After installing DataKit, **enable the [RUM Collector](../integrations/rum.md)**, configure the application settings, and start collecting user access data.

## Start Configuration {#create}

Log in to the <<< custom_key.brand_name >>> console, go to **Real User Monitoring > Application List > Create Application**.

![](img/rum_get_started.png)

1. Enter the **Application Name** and **Application ID**:

    - Application Name: Used to identify the current RUM application.
    - Application ID: The unique identifier for the application within the workspace, corresponding field: `app_id`. This field supports only English letters, numbers, and underscores, with a maximum length of 48 characters.

2. Select the **Application Type**, currently supporting Web, Mini Programs, Android, iOS, macOS, React Native.

3. SDK Configuration:

|                         Application Integration Guide                        |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [Web Application Integration](web/app-access.md){ .md-button .md-button--primary } | [Android Application Integration](android/app-access.md){ .md-button .md-button--primary } | [iOS Application Integration](ios/app-access.md){ .md-button .md-button--primary } |
| [Mini Program Application Integration](miniapp/app-access.md){ .md-button .md-button--primary } | [React Native Application Integration](react-native/app-access.md){ .md-button .md-button--primary } | [Flutter Application Integration](flutter/app-access.md){ .md-button .md-button--primary } |
| [UniApp Application Integration](uni-app/app-access.md){ .md-button .md-button--primary } | [macOS Application Integration](macos/app-access.md){ .md-button .md-button--primary } | [C++ Application Integration](cpp/app-access.md){ .md-button .md-button--primary } |

<font color=coral>Notes on Custom Application Type Configuration:</font>

- Selecting **Custom** application type allows you to view the corresponding integration guide on the right.

- In the **Analysis Dashboard** section, you can customize and select built-in views within the workspace as associated analysis dashboards for this application.

- By default, custom application types <u>have no analysis dashboard</u> and require manual configuration. You can bind multiple built-in views simultaneously.

| Operation      | Description                          |
| ----------- | ------------------------------------ |
| Filter Dropdown       | Single selection, supports fuzzy search, range: built-in views.  |
| Navigate       | Click to navigate and display the analysis dashboard, passing the current application ID as a view variable. |
| Remove    | Click to remove the added associated analysis dashboard. |

- After completing the configuration, return to the **Application List**. You can click :material-dots-horizontal: to edit or delete the application.

???+ warning "Important Notes"

    - Once the Application ID is changed, the SDK configuration information must be updated synchronously;
    - After successfully updating the SDK, the new analysis views and Explorer lists will only display data associated with the latest `app_id`, while data corresponding to the old Application ID will not be shown;
    - Timely update the user access metric monitors to the latest Application ID configuration or recreate them based on the new Application ID data;
    - Old Application ID data can be viewed and analyzed through built-in views, custom dashboards, or DQL tools;
    - If no associated analysis dashboard is added during custom application configuration, navigation to the analysis dashboard will not be possible.

- Further details about the current user access application can be viewed in **[Analysis Dashboard](./app-analysis.md)** or **[Explorer](./explorer/index.md)**.

## What is Session Replay?

The core concepts of <<< custom_key.brand_name >>> RUM revolve around user actions and sessions. Based on various access behaviors performed by users in the application, <<< custom_key.brand_name >>> captures user sessions from Web, Mini Programs, Android, iOS, and custom applications.

Leveraging powerful APIs provided by modern browsers, <<< custom_key.brand_name >>> session replay captures user operation data and replays user paths in real-time, effectively reproducing, locating, and solving errors.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Session Replay Configuration</font>](./session-replay/index.md)

<br/>

</div>

## Visualize User Access Data

### Analysis Dashboard {#panel}

Real User Monitoring > Analysis Dashboard covers various analysis scenarios across different endpoints, displaying multiple metrics related to performance, resources, and errors. You can understand the true front-end experience of users through key performance indicators, quickly locate issues with user access to the application, and improve user access performance.

![](img/panel-rum.gif)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; View Multi-dimensional Data in Analysis Dashboard</font>](./app-analysis.md)

<br/>

</div>

### Explorer {#explorer}

After integrating the application and completing data collection, in addition to the above analysis dashboard, you can further explore each user session (Session), page performance (View), error (Error), and other related data in Explorer. Through a series of settings, you can comprehensively understand and improve the application's operational status and usage.

![](img/explorer-rum.gif)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Explore the Wonders of Explorer</font>](./explorer/index.md)

<br/>

</div>

## Self-built Chain Exception Data Tracing

<<< custom_key.brand_name >>> RUM can set up custom tracing tasks to monitor and trace in real-time. Based on comprehensive tracing information, it quickly and accurately locates root causes of anomalies. It ensures that context is fully passed through the chain in different environments, avoiding disconnection due to lost context, thus promptly identifying vulnerabilities, anomalies, and risks. It can also create end-to-end tests via browser plugins without code.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Configure Self-built Tracing</font>](./self-tracking.md)

<br/>

</div>

## Utilizing Generated Metrics for Data Segmentation

Faced with massive volumes of raw data, <<< custom_key.brand_name >>> RUM's generated metrics feature helps Dev & Ops and business teams reduce the complexity of multi-dimensional analysis. It generates new metric data based on existing data within the current workspace, linking it to custom dashboards for regular statistical analysis based on metric dimensions.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Customize Generated Metrics</font>](./generate-metrics.md)

<br/>

</div>

## Data Storage Policy and Billing Rules

<<< custom_key.brand_name >>> provides three data retention options for user access data: <u>3 days, 7 days, 14 days</u>. You can adjust these settings in **Manage > Basic Settings > Change Data Retention Policy** according to your needs.

> For more data retention policies, refer to [Data Retention Policy](../billing-method/data-storage.md).

Based on a <u>pay-as-you-go</u> billing model, RUM charges are calculated based on the number of PVs generated by all page views within a day in the current workspace, using a tiered pricing structure.

> For more billing rules, refer to [Billing Method](../billing-method/index.md#pv).