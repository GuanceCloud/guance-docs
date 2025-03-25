# Status Page
---

<<< custom_key.brand_name >>> provides a Status Page to help users view the service status of different <<< custom_key.brand_name >>> sites in real time, as well as issues that have occurred historically and their resolution records.

<<< custom_key.brand_name >>> will monitor the service status of various sites in real time. If a service issue occurs, it will be handled immediately. If you encounter an anomaly while using <<< custom_key.brand_name >>>, you can check <<< custom_key.brand_name >>>'s service status in a timely manner to determine the cause of the anomaly. For example, if you find that logs are not being reported, you can check whether <<< custom_key.brand_name >>>'s log service is functioning properly.

## Service Sites

If you are already logged into <<< custom_key.brand_name >>>, you can view the service status of various <<< custom_key.brand_name >>> sites by clicking **Help > Status Page** in the bottom left corner.

<img src="../img/6.status_page_1.png" width="50%" >

By clicking the subscription icon, you can monitor the service operation status of the current site. After subscribing successfully, if there is an anomaly in the service operation status, an email notification will be sent to you.

**Note**: <<< custom_key.brand_name >>> will detect the functionality of each workspace under the site at a frequency of once per minute, summarizing the detection every 5 minutes. Within 5 minutes, if there is one anomaly, it will be judged as an abnormal summary. If there are 6 consecutive anomalies (i.e., 30 minutes), an alert notification email will be triggered. After the first anomaly alert notification, if the first detection of this functionality module (i.e., the summary detection every 5 minutes) returns to normal, it will be judged that the anomaly event has returned to normal.

You can also directly click on the following link to view the service status of various <<< custom_key.brand_name >>> sites.

| Site                | Service Status URL                       | Operator            |
| :------------------ | :-------------------------------------- | :------------------ |
| China Zone 1 (Hangzhou) | [https://status.<<< custom_key.brand_main_domain >>> ](https://status.<<< custom_key.brand_main_domain >>> /)        | Alibaba Cloud (China Hangzhou) |
| China Zone 2 (Ningxia) | [https://aws-status.<<< custom_key.brand_main_domain >>> ](https://aws-status.<<< custom_key.brand_main_domain >>> /) | AWS (China Ningxia)    |
| China Zone 3 (Zhangjiakou) | [https://cn3-status.<<< custom_key.brand_main_domain >>> ](https://cn3-status.<<< custom_key.brand_main_domain >>> ) | Alibaba Cloud (China Hangzhou) |
| China Zone 4 (Guangzhou) | [https://cn4-status.<<< custom_key.brand_main_domain >>> ](https://cn4-status.<<< custom_key.brand_main_domain >>> /) | Huawei Cloud (China Guangzhou) |
| Overseas Zone 1 (Oregon) | [https://us1-status.<<< custom_key.brand_main_domain >>> ](https://us1-status.<<< custom_key.brand_main_domain >>> /) | AWS (US Oregon)  |

## Service Status

<<< custom_key.brand_name >>> supports real-time viewing of the service status of different sites, including normal, abnormal, delayed, and maintenance.

| Service Status | Status Description                                      |
| :------------- | :----------------------------------------------------- |
| Normal         | Indicates that the services of the current site are operating normally, with possible data interruption or loss.             |
| Abnormal       | Indicates that the services of the current site have encountered an anomaly, with potential for data loss.   |
| Delayed        | Indicates that the services of the current site are experiencing delays, with possible data interruption or loss and query delays. |
| Maintenance    | Indicates that <<< custom_key.brand_name >>> technicians are performing maintenance on the current site.          |

### Abnormal/Delay Judgment Logic

On the Status Page, you can view the statuses of modules such as events, infrastructure, user access monitoring, application performance monitoring, metrics, logs, synthetic tests, security checks, and CI visualization. The diagram below shows the data processing flow for each functionality module, primarily including data collection, data processing, and data storage.

![](img/2.status_page.png)

<<< custom_key.brand_name >>>'s Status Page judges the service status during the data processing and data storage processes based on the above data handling process, as shown in the table below:

| Judgment Item      | Judgment Condition | Service Status     | Example Explanation                                                                                          |
| :----------------- | :----------------- | :----------------- | :---------------------------------------------------------------------------------------------------------- |
| Data Push Failure Rate | Greater than 90%  | Abnormal           | Collecting log data, the failure rate of pushing data from Kodo to the message queue exceeds 90%, indicating that the log service status is abnormal.                                                                                   |
| Data Storage Failure Rate | Greater than 90%  | Abnormal           | Collecting log data, the failure rate of writing data from Kodo-x to the database exceeds 90%, indicating that the log service status is abnormal.                                                                                   |
| Message Subscription Delay P99 | Greater than 5 minutes | Delayed           | Collecting application performance data, the delay P99 of data sent from the message queue to Kodo-x exceeds 5 minutes, indicating that the APM service status is delayed. |

### Viewing Service Status

On the <<< custom_key.brand_name >>> service status page, you can:

- Click to switch views and see the service status of all sites;

- Refresh the service status in real time;

- View the current status and the last 24 hours status of events, infrastructure, RUM PV, APM, Metrics, Logs, Synthetic Tests, Security Check, and CI functionality modules;

- Switch to view historical incidents.

![](img/2.status_page_2.png)

## Historical Incidents

On the historical incidents page, you can:

- View all service failures that occurred monthly;

- Switch to view service statuses.

![](img/6.status_page_3.png)