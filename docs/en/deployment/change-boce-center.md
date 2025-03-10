## Overview

The official dial testing center is managed and maintained by <<< custom_key.brand_name >>>, with predefined domestic and international dial testing nodes. It can monitor and statistically analyze the availability of dial testing tasks in real-time, identifying network site performance issues and affected areas before users do.

### Use Cases

- Completely offline, wanting to implement a dial testing service on your own.
- Wanting to implement a dial testing service for internal websites.

### Prerequisites

- Version 1.63.128 or higher

> During upgrades, the launcher service will guide you on whether to switch to a private dial testing center.
>
> During deployment, you will have an option to choose between using a private dial testing center or the official dial testing center.

This article aims to address the pain points of switching dial testing centers after deployment. The following are the steps to do so.

## Operation Steps

### Switching to a Private Dial Testing Center

Log in to the launcher console ---> top-right corner button ---> other, add the following line `dialService: buildin`

![](img/change-boce-center_1.png)

> Adding `dialService: buildin` switches to the private dial testing center, changing it to `dialService: saas` switches back to the official dial testing center.

Top-right corner button ---> click **Modify Application Configuration**, modify the ConfigMap named `core` under the `forethought-core` Namespace related to the DialingServer module.

```shell
# Cloud dial testing service
DialingServer:
  # Configuration of the dial testing service center's address
  use_https: true                           ## Whether to use https
  host: dflux-dial.guance.com               ## Address of the dial testing center, replace with the ingress domain name of your private deployment; remember to revert to the original address if switching back
  port: 443
  timeout: 10
```

> By default, it uses the official provided dial testing center.

### Adding Dial Testing Nodes

Log in to the <<< custom_key.brand_name >>> console, click Synthetic Tests ---> User-defined Node Management ---> Create Node.

> Note: If the node is created in the system workspace, all workspaces can see this dial testing node. If you want only a single workspace to see it, create the dial testing node within that specific workspace.

Click the "Get Configuration" button on the far right, follow the redirection to install the dial testing node.

![](img/change-boce-center_2.png)

![](img/change-boce-center_3.png)

> Note: Besides these three fields, the `dialtesting.conf` file in DataKit also needs to configure `server` as the address of the dial testing service center you intend to use (usually the ingress domain name created during deployment or upgrade).

```shell
[[inputs.dialtesting]]
  # We can also configure a JSON path like "file:///your/dir/json-file-name"
  server = "https://dflux-dial.guance.com"

  # [require] node ID
  region_id = "default"

  # if server is dflux-dial.guance.com, ak/sk required
  ak = ""
  sk = ""
```

### Verification Method

1. Log in to the <<< custom_key.brand_name >>> console, click Synthetic Tests ---> Tasks ---> Create Task ---> HTTP Test.

2. Follow the steps below to create a new dial testing task, then save it.

![](img/change-boce-center_4.png)

3. Go back to the task list and click on the newly created dial testing task.

![](img/change-boce-center_5.png)

4. If the data appears as shown in the image above, the setup was successful.