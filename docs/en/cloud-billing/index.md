---
icon: zy/cloud-billing
---

# Cloud Billing
---

<<< custom_key.brand_name >>>'s cloud billing feature is a comprehensive solution for cloud cost management and analysis. It integrates multiple functions such as data collection, multi-dimensional analysis, and real-time monitoring, aiming to help enterprises optimize the use of cloud resources and control costs. By efficiently collecting cloud billing data through DataFlux Func (Automata), it ensures the accuracy and real-time nature of the data.

You can use the cloud billing Explorer to conveniently browse and filter cost information from different cloud service providers, thereby achieving a comprehensive understanding of cloud resource consumption.

In addition, <<< custom_key.brand_name >>> provides scene-based Views that allow in-depth analysis of cloud resource consumption, covering all levels from products, regions to instance levels. This enables you to identify hotspots and inefficient areas of resource consumption, and predict future resource needs and cost trends, providing data support for long-term cloud cost planning.

Finally, the intelligent monitoring system for cloud billing provides you with the ability to track service consumption in real time and automatically detect abnormal costs, issuing timely warnings and effectively avoiding unnecessary expenses. Through the effective interaction of these functions, <<< custom_key.brand_name >>>'s cloud billing feature forms a powerful cost and consumption analysis system, helping enterprises achieve fine-grained management of cloud resources and cost optimization.

## Prerequisites {#precondition}

Before starting to use the cloud billing analysis feature and ultimately collecting data for reporting, you need to first go to DataFlux Func (Automata) and enable the following collectors:

- Collector —— [Alibaba Cloud - Cloud Billing (Instance Level)](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aliyun-billing-by-instance/)
- Collector —— [Tencent Cloud - Cloud Billing (Instance Level)](https://<<< custom_key.func_domain >>>/doc/script-market-guance-tencentcloud-billing-by-instance/)
- Collector —— [Huawei Cloud - Cloud Billing (Instance Level)](https://<<< custom_key.func_domain >>>/doc/script-market-guance-huaweicloud-billing-by-instance/)
- Collector —— [AWS - Cloud Billing (Instance Level)](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aws-billing-by-instance/)
- Collector —— [Microsoft Cloud - Cloud Billing (Instance Level)](https://<<< custom_key.func_domain >>>/doc/script-market-guance-azure-billing-by-instance/)
- Collector —— [Volcengine - Cloud Billing (Instance Level)](https://<<< custom_key.func_domain >>>/doc/script-market-guance-volcengine-billing-by-instance/)

## Explorer

![](img/bill-intelligent-detection-2.png)

## Cloud Billing Analysis

![](img/bill-intelligent-detection-3.png)

## Intelligent Monitoring of Cloud Billing


Through intelligent algorithms, it automatically [detects](../monitoring/intelligent-monitoring/cloud-bill-detection.md) abnormal account billing costs across different cloud vendors.
