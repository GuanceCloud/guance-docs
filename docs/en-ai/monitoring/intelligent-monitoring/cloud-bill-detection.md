# Intelligent Cloud Billing Monitoring
---

Intelligent cloud billing monitoring is a highly efficient cloud cost management tool designed specifically for you. As enterprises and individuals increasingly rely on cloud services, the rational use and control of cloud service costs have become a critical issue. This tool, through intelligent monitoring of bills, can track the consumption dynamics of cloud services in real time, promptly identify and warn of potential abnormal charges, thereby helping you avoid unnecessary expenses.

In addition, intelligent cloud billing monitoring provides multi-dimensional visualization analysis functions. You can analyze and understand the consumption patterns of cloud resources from multiple perspectives, including but not limited to resource usage, service types, and cost distribution. These detailed visual reports not only allow you to fully grasp the current cost situation but also provide strong data support for future budget planning.

Through these features, you can more precisely adjust and optimize cloud resource allocation, ensuring that every investment achieves maximum value. This refined cost management approach allows you to enjoy the convenience brought by cloud services while effectively controlling and reducing costs, achieving optimal resource utilization.

## Prerequisites

Before using the cloud billing analysis feature, you need to collect and report data. First, go to DataFlux Func [Enable Collector](../../cloud-billing/index.md#precondition).

## Detection Configuration {#config}

![](../img/bill-intelligent-detection.png)

1. Define the monitor name;

2. Select detection scope: Filter detection metrics data based on cloud provider, account name, and product name to limit the scope of detected data. You can add one or more label filters. If no filtering conditions are added here, <<< custom_key.brand_name >>> will detect all cloud billing data.


## View Events

The monitor retrieves statistical data on cloud billing consumption over a period of time. When it identifies abnormal situations, it generates corresponding events, which can be viewed in the **Events > Intelligent Monitoring** list.

![](../img/bill-intelligent-detection-1.png)

:material-numeric-1-circle-outline: Abnormal Analysis: Visualizes account charges, account discount amounts, product consumption trends, and product discount trends based on cloud providers and cloud accounts.

:material-numeric-2-circle-outline: [Extended Fields](../../events/event-explorer/event-details.md#extension)

:material-numeric-3-circle-outline: [Alert Notifications](../../events/event-explorer/event-details.md#alarm)

:material-numeric-4-circle-outline: [History](../../events/event-explorer/event-details.md#history)

:material-numeric-5-circle-outline: [Related Events](../../events/event-explorer/event-details.md#relevance)