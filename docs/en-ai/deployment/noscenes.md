## Overview

After deployment, there might be instances where templates do not exist. This document aims to help resolve such issues and complete the initialization of view templates.

As shown in the figure below:

![](img/noscenes_1.png)

## Synchronization Commands

### Option 1: Synchronization via Launcher Interface

Log in to the launcher management interface via a browser, click on **the configuration icon at the top right corner**, and select the following content for synchronization.

![](img/noscenes_2.png)

> Note: After clicking sequentially, please wait patiently for a few minutes for synchronization to complete. If the above option does not succeed, you can choose **Option 2** to manually execute the synchronization operation.

### Option 2: Command Line Execution

1. Enter the `inner` container under the `forethought-core Namespace`

```shell
kubectl exec -ti -n forethought-core <inner_pod_name> -- /bin/bash
```

2. If you need to modify templates for the Explorer or views, edit the corresponding template files in the `/config/cloudcare-forethought-backend/data_package/dataflux-template` directory.

3. Execute the following synchronization command, which will copy the templates and other data from the data package to the working directory and then automatically send an update task (synchronizing from the working directory to the database).

```shell
curl 'http://0.0.0.0:5000/api/v1/inner/upgrade/tasks/execute_task_func' \
-H 'Content-Type: application/json' \
--data-raw $'{"script_name": "data_package_task", "func_name": "distribute_data_package", "funcKwargs": {"keys": ["dataflux_template"], "is_force": true}}' \
--compressed
```