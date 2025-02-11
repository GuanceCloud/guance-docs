## Overview

The official Dial Testing Center is managed and maintained by Guance, with predefined domestic and international Dial Testing nodes. It can monitor and statistically track the availability of Dial Testing tasks in real-time, identifying network site performance issues and affected areas before users do.

### Applicable Scenarios

- Completely disconnected from the internet, wanting to implement a self-hosted Dial Testing service.
- Wanting to implement a Dial Testing service for internal websites.

### Prerequisites

- Version 1.63.128 or higher

> During upgrades, the launcher service will guide you on whether to switch to a private Dial Testing Center.
>
> During deployment, there will be an option to choose between using a private Dial Testing Center or the official Dial Testing Center.

This article aims to address the pain points of switching Dial Testing Centers after deployment. Below are the operational steps.

## Operational Steps

### Switching to a Private Dial Testing Center

Log in to the launcher console ---> Top-right corner button ---> Others, add the following line `dialService: buildin`

![](img/change-boce-center_1.png)

> Adding `dialService: buildin` switches to a private Dial Testing Center, changing it to `dialService: saas` switches back to the official Dial Testing Center.

Top-right corner button ---> Click **Modify Application Configuration**, edit the content of the ConfigMap named `core` under the `forethought-core` Namespace regarding the DialingServer module.

```shell
# Cloud Dial Testing Service
DialingServer:
  # Address configuration for the Dial Testing Service Center
  use_https: true                           ## Whether to use HTTPS
  host: dflux-dial.guance.com               ## Dial Testing Center address, replace with the ingress domain name of your private deployment; remember to revert to the original address if switching back
  port: 443
  timeout: 10
```

> By default, the official provided Dial Testing Center is used.

### Adding Dial Testing Nodes

Log in to the Guance console, click Synthetic Tests ---> User-defined Node Management ---> New Node.

> Note: If the node is created in the system workspace, all workspaces can see this Dial Testing node. If you want only a single workspace to see it, create the node within that specific workspace.

Click the "Get Configuration" button on the far right, follow the redirection to install the Dial Testing node.

![](img/change-boce-center_2.png)

![](img/change-boce-center_3.png)

> Note: In addition to these three fields, the `dialtesting.conf` file in DataKit also needs to configure `server` as the address of the Dial Testing Service Center you wish to use (usually the ingress domain name created during deployment or upgrade).

```shell
[[inputs.dialtesting]]
  # We can also configure a JSON path like "file:///your/dir/json-file-name"
  server = "https://dflux-dial.guance.com"

  # [require] node ID
  region_id = "default"

  # if server is dflux-dial.guance.com, ak/sk are required
  ak = ""
  sk = ""
```

### Verification Method

1. Log in to the Guance console, click Synthetic Tests ---> Tasks ---> New Task ---> HTTP Dial Testing

2. Follow the steps below to create a new Dial Testing task, then save it.

![](img/change-boce-center_4.png)

3. Return to the tasks page and click on the newly created Dial Testing task.

![](img/change-boce-center_5.png)

4. If the data appears as shown above, the setup is successful.