---
title     : 'Grafana Dashboard Import'
summary   : 'Grafana Dashboard 模版导入观测云工具'
__int_icon: 'icon/grafana_import'
---

<!-- markdownlint-disable MD025 -->
# Grafana Dashboard 导入工具
<!-- markdownlint-enable -->

观测云目前提供 grafana dashboard 模版转换为观测云仪表板模版的 node 脚本

## 配置 {#config}

### 前置条件 {#requirement}

需要在系统中安装 `nodejs`、`npm`,版本要求如下：

- [x]  node >= 12.7.0
- [x]  npm >= 6.10.0

### 使用方式

- 1 安装脚本

```bash
npm install -g @cloudcare/guance-front-tools
```

- 2 查看脚本使用帮助

<!-- markdownlint-disable MD014 -->
```bash
grafanaCovertToGuance
```
<!-- markdownlint-enable -->

具体脚本执行命令如下：
`-d`: grafana json 文件的目录位置，例如：`./grafana/json/grafana.json`
`-o`: 观测云仪表板 json 文件的输出位置，例如: `./guance/json/guance.json`

- 3 执行转换命令

<!-- markdownlint-disable MD014 -->
```bash
grafanaCovertToGuance -d ./grafana/json/grafana.json -o ./guance/json/guance.json
```
<!-- markdownlint-enable -->
- 4 在观测云控制台导入转换后的`json`文件

- 5 完成
