---
title: 'Zadigx'
summary: 'Zadigx displays metrics including Overview, automated builds, automated deployments, and automated testing.'
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

Zadigx displays metrics including Overview, automated builds, automated deployments, and automated testing.



## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version



### Installation Script

> Note: Please prepare a qualified Zadigx API Token in advance

To synchronize Zadigx monitoring data, we install the corresponding collection script: 「Guance Integration (Zadigx Data Collection)」(ID: `guance_zadig`)

After clicking 【Install】, modify the `private_token` in the created `start up` Zadigx collection script and enter your API Token.

Once enabled, you can see the corresponding automatic trigger configuration under 「Manage / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.


By default, we collect some configurations; see the Metrics section for details.




### Verification

1. In 「Manage / Automatic Trigger Configuration」confirm that the corresponding tasks have the matching automatic trigger configurations. You can also check the task records and logs for any anomalies.
2. On the Guance platform, under 「Metrics」check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Zadigx monitoring, the default Measurement set is as follows

| Metric         |        Metric Name        | Unit         |
| ---- | :----: | ---- |
| `zadig_overview_project_count` |         Project Count        | Count       |
| `zadig_overview_cluster_count` |     Cluster Count     | Count      |
| `zadig_overview_service_count` |  Service Count | Count       |
| `zadig_overview_workflow_count` |  Workflow Count | Count           |
| `zadig_overview_env_count` |    Environment Count   | Count      |
| `zadig_overview_artifact_count` |    Artifact Count   | Count       |
| `zadig_test_case_count` |       Automated Test Case Count      | Count        |
| `zadig_test_exec_count` |       Automated Test Execution Count       | Times        |
| `zadig_test_average_runtime` | Average Duration of Automated Test Execution | Seconds       |
| `zadig_build_success` |     Successful Automated Builds     | Times        |
| `zadig_build_failure` |      Failed Automated Builds      | Times       |
| `zadig_build_total` | Total Automated Builds | Times           |
| `zadig_deploy_success` | Successful Automated Deployments | Times           |
| `zadig_deploy_failure` | Failed Automated Deployments | Times           |
| `zadig_deploy_total` |     Total Automated Deployments     | Times           |
| `zadig_test_success_count` | Successful Automated Tests | Times          |
| `zadig_test_timeout_count` |     Timed-out Automated Tests     | Times           |
| `zadig_test_failed_count` | Failed Automated Tests | Times           |