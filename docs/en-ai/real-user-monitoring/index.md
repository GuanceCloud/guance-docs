---
icon: zy/real-user-monitoring
---
# Real User Monitoring (RUM)
---

<video controls="controls" poster="https://static.guance.com/dataflux/help/video/rum.png" >
      <source id="mp4" src="https://static.guance.com/dataflux/help/video/rum.mp4" type="video/mp4">
</video>


## Why Do You Need Real User Monitoring (RUM)?

In the cloud-native era, enhancing user experience has become a new focus for enterprises. Companies not only need comprehensive and authentic data to ensure the stability and reliability of their systems but also need to quickly monitor user behavior and issues encountered.

Therefore, Guance provides RUM functionality, aiming to fully track each user visit, understand the true needs behind each request, and efficiently optimize product performance.

## Where Does the Data Come From?

Guance's RUM collects user access data from Web, Android, iOS, mini-programs, and third-party frameworks through automated deployment with RUM Headless. You can view and analyze user access data in real-time, gain insights into user access environments, trace user operation paths, and break down response times. Additionally, you can understand the application performance metrics resulting from user operations, achieving end-to-end comprehensive monitoring to improve application performance and user experience.

![](img/rum-arch_1.png)

## How to Enable Real User Monitoring (RUM)?

To enable the RUM feature, **you first need to deploy a public DataKit as an Agent**. The client-side user access data will be reported to the Guance workspace via this Agent.

> For detailed installation and configuration methods of DataKit, refer to [DataKit Installation](../datakit/datakit-install.md).

After DataKit is installed, **enable the [RUM Collector](../integrations/rum.md)**, configure the application settings, and start collecting user access data.

## Start Configuration {#create}

Log in to the Guance console, go to **Real User Monitoring > Application List > Create New Application**.

![](img/rum_get_started.png)

1. Enter the **Application Name** and **Application ID**:

    - Application Name: Used to identify the current RUM application.
    - Application ID: A unique identifier for the application within the current workspace, corresponding field: `app_id`. This field supports only English letters, numbers, and underscores, with a maximum length of 48 characters.

2. Select the **Application Type**, currently supporting Web, mini-program, Android, iOS, macOS, React Native.

3. SDK Configuration:

|                         Application Integration Configuration                         |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [Web Application Integration](web/app-access.md){ .md-button .md-button--primary } | [Android Application Integration](android/app-access.md){ .md-button .md-button--primary } | [iOS Application Integration](ios/app-access.md){ .md-button .md-button--primary } |
| [Mini-program Application Integration](miniapp/app-access.md){ .md-button .md-button--primary } | [React Native Application Integration](react-native/app-access.md){ .md-button .md-button--primary } | [Flutter Application Integration](flutter/app-access.md){ .md-button .md-button--primary } |
| [UniApp Application Integration](uni-app/app-access.md){ .md-button .md-button--primary } | [macOS Application Integration](macos/app-access.md){ .md-button .md-button--primary } | [C++ Application Integration](cpp/app-access.md){ .md-button .md-button--primary } |

<font color=coral>About the configuration instructions for choosing custom application types:</font>

- Select **Custom** application type to view the corresponding integration instructions on the right.

- In the **Analysis Dashboard** section, you can customize and select built-in views within the workspace as the associated analysis dashboard for this application.

- By default, custom applications have **no analysis dashboard** and require manual configuration. You can bind multiple built-in views simultaneously.

| Action      | Description                          |
| ----------- | ------------------------------------ |
| Filter Dropdown       | Single selection, supports fuzzy search, scope: built-in views.  |
| Navigate       | Click to navigate and display the analysis dashboard, passing the current application ID as a view variable. |
| Delete    | Click to remove the associated analysis dashboard. |

- After configuration, return to the **Application List**. You can click :material-dots-horizontal: to edit or delete the application.

???+ warning "Notes"

    - Once the Application ID is changed, the SDK configuration information must be updated accordingly;   
    - After updating the SDK, the new analysis views and Explorer lists will only display data associated with the latest `app_id`, and data from the old application ID will not be shown;
    - Update or recreate the user access metric monitors using the new application ID configuration;    
    - Data from the old application ID can be viewed and analyzed through built-in views, custom dashboards, or DQL tools;
    - If no associated analysis dashboard is added during custom application configuration, navigation to the analysis dashboard will not be possible.

- In the **[Analysis Dashboard](./app-analysis.md)** or **[Explorer](./explorer/index.md)**, you can further examine detailed information about the current user access application.

## What is Session Replay?

The basic concepts of Guance's RUM revolve around user actions and sessions. Based on various user activities in the application, Guance captures user sessions from Web, mini-programs, Android, iOS, and custom applications.

Leveraging powerful APIs provided by modern browsers, Guance's session replay captures user operation data and replays user interaction paths in real-time. This effectively reproduces, locates, and resolves errors.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Session Replay Configuration Instructions</font>](./session-replay/index.md)

<br/>

</div>

## Visualize and Analyze User Access Data

### Analysis Dashboard {#panel}

RUM > Analysis Dashboard covers various analysis scenarios across different endpoints, showcasing multiple metrics related to performance, resources, and errors. You can understand the real user experience on the frontend through key performance indicators, quickly pinpoint issues with user access to applications, and improve user access performance.

![](img/panel-rum.gif)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; View Multi-dimensional Data on the Analysis Dashboard</font>](./app-analysis.md)

<br/>

</div>


### Explorer {#explorer}

After integrating the application and completing data collection, besides the analysis dashboard mentioned above, you can use the Explorer to delve deeper into each user session (Session), page performance (View), error (Error), and other relevant data. Through a series of settings, you can comprehensively understand and improve the application's operational status and usage.

![](img/explorer-rum.gif)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Explore the Wonders of the Explorer</font>](./explorer/index.md)

<br/>

</div>

## Self-built Trace Anomaly Data Tracking

Guance's RUM allows setting up custom tracking tasks to monitor traces in real-time. Based on comprehensive tracking information, it quickly and accurately identifies the root cause of anomalies. It ensures that context is fully transmitted across different environments, avoiding disconnections due to lost context. This helps promptly detect vulnerabilities, anomalies, and risks. Additionally, it can create simple, code-free end-to-end tests via browser plugins.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Configure Self-built Tracking</font>](./self-tracking.md)

<br/>

</div>

## Utilize Generated Metrics to Segment Data

Facing vast volumes of raw data, Guance's RUM generated metrics function helps Dev & Ops and business teams reduce the complexity of multi-dimensional analysis. It generates new metric data based on existing data within the current workspace and links it to custom dashboards, allowing regular statistics based on metric dimensions.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Customize Generated Metrics</font>](./generate-metrics.md)

<br/>

</div>

## Data Storage Policy and Billing Rules

Guance offers three data retention periods for user access data: <u>3 days, 7 days, 14 days</u>. You can adjust these settings according to your needs at **Management > Basic Settings > Change Data Retention Policy**.

> For more details on data retention policies, refer to [Data Retention Policies](../billing-method/data-storage.md).

Based on a <u>pay-as-you-go</u> billing model, RUM charges are calculated based on the number of page views (PV) generated within a day in the current workspace, using a tiered pricing structure.

> For more details on billing rules, refer to [Billing Method](../billing-method/index.md#pv).