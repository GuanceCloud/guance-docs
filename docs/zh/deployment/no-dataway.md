## 常见原因分析


-       Dataway 服务部署到服务器上之后并未正常运行。
-       Dataway 服务配置文件错误，未配置对正确的监听、工作空间token信息。
-       Dataway 服务运行配置错误，具体可以通过查看dataway 日志定位。
-       部署Dataway 的服务器无法与 kodo 服务通信。（包括dataway服务器并未在hosts中添加df-kodo 服务的正确解析）
-       kodo 服务异常，具体可通过查看kodo 服务日志进行确认。
-       df-kodo ingress 服务未正确配置。具体表现为无法访问 `http|https://df-kodo.<xxxx>:<port>`


