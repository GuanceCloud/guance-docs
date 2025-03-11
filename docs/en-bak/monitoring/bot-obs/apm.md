# APM Intelligent Inspection

---

## Background

「APM Intelligent Inspection」is based on APM root cause analysis detector, select the `service` 、 `resource` 、 `project` 、 `env` information to be tested, and perform intelligent inspection of APM on a regular basis to automatically analyze the upstream and downstream information of the service through application service index exceptions, and confirm the root cause of the abnormal problem for the application.

## Preconditions

1. In Guance「 [APM](../../application-performance-monitoring/collection/index) 」that already have access applications.
2. Offline deployment of [**DataFlux Func GSE**](https://func.guance.com/#/), Or activate the [**DataFlux Func Hosted Edition**](../../dataflux-func/index.md)
4. In Guance「Management / API Key Management」create [API Key](../../../management/api-key/open-api.md)

> **Note：**If you are considering using a cloud server for your DataFlux Func offline deployment, please consider deploying with your current Guance SaaS on [the same carrier in the same region](../../../getting-started/necessary-for-beginners/select-site/)。

## Start Intelligent Inspection

In the DataFlux Func, install the "Guance Custom Inspection (APM Performance)" through the "Script Market" and follow the prompts to configure the Guance API Key to complete activation.

Select the inspection scene you want to enable in the DataFlux Func script market and click install. Configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/), then select deploy and start the script.

![image](../img/create_checker.png)

Once the deployment of the startup script is successful, it will automatically create the startup script and trigger configuration. You can check the corresponding configuration directly by clicking on the link.

![image](../img/success_checker.png)

## Configs Intelligent Inspection

### Configure Intelligent Inspection in Guance

  ![image](../img/apm02.png)



#### Enable/Disable

APM Intelligent Inspection is "On" by default, and can be manually "Off". When it is on, it will inspect the configured APM.



#### Export

Intelligent Inspection supports "Export JSON configuration". Under the operation menu on the right side of the Intelligent Inspection list, click the "Export" button to export the JSON code of the current inspection, and the export file name format: `intelligent inspection name.json`.

#### Editor

Intelligent Inspection "APM Intelligent Inspection" supports users to manually add filtering conditions, and click the "Edit" button under the operation menu on the right side of the Intelligent Inspection list to edit the inspection template.

  * Filter criteria: configuration application project service belongs to the project, service_sub including service, environment, version by ":" stitching.
  * Alarm notification: support for selecting and editing alarm policies, including the level of events to be notified, notification objects, and alarm silence period, etc.

 Configure the entry parameters by clicking on Edit and then fill in the corresponding detection object in the parameter configuration and click Save to start the inspection：

  ![image](../img/apm03.png)

You can refer to the following configuration for multiple projects, environments, versions and services

  ```json
   // config example：
          enabled_service = [
              "project1:service1:env1:version1",
              "project2:service2:env2:version2"
          ]
  
          disabled_service = [
              "project2:service2:env2:version2"
          ]
  
          [service_error_rate_threshold]
          "project1:service1:env1:version1"=0.1
          "project2:service2:env2:version2"=0.2
  
          [service_p99_threshold]
          "project1:service1:env1:version1"=15000000
          "project2:service2:env2:version2"=90000000
  ```

>  **Note**: In the  DataFlux Func, filter conditions can also be added when writing the  check processing function (refer to the sample code configuration). Note that the parameters configured in the Guance studio will override the parameters configured when writing the  check processing function.

### Configuring inspections in DataFlux Func

After configuring the required filter conditions for inspections in DataFlux Func, you can click the "run()" method to test it directly on the page. After clicking "publish", the script will be executed normally. You can also view or change the configuration in the Guance "Monitoring/Intelligent Inspection".

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_apm_performance__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_project_servcie_sub(data):
    '''
    过滤 project，service_sub，检测符合要求的对象，匹配的返回 True，不匹配的返回 False
    '''
    project = data['project']
    service_sub = data['service_sub']
    if service_sub in ['redis:dev:v1.0', 'mysql:dev:v1.0']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('APM 性能巡检', fixed_crontab='0 * * * *', timeout=900)
def run(configs=None):
    '''
    zh-CN:
        title: APM 性能巡检
        doc: |
            可选参数：
                configs ：
                    可以指定检测 service（enabled_service），不指定则检测所有 service。
                    可以指定过滤 service （disabled_service），不指定不过滤
                    可以针对 service 单独设置 p99 阈值（service_p99_threshold），错误率阈值（service_error_rate_threshold）
                    注：每个 service 由服务所属项目 (project), 服务（service）、环境（env）、版本（version）通过 ":" 拼接而成，例："project1:service:env:version"

                configs 按照 toml 格式配置示例 ：

                    enabled_service = [
                        "project1:service1:env1:version1",
                        "project2:service2:env2:version2"
                    ]

                    disabled_service = [
                        "project2:service2:env2:version2"
                    ]

                    [service_error_rate_threshold]
                    "project1:service1:env1:version1"=0.1
                    "project2:service2:env2:version2"=0.2

                    [service_p99_threshold]
                    "project1:service1:env1:version1"=15000000
                    "project2:service2:env2:version2"=90000000
    en:
        title: APM Performance Check
        doc: |
            Optional parameter：
                configs :
                    You can specify the detection service (enabled_service), otherwise all services will be detected.
                    You can specify the filtering service (disabled_service), and do not specify no filtering
                    You can set the p99 threshold (service_p99_threshold) and error rate threshold (service_error_rate_threshold) separately for services
                    Note: Each service by service belongs to the project (project), service (service), environment (env), version (version) by ":" patchwork, example: "project1: service: env: version"


                Example of configuring configs toml format:

                    enabled_service = [
                        "project1:service1:env1:version1",
                        "project2:service2:env2:version2"
                    ]

                    disabled_service = [
                        "project1:service2:env2:version2",
                    ]

                    [service_error_rate_threshold]
                    "project1:service1:env1:version1"=0.1
                    "project2:service2:env2:version2"=0.2

                    [service_p99_threshold]
                    "project1:service1:env1:version1"=15000000
                    "project2:service2:env2:version2"=90000000
    '''

    checkers = [
        main.APMCheck(configs=configs)
    ]

    Runner(checkers).run_v2()
```

## View Events

 Based on the Guance inspection algorithm, Intelligent Inspection will look for abnormalities in APM metrics, such as `resource` abnormalities occurring suddenly. For abnormal conditions, Intelligent Inspection will generate corresponding events, and you can check the corresponding abnormal events by clicking the "View Related Events" button under the operation menu on the right side of the Smart Inspection list.

![image](../img/apm04.png)



### Event Details page

Click "Event" to view the detail page of intelligent inspection events, including event status, time of exception occurrence, exception name, basic attributes, event details, alarm notification, history and associated events.

  * Click the "View monitor configuration" small icon at the top right corner of the detail page to support viewing and editing the configuration details of the current intelligent inspection.
  * Click the "Export Event JSON" icon in the upper-right corner of the detail page to support exporting the event details.



#### Basic Properties

  * Detection Dimensions: Filter criteria based on smart check configuration, enabling replication of detection dimensions `key/value`, adding to filters and viewing related logs, containers, processes, security patrol, links, user access monitoring, availability monitoring and CI data
  * Extended Attributes: Support replication in the form of `key/value` after selecting extended attributes and forward/reverse filtering.

  ![image](../img/apm05.png)



#### Event Details

  * Event overview: describes the object and content of the exception patrol event
  * Error trend: you can view the performance metrics of the current application for nearly 1 hour
  * Abnormal impact: you can view the services and resources affected by the abnormal service of the current link
  * Abnormal link sampling: view the detailed error time, service, resource and link ID; Click Services and Resources to enter the corresponding data explorer; Click the link ID to enter the specific link details page.

![image](../img/apm06.png)
  ![image](../img/apm07.png)



#### History

 Support to view the detection object, exception/recovery time and duration.

 ![image](../img/apm08.png)



#### Related events

  Support to view related events through filtering fields and selected time component information.

  ![image](../img/apm09.png)



## FAQ

**1. How to configure the detection frequency of the APM Intelligent Inspection**

  **In the  DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` to the decorator when writing the  patrol handler function, and then configure it in `Management / Auto-trigger Configuration'.

**2. There may be no exception analysis when triggered by APM Intelligent Inspection**

  When there is no exception analysis in the inspection report, please check the current data collection status of `datakit`.

**3. Under what circumstances will an APM Intelligent Inspection event be generated**

  Use metrics such as error rate and P90 as entry points to trigger the collection of alarm information and root cause analysis when one of these metrics changes abnormally and has an upstream and downstream link impact.

**4. Abnormal errors are found in scripts that were previously running normally during the inspection process**

Please update the referenced script set in DataFlux Func's script marketplace, you can view the update log of the script marketplace via [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate immediate script update.

**5. During the upgrade inspection process, it was found that there was no change in the corresponding script set in the Startup**

Please delete the corresponding script set first, then click the upgrade button to configure the corresponding Guance API key to complete the upgrade.

**6. How to determine if the inspection is effective after it is enabled**

Check the corresponding inspection status in "Management/Auto-trigger configuration". The status should be "enabled" first, and then click "Execute" to verify if there is any problem with the inspection script. If the words "executed successfully xxx minutes ago" appear, the inspection is running normally and is effective.

  
