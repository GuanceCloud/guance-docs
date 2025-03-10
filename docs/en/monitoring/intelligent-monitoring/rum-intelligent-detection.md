# Intelligent User Access Detection
---

Using intelligent detection algorithms, the system can intelligently monitor performance anomalies and sudden error increases when users access websites or apps. By analyzing detection metrics, the system will automatically perform anomaly analysis and trigger alerts when necessary.

Performance analysis metrics include:

- LCP (Largest Contentful Paint time greater than or equal to 2.5 seconds);
- INP (Interaction time greater than or equal to 200 milliseconds);
- FID (First Input Delay greater than or equal to 100 milliseconds);
- CLS (Cumulative Layout Shift greater than 0.01).

Based on these performance analysis metrics, the system will calculate the percentage of affected users within the detection period and issue alerts based on preset alert level thresholds:

- Critical level: Affected user percentage exceeds 76.2%;
- Warning level: Affected user percentage exceeds 47.4%;
- Error level: Affected user percentage exceeds 59.8%.

Error detection metrics include:

- Session error count;
- Page error count;
- Action error count.


## Use Cases

Supports monitoring metric data anomalies for both Web and APP application types.


## Detection Configuration {#config}

![](../img/intelligent-detection15.png)

1. Define the monitor name;

2. Select detection frequency: The execution frequency of the detection rule is fixed at 60 minutes;

3. Select detection scope: Filter the data range to be detected using fields; if no filters are added, all application data will be detected.


## View Events

The monitor will retrieve the service object metrics information for the last 60 minutes. When anomalies are detected, corresponding events will be generated and can be viewed in the [**Events > Intelligent Monitoring**](../../events/inte-monitoring-event.md) list.


### Event Details Page

Click **Event** to view the details page of the intelligent monitoring event, including event status, anomaly occurrence time, anomaly name, analysis report, alert notifications, history, and related events.

* Click the **Jump to Monitor** button in the top-right corner to adjust the [intelligent monitor](index.md);

* Click the **Export** button in the top-right corner to export as a **JSON file** or **PDF file**, thus obtaining all key data corresponding to the current event.

:material-numeric-1-circle-outline: Analysis Report

![](../img/intelligent-detection14.png)

![](../img/intelligent-detection16.png)

* Anomaly Summary: Displays user access service tags, detailed analysis reports, and statistical anomaly distribution;

* Page Performance/Error Analysis: Links to the user access page dashboard to analyze trends in metrics such as LCP, FCP, and page error rates.

**Note**: When multiple intervals have anomalies, the **Anomaly Analysis** dashboard defaults to displaying the anomaly situation of the first interval. You can switch by clicking the [Anomaly Value Distribution Chart], and the anomaly analysis dashboard will synchronize accordingly.

:material-numeric-2-circle-outline: [Extension Fields](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [Alert Notifications](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [Related Events](../../events/event-explorer/event-details.md#relevance)