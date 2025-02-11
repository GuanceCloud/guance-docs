# Intelligent User Access Monitoring
---

Using intelligent detection algorithms, the system can intelligently monitor performance anomalies and sudden error increases when users access websites or apps. By analyzing monitoring metrics, the system will automatically perform anomaly analysis and trigger alerts when necessary.

Performance analysis metrics include:

- LCP (Largest Contentful Paint time greater than or equal to 2.5 seconds);
- INP (Interaction time greater than or equal to 200 milliseconds);
- FID (First Input Delay greater than or equal to 100 milliseconds);
- CLS (Cumulative Layout Shift greater than 0.01).

Based on these performance analysis metrics, the system will calculate the percentage of affected users within the detection interval and issue alerts according to predefined alert level thresholds:

- Critical level: More than 76.2% of users are affected;
- Warning level: More than 47.4% of users are affected;
- Error level: More than 59.8% of users are affected.

Error detection metrics include:

- Session error count;
- Page error count;
- Action error count.


## Application Scenarios

Supports monitoring abnormal metric data for application types including Web and APP.


## Detection Configuration {#config}

![](../img/intelligent-detection15.png)

1. Define the monitor name;

2. Select the detection frequency: the execution frequency of the detection rule is fixed at 60 minutes;

3. Select the detection scope: filter the data range to be detected using fields; if no filters are added, all application data will be detected.


## View Events

The monitor retrieves the metric information of the monitored application service objects for the last 60 minutes. When an anomaly is identified, corresponding events are generated and can be viewed in the [**Events > Intelligent Monitoring**](../../events/inte-monitoring-event.md) list.


### Event Details Page

Click **Event** to view the details page of the intelligent monitoring event, which includes event status, anomaly occurrence time, anomaly name, analysis report, alert notifications, historical records, and related events.

* Click the **Jump to Monitor** button in the top right corner to adjust the [intelligent monitor](index.md);

* Click the **Export** button in the top right corner to export as a **JSON file** or **PDF file**, thus obtaining all key data related to the current event.

:material-numeric-1-circle-outline: Analysis Report

![](../img/intelligent-detection14.png)

![](../img/intelligent-detection16.png)

* Anomaly Summary: Displays user access service labels, detailed analysis reports, and statistical distribution of anomalies;

* Page Performance/Error Analysis: Links to the user access page dashboard to analyze trends in metrics such as LCP, FCP, and page error rates.

**Note**: When multiple intervals have anomalies, the **Anomaly Analysis** dashboard defaults to displaying the first anomaly interval. You can switch by clicking on the [Anomaly Value Distribution Chart], after which the anomaly analysis dashboard will synchronize accordingly.

:material-numeric-2-circle-outline: [Extended Fields](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [Alert Notifications](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [Related Events](../../events/event-explorer/event-details.md#relevance)