---
title: 'Zadigx'
summary: 'Zadigx displays metrics including Summary, automated builds, automated deployments, and automated testing.'
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

Zadigx displays metrics including Summary, automated builds, automated deployments, and automated testing.



## Configuration {#config}

### Install Func

We recommend enabling the Guance integration - Extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with the script installation.

If you deploy Func on your own, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> We recommend deploying the GSE version



### Installation Script

> Note: Please prepare a valid Zadigx API Token that meets the requirements in advance.

To sync Zadigx monitoring data, we install the corresponding collection script: 「Guance Integration (Zadigx Data Collection)」(ID: `guance_zadig`)

After clicking 【Install】, modify the `private_token` in the created `start up` Zadigx collection script and enter your API Token.

Once enabled, you can see the corresponding automatic trigger configuration under 「Management / Automatic Trigger Configuration」. Click 【Execute】to run it immediately without waiting for the scheduled time. Wait a moment, then you can view the execution task records and corresponding logs.


By default, we collect some configurations; see the Metrics section for details.




### Verification

1. In 「Management / Automatic Trigger Configuration」, confirm that the corresponding tasks have the automatic trigger configuration set up, and check the task records and logs for any anomalies.
2. On the Guance platform, go to 「Metrics」to check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Zadigx monitoring, the default Mearsurement set is as follows:

| Metric                          | Metric Name                  | Unit |
| ------------------------------- | ---------------------------- | ---- |
| `zadig_overview_project_count`  | Project Count                | Count|
| `zadig_overview_cluster_count`  | Cluster Count                | Count|
| `zadig_overview_service_count`  | Service Count                | Count|
| `zadig_overview_workflow_count` | Workflow Count               | Count|
| `zadig_overview_env_count`      | Environment Count            | Count|
| `zadig_overview_artifact_count` | Artifact Count               | Count|
| `zadig_test_case_count`         | Automated Test Case Count    | Count|
| `zadig_test_exec_count`         | Automated Test Execution Count | Times|
| `zadig_test_average_runtime`    | Average Runtime of Automated Tests | Seconds|
| `zadig_build_success`           | Successful Automated Builds  | Times|
| `zadig_build_failure`           | Failed Automated Builds      | Times|
| `zadig_build_total`             | Total Automated Builds       | Times|
| `zadig_deploy_success`          | Successful Automated Deployments | Times|
| `zadig_deploy_failure`          | Failed Automated Deployments | Times|
| `zadig_deploy_total`            | Total Automated Deployments  | Times|
| `zadig_test_success_count`      | Successful Automated Tests   | Times|
| `zadig_test_timeout_count`      | Timeout Automated Tests      | Times|
| `zadig_test_failed_count`       | Failed Automated Tests       | Times|
|                                |                              |      |