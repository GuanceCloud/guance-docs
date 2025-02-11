# Version Upgrade Installation
---

## 1 Upgrade Installation
### 1.1 Launcher Service Upgrade

To upgrade Guance, the first step is to upgrade the **Launcher** service. Obtain the target version's **Launcher** service image. The latest Launcher image address can be found in the [deployment image documentation](changelog.md). Execute the following command on the **operations machine** to upgrade **Launcher**:
```shell
$ kubectl patch deployment launcher -p '{"spec": {"template": {"spec": {"containers": [{"image": "{{ Launcher image address }}", "name": "launcher"}]}}}}' -n launcher
```

Execute the following command to set the number of **launcher** replicas to 1:

```shell
kubectl scale deployment -n launcher --replicas=1  launcher
```

Or

```shell
kubectl patch deployment launcher -p '{"spec": {"replicas": 1}}' -n launcher
```

### 1.2 Upgrade Application

Access **launcher.dataflux.cn** via a browser on the **installation operation machine** and follow the installation guide to complete the upgrade of Guance.

#### 1.2.1 New Application Configuration

**Launcher** automatically detects new application configurations added between the current Guance version and the target upgrade version, lists them, and prompts you to modify the corresponding values according to the configuration template. After making the necessary changes, click "Check Complete, Generate Configuration."

![](img/9.deployment_1.png)

#### 1.2.2 Upgrade Application Configuration

- **Launcher** automatically detects updated application configurations between the current DataFlux version and the target upgrade version. Review the listed updates and make the necessary changes.

![](img/9.deployment_2.png)

- Expand items marked with **Configuration Updated**. The left side shows the historical versions that need upgrading, while the right side displays the current configuration. Modify the configuration content based on the upgrade description on the left.

![](img/9.deployment_3.png)

- You can also modify unmarked application configurations by selecting the **Upgrade Configuration** option.
- After confirming all changes, click the **Confirm Upgrade Configuration** button to upgrade the configuration.

#### 1.2.3 Upgrade Database

**Launcher** automatically detects database upgrades required between the current DataFlux version and the target upgrade version, listing each version's database upgrade content. Click **Confirm Upgrade**:

![](img/9.deployment_4.png)

#### 1.2.4 Upgrade Application

**Launcher** automatically detects applications that need upgrading or are newly added between the current Guance version and the target upgrade version, displaying the image version comparison between the current and target upgrade versions. Click **Confirm Upgrade Application**:

![](img/9.deployment_5.png)

#### 1.2.5 Application Start Status

Displays the start status of all updated or newly added applications. Once all have started successfully, the upgrade installation of this version of Guance is complete.

![](img/9.deployment_6.png)

**Note: During service restarts, stay on this page without closing it until you see the prompt "Version information written successfully" and no error windows pop up, indicating a successful upgrade!**

### 1.3 Very Important Step!!!

After completing the upgrade, verify the upgrade and ensure there are no issues. An important final step is to take the launcher service offline to prevent accidental access that could disrupt application configurations. Execute the following command on the **operations machine** to set the number of launcher pod replicas to 0:

```shell
kubectl scale deployment -n launcher --replicas=0  launcher
```

Or

```shell
kubectl patch deployment launcher -p '{"spec": {"replicas": 0}}' -n launcher
```