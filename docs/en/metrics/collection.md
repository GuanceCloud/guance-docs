# Metrics Collection
---


Guance, equipped with global data collection capability, supports a variety of standard collectors. It can quickly configure data sources and easily collect hundreds of types of data.

## Data Collection

There are two ways to collect metrics, and the prerequisite is that you need to create [Guance Account](https://auth.guance.com/register) and [install DataKit](../datakit/datakit-install.md) on your host.

- The first way: log in to the studio and enter the **Integration** page. After installing DataKit, open the collectors that need to collect metrics, such as [CPU collector](../datakit/cpu.md) and [Nginx collector](../datakit/nginx.md);
- The second way: with the help of [DataKit API](../datakit/apis.md) and [custom writing of metric data through DataKit](../dataflux-func/write-data-via-datakit.md), Guance provides a [DataFlux Func processing platform](../dataflux-func/quick-start.md). It integrates a large number of existing functions to help you quickly report data for overall observation.

![](img/2.datakit_1.png)

If you need to delete measurements in workspace, enter **Management** > **Basic Settings**, click **Delete Specified Measurement**, enter the complete measurement name and click **Confirm** to delete.

**Notes**:

- Only space owners and administrators are allowed to do this;
- Once the measurement is deleted, it cannot be restored. Please be careful.

![](img/3.metric_10.png)
