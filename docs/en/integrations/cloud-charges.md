---
title: 'Cloud Billing Cost Query'
summary: 'Cloud billing cost query, which can retrieve billing information from public clouds such as AWS, Huawei Cloud, Alibaba Cloud, and Tencent Cloud.'
__int_icon: 'icon/cloud_billing/'
dashboard:
  - desc: 'Cloud billing analysis view'
    path: 'dashboard/en/Intelligent_analysis_cloud_billing/'
monitor:
  - desc: 'No'
    path: '-'

---

<!-- markdownlint-disable MD025 -->
# Cloud Billing Cost Query
<!-- markdownlint-enable -->
---

Cloud billing cost query, which can retrieve billing information from public clouds such as AWS, Huawei Cloud, Alibaba Cloud, and Tencent Cloud.


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Script Installation

- Enter the corresponding script market, select **Official Script Market**, click **Enter**, and input **billing** in the upper-right corner.
- Select the corresponding cloud billing, for example, if integrating **AWS**, choose **Guance Integration (AWS-Billing Collection-Instance Level)**, and click the **Install** button.
- Fill in the authentication information in the pop-up box and click **Deploy and Start Script**.
- Click **Go to Automatic Trigger Configuration**, find the corresponding function, and click **Execute**.

The script limits execution to once a day, meaning it retrieves the billing information once daily.

### View Analysis

Go to the Guance console, select **Use Cases**, **Create Dashboard**, search for **Billing Analysis Monitoring View**, click **Billing Analysis Monitoring View**, and click the **Confirm** button.

Adjust the time to `3d` to view the billing information. 

---