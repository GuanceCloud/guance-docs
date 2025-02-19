---
title: 'Zadigx'
summary: 'Zadigx 展示包括概览、自动化构建、自动化部署、自动化测试等指标。'
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

Zadigx  展示包括概览、自动化构建、自动化部署、自动化测试等指标。



## 配置 {#config}

### 安装 Func

推荐开通 观测云集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

> 推荐部署GSE版



### 安装脚本

> 提示：请提前准备好符合要求的 Zadigx API Token

同步 Zadigx 监控数据，我们安装对应的采集脚本：「观测云集成（Zadigx 数据采集）」(ID：`guance_zadig`)

点击【安装】后在创建的 `start up` 的 zadigx 的采集脚本中更改 `private_token` 填入您的 API Token

开启后可以在「管理 / 自动触发配置」里看到对应的自动触发配置。点击【执行】，即可立即执行一次，无需等待定期时间。稍等片刻，可以查看执行任务记录以及对应日志。


我们默认采集了一些配置, 具体见指标一栏




### 验证

1. 在「管理 / 自动触发配置」确认对应的任务是否已存在对应的自动触发配置，同时可以查看对应任务记录及日志检查是否有异常
2. 在观测云平台，「指标」查看是否有对应监控数据

## 指标 {#metric}
配置好 Zadigx 监控, 默认的指标集如下

| 指标         |        指标名称        | 单位         |
| ---- | :----: | ---- |
| `zadig_overview_project_count` |         项目数量        | 个       |
| `zadig_overview_cluster_count` |     集群数量     | 个      |
| `zadig_overview_service_count` |  服务数量 | 个       |
| `zadig_overview_workflow_count` |  工作流数量 | 个           |
| `zadig_overview_env_count` |    环境数量   | 个      |
| `zadig_overview_artifact_count` |    交付物数量   | 个       |
| `zadig_test_case_count` |       自动化测试用例数量      | 个        |
| `zadig_test_exec_count` |       自动化测试执行数量       | 次        |
| `zadig_test_average_runtime` | 自动化测试执行平均时长 | 秒       |
| `zadig_build_success` |     自动化构建成功数     | 次        |
| `zadig_build_failure` |      自动化构建失败数      | 次       |
| `zadig_build_total` | 自动化构建数 | 次           |
| `zadig_deploy_success` | 自动化部署成功数 | 次           |
| `zadig_deploy_failure` | 自动化部署失败数 | 次           |
| `zadig_deploy_total` |     自动化部署数     | 次           |
| `zadig_test_success_count` | 自动化测试成功数 | 次          |
| `zadig_test_timeout_count` |     自动化测试超时数     | 次           |
| `zadig_test_failed_count` | 自动化测试失败数 | 次           |
