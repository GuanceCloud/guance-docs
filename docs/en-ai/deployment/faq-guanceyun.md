## 1 What to Do If Issues Occur During the First Installation and You Need to Clean Up and Reinstall

**Note: This applies only if issues occur during the first installation and you need to completely remove and reinstall. Please confirm carefully before executing the following cleanup steps!**

If an installation issue occurs and you need to completely remove and reinstall, you must clean up the following three areas to reinstall <<< custom_key.brand_name >>> from Launcher:
### 1.1 Cleanup of Installed <<< custom_key.brand_name >>> Application Services
Clean up all installed <<< custom_key.brand_name >>> application services in Kubernetes. You can do this on your operations machine by entering the Launcher container and running the built-in cleanup script of Launcher:
```
kubectl exec -it launcher-xxxxxxxx-xxx -n launcher /bin/bash
```
**launcher-xxxxxxxx-xxx is the name of your Launcher pod!**
Once inside the container, you will find the k8s-clear.sh script (`/config/tools/k8s-clear.sh`) provided by Launcher. Running this script will clean up all <<< custom_key.brand_name >>> application services and Kubernetes resources:

```shell
sh /config/tools/k8s-clear.sh
```

### 1.2 Cleanup of Automatically Created MySQL Databases
You can enter the Launcher container, which comes with a MySQL client tool, and use the following command to connect to the <<< custom_key.brand_name >>> MySQL instance:
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

## 2 How to Configure <<< custom_key.brand_name >>> to Use OceanBase Database
Whether it's a cloud provider's PaaS service or a self-built OceanBase, you can configure it in Launcher as follows. Enter the following information during the initial deployment.
```yaml
# Example for self-built
MySQL HOST: svc-obproxy.oceanbase.svc.cluster.local
Port: 2883
Administrator Account: croot@guance
Administrator Password: root_password
# MySQL HOST: In this example, it is a self-built service accessed via obproxy, so the obproxy service name is entered here. You can also directly enter the obcluster service name without using obproxy. Whether to use obproxy can be controlled by configuration files during deployment; if it is a cloud provider's PaaS capability, enter the PaaS address directly.

# Administrator account format: user@tenant#cluster_name 
user: username
tenant: tenant name
cluster_name: cluster name, optional
```
When <<< custom_key.brand_name >>> uses OceanBase, you need to set the open_cursors parameter of OceanBase. Execute the following command:
```sql
# This parameter is a global parameter. If the provided PaaS OceanBase is shared by multiple tenants, ensure that adjusting this parameter does not affect other tenants.
ALTER SYSTEM SET open_cursors = 200;
```