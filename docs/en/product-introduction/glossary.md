# Concepts
---

Includes <<< custom_key.brand_name >>> components, features, client-side applications, mobile applications, versions, billing, and other term definitions.

## Components

<<< custom_key.brand_name >>> components include the frontend console Studio, data gateway DataWay, data collection agent DataKit, and the extensible programming platform Func.

| Component                                 | Description                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| Studio                               | Studio is <<< custom_key.brand_name >>>'s console, supporting comprehensive querying and analysis of collected data. |
| DataWay                              | DataWay is <<< custom_key.brand_name >>>'s data gateway, mainly used for receiving data sent by DataKit, then reporting it to DataFlux for storage. |
| [DataKit](../datakit/index.md)       | DataKit is <<< custom_key.brand_name >>>'s real-time data collection agent, supporting hundreds of types of data collection. After collecting data, DataKit sends it to the DataWay data gateway, which then reports it to the center for storage and analysis. DataKit needs to be deployed in the user's own IT environment and supports multiple operating systems.<br/>Default collection frequency: 5 minutes |
| [Func](../dataflux-func/index.md) | Func is DataFlux Func, <<< custom_key.brand_name >>>'s extensible programming platform, used for function development, management, and execution. It is simple to use; just write code and publish it, automatically generating an HTTP API interface for functions. The official platform provides various ready-to-use script libraries that can easily be called by <<< custom_key.brand_name >>>. |

<<<% if custom_key.brand_key == 'guance' %>>>

## Storage Engine Suite {#storage-suite}


| Component                                 | Description                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| GuanceDB | Refers to <<< custom_key.brand_name >>>'s total suite of developed storage engines, including GuanceDB for metrics, GuanceDB for logs, and all sub-components in the suite. |
| GuanceDB for metrics | <<< custom_key.brand_name >>>'s time-series metric engine, specifically used for storing and analyzing time-series metric data, including guance-select, guance-insert, and guance-storage three components. |
| GuanceDB for logs | <<< custom_key.brand_name >>>'s non-time-series data storage and analysis engine, suitable for log, APM, RUM, and event data, including guance-select, guance-insert, and currently supported storage engine Doris. |
| guance-select | <<< custom_key.brand_name >>>'s sub-component of the storage suite, responsible for querying and analyzing observable data. |
| guance-insert | <<< custom_key.brand_name >>>'s sub-component of the storage suite, responsible for writing observable data. |
| guance-storage | <<< custom_key.brand_name >>>'s time-series metric data storage engine, responsible for storing time-series metric data. |
| Doris | <<< custom_key.brand_name >>>'s non-time-series data storage engine, suitable for log, APM, RUM, and event data. |

Architecture diagram:

![](img/glossary.png)

<<<% endif %>>>

## Features

Includes scenarios, events, infrastructure, metrics, logs, application performance monitoring, real-user monitoring, synthetic tests, security checks, etc., providing full-chain level data analysis and insight capabilities for collected data.

| Feature                                                         | Description                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Integrations](../integrations/integration-index.md)                             | <<< custom_key.brand_name >>> supports over a hundred data collectors, including HOSTs, CONTAINERS, LOGS, Nginx, APM, RUM, etc. Just install DataKit to start real-time data collection and report it to <<< custom_key.brand_name >>> workspace for data analysis. You can check how to install Datakit, Func, DCA, MOBILE applications in integrations. |
| [Scenarios](../scene/index.md)                                    | In scenarios, support visualized chart displays for collected data. Currently, three display methods are supported: **Dashboards**, **Notes**, and **Explorers**.<br><li>[Dashboard](../scene/dashboard/index.md): Dashboards consist of multiple visual charts combined together for simultaneous viewing and analysis of theme-related data, obtaining more comprehensive information with adjustable layouts and chart sizes;<br/><li>[Note](../scene/note.md): Notes consist of text documents and other visual charts, with fixed layouts from top to bottom. They can combine text and visuals for data analysis and summary reports;<br/><li>[Explorer](../scene/explorer/index.md): Here you can quickly build a log explorer, supporting custom addition of statistical charts, default display attributes, and filtering conditions, tailoring your log viewing needs.<br/><li>[Built-in Views](../scene/built-in-view/index.md): Includes two parts: **System Views** and **User Views**. System views are templates provided officially, while user views are created and saved as templates by users for scene and explorer details binding. |
| [Events](../events/index.md)                                   | Events are generated by monitors, intelligent inspections, SLOs, system operations, and Open APIs, supporting real-time monitoring, unified querying, unresolved event statistics, and data export based on event data, allowing tracing of abnormal situations at past time stages. |
| [Infrastructure](../infrastructure/index.md)                       | Physical infrastructure for data collection, currently supporting HOSTs, CONTAINERS, processes, K8s entities, etc. |
| [Metrics](../metrics/index.md)                                  | <li>[Measurements](../metrics/dictionary.md): A collection of the same type of metrics, generally having the same labels within one measurement set, containing multiple metrics.<br/><li>[Metrics](../metrics/dictionary.md): Metrics help understand the overall availability of a system, such as server CPU usage, website loading times, remaining disk space, etc. Metrics consist of a metric name and a metric value, where the metric name is an alias identifying the metric, and the metric value is the specific numerical value collected.<br/><li>[Labels](../metrics/dictionary.md): A collection of attributes identifying a data point's collection object. Labels consist of label names and label values, and a data point can have multiple labels. For example, when collecting the `CPU Usage` metric, it will identify attributes such as `host`, `os`, `product`, etc., collectively referred to as labels.<br/><li>[Time Series](../metrics/dictionary.md): In the current workspace, based on labels, all possible combinations reported in the metrics data. In <<< custom_key.brand_name >>>, time series are composed of metrics, labels (fields), and data storage duration, where "metrics" and "labels (fields)" combinations serve as the primary key for data storage. |
| [Logs](../logs/index.md)                                     | Records real-time running or behavioral data generated during system or software operation, supporting front-end visualization, filtering, and analysis. |
| [APM](../application-performance-monitoring/index.md) | Tracks and statistics the time spent handling service requests, request status, and other attribute information, used for application performance monitoring. |
| [RUM](../real-user-monitoring/index.md)             | Real-user monitoring refers to collecting data related to the real experiences and behaviors of users interacting with your websites and applications. <<< custom_key.brand_name >>> supports four types of real-user monitoring: Web, MOBILE (Android & IOS), mini-programs. |
| [Synthetic Tests](../usability-monitoring/index.md)               | Utilizes globally distributed testing nodes to periodically monitor websites, domains, API interfaces, etc., via HTTP, TCP, ICMP protocols, supporting the analysis of site quality through trends in availability rates and latency changes. |
| [Security Check](../scheck/index.md)                               | Conducts inspections on systems, software, logs, etc., using new security scripts, supporting real-time data output and synchronization of abnormal issues, understanding device operational conditions and environmental changes, discovering facility defects and safety hazards, and taking effective measures promptly. |
| [CI](../ci-visibility/index.md)                              | <<< custom_key.brand_name >>> supports visualization of Gitlab’s built-in CI processes and results, enabling you to view all CI visualized Pipelines and their success rates, failure reasons, specific failed steps, helping ensure code updates. |
| [Monitoring](../monitoring/index.md)                               | <li>[Monitors](../monitoring/monitor/index.md): By configuring detection rules, trigger conditions, and event notifications, receive alert notifications in real time, promptly identifying and resolving problems. Includes threshold detection, mutation detection, range detection, outlier detection, log detection, process anomaly detection, infrastructure survival detection, application performance metric detection, user access metric detection, security inspection anomaly detection, synthetic test anomaly detection, and network data detection.<br/><li>[Intelligent Inspection](../monitoring/bot-obs/index.md): Based on <<< custom_key.brand_name >>>’s intelligent algorithms, automatically detects and predicts infrastructure and application issues, helping users discover problems occurring during IT system operation, quickly locating abnormal problem causes through root cause analysis.<br/><li>[SLO](../monitoring/slo.md): SLO monitoring revolves around DevOps-related metrics, testing whether system service availability meets target requirements, not only helping users monitor service provider quality but also protecting providers from SLA violations. |
| [Workspaces](../management/index.md)                           | <<< custom_key.brand_name >>> data insights collaboration space, each workspace being independent. Users can query and analyze data within workspaces, supporting joining one or more workspaces through creation or invitation. |
| [DQL](../dql/query.md)                                       | DQL (Debug Query Language) is <<< custom_key.brand_name >>>’s data query language. Users can use DQL query syntax within <<< custom_key.brand_name >>> to query metric-type/log-type data, then visualize the data in charts. |
| [Pipeline](../pipeline/index.md)                | Pipeline is <<< custom_key.brand_name >>>’s data processing tool, defining parsing rules to split metrics, logs, RUM, APM, basic objects, RESOURCE CATALOGS, NETWORK, security inspections, etc., into structured data meeting requirements. |

## Client DCA

[Client DCA (DataKit Control App)](../datakit/dca.md) is an online DataKit management platform, supporting viewing DataKit operational status, and unified management and configuration of collectors, blacklists, Pipelines.

## Mobile APP

[<<< custom_key.brand_name >>> Mobile APP](../mobile/index.md) supports receiving alert notifications for events on mobile devices, viewing all scenario views and log data in workspaces, completing data analysis and insights anytime, anywhere.

## Versions

<<< custom_key.brand_name >>> offers Free Plan, Commercial Plan, Deployment Plan in three versions.

| Version                                               | Description                                                         |
| -------------------------------------------------- | ------------------------------------------------------------ |
| [Free Plan](https://<<< custom_key.studio_main_site_auth >>>/businessRegister) | Register to experience <<< custom_key.brand_name >>> feature modules.                               |
| [Commercial Plan](../plans/commercial-register.md)        | Cloud-based SaaS public version, pay-as-you-go, ready-to-use, requiring only installation of DataKit and configuration of relevant data collectors to complete observability integration.<br/>For billing rules, refer to [Billing Method](../billing-method/index.md). |
| [Deployment Plan](../deployment/index.md)                   | Independent SaaS cloud deployment and local PaaS deployment, requiring users to prepare service resources themselves, offering the highest level of data security and more service support. |

## Billing

<<< custom_key.brand_name >>> provides a dedicated billing account management platform **[Billing Center](../billing-center/index.md)**, where you can recharge accounts, view account balances and bill details, bind workspaces, change settlement methods, etc.

> For explanations of billing methods and items, refer to the document [Billing Method](../billing-method/index.md).

| Feature                                                         | Description                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [Settlement Methods](../billing/billing-account/index.md)              | <<< custom_key.brand_name >>> fee settlement methods, supporting <<< custom_key.brand_name >>> enterprise accounts, cloud accounts, and various settlement methods.<br/><li><<< custom_key.brand_name >>> enterprise account: <<< custom_key.brand_name >>> Billing Center is exclusively used to manage billing-related independent accounts for using <<< custom_key.brand_name >>> products, with one enterprise account able to associate billing for multiple workspaces.<br/><li>Cloud accounts: <<< custom_key.brand_name >>> Billing Center supports Amazon cloud accounts, Alibaba Cloud accounts, and Huawei Cloud accounts. Users can choose to bind cloud accounts for fee settlements. |
| [Account Management](../billing-center/account-management.md)     | <<< custom_key.brand_name >>> Billing Center account management, including account profile changes, password modifications, real-name authentication, and cloud account management. |
| [Workspace Management](../billing-center/workspace-management.md#workspace-lock) | <<< custom_key.brand_name >>> Billing Center account-bound workspace management, one account can bind multiple <<< custom_key.brand_name >>> workspaces. In workspace management, the settlement method for <<< custom_key.brand_name >>> workspaces can be modified. |
| [Bill Management](../billing-center/billing-management.md)     | <<< custom_key.brand_name >>> Billing Center bill management, including monthly bills, consumption details, income and expenditure details, voucher details, and package detail management. |
| [Support Center](../billing-center/support-center.md)         | <<< custom_key.brand_name >>> Support Center, where users can submit and manage tickets, and <<< custom_key.brand_name >>> technical expert teams will contact users promptly to resolve issues after receiving tickets. |