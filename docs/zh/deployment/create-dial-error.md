
## 新建拨测节点报错 SSL: WRONG_VERSION_NUMBER] wrong version number (_ssl.c:1131)
新建拨测节点时报错
![](img/create-dial-error-1.png)
查看forethought-core命名空间下的forethought-backend服务日志有如下报错
![](img/create-dial-error-2.png)
解决方案：
launcher中【修改应用配置】菜单，修改dialtesting配置，将internal_server处配置的地址值协议从https改为http。
![](img/create-dial-error-3.png)

