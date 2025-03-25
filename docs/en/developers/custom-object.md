# Resource Catalog
---

<<< custom_key.brand_name >>> supports reporting resource catalog data through DataFlux Func, including hosts, containers, processes, networks, etc. The custom infrastructure feature of <<< custom_key.brand_name >>> also supports reporting any custom data.

- Any object data: Custom infrastructure, cloud product object data, business-related object data.
- Unified management: Various types of object data are collected in the same format for unified management.
- Correlation analysis: Add labels for data filtering, classification summary, and perform correlation analysis on the data.

## Prerequisites

To report resource catalog data, you need to first install and connect DataKit with DataFlux Func, then report data from DataFlux Func to DataKit, and finally have DataKit report the data to the <<< custom_key.brand_name >>> workspace.

- [Install DataKit](../datakit/datakit-install.md)
- [Install DataFlux Func](https://<<< custom_key.func_domain >>>/doc/quick-start/)
- [Connect DataFlux Func and DataKit](https://<<< custom_key.func_domain >>>/doc/practice-connect-to-datakit/)

## Reporting Resource Catalog Data

After connecting DataFlux Func and DataKit, you can write functions in DataFlux Func to complete the reporting of resource catalog data.

- For interface descriptions regarding DataFlux Func function calls, refer to the documentation [DataKit API](../datakit/apis.md).
- For instructions on how to write data into DataKit using DataFlux Func, refer to the documentation [Writing Data via DataKit](https://<<< custom_key.func_domain >>>/doc/practice-write-data-via-datakit/).