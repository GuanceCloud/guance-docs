---
icon: zy/cloud-billing
---

# Cloud Billing
---

Guance's cloud billing function is a comprehensive cloud cost management and analysis solution. It integrates multiple features such as data collection, multi-dimensional analysis, and real-time monitoring, aiming to help enterprises optimize the use of cloud resources and control costs. By efficiently collecting cloud billing data through DataFlux Func (Automata), it ensures the accuracy and timeliness of the data.

You can use the Cloud Billing Explorer to conveniently browse and filter cost information from different cloud service providers, thereby achieving a comprehensive understanding of cloud resource consumption.

Additionally, Guance's scene view feature allows for in-depth analysis of cloud resource consumption, covering various levels from products, regions to instance levels. This enables you to identify hotspots and inefficient areas of resource consumption and predict future resource needs and cost trends, providing data support for long-term cloud cost planning.

Finally, the intelligent monitoring system for cloud billing provides real-time tracking of service consumption and automatic detection of abnormal charges, issuing timely warnings to effectively avoid unnecessary expenses. Through the effective integration of these functions, Guance's cloud billing feature forms a powerful cost and consumption analysis system, helping enterprises achieve refined management and cost optimization of cloud resources.

## Prerequisites {#precondition}

Before using the cloud billing analysis function and ultimately collecting data for reporting, you need to go to DataFlux Func (Automata) and enable the following collectors:

- Collector——[Alibaba Cloud - Cloud Billing (Instance Level)](https://func.guance.com/doc/script-market-guance-aliyun-billing-by-instance/)
- Collector——[Tencent Cloud - Cloud Billing (Instance Level)](https://func.guance.com/doc/script-market-guance-tencentcloud-billing-by-instance/)
- Collector——[Huawei Cloud - Cloud Billing (Instance Level)](https://func.guance.com/doc/script-market-guance-huaweicloud-billing-by-instance/)
- Collector——[AWS - Cloud Billing (Instance Level)](https://func.guance.com/doc/script-market-guance-aws-billing-by-instance/)
- Collector——[Microsoft Azure - Cloud Billing (Instance Level)](https://func.guance.com/doc/script-market-guance-azure-billing-by-instance/)
- Collector——[VolcEngine - Cloud Billing (Instance Level)](https://func.guance.com/doc/script-market-guance-volcengine-billing-by-instance/)

## Explorer

![](img/bill-intelligent-detection-2.png)

## Cloud Billing Analysis

![](img/bill-intelligent-detection-3.png)

## Intelligent Monitoring for Cloud Billing

Through intelligent algorithms, it automatically [detects](../monitoring/intelligent-monitoring/cloud-bill-detection.md) abnormal account billing expenses across different cloud vendors.