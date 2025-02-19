---
title: '云账单费用查询'
summary: '云账单费用查询，可以查询 AWS 、华为云、阿里云、腾讯云等公有云账单信息'
__int_icon: 'icon/asset/'
dashboard:
  - desc: '账单分析监控视图'
    path: 'dashboard/zh/asset/'
monitor:
  - desc: 'No'
    path: '-'
---

<!-- markdownlint-disable MD025 -->
# 云账单费用查询
<!-- markdownlint-enable -->
---

云账单费用查询，可以查询 AWS 、华为云、阿里云、腾讯云等公有云账单信息。


## 配置 {#config}

### 安装 Func

推荐开通 {{{ custom_key.brand_name }}}集成 - 扩展 - 托管版 Func: 一切前置条件都自动安装好, 请继续脚本安装。

如果自行部署 Func 参考 [自行部署 Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### 安装脚本

- 进入对于的脚本市场，选择 **官方脚本市场**，点击**进入**，右上角输入 **账单**
- 选择对应的云账单，如接入**AWS**，则选择 **{{{ custom_key.brand_name }}}集成（AWS-账单采集-实例维度）**，点击**安装**按钮
- 弹框填写认证信息，点击**部署启动脚本**
- 点击前往**自动触发配置**,找到对应的函数，点击**执行**

脚本内做了限制，一天执行一次，即一天获取一次费用账单信息。

### 视图查看

前往{{{ custom_key.brand_name }}}控制台，选择 **场景**，**新建仪表板**，搜索**账单分析监控视图**，点击 **账单分析监控视图**，点击**确定**按钮。

将时间调整为`3d`，即可查看账单信息

