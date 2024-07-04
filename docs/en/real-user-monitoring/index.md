---
icon: zy/real-user-monitoring
---
# RUM

---

## Why do we need RUM?

In the era of cloud-native, improving user experience has become a new topic of concern for enterprises. Enterprises not only need to observe comprehensive and real data to ensure the stability and reliability of their systems, but also need to quickly monitor user behavior and the problems they encounter.

Therefore, Guance provides RUM to fully track every user visit, understand the real needs behind each request, and efficiently optimize product performance.

## Where does the data come from?

Guance RUM collects RUM data from Web, Android, iOS, mini program and third-party frameworks through RUM Headless automated deployment. You can view and analyze RUM data in real time, understand the user access environment, trace user operation paths, and analyze operation response times. You can also learn about the application performance indicators of a series of call chains caused by user operations, achieve end-to-end comprehensive monitoring, and efficiently improve application performance and user experience.

![](img/rum-arch_1.png)

## How to enable RUM?

To enable the RUM function, **you need to first deploy a public DataKit as an Agent**, and the RUM data from the client is reported to the Guance workspace through this Agent.

> For specific DataKit installation and configuration methods, see [DataKit Installation](../datakit/datakit-install.md).

After DataKit is installed, **enable [RUM Collector](../integrations/rum.md)**, and configure the application access to start collecting relevant RUM data.

## Setup {#create}

Log in to the Guance console, go to **RUM > Applications > Create**.

![](img/rum-0522.png)

1. Enter the **Application Name** and **Application ID**.
    
    - Application Name: Used to identify the name of the current RUM application.
    
    - Application ID: The unique identifier of the application in the current workspace, corresponding to the field: `app_id`. This field only supports alphanumeric characters and underscores, with a maximum of 48 characters.

2. Select the **Application Type**, which currently supports five types: **Web, Miniapp, Android, iOS and macOS**.

3. SDK Configuration

You can click on the following links to view the corresponding application access configuration:

| <font color=coral>**Application Access**</font> |  |  |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [Web](web/app-access.md){ .md-button .md-button--primary } | [Android](android/app-access.md){ .md-button .md-button--primary } | [iOS](ios/app-access.md){ .md-button .md-button--primary } |
| [Miniapp](miniapp/app-access.md){ .md-button .md-button--primary } | [React Native](react-native/app-access.md){ .md-button .md-button--primary } | [Flutter](flutter/app-access.md){ .md-button .md-button--primary } |
| [UniApp](uni-app/app-access.md){ .md-button .md-button--primary } | [macOS](macos/app-access.md){ .md-button .md-button--primary } |  |

???+ warning "Notes"

    - Once the Application ID is changed, the configuration information in the SDK needs to be updated accordingly.
    - After the SDK is successfully updated, the new analysis views and explorer lists only display the latest `app_id` associated data, and the data corresponding to the old Application ID will not be displayed.
    - Please promptly change the user access indicator monitoring to the latest Application ID configuration or create a new one based on the new Application ID.
    - The old Application ID data can be viewed and analyzed through the user access built-in views, custom dashboards, or DQL tools.
    - If you do not add associated analysis dashboards when configuring custom applications, you will not be able to jump to the analysis dashboards.

<!--
For the relevant configuration instructions for selecting custom application types:

- Select the **macOS** application type to view the corresponding application access instructions on the right.
- In the **Analysis Dashboard** column, you can customize the selection of built-in views as the associated analysis dashboard for this application.
- The default custom application type <u>does not have an analysis dashboard</u> and needs to be manually configured. You can bind multiple built-in views at the same time.

| Operation | Description |
| --- | --- |
| Filter dropdown | Single selection, supports fuzzy matching search, range: built-in views. |
| Jump | Click to jump and open the analysis dashboard, and pass the current application ID to the view variable. |
| Delete | Click to delete the added associated analysis dashboard. |


- After the configuration is completed, go back to the **Application List**. You can click :material-dots-horizontal: to edit or delete the application.


- You can further view detailed information about the current user access application by clicking **[Analysis Dashboard](https://www.notion.so/app-analysis.md)** or **[Explorer](https://www.notion.so/explorer/index.md)**.
-->

## What is Session Replay?

The basic concept of Guance RUM revolves around user operations and user sessions. Based on the various access behaviors performed by users in the application, Guance can capture user sessions of Web, mini apps, Android, iOS, and custom applications.

With the help of powerful API extension capabilities provided by modern browsers, Guance Session Replay can capture real-time user operation data, replay user operation paths. In this way, errors can be effectively reproduced, located, and resolved.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Session Replay Configuration Instructions</font>](./session-replay/index.md)

</div>

## Visualize RUM data

### Analysis Dashboard {#panel}

**RUM > Analysis Dashboard** covers various analysis scenarios for different ports, and displays multiple metrics data from three aspects: performance, resources and errors. You can understand the real front-end experience of users through key performance indicators, quickly locate problems encountered by users when accessing the application, and improve user access performance.

![](img/panel-rum.png)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Analysis Dashboard to View Multidimensional Data</font>](./app-analysis.md)


</div>

### Explorers {#explorer}

After the application is accessed and data collection is completed, in addition to the analysis dashboard mentioned above, you can further understand each user session, page performance, errors, and other related data in the explorer, and comprehensively understand and improve the running status and usage of the application through a series of settings.

![](img/explorer-rum.gif)

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Explore Powerful Uses of Explorers</font>](./explorer/index.md)


</div>

## Self-built Error Tracking

Guance RUM can set up custom tracking tasks to monitor the tracking trajectory in real time, locate abnormal root causes quickly and accurately based on comprehensive tracking information. It can also ensure that the context on the link is fully transmitted in different environments to avoid the occurrence of broken links caused by context loss, and discover vulnerabilities, exceptions, and risks in a timely manner. It can also create concise and codeless end-to-end tests through browser plug-ins.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Configure Self-built Tracking</font>](./self-tracking.md)


</div>

## Use Metrics to Segment Data

Facing a large volume of raw data, the generated metrics function of Guance RUM can help Dev & Ops and business departments reduce the difficulty of multidimensional analysis. It generates new metric data based on existing data in the current space, binds it to custom dashboards, and performs regular statistics based on metric dimensions.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; Customize Generated Metrics</font>](./generate-metrics.md)

</div>

## Data Storage and Billing

Guance provides three options for the storage duration of RUM data: <u>3 days, 7 days, and 14 days</u>. You can adjust it according to your needs in **Management > Basic Settings > Change Data Storage Strategy**.

> For more information on data storage strategies, see [Data Storage Strategies](../billing/billing-method/data-storage.md).

Based on the <u>pay-as-you-go, pay-per-use</u> billing method, the billing of RUM statistics the number of page views generated by all pages in the workspace within a day, using a gradient billing mode.

> For more billing rules, see [Billing Methods](../billing/billing-method/index.md#pv).