---
icon: zy/cloud-billing
---

# Cloud Billing
---

The cloud billing feature of <<< custom_key.brand_name >>> is a comprehensive cloud cost management and analysis solution. It integrates multiple functions such as data collection, multi-dimensional analysis, and real-time monitoring, aiming to help enterprises optimize the use of cloud resources and control costs. By efficiently collecting cloud billing data through DataFlux Func (Automata), it ensures the accuracy and real-time nature of the data.

You can use the cloud billing Explorer to conveniently browse and filter cost information from different cloud service providers, thereby achieving a comprehensive understanding of cloud resource consumption.

Additionally, <<< custom_key.brand_name >>> provides scene-based View functionality, allowing in-depth analysis of cloud resource consumption scenarios, covering various levels from products, regions to instance levels. This enables you to identify hotspots and inefficient areas of resource consumption and predict future resource needs and cost trends, providing data support for long-term cloud cost planning.

Finally, the intelligent monitoring system for cloud billing offers real-time tracking of service consumption and automatic detection of abnormal charges, promptly issuing warnings to effectively avoid unnecessary expenses. Through the effective integration of these features, <<< custom_key.brand_name >>>'s cloud billing function forms a powerful cost and consumption analysis system, helping enterprises achieve refined management and cost optimization of cloud resources.

## Prerequisites {#precondition}

Before using the cloud billing analysis feature and ultimately collecting and reporting data, you need to enable the following collectors on DataFlux Func:

- Collector —— [Alibaba Cloud - Cloud Billing (Instance Level)](https://func.guance.com/doc/script-market-guance-aliyun-billing-by-instance/)
- Collector —— [Tencent Cloud - Cloud Billing (Instance Level)](https://func.guance.com/doc/script-market-guance-tencentcloud-billing-by-instance/)
- Collector —— [Huawei Cloud - Cloud Billing (Instance Level)](https://func.guance.com/doc/script-market-guance-huaweicloud-billing-by-instance/)
- Collector —— [AWS - Cloud Billing (Instance Level)](https://func.guance.com/doc/script-market-guance-aws-billing-by-instance/)
- Collector —— [Microsoft Azure - Cloud Billing (Instance Level)](https://func.guance.com/doc/script-market-guance-azure-billing-by-instance/)
- Collector —— [Volc Engine - Cloud Billing (Instance Level)](https://func.guance.com/doc/script-market-guance-volcengine-billing-by-instance/)

## Explorer

![](img/bill-intelligent-detection-2.png)

## Cloud Billing Analysis

![](img/bill-intelligent-detection-3.png)

## Intelligent Monitoring for Cloud Billing

Through intelligent algorithms, it automatically [detects](../monitoring/intelligent-monitoring/cloud-bill-detection.md) abnormal account billing costs across different cloud providers.