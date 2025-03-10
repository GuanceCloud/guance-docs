# DBSCAN

A method for detecting anomalies by analyzing multiple time series based on historical data.

## Algorithm Introduction

DBSCAN is a density-based clustering algorithm. It partitions regions with density above a certain threshold into clusters and considers low-density regions as noise. The DBSCAN algorithm does not require pre-specifying the number of clusters, can discover clusters of arbitrary shape, and has good robustness to noisy data.

- Detection Object: Multiple time series data;
- Use Cases: Suitable for scenarios where outliers need to be detected within the same group of time series;
- Parameters: Detection interval T, distance parameter;
- Meaning: Identify which time series are abnormal within the range `Now - T` to `Now`;
- Return: Returns 1 to n outlier time series.

## Core Parameters

> Distance (eps): float, default=0.5

The distance parameter indicates the maximum distance between two samples that are considered neighbors, not the maximum distance between points within a cluster. (float, default=0.5)

You can configure any floating-point value in the range (0-3.0). If not configured, the default distance parameter is 0.5. Larger distances result in fewer detected anomalies, while smaller distances may detect many outliers. Setting the distance too large might result in no outliers being detected. Therefore, it's important to set an appropriate distance parameter based on the characteristics of the data.

## Use Cases

Taking the central function DBSCAN as an example, when users join the <<< custom_key.brand_name >>> workspace, they can choose DBSCAN. **Advanced Function - DBSCAN** detects outliers in multiple time series based on historical data.

In the **Scenario**, select **Time Series Chart**, click the **Add Function** button under **Query**, choose **Advanced Functions > DBSCAN**, configure the algorithm parameters, and the view will display the outlier effects of multiple time series. As shown in the figure:

![](../img/ad-2.png)

DQL query example:

```
DBSCAN(`M::cpu:(usage_idle)`, 0.5)
```

???+ warning

    When performing queries:

    - Time slices should be included in the query data, e.g., `1h:5m:1m`;
    - The algorithm requires at least five values; ensure sufficient data points during the query;
    - This algorithm processes multiple time series, so the query should include a `group by` field.


## Display Styles

- Configuration results showing outliers:

![](../img/ad-3.png)

- If no outliers are detected, the original data is displayed as is:

![](../img/ad-4.png)