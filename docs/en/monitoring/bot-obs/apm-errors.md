# Server Application Error Patrol

---

## Background

When there is a running error on the server, we need to find out in advance and give early warning to troubleshoot the development operation and maintenance, and confirm whether the error has potential impact on the application in time. The content of server-side application error inspection event report is to remind development, operation and maintenance that new errors have occurred in the application in the past hour, and locate the specific error places to provide related diagnostic clues to users together.

## Preconditions

1. There are already access applications in Guance Cloud "application performance monitoring"
2. Offline deployment of self-built DataFlux Func
3. Open the [script market](https://func.guance.com/doc/script-market-basic-usage/) of self-built DataFlux Func
4. Create an [API Key](../../management/api-key/open-api.md) for action in Guance Cloud "management/API Key management"
5. In the self-built DataFlux Func, install "Guance Cloud Self-built Inspection Core Package", "Guance Cloud Algorithm Library" and "Guance Cloud Self-built Inspection (APM Error)" through "Script Market"
6. In the DataFlux Func, write the self-built check processing function
7. In the self-built DataFlux Func, create auto-trigger configuration for the written function through "Manage/Auto-trigger Configuration"

## Configuration Check

Create a new script set in the self-built DataFlux Func to start the memory leak check configuration.

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_apm_error__main as main

# Account Configuration
API_KEY_ID  = 'wsak_xxxxxx'
API_KEY     = '5K3Ixxxxxx'

# The function filters parameter filter and Guance Cloud studio monitoring\intelligent check configuration have calling priority. After the function filters parameter filter is configured, there is no need to change the detection configuration in Guance Cloud studio monitoring\ intelligent check. If both sides are configured, the filters parameter in the script will take effect first.

def filter_project_servcie_sub(data):
    # {'project': None, 'service_sub': 'mysql:dev'}, {'project': None, 'service_sub': 'redis:dev'}, {'project': None, 'service_sub': 'ruoyi-gateway:dev'}, {'project': None, 'service_sub': 'ruoyi-modules-system:dev'}
    project = data['project']
    service_sub = data['service_sub']
    if service_sub in ['ruoyi-08-auth:dev:1.0']:
        return True

'''
Task configuration parameters use:
@DFF.API('Server-side application error check', fixed_crontab='0 * * * *', timeout=1800)

fixed_crontab: Fixed execution frequency "once per hour"
timeout: Task execution timeout, controlled at 30 minutes
'''

# The server side applies the error check configuration; the user does not need to modify it
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('Server-side application error check', fixed_crontab='0 * * * *', timeout=1800)
def run(configs={}):
    """
    参数：
        configs：配置需要检测的 app_name 列表（可选，不配置默认检测所有 app_name）

        配置示例：
        configs = {
            "project": ["project", "project2"]  项目
            "env"    : ["env1", "env2"]         环境
            "version": ["version1", "version2"] 版本
            "service": ["service1", "service2"] 服务
        }
    """
    checkers = [
        # APM error check
        main.ApmErrorCheck(configs=configs, filters=[filter_project_servcie_sub]),

    ]

    Runner(checkers, debug=False).run()
```

## Start Check

### Register Detect Item in Guance Cloud

In DataFlux Func, you can click run to test by directly selecting `run()` method in the page after the check is configured, and you can view and configure it in Guance Cloud "Monitoring/Intelligent Check" after clicking Publish.

![image](../img/apm-errors01.png)

### Configure Server Application Error Check in Guance Cloud

![image](../img/apm-errors02.png)

#### Enable/Disable

Memory leak check is "On" by default and can be "Off" manually. The configured service list will be inspected after being turned on.

#### Export

Intelligent check supports "exporting JSON configuration". Under the operation menu on the right side of the intelligent check list, click the "Export" button to export the json code of the current check, and export the file name format: intelligent check name. json.

#### Edit

Intelligent Check "Server Application Error Check" supports users to manually add filter conditions. Under the operation menu on the right side of the intelligent check list, click the "Edit" button to edit the check template.

* Filter: Configure the list of app_names to be detected (optional, do not configure default detection of all app_names)
* Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period.

Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration, and click Save to start check:

![image](../img/apm-errors03.png)

You can refer to the following JSON configuration information for multiple projects, environments, versions and services.

```json
 // Configuration example:
    configs = {
        "project": ["project", "project2"]  project
        "env"    : ["env1", "env2"]         environment
        "version": ["version1", "version2"] version
        "service": ["service1", "service2"] service
    }
```

>  **Note**: In the self-built DataFlux Func, filter conditions can also be added when writing the self-built check processing function (refer to the sample code configuration). Note that the parameters configured in the Guance Cloud studio will override the parameters configured when writing the self-built check processing function.

## View Events

This check will scan the newly added application error information in the last hour. Once a new error does not occur, the intelligent check will generate corresponding events. Under the operation menu on the right side of the intelligent check list, click the "View Related Events" button to view the corresponding abnormal events.

![image](../img/apm-errors04.png)

### Event Details Page

Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

* Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check
* Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events

#### Basic Attributes

* Detection Dimensions: Filter criteria based on smart patrol configuration, enabling replication of detection dimensions `key/value`, adding to filters, and viewing related logs, containers, processes, security check, links, user access monitoring, availability monitoring and CI data
* Extended Attributes: Support replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering

![image](../img/apm-errors05.png)

#### Event Details

* Event Overview: Describes the objects, contents of abnormal check events.
* Error Distribution: You can view the change of the number of errors in the past 1 hour when the current exception is applied.
* Error Details: You can display the new error details and specific error count of exception application. You can click specific error information, error type and error stack to jump to the error details page for viewing.

![image](../img/apm-errors06.png)

![image](../img/apm-errors07.png)

#### History

Support to view detection objects, exception/recovery time and duration.

![image](../img/apm-errors08.png)

#### Associated Events

Support to view associated events by filtering fields and selected time component information.

![image](../img/apm-errors09.png)

## FAQ

**1.How to configure the detection frequency of server application error check**

* In the self-built DataFlux Func, add `fixed_crontab='0 * * * *', timeout=1800` in the decorator when writing the self-built check processing function, and then configure it in "admin/auto-trigger configuration".

**2.There may be no exception analysis when the server applies error check trigger**

Check the current data collection status of `datakit` when there is no anomaly analysis in the check report.

**3.Under what circumstances will server-side application error check events occur**

The server-side application error inspection will scan the newly added application error information in the last hour. Once a new error type does not occur, the intelligent inspection will generate corresponding events.
