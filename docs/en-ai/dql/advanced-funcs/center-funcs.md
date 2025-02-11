# DBSCAN

Anomaly detection based on historical data for multiple time series.

## Algorithm Introduction

DBSCAN is a density-based clustering algorithm. It divides regions with density reaching a certain threshold into clusters and considers low-density regions as noise. The DBSCAN algorithm does not require pre-specifying the number of clusters, can discover clusters of arbitrary shape, and has good robustness to noisy data.

- Detection Object: Multiple time series data;
- Use Case: Suitable for scenarios where outliers in the same group of time series need to be identified;
- Parameters: Detection interval T, distance parameter;
- Meaning: From the multiple time series between `Now - T` and `Now`, identify which time series are anomalous;
- Return: Returns 1 to n outlier time series.

## Core Parameters

> Distance (eps): float, default=0.5

The distance parameter indicates the maximum distance between two samples for them to be considered neighbors, not the maximum distance between points within a cluster. (float, default=0.5)

You can configure any floating-point value between 0 and 3.0. If not configured, the default distance parameter is 0.5. Larger distance settings result in fewer anomalies detected, while too small a distance may detect many outliers, and too large a distance may result in no outliers being detected. Therefore, it's important to set an appropriate distance parameter based on different data characteristics.

## Use Cases

Taking the central function DBSCAN as an example, when users join a Guance workspace, they can choose DBSCAN. **Advanced Function - DBSCAN** outlier detection is based on historical data for multiple time series.

In the **Scenario**, select **Time Series Chart**, click the **Add Function** button under **Query**, choose **Advanced Function > DBSCAN**, set the algorithm parameters, and the chart will display the outlier effects of multiple time series. As shown in the figure:

![](../img/ad-2.png)

DQL query example:

```
DBSCAN(`M::cpu:(usage_idle)`, 0.5)
```

???+ warning

    When performing queries:

    - Time slices should be included in the query data, for example `1h:5m:1m`;
    - The algorithm requires at least five values for calculation; ensure the query meets this requirement;
    - This algorithm processes multiple time series and requires a `group by` field in the data query.


## Display Style

- Configuration results for outliers:

![](../img/ad-3.png)

- If there are no outliers, the original data is displayed as follows:

![](../img/ad-4.png)