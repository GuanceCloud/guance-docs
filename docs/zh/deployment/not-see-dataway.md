## 创建了 DataWay 为什么在前台看不到
### 常见原因分析
如下图所示：
![](img/not_see_dataway_1.jpg)
-       `Dataway` 服务部署到服务器上之后并未正常运行。
-       `Dataway` 服务配置文件错误，未配置对正确的监听、工作空间 `token` 信息。
-       `Dataway` 服务运行配置错误，具体可以通过查看 `dataway` 日志定位。
-       之前部署初始化的时候，没有重启 `redis` 清空缓存。
-       部署 `Dataway` 的服务器无法与 `kodo` 服务通信。（包括 `dataway` 服务器并未在 `hosts` 中添加 `df-kodo` 服务的正确解析）
-       `kodo` 服务异常，具体可通过查看kodo 服务日志进行确认。
-       `df-kodo ingress` 服务未正确配置。具体表现为无法访问 `http|https://df-kodo.<xxxx>:<port>`
