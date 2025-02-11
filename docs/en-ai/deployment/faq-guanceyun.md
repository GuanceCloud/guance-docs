## 1 What to Do if Issues Occur During Initial Installation and You Need to Clean Up and Reinstall
**Note: This applies only to scenarios where issues occur during the initial installation, requiring a complete removal before reinstalling. Please confirm carefully before executing the following cleanup steps!**

If you encounter installation issues and need to remove everything before reinstalling, you must clean up the following three areas in order to reinstall Guance from the Launcher:
### 1.1 Cleanup of Installed Guance Application Services
Clean up various installed Guance application services in Kubernetes. On the operations machine, enter the Launcher container and execute the built-in cleanup script of Launcher:
```
kubectl exec -it launcher-xxxxxxxx-xxx -n launcher /bin/bash
```
**launcher-xxxxxxxx-xxx is the name of your Launcher service pod!**
Once inside the container, you can find the `k8s-clear.sh` script (`/config/tools/k8s-clear.sh`) provided by the Launcher service. Execute this script to clean up all Guance application services and k8s resources:

```shell
sh /config/tools/k8s-clear.sh
```

### 1.2 Cleanup of Automatically Created MySQL Databases
You can enter the Launcher container, which includes the MySQL client tool, and use the following command to connect to the Guance MySQL instance:
```shell
mysql -h <MySQL instance host> -u root -P <MySQL port> -p  
```
You need to connect using a MySQL administrator account. After connecting, execute the following six MySQL database and user cleanup commands:
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

## 2 How to Configure Guance to Use OceanBase Database
Whether it's a cloud provider's PaaS service or a self-built OceanBase, you can configure it into the Launcher as follows. Enter the following information during the initial deployment.
```yaml
# Example for self-built setup
MySQL HOST: svc-obproxy.oceanbase.svc.cluster.local
Port: 2883
Admin Account: croot@guance
Admin Password: root_password
# MySQL HOST: In this example, it is a self-built service accessed via obproxy. Here, you should fill in the obproxy svc name. Alternatively, you can directly use the obcluster svc name without obproxy. Whether to use obproxy can be controlled by configuration files during deployment; if it's a cloud provider's PaaS service, simply fill in the PaaS address.

# Admin account format: user@tenant#cluster_name 
user: username
tenant: tenant name
cluster_name: cluster name (optional)
```
When using OceanBase with Guance applications, you need to set the `open_cursors` parameter of OceanBase. Execute the following command:
```sql
# This parameter is global. If the provided PaaS OceanBase is shared among multiple tenants, ensure that adjusting this parameter does not affect other tenants.
ALTER SYSTEM SET open_cursors = 200;
```