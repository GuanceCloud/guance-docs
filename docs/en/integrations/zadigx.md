---
title: 'Zadigx'
summary: 'Zadigx displays metrics including Overview, Automated Build, Automated Deployment, and Automated Testing.'
__int_icon: 'icon/zadigx'
dashboard:
  - desc: 'Zadigx'
    path: 'dashboard/en/zadigx/'

monitor:
  - desc: 'Zadigx'
    path: 'monitor/en/zadigx/'
---


<!-- markdownlint-disable MD025 -->
# Zadigx
<!-- markdownlint-enable -->

Zadigx displays metrics including Overview, Automated Build, Automated Deployment, and Automated Testing.



## Configuration {#config}

### Install Func

It is recommended to enable Guance integration - Extension - Managed Func: all prerequisites are automatically installed. Please continue with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> It is recommended to deploy the GSE version.



### Installation Script

> Note: Please prepare a qualified Zadigx API Token in advance.

To synchronize Zadigx monitoring data, we install the corresponding collection script: "Guance Integration (Zadigx Data Collection)" (ID: `guance_zadig`)

After clicking 【Install】, modify the `private_token` in the startup zadigx collection script created and enter your API Token.

Once enabled, you can see the corresponding automatic trigger configuration under "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.


We collect some configurations by default, for details, please refer to the Metrics section.




### Verification

1. In "Manage / Automatic Trigger Configuration", confirm whether the corresponding task has the corresponding automatic trigger configuration, and check the task records and logs for any abnormalities.
2. On the Guance platform, under "Metrics", check if there are corresponding monitoring data.

## Metrics {#metric}
After configuring Zadigx monitoring, the default Measurement set is as follows

| Metric         |        Metric Name        | Unit         |
| ---- | :----: | ---- |
| `zadig_overview_project_count` |         Project Count        | Units       |
| `zadig_overview_cluster_count` |     Cluster Count     | Units      |
| `zadig_overview_service_count` |  Service Count | Units       |
| `zadig_overview_workflow_count` |  Workflow Count | Units           |
| `zadig_overview_env_count` |    Environment Count   | Units      |
| `zadig_overview_artifact_count` |    Artifact Count   | Units       |
| `zadig_test_case_count` |       Automated Test Case Count      | Units        |
| `zadig_test_exec_count` |       Automated Test Execution Count       | Times        |
| `zadig_test_average_runtime` | Automated Test Execution Average Duration | Seconds       |
| `zadig_build_success` |     Automated Build Success Count     | Times        |
| `zadig_build_failure` |      Automated Build Failure Count      | Times       |
| `zadig_build_total` | Automated Build Count | Times           |
| `zadig_deploy_success` | Automated Deployment Success Count | Times           |
| `zadig_deploy_failure` | Automated Deployment Failure Count | Times           |
| `zadig_deploy_total` |     Automated Deployment Count     | Times           |
| `zadig_test_success_count` | Automated Test Success Count | Times          |
| `zadig_test_timeout_count` |     Automated Test Timeout Count     | Times           |
| `zadig_test_failed_count` | Automated Test Failure Count | Times           |