# Command Line Interface

## 介绍

Guance 命令行接口（Command-Line Interface）是一个跨平台命令行工具，用于连接到观测云并在观测云上执行资源管理操作。它同样适用于将各种第三方生态的内容，导入到观测云平台进行统一管理。

在实际的云服务交互场景中，有三种方式可以与 SaaS 平台交互：

- 命令式 API 和工具：使用操作谓词来解释如何操作特定资源，例如包括 RESTFul 和指令动作。    
- 声明式 API 和工具：则仅描述所需的资源。具体操作由平台或工具通过分析当前状态自动计算并执行。    
- 交互式工具：则旨在通过与用户的互动，推动用户逐步实现其目标。例如 API 调试器允许用户不断调整参数并启动请求，直到达到预期结果。   

CLI 是 SaaS 供应商至关重要的开发者工具，它取代了 GUI 作为用户交互的另一个界面。CLI 通常用于解决软件的自动化问题，实现自动化的命令式操作，例如通过编写脚本调用 CLI 来实现自动化运维的**最后一公里**。

Guance CLI 目前支持以下三种命令式操作：

- 资源导入工具：用于将第三方生态的内容，导入到观测云统一管理（例如导入 Grafana 仪表板到观测云）。  
- 数据上传工具：用于将一次性数据（例如单一数据文件，持续集成产物等）上报到观测云（例如上传测试数据等）。  
- 安装工具：用于一键安装观测云生态的各个组件。  

如果您希望开始体验 Guance CLI 的能力，请打开下方**使用场景**，启动交互式指南，进行在线实验；或参考 GitHub 主页中的安装方式进行安装。

## 使用场景

### 使用 CLI 导入 Grafana 仪表板到观测云

Grafana 是一款流行的开源数据可视化工具，可以从多种数据源导入数据并进行可视化。它支持多种图表类型，如线图、柱状图、散点图、热力图等，通过直观的图表呈现方式，帮助用户更好地理解数据的变化趋势和分布情况，并进行数据分析和决策。

Guance CLI 支持将 Grafana 中的仪表板导出成为观测云平台所支持的格式，以便导入到观测云。同时还可以导出 Terraform 文件以便于进行大规模的项目集成。

### 使用方法

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; 观测云 Grafana Importer - 在线实验室</font>](https://killercoda.com/guance-cloud/course/official/grafana-importer)

<br/>

</div>


### 使用限制

以下使用限制如对您的使用造成困扰，请参考下方反馈渠道与我们联系，获取 1v1 支持。

:material-numeric-1-circle-outline: 部分 Panel 格式不支持

当前支持的 panel 类型共有 10 种，包括两种已废弃的类型（为了兼容旧仪表板）。

如您期望的 panel 未被支持，可及时与我们联系。

:material-numeric-2-circle-outline: 部分模版变量语法不支持

Grafana PromQL 仪表板的 PromQL 查询将翻译成观测云的 DQL 查询， 但目前仅支持翻译 `label_values` 的非嵌套表达式函数，其它函数如 `query_result` 会转为空查询。

:material-numeric-3-circle-outline: PromQL 结果不支持简写

PromQL 的 series 名称根据查询自动生成，不支持简写（类似 DQL 中的 as 关键字）。

### 反馈渠道

https://github.com/GuanceCloud/guance-cli/issues