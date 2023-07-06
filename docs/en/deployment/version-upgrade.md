# Upgrade Installation 
---

## 1 Upgrade Installation 
### 1.1 Launcher Service Upgrade 

To upgrade Guance Cloud, the first step is to upgrade the **Launcher** service and obtain the target version of the **Launcher** service image that needs to be upgraded. The latest version of the Launcher image address can view the document [community version deployment image](changelog.md) , and execute the following commands on the **O&M operator** to upgrade the **Launcher**：
```shell
$ kubectl patch deployment launcher -p '{"spec": {"template": {"spec": {"containers": [{"image": "{{ Launcher 镜像地址 }}", "name": "launcher"}]}}}}' -n launcher
```

Execute the following command to set the **launcher** Execute the following command to set the 1:

```shell
kubectl scale deployment -n launcher --replicas=1  launcher
```

or

```shell
kubectl patch deployment launcher -p '{"spec": {"replicas": 1}}' -n launcher
```

### 1.2 Upgrade Application

Visit **launcher.dataflux.cn** on the browser where the operator is installed, and complete the upgrade of Guance according to the installation boot steps. 

#### 1.2.1 Add Application Configuration

**launcher** automatically detects the newly added application configuration between the current Guance version and the target upgraded version and lists it. After modifying the corresponding value according to the configuration template, click "Check and Generate Configuration". 

![](img/9.deployment_1.png)


#### 1.2.2 Upgrade Application Configuration

- **launcher** automatically detects the current DataFlux version, and there are updated application configurations between the target upgraded version, and modifies the corresponding values according to the listed updated contents. 

![](img/9.deployment_2.png)

- Expand the configuration items marked with **configuration with update**, list the historical version to be upgraded on the left side, apply the current configuration on the right side, and modify the configuration content on the right side according to the configuration upgrade description on the left side. 

![](img/9.deployment_3.png)

- At the same time, you can also modify the application **configuration with update**. After checking the **upgrade configuration** option, you can modify the configuration. 
- After confirming that all configurations have been modified, click **confirm to upgrade configuration** button to upgrade the configuration. 

#### 1.2.3 Upgrade Database

**launcher** automatically detects the current DataFlux version. Between the target upgrade version, there are applications for database upgrade, and lists the database upgrade contents of each version. Click **confirm to upgrade**:

![](img/9.deployment_4.png)

#### 1.2.4 Upgrade Application

**launcher** automatically detects the current Guance Cloud version, and there are upgrades or newly added applications between the target upgrade version, and displays the mirror version comparison between the current version and the target upgrade version. Click **confirm to upgrade**：

![](img/9.deployment_5.png)

#### 1.2.5 Application Startup Status

Display the startup status of all updated or newly added applications, and when all the applications are started, the upgrade and installation of this version of Guance is completed. 

![](img/9.deployment_6.png)

**Note: In the process of service restart, you must stay on this page and don't close it. When you finally see the prompt of "version information was written successfully" and no error window pops up, it means that the upgrade is successful!**

### 1.3 Important Step!!!

After the upgrade is completed, carry out the verification after the upgrade. After the verification is correct, it is a very important step to take the launcher service offline to prevent the application configuration from being accessed by mistake. You can execute the following command on the **O&M operator** to set the pod copy number of the launcher service to 0: 

```shell
kubectl scale deployment -n launcher --replicas=0  launcher
```

or

```shell
kubectl patch deployment launcher -p '{"spec": {"replicas": 0}}' -n launcher
```
