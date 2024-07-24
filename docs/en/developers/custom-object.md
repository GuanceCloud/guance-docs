# Custom Object
---

Guance supports reporting custom object data through DataFlux Func. Except for hosts, containers, processes, networks, etc., Guance infrastructure customization function supports reporting any custom data.

- Random object data: custom infrastructure, cloud product object data and business class object data
- Unified management: Different types of object data are collected in the same format and managed in a unified way.
- Association analysis: add labels for data screening, classification and summary, and carry out association analysis on data.

## Preconditions

Custom object data reporting needs to install and connect DataKit and DataFlux Func first, then report data to DataKit through DataFlux Func, and finally DataKit reports data to guance workspace.

- [Install DataKit](../datakit/datakit-install.md)
- [Install DataFlux Func](../dataflux-func/quick-start.md)
- [Connect DataFlux Func and DataKit](../dataflux-func/connect-to-datakit.md)

## Report Custom Object Data

After DataFlux Func and DataKit are connected, you can write functions in DataFlux Func to report custom object data.

- Refer to the doc [DataKit API](../datakit/apis.md) for an interface description of the DataFlux Func function call.

