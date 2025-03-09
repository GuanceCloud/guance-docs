# APM Performance Check

---

## Background

"APM Performance Check" is based on the APM Incident Root Cause Analysis Detector. It allows you to select the `service`, `resource`, `project`, and `env` information to be inspected, and regularly performs intelligent checks on application performance. By automatically analyzing anomalies in application service metrics, it identifies upstream and downstream service information to pinpoint root cause issues.

## Prerequisites

1. <<< custom_key.brand_name >>> "[APM](../../application-performance-monitoring/collection/index.md)" already has integrated applications.
2. Self-hosted [DataFlux Func <<< custom_key.brand_name >>> Special Edition](https://func.guance.com/#/), or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md)
4. In <<< custom_key.brand_name >>> "Manage / API Key Management," create an [API Key](../../management/api-key/open-api.md) for operations.

> **Note**: If considering using a cloud server for offline deployment of DataFlux Func, please ensure it is deployed with the current <<< custom_key.brand_name >>> SaaS [in the same operator and region](../../../getting-started/necessary-for-beginners/select-site/).

## Enabling Checks

In your self-hosted DataFlux Func, install the "<<< custom_key.brand_name >>> Self-hosted Check (APM Performance)" from the "Script Market" and configure the <<< custom_key.brand_name >>> API Key to complete the setup.

Choose the desired check scenario in the DataFlux Func Script Market, click install, configure the <<< custom_key.brand_name >>> API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/) settings, then select deploy to start the script.

![image](../img/create_checker.png)

After successfully deploying the startup script, it will automatically create the startup script and auto-trigger configuration, which can be viewed directly via the provided link.

![image](../img/success_checker.png)

## Configuring Checks

Configure the desired filtering conditions for the checks in either the <<< custom_key.brand_name >>> studio's Monitoring - Intelligent Check module or the automatically generated startup script in DataFlux Func. Refer to the following two configuration methods:

### Configuring Checks in <<< custom_key.brand_name >>>

  ![image](../img/apm02.png)

#### Enable/Disable

APM Performance Check defaults to "Enabled" status but can be manually "Disabled." When enabled, it will perform checks on the configured APM monitoring.

#### Editing

The "APM Performance Check" under Intelligent Checks supports manual addition of filter conditions. Click the **Edit** button in the operation menu on the right side of the Intelligent Check list to edit the check template.

* Filter Conditions: Configure the project of the service (`project`), `service_sub` including service (`service`), environment (`env`), version (`version`) concatenated by ":".
* Alert Notifications: Supports selecting and editing alert strategies, including event severity levels, notification targets, and alert silence periods.

Click Edit in the configuration entry parameters, fill in the corresponding detection objects in the parameter configuration, and click Save to start the check:

  ![image](../img/apm03.png)

You can refer to the following configuration for multiple projects, environments, versions, and services:

  ```json
   // Configuration Example:
  configs configured in TOML format:
          enabled_service = [
              "project1:service1:env1:version1",
              "project2:service2:env2:version2"
          ]
  
  				# Specify services to check; default is the entire workspace
          disabled_service = [
              "project2:service2:env2:version2"
          ]
  
  				# Specify error rate for services; default is 0
          [service_error_rate_threshold]
          "project1:service1:env1:version1"=0.1
          "project2:service2:env2:version2"=0.2
  
  				# Specify p99 threshold for services; default is 15s 
          [service_p99_threshold]
          "project1:service1:env1:version1"=15000000
          "project2:service2:env2:version2"=90000000
  ```

> **Note**: In the self-hosted DataFlux Func, when writing self-hosted check handling functions, you can also add filter conditions (refer to example code configuration). Note that parameters configured in <<< custom_key.brand_name >>> studio will override those set in the self-hosted check handling function.

### Configuring Checks in DataFlux Func

In DataFlux Func, after configuring the required filtering conditions for checks, you can test by clicking the `run()` method directly on the page. After publishing, the script will run normally. You can also view or change configurations in <<< custom_key.brand_name >>> "Monitoring / Intelligent Checks."

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_apm_performance__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_project_servcie_sub(data):
    '''
    Filter project, service_sub, inspect objects that meet requirements, return True if matched, False otherwise
    '''
    project = data['project']
    service_sub = data['service_sub']
    if service_sub in ['redis:dev:v1.0', 'mysql:dev:v1.0']:
        return True
  
  
@self_hosted_monitor(account['api_key_id'], account['api_key'])
@DFF.API('APM Performance Check', fixed_crontab='0 * * * *', timeout=900)
def run(configs=None):
    '''
    en:
        title: APM Performance Check
        doc: |
            Optional parameter:
                configs :
                    You can specify the detection service (enabled_service), otherwise all services will be detected.
                    You can specify the filtering service (disabled_service), and do not specify no filtering
                    You can set the p99 threshold (service_p99_threshold) and error rate threshold (service_error_rate_threshold) separately for services
                    Note: Each service by service belongs to the project (project), service (service), environment (env), version (version) by ":" patchwork, example: "project1: service: env: version"

                Example of configuring configs in TOML format:

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

## Viewing Events

Based on <<< custom_key.brand_name >>> inspection algorithms, Intelligent Checks identify anomalies in APM metrics, such as sudden anomalies in `resource`. For any anomalies, Intelligent Checks generate corresponding events. In the Intelligent Check list's operation menu, click the **View Related Events** button to view the corresponding anomaly events.

![image](../img/apm04.png)

### Event Details Page

Clicking **Event**, you can view the details page of the Intelligent Check event, including event status, anomaly occurrence time, anomaly name, basic attributes, event details, alert notifications, history, and related events.

* Click the "View Monitor Configuration" icon in the top-right corner of the details page to view and edit the current Intelligent Check configuration details.

#### Basic Attributes

* Detection Dimensions: Based on the Intelligent Check configuration's filter conditions, it supports copying `key/value`, adding filters, and viewing related logs, containers, processes, Security Checks, traces, RUM PV, Synthetic Tests, and CI data.
* Extended Attributes: Select extended attributes to support copying in `key/value` form, forward/reverse filtering.

![image](../img/apm05.png)

#### Event Details

* Event Overview: Describes the object and content of the anomaly check event.
* Error Trend: View the performance metrics of the current application over the past hour.
* Anomaly Impact: View the services and resources affected by the abnormal service in the current trace.
* Anomaly Trace Sampling: View detailed error times, services, resources, and trace IDs. Clicking on services or resources enters the corresponding data viewer; clicking on trace ID enters the specific trace detail page.

![image](../img/apm06.png)
![image](../img/apm07.png)

#### History Records

Supports viewing the detection object, anomaly/recovery times, and duration.

![image](../img/apm08.png)

#### Related Events

Supports viewing related events through filter fields and selected Time Widget information.

![image](../img/apm09.png)

## Common Issues

**1. How to configure the frequency of APM Performance Checks**

  * In self-hosted DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator when writing the self-hosted check handling function, and configure it in "Manage / Auto Trigger Configuration."

**2. Why might there be no anomaly analysis in APM Performance Checks**

  When there is no anomaly analysis in the check report, check the current `datakit` data collection status.

**3. Under what circumstances will APM Performance Check events be generated**

  Using error rates, P90, etc., as indicators, when one of these indicators shows abnormal changes and affects upstream and downstream services, it triggers the collection of alarm information and root cause analysis.

**4. What should be done if previously running scripts encounter errors during checks**

Update the referenced script sets in the DataFlux Func Script Market. You can view the update records of the script market through the [**Change Log**](https://func.guance.com/doc/script-market-guance-changelog/) to facilitate timely updates of the scripts.

**5. Why does the corresponding script set remain unchanged during script upgrade**

Delete the corresponding script set first, then click the upgrade button to configure the corresponding <<< custom_key.brand_name >>> API key to complete the upgrade.

**6. How to determine if the check has taken effect after enabling**

In "Manage / Auto Trigger Configuration," view the corresponding check status. The status should be enabled, and you can verify the check script by clicking execute. If it shows successful execution within the last xx minutes, the check is functioning properly.