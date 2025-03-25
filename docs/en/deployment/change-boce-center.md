## Overview

The official Testing Center is managed and maintained by <<< custom_key.brand_name >>>, with predefined domestic and international testing nodes. It can monitor and statistically analyze the availability of testing tasks in real time, discovering network site performance issues and affected scopes before the users do.

### Use Cases

- No network access at all, wanting to implement a testing service on your own.
  
- Wanting to implement an internal website testing service.

### Prerequisites

- Version 1.63.128 or higher

> During upgrades, the launcher service will guide you on whether you need to switch to a private testing center.
>
> During deployment, there will be an option for you to choose between using a private testing center or the official testing center.

Therefore, this article aims to address the pain point of switching testing centers after deployment. Below are the operational steps.

## Operational Steps

### Switching to the Private Testing Center

Log in to the launcher console ---> Top-right button ---> Other, add the following line `dialService: buildin`

![](img/change-boce-center_1.png)

> Adding `dialService: buildin` switches to the private testing center, changing it to `dialService: saas` switches back to the official testing center.

Top-right button ---> Click **Modify Application Configuration**, modify the content of the ConfigMap named core under the forethought-core Namespace regarding the DialingServer module.

```shell
# Cloud testing service
DialingServer:
  # Address configuration for the testing service center
  use_https: true                           ## Whether to use https
  host: <<< custom_key.dial_server_domain >>>               ## Testing center address, replace with the ingress domain name for private deployment; remember to revert to the original address if switching back
  port: 443
  timeout: 10
```

> By default, the official provided testing center is used.

### Creating Testing Nodes

Log in to the <<< custom_key.brand_name >>> console, click Synthetic Tests ---> Self-built Nodes Management ---> Create Node.

> Note: If the node is created in the system workspace, all workspaces will be able to see this testing node. If you want only one specific workspace to see it, create the testing node within that workspace.

Click the Get Configuration button on the far right, and follow the redirection to install the testing node.

![](img/change-boce-center_2.png)

![](img/change-boce-center_3.png)

> Note: In addition to these three fields, the dialtesting.conf in DataKit also needs to configure `server` as the address of the required testing service center (usually the ingress domain name created during deployment or upgrade).

```shell
[[inputs.dialtesting]]
  # We can also configure a JSON path like "file:///your/dir/json-file-name"
  server = "https://<<< custom_key.dial_server_domain >>>"

  # [require] node ID
  region_id = "default"

  # if server is <<< custom_key.dial_server_domain >>>, ak/sk are required
  ak = ""
  sk = ""
```

### Verification Method

1. Log in to the <<< custom_key.brand_name >>> console, click Synthetic Tests ---> Tasks ---> Create Task ---> HTTP Testing

2. Follow the steps below to create a new testing task, then save it.

![](img/change-boce-center_4.png)

3. Go back to the task and click the testing task just created.

![](img/change-boce-center_5.png)

4. If the data appears as shown in the figure above, the operation was successful.