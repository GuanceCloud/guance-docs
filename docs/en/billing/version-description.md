# Plan Description
---

There are three plans of Guance: free plan, Commercial Plan and private cloud deployment plan. Free plan and Commercial Plan are SaaS deployment methods, which can be used directly by online registration; Private cloud deployment plan is a plan independently deployed for customers in their own environment, and customers can open registration and use for their users according to their own business conditions.

This article introduces the difference between the free plan and the Commercial Plan of Guance.

## Plan Difference
| **Difference** | **Project** | **Free Plan** | **Commercial Plan** |
| --- | --- | --- | --- |
| Data | DataKit data | Unlimited | Unlimited |
|  | Daily data reporting limit | Limited data is reported, and excess data is no longer reported. | Unlimited |
|  | Data storage strategy | 7-day cycle | Custom storage policy |
| Function | Infrastructure | Available | Available |
|  | Log | Available | Available |
|  | Backup log | / | Available |
|  | APM | Available | Available |
|  | RUM | Available | Available |
|  | CI visibility | Available | Available |
|  | Scheck | Available | Available |
|  | Monitoring | Available | Available |
|  | Synthetic tests |China Dialing | Global dialing |
|  | SMS alarm notification | / | Available |
|  | DataFlux Func | Available | Available |
|  | Account permissions | Read-only, standard permissions are promoted to administrators without auditing. | Read-only, standard permissions are promoted to administrators, and need to be approved by Billing Center administrators. |
| Services | Basic services | Community, phone, work order support (5 x 8 hours) | Community, phone, work order support (5 x 8 hours)|
|  | Training services | Regular training on observability | Regular training on observability |
|  | Expert services | / | Professional product technical expert support |
|  | Value-added services | / | Internet professional operation and maintenance service |
|  | Monitoring digital combat screen | / | Customizable |


## Notes

- Free plan users support online upgrade to Commercial Plan. If the free plan is not upgraded, there will be no charge. Once upgraded to paid plan, it cannot be refunded;
- If the data quota is fully used for different billing items in the free plan, the data will stop being reported and updated; The two types of data, object and event, still support reporting and updating, and users can still see infrastructure list data and event data;
- Timeseries and backup log statistics are full data, and other billing items are incremental data; Incremental data statistics reset the free quota at 0:00 every day, which is valid on the same day.

For more details, please refer to the doc [free start](../billing/free-start.md), [upgrade Commercial Plan](../billing/commercial-plan.md), [data storage strategy](../billing/billing-method/data-storage.md) and [rights management](../management/access-management.md).



