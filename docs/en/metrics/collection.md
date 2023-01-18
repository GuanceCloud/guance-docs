# Metrics Collection
---

## Introduction

Guance Cloud, equipped with global data collection capability, supports a variety of standard collectors. It can quickly configure data sources and easily collect hundreds of types of data.

## Data Collection

There are two ways to collect indicators, and the premise is that you need to create [Guance Cloud Account](https://auth.guance.com/register) and [install DataKit](../datakit/datakit-install.md) on your host computer.

- The first way: log in to the console and enter the "Integration" page. After installing DataKit, open the collectors that need to collect indicators, such as [CPU collector](../datakit/cpu.md), [Nginx collector](../datakit/nginx.md) and so on；
- The second way is with the help of [DataKit API](../datakit/apis.md) and [custom writing of indicator data through DataKit](../dataflux-func/write-data-via-datakit.md), Guance Cloud provides a [DataFlux Func function processing platform](../dataflux-func/quick-start.md), integrating a large number of off-the-shelf functions to help you quickly report data for overall observation.

![](img/2.datakit_1.png)

## Delete Indicator Data

Guance Cloud supports administrators to delete indicator sets in space, enter "Management"-"Basic Settings", click "Delete Indicator Set", enter the complete indicator set name and click "OK" to delete.

???+ attention

    - Only space owners and administrators are allowed to do this;
    - Once the indicator set is deleted, it cannot be restored. Please be careful.

![](img/3.metric_10.png)
