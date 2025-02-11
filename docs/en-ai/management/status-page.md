# Status Page
---

Guance provides a Status Page to help users view the service status of different Guance sites in real-time, as well as historical issues and their resolution records.

Guance continuously monitors the service status of various sites. In case of service issues, they are addressed immediately. If you encounter any anomalies while using Guance, you can check the service status to determine the cause. For example, if you find that logs are not being reported, you can check whether the log service is functioning normally.

## Service Sites

If you have logged into Guance, you can access the service status of all sites by clicking **Help > Status Page** in the bottom-left corner.

![Status Page](../img/6.status_page_1.png)

Clicking the subscription icon allows you to monitor the service operation status of the current site. After subscribing successfully, if there is an anomaly in the service operation status, you will receive email notifications.

**Note**: Guance checks the functional modules of workspaces under each site at a frequency of once per minute, with a summary check every 5 minutes. If there is an anomaly within 5 minutes, it is considered an abnormal summary. If there are continuous 6 anomalies (i.e., 30 minutes) of consecutive anomalies, an alert notification email will be triggered. After the first anomaly alert notification, if the first check of the functional module (i.e., the 5-minute summary check) returns to normal, it is determined that the anomaly has been resolved.

You can also directly click the following links to view the service status of different Guance sites.

| Site                | Service Status URL                       | Operator            |
| :------------------ | :--------------------------------------- | :------------------ |
| China Region 1 (Hangzhou) | [https://status.guance.com](https://status.guance.com/)        | Alibaba Cloud (China Hangzhou) |
| China Region 2 (Ningxia) | [https://aws-status.guance.com](https://aws-status.guance.com/) | AWS (China Ningxia)    |
| China Region 3 (Zhangjiakou) | [https://cn3-status.guance.com](https://cn3-status.guance.com) | Alibaba Cloud (China Hangzhou) |
| China Region 4 (Guangzhou) | [https://cn4-status.guance.com](https://cn4-status.guance.com/) | Huawei Cloud (China Guangzhou) |
| Overseas Region 1 (Oregon) | [https://us1-status.guance.com](https://us1-status.guance.com/) | AWS (US Oregon)  |

## Service Status

Guance supports real-time viewing of service statuses for different sites, including Normal, Abnormal, Delayed, and Maintenance.

| Service Status | Status Description                                         |
| :------------- | :--------------------------------------------------------- |
| Normal         | Indicates that the current site's service is operating normally, but data interruption or loss may occur.             |
| Abnormal       | Indicates that the current site's service has encountered an issue, and data loss may occur.   |
| Delayed        | Indicates that the current site's service has experienced delays, leading to data interruption or loss and delayed query results. |
| Maintenance    | Indicates that Guance technicians are performing maintenance on the current site.          |

### Abnormal/Delayed Judgment Logic

On the Status Page, you can view the status of functional modules such as events, infrastructure, RUM, APM, Metrics, logs, Synthetic Tests, Security Check, and CI visualization. The following diagram illustrates the data processing flow for these functional modules, which mainly includes data collection, data processing, and data storage.

![](img/2.status_page.png)

The Status Page of Guance judges the service status based on the above data processing flow during the data processing and data storage phases, as shown in the table below:

| Judgment Item      | Judgment Condition | Service Status | Example Description |
| :----------------- | :----------------- | :------------ | :------------------ |
| Data Push Failure Rate | Greater than 90%  | Abnormal      | Collecting log data, the failure rate of pushing data from Kodo to the message queue is greater than 90%, indicating that the log service status is abnormal.        | 
| Data Entry Failure Rate | Greater than 90%  | Abnormal      | Collecting log data, the failure rate of writing data from Kodo-x to the database is greater than 90%, indicating that the log service status is abnormal.        | 
| Message Subscription Delay P99 | Greater than 5 minutes | Delayed      | Collecting APM data, the P99 delay of sending data from the message queue to Kodo-x exceeds 5 minutes, indicating that the APM service status is delayed.        |

### Viewing Service Status

On the Guance service status page, you can:

- Switch to view the service status of all sites;

- Refresh the service status in real-time;

- View the current status and the last 24-hour status of functional modules such as events, infrastructure, RUM, APM, Metrics, logs, Synthetic Tests, Security Check, and CI;

- Switch to view historical incidents.

![](img/2.status_page_2.png)

## Historical Incidents

On the historical incidents page, you can:

- View all service failures that occurred each month;

- Switch to view the service status.

![](img/6.status_page_3.png)