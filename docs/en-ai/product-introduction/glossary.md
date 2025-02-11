# Concept Overview
---

Including explanations of Guance components, features, clients, mobile apps, versions, and billing terms.

## Components

Guance's components include the frontend console Studio, data gateway DataWay, data collection agent DataKit, and the extensible programming platform Func.

| Component                                 | Description                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| Studio                               | Studio is Guance's console that supports comprehensive querying and analysis of collected data. |
| DataWay                              | DataWay is Guance's data gateway, primarily used to receive data sent by DataKit and then report it to the DataFlux center for storage. |
| [DataKit](../datakit/index.md)       | DataKit is Guance's real-time data collection agent, supporting over a hundred types of data collection. DataKit sends collected data to the DataWay data gateway first, which then reports it to the center for storage and analysis. DataKit needs to be deployed in the user's own IT environment and supports multiple operating systems.<br/>Default collection frequency: 5 minutes |
| [Func](../dataflux-func/index.md) | Func, also known as DataFlux Func, is Guance's extensible programming platform used for function development, management, and execution. It is simple to use; just write and publish code, automatically generating an HTTP API interface for functions. Officially provided with various ready-to-use script libraries, making it easy for Guance to call. |

## Storage Engine Suite {#storage-suite}

| Component                                 | Description                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| GuanceDB | Refers to the overall name of the storage engine suite developed by Guance, including GuanceDB for Metrics, GuanceDB for Logs, and all sub-components within the suite. |
| GuanceDB for Metrics | Guance's time series metrics engine, specifically designed for storing and analyzing time series metrics data, including guance-select, guance-insert, and guance-storage components. |
| GuanceDB for Logs | Guance's non-time series data storage and analysis engine, suitable for logs, APM, RUM, and event data, including guance-select, guance-insert, and the currently supported storage engine Doris. |
| guance-select | A sub-component of the Guance storage suite, specifically responsible for querying and analyzing observable data. |
| guance-insert | A sub-component of the Guance storage suite, specifically responsible for writing observable data. |
| guance-storage | Guance's time series metrics data storage engine, responsible for storing time series metrics data. |
| Doris | Guance's non-time series data storage engine, suitable for logs, APM, RUM, and event data. |

Relationship architecture diagram:

![](img/glossary.png)

## Features

Includes scenarios, events, infrastructure, metrics, logs, APM, RUM, synthetic tests, security checks, etc., providing end-to-end data analysis and insights for collected data.

| Feature                                                         | Description                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Integration](../integrations/integration-index.md)                             | Guance supports over a hundred data collectors, including hosts, containers, logs, Nginx, APM, RUM, etc. Just install DataKit to start real-time data collection and report it to the Guance workspace for data analysis. You can see how to install DataKit, Func, DCA, and mobile apps in integrations. |
| [Scenarios](../scene/index.md)                                    | Scenarios support visual chart displays for collected data, currently supporting three display methods: **Dashboard**, **Note**, **Explorer**.<br><li>[Dashboard](../scene/dashboard/index.md): Dashboards are composed of multiple visual charts for viewing and analyzing various data related to a theme simultaneously, obtaining comprehensive information, with freely adjustable layout and chart sizes;<br/><li>[Note](../scene/note.md): Notes consist of text documents and other visual charts, with fixed layouts from top to bottom. They can be used for data analysis and summary reports through a combination of text and images;<br/><li>[Explorer](../scene/explorer/index.md): Here you can quickly build a log viewer, supporting custom addition of statistical charts, setting default display properties and filtering conditions, customizing your log viewing needs.<br/><li>[Built-in Views](../scene/built-in-view/index.md): Includes **System Views** and **User Views**. System views are official view templates, while user views are created and saved by users as templates. User views can be cloned from system views and used for scenario and explorer detail binding. |
| [Events](../events/index.md)                                   | Events are generated by monitors, intelligent inspections, SLOs, system operations, and Open APIs, supporting real-time monitoring, unified queries, unresolved event statistics, and data export based on event data to trace anomalies at specific times. |
| [Infrastructure](../infrastructure/index.md)                       | Physical infrastructure for data collection, currently supporting hosts, containers, processes, K8s, etc. |
| [Metrics](../metrics/index.md)                                  | <li>[Mearsurement](../metrics/dictionary.md): A collection of the same type of metrics, generally having the same metric labels, one measurement can contain multiple metrics.<br/><li>[Metric](../metrics/dictionary.md): Metrics help understand the overall availability of the system, such as server CPU usage, website loading time, remaining disk space, etc. Metrics consist of a metric name and a metric value, where the metric name is an alias identifying the metric, and the metric value is the actual numerical value collected.<br/><li>[Labels](../metrics/dictionary.md): A set of attributes identifying a data point collection object, divided into label names and label values. A data point can have multiple labels. For example, when collecting the `CPU usage` metric, it would identify attributes like `host`, `os`, `product`, etc., collectively called labels.<br/><li>[Time Series](../metrics/dictionary.md): In the current workspace, the number of all possible combinations based on tags in reported metrics data. In Guance, a time series is composed of metrics, tags (fields), and data storage duration, with "metrics" and "tags (fields)" forming the primary key for data storage. |
| [Logs](../logs/index.md)                                     | Used to record real-time operational or behavioral data generated by systems or software, supporting front-end visualization, filtering, and analysis. |
| [Application Performance Monitoring (APM)](../application-performance-monitoring/index.md) | Tracks the time spent processing service requests, request status, and other attribute information, used for monitoring application performance. |
| [Real User Monitoring (RUM)](../real-user-monitoring/index.md)             | Collects data related to the real experience and behavior of users interacting with websites and applications. Guance supports four types of RUM for Web, mobile (Android & iOS), and mini-programs. |
| [Synthetic Tests](../usability-monitoring/index.md)               | Uses globally distributed dial testing nodes to periodically monitor websites, domains, API interfaces, etc., via HTTP, TCP, ICMP protocols. Supports analyzing site quality through available rate and latency trend changes. |
| [Security Check](../scheck/index.md)                               | Conducts inspections on systems, software, logs, etc., using new security scripts. Supports real-time data output and synchronization of abnormal issues, helping to monitor device operation and environmental changes, identify facility defects and safety hazards, and take timely effective measures. |
| [CI](../ci-visibility/index.md)                              | Guance supports visualizing Gitlab's built-in CI process and results, allowing you to view all CI pipelines and their success rates, failure reasons, and specific failed stages in Guance, helping to ensure code updates. |
| [Monitoring](../monitoring/index.md)                               | <li>[Monitors](../monitoring/monitor/index.md): By configuring detection rules, trigger conditions, and event notifications, receive alert notifications promptly, timely discover and resolve issues. Includes threshold detection, mutation detection, range detection, outlier detection, log detection, process anomaly detection, infrastructure survival detection, application performance metric detection, user access metric detection, security check anomaly detection, synthetic test anomaly detection, and network data detection.<br/><li>[Intelligent Inspection](../monitoring/bot-obs/index.md): Based on Guance's intelligent algorithms, automatically detect and predict infrastructure and application issues, helping users identify problems in IT system operations through root cause analysis, quickly locating the causes of anomalies.<br/><li>[SLO](../monitoring/slo.md): SLO monitoring revolves around DevOps metrics, testing whether system service availability meets target requirements, not only helping users monitor service quality but also protecting providers from SLA violations. |
| [Workspace](../management/index.md)                           | A collaboration space for Guance data insights, each workspace being independent. Users can perform data queries and analysis in workspaces and join one or more workspaces through creation or invitation. |
| [DQL](../dql/query.md)                                       | DQL (Debug Query Language) is Guance's data query language. Users can use DQL query syntax in Guance to query metric-type/log-type data and visualize it in charts. |
| [Pipeline](../pipeline/index.md)                | Pipeline is Guance's data processing tool, supporting parsing rules to structure metrics, logs, user visits, application performance, base objects, resource catalogs, networks, security checks, etc., into required structured data. |

## Client DCA

[Client DCA (DataKit Control App)](../datakit/dca.md) is the online management platform for DataKit, supporting viewing DataKit operation status, and unified management and configuration of collectors, blacklists, and Pipelines.

## Mobile App

[Guance Mobile App](../mobile/index.md) supports receiving alert notifications for events on mobile devices, viewing all scene views and log data in workspaces, enabling seamless data analysis and insights anytime, anywhere.

## Versions

Guance provides Free Plan, Commercial Plan, and Deployment Plan versions.

| Version                                               | Description                                                         |
| -------------------------------------------------- | ------------------------------------------------------------ |
| [Free Plan](https://auth.guance.com/businessRegister) | Register to experience Guance's feature modules.                               |
| [Commercial Plan](../plans/commercial-register.md)        | Cloud-based SaaS public version, pay-as-you-go, ready-to-use. Just install DataKit and configure relevant data collectors to complete observability integration.<br/>For billing rules, refer to [Billing Method](../billing-method/index.md). |
| [Deployment Plan](../deployment/index.md)                   | Independent SaaS cloud deployment and local PaaS deployment, requiring users to prepare service resources themselves, offering the highest level of data security and more service support. |

## Billing

Guance provides a dedicated billing account management platform **[Billing Center](../billing-center/index.md)**, where you can recharge accounts, view account balances and bill details, bind workspaces, change settlement methods, etc.

> For explanations of billing methods and items, refer to the document [Billing Method](../billing-method/index.md).

| Feature                                                         | Description                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Settlement Methods](../billing/billing-account/index.md)              | Guance's fee settlement methods, supporting enterprise accounts and cloud accounts.<br/><li>Enterprise Account: An independent account in the Guance Billing Center used to manage fees incurred from using Guance products. One enterprise account can be associated with multiple workspace billings.<br/><li>Cloud Accounts: The Guance Billing Center supports Amazon Web Services, Alibaba Cloud, and Huawei Cloud accounts. Users can choose to bind cloud accounts for fee settlement. |
| [Account Management](../billing-center/account-management.md)     | Guance Billing Center account management, including changes to account information, password modification, real-name authentication, and cloud account management. |
| [Workspace Management](../billing-center/workspace-management.md#workspace-lock) | Management of workspaces bound to Guance Billing Center accounts. One account can bind multiple Guance workspaces. Workspace management allows modifying the settlement method for Guance workspaces. |
| [Bill Management](../billing-center/billing-management.md)     | Guance Billing Center bill management, including monthly bills, expense details, income and expense details, voucher details, and package details management. |
| [Support Center](../billing-center/support-center.md)         | Guance's support center, where users can submit and manage tickets. Guance's technical experts will contact users promptly to resolve issues. |