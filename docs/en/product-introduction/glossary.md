# Concepts
---

Includes explanations of terms such as <<< custom_key.brand_name >>> components, features, clients, mobile, versions, and billing.

## Components

<<< custom_key.brand_name >>> components include the front-end console Studio, data gateway DataWay, data collection Agent DataKit, and the extensible programming platform Func.

| Component                                 | Description                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| Studio                               | Studio is <<< custom_key.brand_name >>>'s console, supporting comprehensive querying and analysis of collected data. |
| DataWay                              | DataWay is <<< custom_key.brand_name >>>'s data gateway, mainly used to receive data sent by DataKit, then report it to DataFlux for storage. |
| [DataKit](../datakit/index.md)       | DataKit is <<< custom_key.brand_name >>>'s real-time data collection Agent, supporting hundreds of types of data collection. After DataKit collects data, it sends it to the DataWay data gateway, which then reports it to the center for storage and analysis. DataKit needs to be deployed in the user's own IT environment and supports multiple operating systems.<br/>Default collection frequency: 5 minutes |
| [Func](../dataflux-func/index.md) | Func is DataFlux Func, <<< custom_key.brand_name >>>'s extensible programming platform, used for function development, management, and execution. It is simple to use; just write code and publish it, automatically generating an HTTP API interface for the function. The official provides various ready-to-use script libraries, easily allowing <<< custom_key.brand_name >>> to call them. |

## Storage Engine Suite {#storage-suite}


| Component                                 | Description                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| GuanceDB | Refers to the general term for <<< custom_key.brand_name >>>'s storage engine suite, including GuanceDB for metrics, GuanceDB for logs, and all sub-components within the suite. |
| GuanceDB for metrics | <<< custom_key.brand_name >>>'s time series metric engine, specifically designed for storing and analyzing time series metric data, including guance-select, guance-insert, and guance-storage components. |
| GuanceDB for logs | <<< custom_key.brand_name >>>'s non-time-series data storage and analysis engine, suitable for logs, APM, RUM, and event data, including guance-select, guance-insert, and the currently supported storage engine Doris. |
| guance-select | A sub-component of <<< custom_key.brand_name >>>'s storage suite, specifically responsible for querying and analyzing observable data. |
| guance-insert | A sub-component of <<< custom_key.brand_name >>>'s storage suite, specifically responsible for writing observable data. |
| guance-storage | <<< custom_key.brand_name >>>'s time series metric data storage engine, responsible for storing time series metric data. |
| Doris | <<< custom_key.brand_name >>>'s non-time-series data storage engine, suitable for logs, APM, RUM, and event data. |

Architecture diagram:

![](img/glossary.png)

## Features

Includes scenarios, events, infrastructure, Metrics, logs, application performance monitoring, real-user monitoring, synthetic testing, security checks, etc., providing full-chain-level data analysis and insight capabilities for collected data.

| Feature                                                         | Description                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Integrations](../integrations/integration-index.md)                             | <<< custom_key.brand_name >>> supports over a hundred data collectors, including HOST, CONTAINERS, logs, Nginx, APM, RUM, etc. Simply install DataKit to start real-time data collection and reporting to <<< custom_key.brand_name >>> workspaces for data analysis. You can refer to integrations on how to install Datakit, Func, DCA, and mobile. |
| [Scenarios](../scene/index.md)                                    | In scenarios, you can visualize the collected data with charts. Currently, three display methods are supported: **Dashboards**, **Notes**, and **Explorers**.<br><li>[Dashboard](../scene/dashboard/index.md): Dashboards consist of multiple visual charts for viewing and analyzing topic-related data comprehensively. Layouts and chart sizes can be freely adjusted;<br/><li>[Note](../scene/note.md): Notes consist of text documents and other visual charts with fixed layouts from top to bottom. They allow combined textual and visual data analysis and summary reporting;<br/><li>[Explorer](../scene/explorer/index.md): Here you can quickly set up a log explorer, support adding custom statistical charts, setting default display properties and filter conditions, customizing your log viewing needs.<br/><li>[Built-in Views](../scene/built-in-view/index.md): Includes two parts, **System Views** and **User Views**. System views are officially provided view templates, while user views are user-defined created and saved as templates. Supports cloning from system views for binding to scenarios and explorers details. |
| [Events](../events/index.md)                                   | Events are generated by monitors, intelligent inspections, SLOs, system operations, and Open API writes. They support real-time monitoring, unified querying, unresolved event statistics, and data export based on event data to trace anomalies that occurred during a specific time period. |
| [Infrastructure](../infrastructure/index.md)                       | Physical infrastructure for data collection. Currently supports HOSTs, CONTAINERS, processes, K8s entities, and more. |
| [Metrics](../metrics/index.md)                                  | <li>[Measurements](../metrics/dictionary.md): Collections of the same type of Metrics. Generally, Metrics in the same Measurement have identical tags, and one Measurement can contain multiple Metrics.<br/><li>[Metrics](../metrics/dictionary.md): Metrics help understand the overall availability of the system, such as server CPU usage, website loading time, remaining disk space, etc. Metrics consist of Metric names and Metric values. Metric names are aliases identifying the Metric, while Metric values represent the specific numerical values collected.<br/><li>[Tags](../metrics/dictionary.md): Sets of attributes identifying the objects of data point collection. Tags consist of tag names and tag values, and one data point can have multiple tags. For example, when collecting the Metric `CPU Usage`, it identifies attributes like `host`, `os`, `product`, etc., collectively referred to as tags.<br/><li>[Time Series](../metrics/dictionary.md): In the current workspace, the number of combinations based on labels in reported Metric data. In <<< custom_key.brand_name >>>, Time Series is composed of Metrics, tags (fields), and data retention periods, where "Metrics" and "tags (fields)" form the primary key for data storage. |
| [Logs](../logs/index.md)                                     | Records real-time operational or behavioral data produced by systems or software, supporting front-end visualization, filtering, and analysis. |
| [APM](../application-performance-monitoring/index.md) | Tracks and analyzes the time spent handling requests by services, request statuses, and other attribute information, useful for monitoring application performance. |
| [RUM](../real-user-monitoring/index.md)             | Real-User Monitoring refers to collecting data related to the real experiences and behaviors of users interacting with your websites and applications. <<< custom_key.brand_name >>> supports four types of real-user monitoring: Web, Mobile (Android & IOS), and Mini Programs. |
| [Synthetic Tests](../usability-monitoring/index.md)               | Uses globally distributed test nodes to monitor websites, domains, API interfaces, etc., via protocols such as HTTP, TCP, ICMP periodically. Supports analyzing site quality through trends in availability rates and delays. |
| [Security Check](../scheck/index.md)                               | Conducts inspections on systems, software, and logs using new security scripts, supporting real-time data output and synchronization of abnormal issues, understanding device operation status and environmental changes, discovering facility defects and security risks, and taking timely effective measures. |
| [CI](../ci-visibility/index.md)                              | <<< custom_key.brand_name >>> supports visualization of Gitlab’s built-in CI processes and results. You can view all visualized Pipelines and their success rates, failure reasons, and specific failed stages in <<< custom_key.brand_name >>>, helping ensure code updates. |
| [Monitoring](../monitoring/index.md)                               | <li>[Monitors](../monitoring/monitor/index.md): By configuring detection rules, trigger conditions, and event notifications, receive alert notifications promptly to identify and resolve problems. Includes threshold detection, mutation detection, range detection, outlier detection, log detection, process anomaly detection, infrastructure survival detection, application performance indicator detection, user access indicator detection, security inspection anomaly detection, synthetic testing anomaly detection, and network data detection.<br/><li>[Intelligent Inspection](../monitoring/bot-obs/index.md): Based on <<< custom_key.brand_name >>>’s intelligent algorithms, automatically detects and predicts infrastructure and application problems, helping users discover issues occurring during IT system operation. Through root cause analysis, quickly locate the causes of abnormal problems.<br/><li>[SLO](../monitoring/slo.md): SLO monitoring revolves around DevOps indicators to test whether system service availability meets target requirements. Not only does it help users monitor the quality of service provided by service providers but also protects service providers from SLA violations. |
| [Workspaces](../management/index.md)                           | <<< custom_key.brand_name >>>'s collaborative space for data insights. Each workspace operates independently. Users can perform data queries and analyses within workspaces and join one or more workspaces via creation or invitation. |
| [DQL](../dql/query.md)                                       | DQL (Debug Query Language) is <<< custom_key.brand_name >>>'s data query language. Users can use DQL query syntax in <<< custom_key.brand_name >>> to query Metrics-type/Log-type data and visualize data charts. |
| [Pipeline](../pipeline/index.md)                | Pipeline is <<< custom_key.brand_name >>>'s data processing tool. By defining parsing rules, it supports structuring Metrics, logs, RUM, APM, basic objects, Resource Catalogs, NETWORK, Security Checks, and other data into required structured data. |

## Client DCA

[Client DCA (DataKit Control App)](../datakit/dca.md) is an online DataKit management platform that supports viewing DataKit runtime status and managing configurations for collectors, blacklists, and Pipelines uniformly.

## Mobile APP

[<<< custom_key.brand_name >>> Mobile App](../mobile/index.md) supports receiving alert notifications for events on mobile devices, viewing all scene views and log data in the workspace, enabling easy data analysis and insights anytime and anywhere.

## Versions

<<< custom_key.brand_name >>> offers Free Plan, Commercial Plan, and Deployment Plan versions.

| Version                                               | Description                                                         |
| -------------------------------------------------- | ------------------------------------------------------------ |
| [Free Plan](https://<<< custom_key.studio_main_site_auth >>>/businessRegister) | Register to experience <<< custom_key.brand_name >>> feature modules.                               |
| [Commercial Plan](../plans/commercial-register.md)        | Cloud-based SaaS public version, pay-as-you-go, plug-and-play. After installing DataKit, configure relevant data collectors to complete observability access.<br/>For billing rules, refer to [Billing Method](../billing-method/index.md). |
| [Deployment Plan](../deployment/index.md)                   | Independent deployment on SaaS cloud or local PaaS deployment. Requires users to prepare service resources themselves, offering the highest level of data security and additional service support. |

## Billing

<<< custom_key.brand_name >>> provides a dedicated billing account management platform **[Billing Center](../billing-center/index.md)** where you can recharge accounts, check balances and bill details, bind workspaces, change settlement methods, and more.

> For explanations of billing methods and items, refer to the document [Billing Method](../billing-method/index.md).

| Feature                                                         | Description                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Settlement Methods](../billing/billing-account/index.md)              | <<< custom_key.brand_name >>> fee settlement methods, supporting <<< custom_key.brand_name >>> enterprise accounts, cloud accounts, and more.<br/><li><<< custom_key.brand_name >>> enterprise account: <<< custom_key.brand_name >>> Billing Center is exclusively used to manage independent accounts related to charges incurred from using <<< custom_key.brand_name >>> products. One enterprise account can be associated with multiple workspace billings.<br/><li>Cloud Accounts: <<< custom_key.brand_name >>> Billing Center supports Amazon cloud accounts, Alibaba Cloud accounts, and Huawei Cloud accounts. Users can choose to bind cloud accounts for fee settlements. |
| [Account Management](../billing-center/account-management.md)     | <<< custom_key.brand_name >>> Billing Center account management, including account profile changes, password modifications, real-name authentication, and cloud account management. |
| [Workspace Management](../billing-center/workspace-management.md#workspace-lock) | <<< custom_key.brand_name >>> Billing Center account-bound workspace management. An account can bind multiple <<< custom_key.brand_name >>> workspaces. Workspace management allows modifying <<< custom_key.brand_name >>> workspace settlement methods. |
| [Bill Management](../billing-center/billing-management.md)     | <<< custom_key.brand_name >>> Billing Center bill management, including monthly bills, consumption details, income and expenditure details, voucher details, and package details management. |
| [Support Center](../billing-center/support-center.md)         | <<< custom_key.brand_name >>> Support Center where users can submit and manage tickets. <<< custom_key.brand_name >>> technical expert teams will promptly contact users to resolve issues after receiving tickets. |