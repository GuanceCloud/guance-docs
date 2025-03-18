# Concepts
---

Including components, features, clients, mobile applications, versions, billing, and other terminologies.

## Components

The components of <<< custom_key.brand_name >>> include the frontend console Studio, data gateway DataWay, data collection agent DataKit, and the extensible programming platform Func.

| Component                                 | Description                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| Studio                               | Studio is the control panel of <<< custom_key.brand_name >>>, supporting comprehensive querying and analysis of collected data. |
| DataWay                              | DataWay is the data gateway of <<< custom_key.brand_name >>>, primarily used to receive data sent by DataKit and then report it to the DataFlux center for storage. |
| [DataKit](../datakit/index.md)       | DataKit is the real-time data collection agent of <<< custom_key.brand_name >>>, supporting hundreds of data collections. DataKit sends data to the DataWay data gateway first, which then reports it to the central system for storage and analysis. DataKit needs to be deployed in the user's own IT environment and supports multiple operating systems.<br/>Default collection frequency: 5 minutes |
| [Func](../dataflux-func/index.md) | Func, also known as DataFlux Func, is the extensible programming platform of <<< custom_key.brand_name >>>, used for function development, management, and execution. It is simple to use; you just write code and publish it, automatically generating an HTTP API interface for the function. Officially provided script libraries are ready-to-use, easily allowing <<< custom_key.brand_name >>> to call them. |

## Storage Engine Suite {#storage-suite}

| Component                                 | Description                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| GuanceDB | Refers to the total set of storage engines developed by <<< custom_key.brand_name >>>, including GuanceDB for metrics, GuanceDB for logs, and all sub-components within the suite. |
| GuanceDB for metrics | The time series metrics engine of <<< custom_key.brand_name >>>, specifically designed for storing and analyzing time series metrics data, including three components: guance-select, guance-insert, and guance-storage. |
| GuanceDB for logs | The non-time series data storage and analysis engine of <<< custom_key.brand_name >>>, suitable for log, APM, RUM, and event data, including guance-select, guance-insert, and the currently supported storage engine Doris. |
| guance-select | A sub-component of <<< custom_key.brand_name >>>'s storage suite, responsible for querying and analyzing observable data. |
| guance-insert | A sub-component of <<< custom_key.brand_name >>>'s storage suite, responsible for writing observable data. |
| guance-storage | The time series metrics data storage engine of <<< custom_key.brand_name >>>, responsible for storing time series metrics data. |
| Doris | The non-time series data storage engine of <<< custom_key.brand_name >>>, suitable for log, APM, RUM, and event data. |

Architecture Diagram:

![](img/glossary.png)

## Features

Including scenarios, events, infrastructure, metrics, logs, APM, RUM, synthetic tests, security checks, etc., providing end-to-end data analysis and insights based on collected data.

| Feature                                                         | Description                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Integrations](../integrations/integration-index.md)                             | <<< custom_key.brand_name >>> supports over a hundred data collectors, including hosts, containers, logs, Nginx, APM, RUM, etc. Simply install DataKit to start real-time data collection from different sources and report it to <<< custom_key.brand_name >>> workspaces for data analysis. You can view how to install DataKit, Func, DCA, and mobile applications in the integrations section. |
| [Scenarios](../scene/index.md)                                    | In scenarios, you can visualize collected data using charts. Currently, three display methods are supported: **Dashboards**, **Notes**, and **Explorers**.<br><li>[Dashboards](../scene/dashboard/index.md): Dashboards consist of multiple visual charts, used to view and analyze various related data simultaneously, obtaining comprehensive information with adjustable layout and chart sizes;<br/><li>[Notes](../scene/note.md): Notes combine text documents and visual charts, with a fixed layout from top to bottom. They allow for combined textual and graphical data analysis and reporting;<br/><li>[Explorers](../scene/explorer/index.md): Here, you can quickly build a log explorer, supporting customizable addition of statistical charts, setting default display attributes and filtering conditions, tailoring your log viewing needs.<br/><li>[Built-in Views](../scene/built-in-view/index.md): Includes two parts: **System Views** and **User Views**. System views are templates provided officially, while user views are created and saved by users as templates for use in scenarios and explorer details binding. |
| [Events](../events/index.md)                                   | Events are generated by monitors, intelligent inspections, SLOs, system operations, and Open API writes. They support real-time monitoring, unified querying, unresolved event statistics, and data export, allowing tracing of anomalies during specific time periods based on event data. |
| [Infrastructure](../infrastructure/index.md)                       | Physical infrastructure for data collection, currently supporting entities such as hosts, containers, processes, K8s, etc. |
| [Metrics](../metrics/index.md)                                  | <li>[Measurement](../metrics/dictionary.md): A collection of the same type of metrics, generally having the same metric labels within one measurement, containing multiple metrics.<br/><li>[Metrics](../metrics/dictionary.md): Metrics help understand overall system availability, such as server CPU usage, website loading times, remaining disk space, etc. Metrics consist of a metric name and a metric value, where the metric name is an alias identifying the metric, and the metric value is the actual numeric value collected.<br/><li>[Labels](../metrics/dictionary.md): A set of attributes identifying the data point collection object. Labels consist of label names and label values, and a data point can have multiple labels. For example, when collecting the `CPU Usage` metric, it will identify attributes like `host`, `os`, `product`, etc., collectively referred to as labels.<br/><li>[Time Series](../metrics/dictionary.md): In the current workspace, the number of all possible combinations based on labels in reported metric data. In <<< custom_key.brand_name >>>, a time series is composed of metrics, labels (fields), and data storage duration, with "metrics" and "labels (fields)" forming the primary key for data storage. |
| [Logs](../logs/index.md)                                     | Records real-time operational or behavioral data generated by systems or software, supporting front-end visualization, filtering, and analysis. |
| [Application Performance Monitoring (APM)](../application-performance-monitoring/index.md) | Tracks the time spent processing service requests, request status, and other attribute information, used for monitoring application performance. |
| [Real User Monitoring (RUM)](../real-user-monitoring/index.md)             | Refers to collecting data related to the real experience and behavior of users interacting with your websites and applications. <<< custom_key.brand_name >>> supports four types of RUM: Web, mobile (Android & iOS), and mini-programs. |
| [Synthetic Tests](../usability-monitoring/index.md)               | Utilizes globally distributed dial testing nodes to periodically monitor websites, domains, API interfaces, etc., via protocols such as HTTP, TCP, ICMP. Supports analyzing site quality through available rate and latency trend changes. |
| [Security Check](../scheck/index.md)                               | Conducts inspections of systems, software, and logs using advanced security scripts, supporting real-time data output and immediate synchronization of abnormal issues, monitoring device operation status and environmental changes, identifying facility defects and safety hazards, and promptly taking effective measures. |
| [CI](../ci-visibility/index.md)                              | <<< custom_key.brand_name >>> supports visualizing Gitlab’s built-in CI processes and results, allowing you to view all CI pipelines, their success rates, failure reasons, and specific failed stages in <<< custom_key.brand_name >>>, helping ensure code updates. |
| [Monitoring](../monitoring/index.md)                               | <li>[Monitors](../monitoring/monitor/index.md): By configuring detection rules, trigger conditions, and event notifications, receive alert notifications promptly, enabling timely issue identification and resolution. Includes threshold detection, anomaly detection, range detection, outlier detection, log detection, process anomaly detection, infrastructure survival detection, APM metric detection, RUM metric detection, security check anomaly detection, synthetic testing anomaly detection, and network data detection.<br/><li>[Smart Inspections](../monitoring/bot-obs/index.md): Based on <<< custom_key.brand_name >>>'s intelligent algorithms, automatically detect and predict infrastructure and application issues, helping users discover problems in IT system operations through root cause analysis, quickly locating abnormal issue causes.<br/><li>[SLO](../monitoring/slo.md): SLO monitoring revolves around DevOps metrics, testing whether system service availability meets target requirements, not only helping users monitor service quality but also protecting service providers from SLA violations. |
| [Workspaces](../management/index.md)                           | <<< custom_key.brand_name >>>’s collaboration space for data insights, with each workspace being independent. Users can perform data queries and analysis within workspaces, joining one or more workspaces via creation or invitation. |
| [DQL](../dql/query.md)                                       | DQL (Debug Query Language) is <<< custom_key.brand_name >>>’s data query language. Users can use DQL query syntax in <<< custom_key.brand_name >>> to query metrics or log data and visualize it with charts. |
| [Pipeline](../pipeline/index.md)                | Pipeline is <<< custom_key.brand_name >>>’s data processing tool, supporting the parsing of metrics, logs, RUM, APM, basic objects, resource catalogs, networks, and security checks into structured data through defined parsing rules. |

## Client DCA

[Client DCA (DataKit Control App)](../datakit/dca.md) is the online management platform for DataKit, supporting viewing DataKit’s running status and unified management and configuration of collectors, blacklists, and Pipelines.

## Mobile App

[<<< custom_key.brand_name >>> Mobile App](../mobile/index.md) supports receiving alert notifications for events on mobile devices, viewing all scene views and log data in workspaces, and completing data analysis and insights anytime, anywhere.

## Versions

<<< custom_key.brand_name >>> offers Free Plan, Commercial Plan, and Deployment Plan versions.

| Version                                               | Description                                                         |
| -------------------------------------------------- | ------------------------------------------------------------ |
| [Free Plan](https://<<< custom_key.studio_main_site_auth >>>/businessRegister) | Register to experience <<< custom_key.brand_name >>>’s feature modules.                               |
| [Commercial Plan](../plans/commercial-register.md)        | Cloud-based SaaS public version, pay-as-you-go, ready-to-use. Just install DataKit and configure relevant data collectors to complete observability access.<br/>For billing rules, refer to [Billing Method](../billing-method/index.md). |
| [Deployment Plan](../deployment/index.md)                   | Independent SaaS cloud deployment and PaaS local deployment, requiring users to prepare service resources themselves, offering the highest level of data security and more service support. |

## Billing

<<< custom_key.brand_name >>> provides a dedicated billing account management platform, the **[Billing Center](../billing-center/index.md)**, where you can recharge accounts, view account balances and bill details, bind workspaces, change settlement methods, and more.

> For explanations of billing terms and items, refer to the [Billing Method](../billing-method/index.md) document.

| Function                                                         | Description                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Settlement Methods](../billing/billing-account/index.md)              | <<< custom_key.brand_name >>>’s billing settlement methods, supporting <<< custom_key.brand_name >>> enterprise accounts, cloud accounts, and other settlement methods.<br/><li><<< custom_key.brand_name >>> Enterprise Account: A standalone account in <<< custom_key.brand_name >>>’s Billing Center dedicated to managing charges incurred from using <<< custom_key.brand_name >>> products, capable of associating multiple workspace billing.<br/><li>Cloud Accounts: <<< custom_key.brand_name >>>’s Billing Center supports Amazon Web Services, Alibaba Cloud, and Huawei Cloud accounts. Users can choose to bind these cloud accounts for billing settlements. |
| [Account Management](../billing-center/account-management.md)     | <<< custom_key.brand_name >>>’s Billing Center account management, including account information changes, password modifications, identity verification, and cloud account management. |
| [Workspace Management](../billing-center/workspace-management.md#workspace-lock) | <<< custom_key.brand_name >>>’s Billing Center account-bound workspace management. One account can bind multiple <<< custom_key.brand_name >>> workspaces. Workspace management allows modifying the settlement method for <<< custom_key.brand_name >>> workspaces. |
| [Billing Management](../billing-center/billing-management.md)     | <<< custom_key.brand_name >>>’s Billing Center bill management, including monthly bills, consumption details, income and expenditure details, voucher details, and package details management. |
| [Support Center](../billing-center/support-center.md)         | <<< custom_key.brand_name >>>’s support center, where users can submit and manage tickets. <<< custom_key.brand_name >>> technical experts will promptly contact users to resolve issues after receiving tickets. |