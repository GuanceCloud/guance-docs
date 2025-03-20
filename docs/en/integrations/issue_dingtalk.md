---
title: 'Incident - DingTalk'
summary: '<<< custom_key.brand_name >>> Incident is deeply integrated with DingTalk, making it convenient to send incident information to DingTalk and reply via DingTalk, which can then be transmitted back to <<< custom_key.brand_name >>>'
__int_icon: 'icon/dingtalk'
dashboard:
  - desc: 'None for now'
    path: ''
monitor:
  - desc: 'None for now'
    path: ''
---

<!-- markdownlint-disable MD025 -->
# Incident - DingTalk
<!-- markdownlint-enable -->

<<< custom_key.brand_name >>> Incident is deeply integrated with DingTalk, making it convenient to send incident information to DingTalk and reply via DingTalk, which can then be transmitted back to <<< custom_key.brand_name >>>.

---

## Configuration {#config}

### Prerequisites

You need management permissions for both the "<<< custom_key.brand_name >>> Workspace" and the "DingTalk Open Platform."

### Install Func

It is recommended to enable the <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites will be automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version.

### Install Script

In the script market, install the corresponding collection script: "<<< custom_key.brand_name >>> Integration (<<< custom_key.brand_name >>> Incident-DingTalk)" (ID: `guance_issue_dingtalk`) to activate.

For easier documentation maintenance, please navigate to [DingTalk Integration Configuration](https://<<< custom_key.func_domain >>>/doc/script-market-guance-issue-dingtalk-integration/) for the operation.