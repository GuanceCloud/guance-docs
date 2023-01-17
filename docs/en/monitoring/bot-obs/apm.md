# Application Performance Check

---

## Background

Based on APM abnormal root cause analysis detector, "application performance detection" selects the information of `service`, `resource`, `project` and `env` to be detected, conducts intelligent check on application performance regularly, automatically analyzes the upstream and downstream information of the service through the abnormal service metric of the application program and confirms the abnormal root cause problem for the application program.

## Precondition

1. There are already access applications in Guance Cloud "application performance monitoring".
2. Offline deployment of self-built DataFlux Func
3. Open the [script market](https://func.guance.com/doc/script-market-basic-usage/)
4. Create an [API Key](../../management/api-key/open-api.md) for action in Guance Cloud "management/API Key management"
5. In the self-built DataFlux Func, install "Guance Cloud Self-built Inspection Core Core Package", "Guance Cloud Algorithm Library" and "Guance Cloud Self-built Inspection (APM Performance)" through "Script Market"
6. In the DataFlux Func, write the self-built check processing function
7. In the self-built DataFlux Func, create auto-trigger configuration for the written function through "Manage/Auto-trigger Configuration"

## Configuration Check

Create a new script set in the self-built DataFlux Func to start the application performance check configuration.

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_apm_performance__main as apm_main

# Account Configuration
API_KEY_ID  = 'wsak_xxx'
API_KEY     = 'wsak_xxx'

# The function filters parameter filter and Guance Cloud studio monitoring\intelligent check configuration have calling priority. After the function filters parameter filter is configured, there is no need to change the detection configuration in Guance Cloud studio monitoring\intelligent check. If both sides are configured, the filters parameter in the script will take effect first.

def filter_project_servcie_sub(data):
    # {'project': None, 'service_sub': 'mysql:dev'}, {'project': None, 'service_sub': 'redis:dev'}, {'project': None, 'service_sub': 'ruoyi-gateway:dev'}, {'project': None, 'service_sub': 'ruoyi-modules-system:dev'}
    project = data['project']
    service_sub = data['service_sub']
    if service_sub in ['ruoyi-gateway:dev', 'ruoyi-modules-system:dev']:
        return True

'''
Task configuration parameters use:
@DFF.API('Application performance inspection', fixed_crontab='0 * * * *', timeout=900)

fixed_crontab: Fixed execution frequency "once per hour"
timeout: Task execution timeout, controlled at 15 minutes
'''    
   
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('application performance inspection', fixed_crontab='0 * * * *', timeout=900)
def run(configs=[]):
    '''
    Parameters:
    configs :
        project: Items to which services belong
        service_sub: Including service, environment, version by splicing ":", for example: "service:env:version"、"service:env"、"service:version"

    Example:
        configs = [
            {"project": "project1", "service_sub": "service1:env1:version1"},
            {"project": "project2", "service_sub": "service2:env2:version2"}
        ]
    '''
    checkers = [
        apm_main.APMCheck(configs=configs, filters=[filter_project_servcie_sub]),
    ]

    Runner(checkers, debug=False).run()
```

## Start Check

### Register a Detect Item in Guance Cloud

In DataFlux Func, after the check is configured, you can click run to test by directly selecting `run()` method in the page, and after clicking Publish, you can view and configure it in Guance Cloud "Monitoring/Intelligent Patrol".

![image](../img/apm01.png)



### Configure Application Performance Check in Guance Cloud

  ![image](../img/apm02.png)



#### Enable/Disable

The application performance check is "On" by default, and can be "Off" manually. The configured application performance monitoring will be checked after being turned on.



#### Export

  Intelligent check supports "exporting JSON configuration". Under the operation menu on the right side of the intelligent check list, click the "Export" button to export the json code of the current check, and export the file name format: intelligent check name. json.



#### Edit

  Intelligent Check "Application Performance Check" supports users to manually add filter conditions. Under the operation menu on the right side of the intelligent Check list, click the "Edit" button to edit the check template.

  * Filter criteria: Configure the project to which the project service belongs, service_sub including service, environment and version to be spliced by ":".
  * Alarm Notification: Support the selection and editing of alarm policies, including the level of events to be notified, the notification object and the alarm silence period.

  Click Edit to configure entry parameters, then fill in the corresponding detection object in parameter configuration and click Save to start check:

  ![image](../img/apm03.png)

You can refer to the following JSON configuration information for multiple projects, environments, versions and services.

  ```json
   // Configuration example:
      configs = [
          {"project": "project1", "service_sub": "service1:env1:version1"},
          {"project": "project2", "service_sub": "service2:env2:version2"}
      ]
  ```



## View Events

  Intelligent check is based on Guance Cloud check algorithm, which will find abnormal situations in APM metrics, such as `resource` sudden anomaly. For abnormal situations, intelligent check will generate corresponding events. Under the operation menu on the right side of intelligent check list, click the "View Related Events" button to view the corresponding abnormal events.

![image](../img/apm04.png)



### Event Details page

  Click "Event" to view the details page of intelligent check events, including event status, exception occurrence time, exception name, basic attributes, event details, alarm notification, history and related events.

  * Click the "View Monitor Configuration" icon in the upper right corner of the Details page to support viewing and editing the configuration details of the current intelligent check.
  * Click the "Export Event JSON" icon in the upper right corner of the details page to support exporting the details of events.



#### Basic Attributes

  * Detection Dimensions: Filter criteria based on smart check configuration, enabling replication of detection dimensions `key/value`, adding to filters and viewing related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data
  * Extended Attributes: Support replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering.

  ![image](../img/apm05.png)



#### Event Details

  * Event Overview: Describes the object, content of the anomaly check event
  * Error Trend: You can view the performance metrics of the current application for nearly 1 hour
  * Abnormal Impact: You can view the services and resources affected by the abnormal service of the current link
  * Abnormal link sampling: check the detailed error time, service, resource and link ID; Click on the service, and the resource will enter the corresponding data observer; Click on the link ID will bring you to the specific link details page.

![image](../img/apm06.png)
  ![image](../img/apm07.png)



#### History

  Support to view detection objects, exception/recovery time and duration.

 ![image](../img/apm08.png)



#### Associated Events

  Support to view associated events by filtering fields and selected time component information.

  ![image](../img/apm09.png)



## FAQ

  **1.How to configure the detection frequency of application performance check**

  * In the self-built DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` and timeout=900 'in the decorator when writing the self-built patrol processing function, and then configure it in "Administration/Auto-trigger Configuration".

  **2.There may be no anomaly analysis when applying the performance check trigger**

  Check the current data collection status of `datakit` when there is no anomaly analysis in the check report.

  **3.Under what circumstances will an application performance check event occur**

  Error rate, P90 and other metrics as the entry point, when one of the metrics changes abnormally and produces the impact of upstream and downstream links, trigger the collection of alarm information and carry out root cause analysis.

  

  
