# Status Page
---

Guance provides a Status Page to help users monitor the real-time service status of different sites on Guance, as well as the history of issues and their resolution records.

Guance constantly monitors the service status of each site. If any service issues occur, they will be promptly addressed and resolved. If you encounter any abnormalities while using Guance, you can check the service status on the Guance Status Page to determine the cause of the issue. For example, if you find that logs cannot be reported, you can check whether the log service on Guance is functioning properly.

## Service Site

If you have logged into Guance, you can view the service status of each site of Guance by clicking **Help > Status Page** in the lower left corner.

<img src="../img/6.status_page_1.png" width="50%" >

You can also directly click the following link to view the service status of each site in Guance.

| Sites              | Service Status URL            | Operator             |
| :---------------- | :-------------------------------------- | :----------------- |
| CN1 (Hangzhou)   | [http://status.guance.com](http://status.guance.com/)        | Alibaba Cloud (Hangzhou, China |
| CN2 (Ningxia)   | [http://aws-status.guance.com](http://aws-status.guance.com/) | AWS (Ningxia, China)    |
| CN3 (Zhangjiakou) | [http://cn3-status.guance.com](http://cn3-status.guance.com) | Alibaba Cloud (Hangzhou, China |
| CN4 (Guangzhou)   | [http://cn4-status.guance.com](http://cn4-status.guance.com/) | Huawei Cloud (Guangzhou, China) |
| US1 (Oregon) | [http://us1-status.guance.com](http://us1-status.guance.com/) | AWS (Oregon, USA)  |

## Service Status

Guance supports real-time viewing of service status of different sites, including normal, abnormal and maintenance status.

| Service Status | Description                                                         |
| :------- | :----------------------------------------------------------- |
| Normal     | Indicate that the service of the current site is working properly.                                 |
| Anomaly     | Indicate that the service of the current site is delayed or abnormal, such as: <br><li>collecting log data, but no log data is reported, and the status of log service is abnormal at this time; <br><li>collecting application performance data, and report the data delay. At this time, the status of APM service is abnormal. |
| Maintenance     | Indicate that Guance technician is maintaining the current site.                   |

### Exception/Delay Judgment Logic

On the Status Page, you can view the status of Events, Infrastructure, RUM, APM, metrics, logs, Synthetic Tests, Security Check, CI Visibility, and other features. The following figure shows the data processing process of each feature, including data collection, data processing, and data storage.

![](img/2.status_page.png)

Guance's Status Page is based on the above data processing process to determine the service status in the data processing and data storage processes, as shown in the table below:

| Judgment Item | Judgment Condition | Service Status | Example Explanation |
| --- | --- | --- | --- |
| Data Push Failure Rate | Greater than 90% | Exception | When the failure rate of pushing log data from Kodo to the message queue is greater than 90%, the status of the log service is considered as exceptional. |
| Data Storage Failure Rate | Greater than 90% | Exception | When the failure rate of writing log data from Kodo-x to the database is greater than 90%, the status of the log service is considered as exceptional. |
| Message Subscription Delay P99 | Greater than 5 minutes | Delay | When the P99 delay of sending message queue data to Kodo-x exceeds 5 minutes in the collection of application performance data, the status of the APM service is considered as delayed. |

### View Service Status

On Guance Service Status page, you can:

- Click Switch to view the service status of all sites;

- Refresh the service status in real time;

- Check the current status and the last 24-hour status of CI visibility, synthetic tests, events, logs, metrics, basic implementation, RUM, security check and APM function modules;

- Switch to view historical incidents.

![](img/6.status_page_4.png)

## Historical Accident

On the **Historical Incident** page, you can:

- Check all service failures that occur every month;
- Switch to view service status.



![](img/6.status_page_3.png)









