---
title: 'Cloud Billing Cost Inquiry'
summary: 'Cloud billing cost inquiry, which can query billing information from public clouds such as AWS, Huawei Cloud, Alibaba Cloud, Tencent Cloud, etc.'
__int_icon: 'icon/asset/'
dashboard:
  - desc: 'Billing Analysis Monitoring View'
    path: 'dashboard/en/asset/'
monitor:
  - desc: 'No'
    path: '-'
---

<!-- markdownlint-disable MD025 -->
# Cloud Billing Cost Inquiry
<!-- markdownlint-enable -->
---

Cloud billing cost inquiry, which can query billing information from public clouds such as AWS, Huawei Cloud, Alibaba Cloud, Tencent Cloud, etc.

## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Script Installation

- Enter the corresponding script market, select **Official Script Market**, click **Enter**, and type **billing** in the top-right corner.
- Choose the corresponding cloud billing, for example, if integrating **AWS**, select **Guance Integration (AWS-Billing Collection-Instance Level)**, and click the **Install** button.
- Fill in the authentication information in the pop-up box and click **Deploy and Start Script**.
- Click **Go to Automatic Trigger Configuration**, find the corresponding function, and click **Execute**.

The script is configured to run once a day, retrieving the billing information once daily.

### View Dashboard

Go to the Guance console, select **Scenarios**, **Create New Dashboard**, search for **Billing Analysis Monitoring View**, click **Billing Analysis Monitoring View**, and click the **Confirm** button.

Set the time range to `3d` to view the billing information.