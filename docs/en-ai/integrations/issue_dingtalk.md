---
title: 'Incident - DingTalk'
summary: 'Guance Incident is deeply integrated with DingTalk, making it convenient to send incident information to DingTalk and reply through DingTalk, which will be transmitted back to Guance'
__int_icon: 'icon/dingtalk'
dashboard:
  - desc: 'None'
    path: ''
monitor:
  - desc: 'None'
    path: ''
---

<!-- markdownlint-disable MD025 -->
# Incident - DingTalk
<!-- markdownlint-enable -->

Guance Incident is deeply integrated with DingTalk, making it convenient to send incident information to DingTalk and reply through DingTalk, which will be transmitted back to Guance.

---

## Configuration {#config}

### Prerequisites

You need management permissions for both the "Guance Workspace" and the "DingTalk Open Platform".

### Install Func

We recommend enabling the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-hosted Func Deployment](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version.

### Install Script

In the script market, install the corresponding collection script: "Guance Integration (Guance Incident - DingTalk)" (ID: `guance_issue_dingtalk`) to enable it.

For easier maintenance of documentation, please perform operations at [DingTalk Integration Configuration](https://func.guance.com/doc/script-market-guance-issue-dingtalk-integration/)