# Status Page
---

<<< custom_key.brand_name >>> provides a Status Page to help users view the service status of different <<< custom_key.brand_name >>> sites in real time, as well as historical issues and resolution records.

<<< custom_key.brand_name >>> continuously monitors the service status of various sites. If a service issue occurs, it will be addressed immediately. If you encounter any anomalies while using <<< custom_key.brand_name >>>, you can check the service status to determine the cause. For example, if you notice that logs are not being reported, you can check whether <<< custom_key.brand_name >>>'s log service is functioning normally.

## Service Sites

If you have logged into <<< custom_key.brand_name >>>, you can view the service status of each site by clicking **Help > Status Page** in the lower-left corner.

![Status Page](../img/6.status_page_1.png)

Click the subscription icon to monitor the operational status of the current site. After subscribing successfully, you will receive email notifications if there are any service anomalies.

**Note**: <<< custom_key.brand_name >>> checks the functionality of workspaces under each site at a frequency of once per minute, summarizing the checks every 5 minutes. If an anomaly occurs within 5 minutes, it will be marked as abnormal. If there are continuous 6 anomalies (i.e., 30 minutes), an alert notification email will be triggered. After the first anomaly alert, if the next summary check (every 5 minutes) returns normal, the anomaly event is considered resolved.

You can also directly click the following links to view the service status of <<< custom_key.brand_name >>>'s various sites.

| Site               | Service Status URL                         | Operator             |
| :----------------- | :----------------------------------------- | :------------------- |
| China Region 1 (Hangzhou) | [https://status.<<< custom_key.brand_main_domain >>>](https://status.<<< custom_key.brand_main_domain >>>/)        | Alibaba Cloud (China Hangzhou) |
| China Region 2 (Ningxia)   | [https://aws-status.<<< custom_key.brand_main_domain >>>](https://aws-status.<<< custom_key.brand_main_domain >>>/) | AWS (China Ningxia)    |
| China Region 3 (Zhangjiakou) | [https://cn3-status.<<< custom_key.brand_main_domain >>>](https://cn3-status.<<< custom_key.brand_main_domain >>>) | Alibaba Cloud (China Hangzhou) |
| China Region 4 (Guangzhou)   | [https://cn4-status.<<< custom_key.brand_main_domain >>>](https://cn4-status.<<< custom_key.brand_main_domain >>>/) | Huawei Cloud (China Guangzhou) |
| Overseas Region 1 (Oregon) | [https://us1-status.<<< custom_key.brand_main_domain >>>](https://us1-status.<<< custom_key.brand_main_domain >>>/) | AWS (US Oregon)  |

## Service Status

<<< custom_key.brand_name >>> supports real-time viewing of the service status for different sites, including Normal, Anomaly, Delay, and Maintenance.

| Service Status | Status Description                                      |
| :------------- | :----------------------------------------------------- |
| Normal         | Indicates that the current site's service is operating normally, but data interruptions may occur. |
| Anomaly        | Indicates that the current site's service has encountered an anomaly, with potential data loss. |
| Delay          | Indicates that the current site's service has experienced delays, with data interruptions and query delays. |
| Maintenance    | Indicates that <<< custom_key.brand_name >>> technicians are maintaining the current site. |

### Anomaly/Delay Judgment Logic

On the Status Page, you can view the status of various modules such as events, infrastructure, user access monitoring, APM, Metrics, logs, Synthetic Tests, security checks, and CI visualization. The following diagram illustrates the data processing workflow for these modules, which mainly includes data collection, data processing, and data storage.

![](img/2.status_page.png)

<<< custom_key.brand_name >>>'s Status Page evaluates the service status based on the data processing and storage phases, as shown in the table below:

| Judgment Item       | Judgment Condition      | Service Status | Example Description                                                                                       |
| :------------------ | :---------------------- | :------------- | :-------------------------------------------------------------------------------------------------------- |
| Data Push Failure Rate | Greater than 90%        | Anomaly        | Collecting log data, where the failure rate of pushing data from Kodo to the message queue exceeds 90%, indicating an anomaly in the log service. |
| Data Ingestion Failure Rate | Greater than 90%        | Anomaly        | Collecting log data, where the failure rate of writing data from Kodo-x to the database exceeds 90%, indicating an anomaly in the log service. |
| Message Subscription Delay P99 | Greater than 5 minutes   | Delay          | Collecting APM data, where the delay P99 of sending data from the message queue to Kodo-x exceeds 5 minutes, indicating a delay in the APM service. |

### Viewing Service Status

On <<< custom_key.brand_name >>>'s service status page, you can:

- Switch to view the service status of all sites;
- Refresh the service status in real time;
- View the current status and the past 24-hour status of modules like events, infrastructure, RUM PV, APM, Metrics, logs, Synthetic Tests, security checks, and CI;
- Switch to view historical incidents.

![](img/2.status_page_2.png)

## Historical Incidents

On the historical incidents page, you can:

- View all service outages that occurred each month;
- Switch to view service status.

![](img/6.status_page_3.png)