---
icon: zy/dataflux-func
---

# DataFlux Func
---

DataFlux Func 是一个基于 Python 的脚本开发、管理、执行平台。是[{{{ custom_key.brand_name }}}](https://guance.com/)下属的一个函数计算组件，目前已成为可独立运行的系统。

主要分为 2 个部分：

- Server：使用 Node.js + Express 构建，主要提供 Web UI 服务、对外 API 接口。
- Worker：使用 Python3 + Celery 构建，主要提供 Python 脚本的执行环境（内含 Beat 模块）。

