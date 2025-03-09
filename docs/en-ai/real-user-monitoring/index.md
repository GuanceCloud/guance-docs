---
icon: zy/real-user-monitoring
---
# Real User Monitoring (RUM)
---

<video controls="controls" poster="https://<<< custom_key.static_domain >>>/dataflux/help/video/rum.png" >
      <source id="mp4" src="https://<<< custom_key.static_domain >>>/dataflux/help/video/rum.mp4" type="video/mp4">
</video>


## Why Do You Need Real User Monitoring (RUM)?

In the cloud-native era, enhancing user experience has become a new focus for enterprises. Companies not only need comprehensive and accurate data to ensure system stability and reliability but also need to quickly monitor user behavior and issues encountered.

Therefore, <<< custom_key.brand_name >>> provides RUM functionality, aiming to fully track each user visit, understand the real needs behind each request, and efficiently optimize product performance.

## Where Does the Data Come From?

<<< custom_key.brand_name >>>'s RUM collects user access data from Web, Android, iOS, Mini Programs, and third-party frameworks through automated deployment of RUM Headless. You can view and analyze user access data in real-time, gain insights into user environments, trace user operation paths, and break down response times. Additionally, you can understand the application performance metrics resulting from user operations, achieving end-to-end monitoring to improve application performance and user experience.


![](img/rum-arch_1.png)

## How to Enable Real User Monitoring (RUM)?

To enable the RUM feature, **first, you need to deploy a public DataKit as an Agent**. Client-side user access data will be reported to the <<< custom_key.brand_name >>> workspace via this Agent.

> For detailed DataKit installation and configuration methods, refer to [DataKit Installation](../datakit/datakit-install.md).

After installing DataKit, **enable the [RUM Collector](../integrations/rum.md)**, configure your application settings, and start collecting user access data.

## Start Configuration {#create}

Log in to the <<< custom_key.brand_name >>> console, navigate to **Real User Monitoring > Application List > Create Application**.

![](img/rum_get_started.png)

1. Enter the **Application Name** and **Application ID**:

    - Application Name: Used to identify the current RUM application.
    - Application ID: The unique identifier for the application within the current workspace, corresponding field: `app_id`. This field supports only English letters, numbers, and underscores, with a maximum of 48 characters.

2. Select the **Application Type**, currently supporting Web, Mini Program, Android, iOS, macOS, React Native.

3. SDK Configuration:

|                         Application Integration Configuration                         |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [Web Application Integration](web/app-access.md){ .md-button .md-button--primary } | [Android Application Integration](android/app-access.md){ .md-button .md-button--primary } | [iOS Application Integration](ios/app-access.md){ .md-button .md-button--primary } |
| [Mini Program Application Integration](miniapp/app-access.md){ .md-button .md-button--primary } | [React Native Application Integration](react-native/app-access.md){ .md-button .md-button--primary } | [Flutter Application Integration](flutter/app-access.md){ .md-button .md-button--primary } |
| [UniApp Application Integration](uni-app/app-access.md){ .md-button .md-button--primary } | [macOS Application Integration](macos/app-access.md){ .md-button .md-button--primary } | [C++ Application Integration](cpp/app-access.md){ .md-button .md-button--primary } |

<font color=coral>Notes on Custom Application Type Configuration:</font>

- Selecting the **Custom** application type allows you to view the corresponding integration instructions on the right.

- In the **Analysis Dashboard** section, you can customize and select built-in views within the workspace as the associated analysis dashboard for this application.

- By default, custom application types <u>have no analysis dashboard</u> and require manual configuration. You can bind multiple built-in views simultaneously.

| Action      | Description                          |
| ----------- | ------------------------------------ |
| Filter Dropdown       | Single selection, supports fuzzy search, range: built-in views.  |
| Navigate       | Click to navigate to the selected analysis dashboard, passing the current application ID as a view variable. |
| Remove    | Click to remove the associated analysis dashboard. |

- After configuration, return to the **Application List**. You can click :material-dots-horizontal: to edit or delete the application.

???+ warning "Important Notes"

    - If the Application ID is changed, you need to update the SDK configuration accordingly.
    - After successfully updating the SDK, the new analysis views and Explorer lists will only display data associated with the latest `app_id`, while data from the old application ID will not be shown.
    - Update or recreate user access metric monitors using the latest application ID configuration.
    - Old application ID data can be viewed and analyzed through built-in views, custom dashboards, or DQL tools.
    - If no associated analysis dashboard is added during custom application configuration, navigation to the analysis dashboard will not be possible.

- Further details about the current user access application can be viewed in the **[Analysis Dashboard](./app-analysis.md)** or **[Explorer](./explorer/index.md)**.

## What Is Session Replay?

The core concepts of <<< custom_key.brand_name >>>'s RUM revolve around user actions and sessions. Based on various user activities in the application, <<< custom_key.brand_name >>> captures user sessions from Web, Mini Programs, Android, iOS, and custom applications.

Leveraging powerful APIs provided by modern browsers, <<< custom_key.brand_name >>>'s session replay captures user operation data and replays user interaction paths in real-time. This effectively reproduces, locates, and resolves errors.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Session Replay Configuration</font>](./session-replay/index.md)

<br/>

</div>

## Visualize User Access Data

### Analysis Dashboard {#panel}

The RUM Analysis Dashboard covers multiple scenarios across different endpoints, displaying key performance indicators related to performance, resources, and errors. You can understand the true user experience on the frontend, quickly identify issues with user access to the application, and improve user access performance.

![](img/panel-rum.gif)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; View Multi-dimensional Data in the Analysis Dashboard</font>](./app-analysis.md)

<br/>

</div>

### Explorer {#explorer}

After integrating the application and completing data collection, besides the analysis dashboard, you can further explore each user session (Session), page performance (View), errors (Error), and other relevant data in the Explorer. Through a series of settings, you can comprehensively understand and improve the application's operational status and usage conditions.

![](img/explorer-rum.gif)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Explore the Wonders of the Explorer</font>](./explorer/index.md)

<br/>

</div>

## Self-built Chain Tracing for Anomaly Data

<<< custom_key.brand_name >>>'s RUM can set up custom tracing tasks to monitor traces in real-time. Based on comprehensive tracing information, it can quickly and accurately locate the root cause of anomalies. It ensures that context is fully transmitted across different environments, preventing context loss that could lead to broken chains. This helps timely identify vulnerabilities, anomalies, and risks. Additionally, it can create simple, codeless end-to-end tests through browser plugins.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Configure Self-built Tracing</font>](./self-tracking.md)

<br/>

</div>

## Utilize Generated Metrics for Data Segmentation

Faced with large volumes of raw data, <<< custom_key.brand_name >>>'s generated metrics function helps Dev & Ops and business teams reduce the complexity of multi-dimensional analysis. It generates new metric data based on existing data within the current workspace, linking to custom dashboards for regular statistics based on metric dimensions.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Customize Generated Metrics</font>](./generate-metrics.md)

<br/>

</div>

## Data Storage Policy and Billing Rules

<<< custom_key.brand_name >>> offers three data retention options for user access data: <u>3 days, 7 days, 14 days</u>. You can adjust this in **Manage > Basic Settings > Change Data Retention Policy** according to your needs.

> For more data retention policies, refer to [Data Retention Policies](../billing-method/data-storage.md).

Based on a <u>pay-as-you-go</u> billing model, RUM charges are calculated based on the number of page views (PV) generated in the current workspace over one day, using a tiered pricing structure.

> For more billing rules, refer to [Billing Method](../billing-method/index.md#pv).