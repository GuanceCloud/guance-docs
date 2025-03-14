# Resource Catalog
---

<<< custom_key.brand_name >>> supports reporting resource catalog data via DataFlux Func, including hosts, containers, processes, networks, and more. <<< custom_key.brand_name >>>'s custom infrastructure functionality supports reporting any custom data.

- Arbitrary object data: Custom infrastructure data, cloud product object data, business-related object data.
- Unified management: Various types of object data are collected in a uniform format for unified management.
- Correlation analysis: Add labels for data filtering, classification aggregation, and correlation analysis of data.

## Prerequisites

Reporting resource catalog data requires installing and connecting DataKit and DataFlux Func first, then reporting data to DataKit via DataFlux Func, and finally DataKit reports the data to the <<< custom_key.brand_name >>> workspace.

- [Install DataKit](../datakit/datakit-install.md)
- [Install DataFlux Func](https://<<< custom_key.func_domain >>>/doc/quick-start/)
- [Connect DataFlux Func and DataKit](https://<<< custom_key.func_domain >>>/doc/practice-connect-to-datakit/)

## Reporting Resource Catalog Data

After connecting DataFlux Func and DataKit, you can write functions in DataFlux Func to report resource catalog data.

- For details on DataFlux Func function invocation interfaces, refer to the [DataKit API](../datakit/apis.md) documentation.
- For instructions on how to write data to DataKit using DataFlux Func, refer to the [Writing Data via DataKit](https://<<< custom_key.func_domain >>>/doc/practice-write-data-via-datakit/) documentation.