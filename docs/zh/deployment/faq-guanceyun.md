
## 1 初次安装发生问题，需要清理后重新安装怎么办！
**注意：仅限初次安装时发生问题，需要铲除重新安装的场景，请仔细确认后再执行此以下清理步骤！**

如果发生安装问题，需要全部铲除后重新安装，需要清理以下三个地方，才可以从 Launcher 开始重新安装{{{ custom_key.brand_name }}}：
### 1.1 清理已安装的{{{ custom_key.brand_name }}}应用服务
清理 Kubernetes 中已安装的各种{{{ custom_key.brand_name }}}应用服务，可以在运维操作机上，进入 Launcher 容器，执行 Launcher 自带的清理脚本：
```
kubectl exec -it launcher-xxxxxxxx-xxx -n launcher /bin/bash
```
**launcher-xxxxxxxx-xxx 为您的 launcher 服务 pod 名称！**
进入容器后，可以看到 Launcher 服务自带的 k8s-clear.sh（`/config/tools/k8s-clear.sh`）脚本，执行此脚本，将清理所有{{{ custom_key.brand_name }}}应用服务及 k8s 的资源：

```shell
sh /config/tools/k8s-clear.sh
```

### 1.2 清理 MySQL 中自动创建的数据库
可以进入 Launcher 容器，Launcher 容器中自带了 mysql 客户端工具，使用以下命令连接到{{{ custom_key.brand_name }}}MySQL 实例：
```shell
mysql -h <mysql 实例 host> -u root -P <mysql 端口> -p  
```
需要使用 mysql 管理员账号连接，连接后，执行以下 6 个 MySQL 数据库及用户清理命令：
```sql
drop database df_core;
drop user df_core;
drop database df_message_desk;
drop user df_message_desk;
drop database df_func;
drop user df_func;
drop database df_dialtesting;
drop user df_dialtesting;
```

## 2 {{{ custom_key.brand_name }}}使用Oceanbase数据库该如何配置
无论是云厂商的PaaS服务，还是自搭建的Oceanbase。都可以按照以下方式配置到launcher中，初次部署时将以下信息填入。
```yaml
# 自搭建为例
MySQL HOST: svc-obproxy.oceanbase.svc.cluster.local
端口: 2883
管理员账号: croot@guance
管理员密码: root_password
# MySQL HOST: 本案例是自搭建服务，通过obproxy代理，此处填写的是obproxy的svc名称。也可以不通过
obproxy代理，填写obcluster的svc名称。是否使用obproxy可以通过部署阶段配置文件控制；如果是客户提供
的云厂商PaaS能力，直接填写PaaS地址。

# 管理员账号格式为： user@tenant#cluster_name 
user: 用户名
tenant: 租户名
cluster_name: 集群名，可以省略
```
{{{ custom_key.brand_name }}}应用在使用 OceanBase 时，需要设置 OceanBase 的 open_cursors 参数，执行以下命令
```sql
# 该参数是全局参数，如果客户提供 PaaS OceanBase 是多租户共用，请确定该参数调整是否对其他租户有影响。
ALTER SYSTEM SET open_cursors = 200;
```
