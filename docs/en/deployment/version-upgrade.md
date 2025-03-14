# Version Upgrade Installation
---

## 1 Upgrade Installation
### 1.1 Launcher Service Upgrade

To upgrade <<< custom_key.brand_name >>>, the first step is to upgrade the **Launcher** service. Obtain the target version's **Launcher** service image that needs to be upgraded. The latest Launcher image address can be found in the document [this deployment image](changelog.md). Execute the following command on the **operations machine** to upgrade **Launcher**:
```shell
$ kubectl patch deployment launcher -p '{"spec": {"template": {"spec": {"containers": [{"image": "{{ Launcher image address }}", "name": "launcher"}]}}}}' -n launcher
```

Execute the following command to set the number of **launcher** replicas to 1:

```shell
kubectl scale deployment -n launcher --replicas=1 launcher
```

or

```shell
kubectl patch deployment launcher -p '{"spec": {"replicas": 1}}' -n launcher
```

### 1.2 Upgrade Application

Access **launcher.dataflux.cn** via a browser on the **installation operation machine**, and follow the installation guide steps to complete the <<< custom_key.brand_name >>> upgrade.

#### 1.2.1 New Application Configuration

**Launcher** automatically detects new application configurations added between the current <<< custom_key.brand_name >>> version and the target upgrade version, and lists them. Modify the corresponding values according to the configuration template, then click "Check Complete, Generate Configuration".

![](img/9.deployment_1.png)

#### 1.2.2 Upgrade Application Configuration

- **Launcher** automatically detects updated application configurations between the current DataFlux version and the target upgrade version, and lists the updated items. Modify the corresponding values based on the listed updates.

![](img/9.deployment_2.png)

- Expand items marked as **Configuration Updated**. The left column lists historical versions that need upgrading, while the right column shows the current application configuration. Modify the configuration content on the right based on the upgrade description on the left.

![](img/9.deployment_3.png)

- You can also modify unmarked **Configuration Updated** application configurations by checking the **Upgrade Configuration** option.
- After confirming all configuration changes, click the **Confirm Upgrade Configuration** button to upgrade the configuration.

#### 1.2.3 Upgrade Database

**Launcher** automatically detects database upgrades for applications between the current DataFlux version and the target upgrade version, and lists the upgrade content for each version. Click **Confirm Upgrade**:

![](img/9.deployment_4.png)

#### 1.2.4 Upgrade Application

**Launcher** automatically detects upgraded or newly added applications between the current <<< custom_key.brand_name >>> version and the target upgrade version, and displays the image version comparison between the current and target upgrade versions. Click **Confirm Upgrade Application**:

![](img/9.deployment_5.png)

#### 1.2.5 Application Startup Status

Displays the startup status of all updated or newly added applications. Once all have started successfully, the <<< custom_key.brand_name >>> upgrade installation is complete.

![](img/9.deployment_6.png)

**Note: During the service restart process, stay on this page without closing it until you see the prompt “Version information written successfully” and no error window pops up, indicating a successful upgrade!**

### 1.3 Very Important Step!!!

After completing the upgrade, verify the upgrade results. An important step after verification is to take the launcher service offline to prevent accidental access that could disrupt the application configuration. On the **operations machine**, execute the following command to set the number of launcher service pods to 0:

```shell
kubectl scale deployment -n launcher --replicas=0 launcher
```

or

```shell
kubectl patch deployment launcher -p '{"spec": {"replicas": 0}}' -n launcher
```