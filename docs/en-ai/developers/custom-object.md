# Resource Catalog
---

Guance supports reporting Resource Catalog data via DataFlux Func (Automata), including hosts, containers, processes, networks, and more. The custom functionality of Guance's infrastructure allows reporting any custom data.

- Any Object Data: Custom infrastructure, cloud product object data, business-related object data
- Unified Management: Collect various types of object data in a uniform format for unified management.
- Correlation Analysis: Add labels for data filtering, classification, and aggregation, enabling correlation analysis on the data.

## Prerequisites

Reporting Resource Catalog data requires installing and connecting DataKit and DataFlux Func (Automata) first, then reporting data to DataKit via DataFlux Func (Automata), and finally having DataKit report the data to the Guance workspace.

- [Install DataKit](../datakit/datakit-install.md)
- [Install DataFlux Func](https://func.guance.com/doc/quick-start/)
- [Connect DataFlux Func and DataKit](https://func.guance.com/doc/practice-connect-to-datakit/)

## Reporting Resource Catalog Data

After connecting DataFlux Func (Automata) and DataKit, you can write functions in DataFlux Func (Automata) to report Resource Catalog data.

- For details on DataFlux Func function invocation interfaces, refer to the [DataKit API documentation](../datakit/apis.md).
- For instructions on writing data to DataKit using DataFlux Func, refer to the [Writing Data via DataKit](https://func.guance.com/doc/practice-write-data-via-datakit/) documentation.