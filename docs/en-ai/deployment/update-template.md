### Introduction

This section describes how to manually update view template packages, metrics dictionaries, official Pipeline packages, etc., in an offline environment without upgrading the <<< custom_key.brand_name >>> version.

### How to Update View Template Packages in an Offline Environment

1. Download the latest view template package: [https://gitee.com/dataflux/dataflux-template](https://gitee.com/dataflux/dataflux-template)
   You need to download the template package from the master branch. After a successful download, you will get a **dataflux-template-master.zip** file.
2. Upload the downloaded file to the container's persistent storage directory at the path: forethought-core namespace --> inner container --> `/config/cloudcare-forethought-backend/sysconfig/staticFolder/`
3. Replace the contents of the existing staticFolder with the uploaded file.
```shell
cd /config/cloudcare-forethought-backend/sysconfig/staticFolder
unzip dataflux-template-master.zip
# On initial deployment, since the dataflux-template does not exist, there is no need to perform the mv operation. During use, if you need to update the template, then execute the mv operation.
# mv dataflux-template dataflux-template-bak
mv dataflux-template-master dataflux-template
```
4. Enter the Python environment. Path: forethought-core namespace --> inner container --> `/config/cloudcare-forethought-backend`
```shell
python
```
5. Execute the Python command:
```python
from forethought.tasks.timed_sync_integration import execute_update_integration 
execute_update_integration()
```
6. If you see the following prompt, it indicates that the import was successful.
![success.jpg](img/update-success.png)

### How to Update Metrics Dictionary JSON in an Offline Environment

1. Download the latest metrics dictionary JSON file: [https://<<< custom_key.static_domain >>>/datakit/measurements-meta.json](https://<<< custom_key.static_domain >>>/datakit/measurements-meta.json)
2. In the directory path: forethought-core namespace --> inner container --> `/config/cloudcare-forethought-backend/sysconfig/staticFolder/metric`, create a new `metric_config.json` file and paste the content from the link into this file.

### How to Update the Official Pipeline Library in an Offline Environment

1. Download the latest metrics dictionary JSON file: [https://<<< custom_key.static_domain >>>/datakit/internal-pipelines.json](https://<<< custom_key.static_domain >>>/datakit/internal-pipelines.json)
2. In the directory path: forethought-core namespace --> inner container --> `/config/cloudcare-forethought-backend/sysconfig/staticFolder`, create a new `internal-pipelines.json` file and paste the content from the link into this file.