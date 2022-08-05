# Scheck 版本历史

## 1.0.8 （2022/03/11）
### 发布说明

脚本相关：
  无

新功能相关：

- 添加scheck [系统脚本黑名单](scheck-configure.md#不想使用系统规则如何操作)

## 1.0.7（2021/12/7）

### 发布说明

代码相关

- 增加14个nginx巡检规则
- 修复之前个别manifest文件说明错误
- luastatus命令增加间隔时长字段
- 开发者模式在1.0.6基础上增加功能：在该模式下 所有的规则统一为每五分钟执行一次。日志级别自动降为`debug`

## 1.0.6（2021/11/19）

### 发布说明

代码相关
- 上报信息到datakit时带上version信息和input信息
- 增加readme-en，[github](https://github.com/DataFlux-cn/scheck) 上下载代码可编译
- 增加文档 [如何使用lua标准库和lua-lib](lualib.md)
- 修复部分规则bug
- 增加开发者模式 可查看运行时期内存、cpu、lua缓存情况，默认关闭，后续功能待补充完善，参考文档: [怎么使用开发者模式查看缓存](cachedev.md)

## 1.0.5（2021/11/03）

### 发布说明

代码相关
- 新增 容器相关的[go-openlib](funcs.md#容器相关（container）)接口函数
- 增加21个容器相关脚本规则
- 优化单元测试：有特定的环境需求时可使用mock进行测试

脚本相关：
- 增加[k8s相关:kube-apiserver,kubelet,etcd检测脚本](0400-k8s-node-conf-priv.md)
- 增加[docker相关：container启动命令，container列表等检测脚本](0310-docker-runlike.md)

----

## 1.0.4（2021/10/14）

### 发布说明

- 修复 scheck 安装后 version 等文件权限混乱
- 修复 datakit 无法上报信息时导致的规则运行异常
- 调整 lua 引用 golang lib [使用方式](funcs.md)
- 调整命令 `-luastatus` 后不再生成本地的 html 文件和 md 文件
- 调整数据类型文件（密码库）移动至当前目录下的 `data` 中，不再随进程重启而覆盖
- 新增用户[规则ID规范](custom-how-to.md#lua规则命名规范)检测 
- 新增删除缓存和删除全局缓存[方法](funcs.md#del_cache)
- 内存使用优化
- lua 规则运行平滑性优化

安全监测脚本相关：

- 增加[crontab 检测脚本](0142-crontab-add.md)
- [加强用户检测频率](0001-user-add.md)（从轮询形式变成实时监听）

----

## 1.0.3（2021/09/27）

### 发布说明

- 修复 fsnotify manifest 文件错误。

----

## 1.0.2（2021/09/23）

### 发布说明

本次发布对 Scheck 做了较大的调整，主要涉及性能、稳定性方面。

- 内存 性能优化
- 调整文件监听检测方式，替换原来文件缓存的形式
- 规则脚本除了间歇运行方式，增加一种常驻运行分类，后者常用于监听类场景,如:[文件变更](funcs.md#sc_path_watch) 等。
- 增加 Lua 脚本执行超时控制
- 增加 Lua 运行的[统计信息](scheck-how-to.md#c5609495)
- 增加命令行 `-check` [功能](scheck-how-to.md#c5609495)

----

## v1.0.0-67-gd445240（2021/8/27）
### 发布说明

脚本相关：

- 添加多个容器检测脚本

新功能相关：

- 修改了scheck 配置
- 添加阿里云日志对接
- 添加自定义rule路径和用户自定义lua.libs路径
- 添加cgroup功能
- 用户自定义rule脚本自动更新功能
- windows的powershell安装和linux环境下的shell安装
- 服务第一次启动时发送info信息
- output支持多端发送信息

优化相关：
- cpu 性能优化
- 语雀文档重构

----

## v1.0.1-67-gd445240（2021/6/18）
### 发布说明

脚本相关：

- 添加mysql 弱密码扫描

新功能相关：

- 添加3个func

----

## v1.0.1-62-g7715dc6
### 发布说明

本次发布，对Security Checker 操作层面名称统一确认为scheck。修改了相关bug

脚本相关：

- 修改了desc内容间隔
- 调整脚本的执行频率

新功能相关：

- 添加scheck 自身md5选项

### Bug 修复

- 优化脚本运行性能


%!(EXTRA string=1.0.7-4-g582a075, string=2022-08-05 03:12:31)