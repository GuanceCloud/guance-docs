### Introduction

This section introduces how to manually update view template packages, Metrics dictionaries, and official Pipeline packages in an offline environment without upgrading the Guance version.

### How to Update View Template Packages in an Offline Environment

1. Download the latest view template package: [https://gitee.com/dataflux/dataflux-template](https://gitee.com/dataflux/dataflux-template)
   You need to download the template package from the master branch. After successful download, you will get a **dataflux-template-master.zip** file.
2. Upload the downloaded file to the container's persistent storage directory. The path is: forethought-core namespace --> inner container --> `/config/cloudcare-forethought-backend/sysconfig/staticFolder/`
3. Replace the contents of the previous staticFolder with the uploaded file.
   ```shell
   cd /config/cloudcare-forethought-backend/sysconfig/staticFolder
   unzip dataflux-template-master.zip
   # For initial deployment, since dataflux-template does not exist, there is no need to execute the mv command. During use, if you need to update the template, then execute the mv command.
   # mv dataflux-template dataflux-template-bak
   mv dataflux-template-master dataflux-template
   ```
4. Enter the Python environment. The path is: forethought-core namespace --> inner container --> `/config/cloudcare-forethought-backend`
   ```shell
   python
   ```
5. Execute the Python command
   ```python
   from forethought.tasks.timed_sync_integration import execute_update_integration 
   execute_update_integration()
   ```
6. If you see the following prompt, it indicates that the import was successful.
   ![success.jpg](img/update-success.png)

### How to Update Metrics Dictionary JSON in an Offline Environment

1. Download the latest Metrics dictionary JSON file: [https://static.guance.com/datakit/measurements-meta.json](https://static.guance.com/datakit/measurements-meta.json)
2. In the folder located at: forethought-core namespace --> inner container --> `/config/cloudcare-forethought-backend/sysconfig/staticFolder/metric`, create a new `metric_config.json` file and paste the content from the link into it.

### How to Update the Official Pipeline Library in an Offline Environment

1. Download the latest Metrics dictionary JSON file: [https://static.guance.com/datakit/internal-pipelines.json](https://static.guance.com/datakit/internal-pipelines.json)
2. In the folder located at: forethought-core namespace --> inner container --> `/config/cloudcare-forethought-backend/sysconfig/staticFolder`, create a new `internal-pipelines.json` file and paste the content from the link into it.