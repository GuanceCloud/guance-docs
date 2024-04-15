---
title: 'Zadigx'
summary: 'ZadigX is a cloud-native DevOps value chain platform developed by KodeRover based on Kubernetes.'
__int_icon: 'icon/zadigx'
dashboard:
  - desc: 'Zadigx'
    path: 'dashboard/zh/zadigx/'

monitor:
  - desc: 'Zadigx'
    path: 'monitor/zh/zadigx/'
---


<!-- markdownlint-disable MD025 -->
# Zadigx
<!-- markdownlint-enable -->

Zadigx showcases, including overview, automated build, automated deployment, automated testing, etc.



## Config {#config}

### Install Func

Recommend opening 「Integrations - Extension - DataFlux Func (Automata)」: All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> GSE edition is recommended



### Installation script

> Note: Please prepare a Zadigx API Token that meets the requirements in advance.

To synchronize Zadigx monitoring data, we need to install the corresponding collection script:「Guance Integration（**Zadig** dataCollect）」(ID：`guance_zadig`)

Click "Install" and modify the `private_token` in the created "start up" collection script for **zadigx** to your API Token.

You can see the corresponding auto-trigger configuration in "Management / Auto-trigger Configuration" after you turn it on. Click "Execute" to execute the task immediately without waiting for the regular time. Wait for a while, you can check the record and log of the executed task.


We have collected some default configurations. Please refer to the metric for details.




### Verify

1. In「Management / Crontab Config」check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist.
2. On the observation cloud platform, press 「Metrics」 to check whether monitoring data exists.

## Metric {#metric}
After configuring Zadigx monitoring, the default set of metrics is as follows:

| **Metric** |        **Metric Name**        | **Unit** |
| ---- | :----: | ---- |
| `zadig_overview_project_count` | `Number of Projects`     | `Count` |
| `zadig_overview_cluster_count` |     `Number of Clusters`     | `Count` |
| `zadig_overview_service_count` | `Number of Services` | `Count` |
| `zadig_overview_workflow_count` | `Number of Workflows` | `Count`    |
| `zadig_overview_env_count` | `Number of Environments` | `Count` |
| `zadig_overview_artifact_count` | `Number of Artifacts` | `Count` |
| `zadig_test_case_count` | `Number of Automated Test Cases`    | `Count` |
| `zadig_test_exec_count` |       `Number of Automated Test Executions`       | `Count` |
| `zadig_test_average_runtime` | `Average Runtime of Automated Tests` | `S`     |
| `zadig_build_success` |     `Number of Successful Automated Builds`     | `Count` |
| `zadig_build_failure` |      `Number of Failed Automated Builds`      | `Count` |
| `zadig_build_total` | `Total Number of Automated Builds` | `Count`    |
| `zadig_deploy_success` | `Number of Successful Automated Deployments` | `Count`    |
| `zadig_deploy_failure` | `Number of Failed Automated Deployments` | `Count`    |
| `zadig_deploy_total` |     `Total Number of Automated Deployments`     | `Count`    |
| `zadig_test_success_count` | `Number of Successful Automated Tests` | `Count`   |
| `zadig_test_timeout_count` |     `Number of Automated Test Timeouts`     | `Count`    |
| `zadig_test_failed_count` | `Number of Failed Automated Tests` | `Count`    |
