# Server Application Error Intelligent Inspection

---

## Background

When server-side operation errors occur, we need to find early and timely warning to allow development and operation maintenance to troubleshoot and confirm whether the error has a potential impact on the application in a timely manner. The content of the server-side application error patrol event report is to remind the development and operation of the maintenance in the past hour there is a new application error and locate the specific place of error will be associated with the diagnostic clues provided to the user.

## Preconditions

1. In Guance「 [application performance monitoring](../../application-performance-monitoring/collection/index) 」that already have access applications.
2. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../dataflux-func/index.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Start Intelligent Inspection

In the DataFlux Func, install the "Guance Custom Inspection (APM Errors)" through the "Script Market" and follow the prompts to configure the Guance API Key to complete activation.

Select the inspection scene you want to enable in the DataFlux Func script market and click install. Configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select deploy and start the script.

![image](../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../img/success_checker.png)

## Configs Intelligent Inspection

### Configure Intelligent Inspection in Guance

![image](../img/apm-errors02.png)

#### Enable/Disable

Server Application Error Intelligent Inspection is "On" by default, and can be manually "Off". When it is on, it will inspect the configured APM.

#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

Intelligent Inspection "Server Application Error Intelligent Inspection" supports users to manually add filtering conditions, and click the "Edit" button under the operation menu on the right side of the Intelligent Inspection list to edit the inspection template.

  * Filter criteria: configuration application project service belongs to the project, service_sub including service, environment, version by ":" stitching.
  * Alarm notification: support for selecting and editing alarm policies, including the level of events to be notified, notification objects, and alarm silence period, etc.

 Configure the entry parameters by clicking on Edit and then fill in the corresponding detection object in the parameter configuration and click Save to start the inspection：

![image](../img/apm-errors03.png)

You can refer to the following configuration information for multiple projects, environments, versions and services.

```json
 // Configuration example:
    configs :
        project1:service1:env1:version1
        project2:service2:env2:version2
```

>  **Note**: In the  DataFlux Func, filter conditions can also be added when writing the  check processing function (refer to the sample code configuration). Note that the parameters configured in the Guance studio will override the parameters configured when writing the  check processing function.

### Configuring inspections in DataFlux Func

After configuring the required filter conditions for inspections in DataFlux Func, you can click the "run()" method to test it directly on the page. After clicking "publish", the script will be executed normally. You can also view or change the configuration in the Guance "Monitoring/Intelligent Inspection".

```python
from guance_monitor__runner import Runner
from guance_monitor__register import self_hosted_monitor
import guance_monitor_apm_error__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_project_servcie_sub(data):
    project = data['project']
    service_sub = data['service_sub']
    '''
    Filter the "service_sub" attribute, customize the conditions that meet the requirements for the "service_sub" attribute, and return True if there is a match, and False if there is no match.
    return True｜False
    '''
    if service_sub in ['xxx-xxx-auth:dev:1.0']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('APM 新增错误类型', fixed_crontab='0 * * * *', timeout=900)
def run(configs=None):
    """
    Optional parameters：
        configs:
	Multiple services can be specified (concatenated by line breaks), and if not specified, all services will be checked.
		Each service is composed of the project to which the service belongs, the service itself, the environment, and the version concatenated by ":".Example:"project1:service:env:version"
    示例：
        configs example：
            project1:service1:env1:version1
            project2:service2:env2:version2
    """
    checkers = [
        main.ApmErrorCheck(configs=configs, filters=[filter_project_servcie_sub]), # Support for user-configured multiple filtering functions that are executed in sequence.
    ]

    Runner(checkers, debug=False).run()
```



## View Events

This check will scan the newly added application error information in the last hour. Once a new error does not occur, the intelligent check will generate corresponding events. Under the operation menu on the right side of the intelligent check list, click the "View Related Events" button to view the corresponding abnormal events.

![image](../img/apm-errors04.png)

### Event Details Page

Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

* Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check
* Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events

#### Basic Properties

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

 Support to view the detection object, exception/recovery time and duration.

![image](../img/apm-errors08.png)

#### Related events

Support to view related events through filtering fields and selected time component information.

![image](../img/apm-errors09.png)

## FAQ

**1.How to configure the detection frequency of server application error check**

* In the  DataFlux Func, add `fixed_crontab='0 * * * *', timeout=1800` in the decorator when writing the  check processing function, and then configure it in "admin/auto-trigger configuration".

**2.There may be no exception analysis when the server applies error check trigger**

Check the current data collection status of `datakit` when there is no anomaly analysis in the check report.

**3.Under what circumstances will server-side application error check events occur**

The server-side application error inspection will scan the newly added application error information in the last hour. Once a new error type does not occur, the intelligent inspection will generate corresponding events.

**4. Abnormal errors are found in scripts that were previously running normally during the inspection process**

Please update the referenced script set in DataFlux Func's script marketplace, you can view the update log of the script marketplace via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script update.

**5. During the upgrade inspection process, it was found that there was no change in the corresponding script set in the Startup**

Please delete the corresponding script set first, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**6. How to determine if the inspection is effective after it is enabled**

Check the corresponding inspection status in "Management/Auto-trigger configuration". The status should be "enabled" first, and then click "Execute" to verify if there is any problem with the inspection script. If the words "executed successfully xxx minutes ago" appear, the inspection is running normally and is effective.
