# Metrics Collection
---

Guance has comprehensive data collection capabilities, supporting multiple standard collectors. It allows for quick configuration of data sources and easy collection of over a hundred types of data.

## Data Collection

There are two methods to collect metrics, both requiring the creation of a [Guance account](https://auth.guance.com/register) first, and installing DataKit on the host machine [DataKit installation](../datakit/datakit-install.md).

- The first method: Log in to the console, go to the **Integrations** page. After installing DataKit, enable the required collectors for metric collection, such as the [CPU collector](../integrations/cpu.md), [Nginx collector](../integrations/nginx.md), etc.;
- The second method: Use the [DataKit API](../datakit/apis.md) method to [write custom metrics data via DataKit](https://func.guance.com/doc/practice-write-data-via-datakit/). Guance provides the [DataFlux Func (Automata) function processing platform](https://func.guance.com/doc/quick-start/), which integrates a large number of ready-made functions to help you quickly report data for overall observability.

![](img/2.datakit_1.png)

To delete a Mearsurement within a workspace, go to **Management > Settings**, click **Delete Specified Mearsurement**, enter the complete Mearsurement name, and click **Confirm** to delete it.

**Note**:

- Only workspace owners and administrators can perform this operation;
- Once a Mearsurement is deleted, it cannot be recovered. Please proceed with caution.

<img src="../img/3.metric_10.png" width="60%" >