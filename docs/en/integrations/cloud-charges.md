---
title: 'Cloud Billing Cost Inquiry'
summary: 'Cloud billing cost inquiry, which can query public cloud billing information from AWS, Huawei Cloud, Alibaba Cloud, Tencent Cloud, etc.'
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

Cloud billing cost inquiry, which can query public cloud billing information from AWS, Huawei Cloud, Alibaba Cloud, Tencent Cloud, etc.


## Configuration {#config}

### Install Func

We recommend enabling the Guance Integration - Extensions - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Install Script

- Enter the corresponding script market, select **Official Script Market**, click **Enter**, and enter **billing** in the top-right corner.
- Choose the corresponding cloud billing, such as for **AWS**, select **Guance Integration (AWS-Billing Collection-Instance Level)**, and click the **Install** button.
- Fill in the authentication information in the pop-up box and click **Deploy and Start Script**.
- Click to go to **Automatic Trigger Configuration**, find the corresponding function, and click **Execute**.

The script is limited to running once a day, meaning it retrieves the billing information once daily.

### View Dashboard

Go to the Guance console, select **Use Cases**, **Create Dashboard**, search for **Billing Analysis Monitoring View**, click **Billing Analysis Monitoring View**, and click the **Confirm** button.

Adjust the time to `3d` to view the billing information.
