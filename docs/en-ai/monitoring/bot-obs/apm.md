# APM Performance Check

---

## Background

"Application Performance Monitoring" is based on the APM anomaly root cause analysis detector. Users can select the `service`, `resource`, `project`, and `env` information to be monitored, and regularly perform intelligent inspections of application performance. It automatically analyzes upstream and downstream service information based on anomalies in application service metrics, helping to identify root cause anomalies.

## Prerequisites

1. Guance "[Application Performance Monitoring](../../application-performance-monitoring/collection/index.md)" has integrated applications.
2. Self-hosted [DataFlux Func Special Edition for Guance](https://func.guance.com/#/), or subscribe to [DataFlux Func (Automata)](../../dataflux-func/index.md).
4. Create an [API Key](../../management/api-key/open-api.md) for operations in "Management / API Key Management".

> **Note**: If you consider using cloud servers for offline deployment of DataFlux Func, ensure it is deployed with the same operator and region as your current Guance SaaS deployment, as specified in [Select Site](../../../getting-started/necessary-for-beginners/select-site/).

## Enabling Inspection

In the self-hosted DataFlux Func, install "Self-hosted Inspection (APM Performance)" from the "Script Market" and configure the Guance API Key to enable inspection.

Choose the required inspection scenario from the DataFlux Func Script Market, click install, configure the Guance API Key and [GuanceNode](https://func.guance.com/doc/script-market-guance-monitor-connect-to-other-guance-node/) connection, then select deploy to start the script.

![image](../img/create_checker.png)

After successful deployment, automatic startup scripts and trigger configurations are created, which can be directly accessed via provided links.

![image](../img/success_checker.png)

## Configuring Inspection

Configure inspection filters in either the Guance Studio under "Monitoring - Intelligent Inspection" or in the automatically generated startup script within DataFlux Func. Refer to the following two configuration methods:

### Configuring Inspection in Guance

  ![image](../img/apm02.png)

#### Enable/Disable

The APM Performance Check is enabled by default but can be manually disabled. Once enabled, it will inspect configured application performance monitoring.

#### Editing

Intelligent Inspection "APM Performance Check" supports manual addition of filter conditions. Click the **Edit** button in the operation menu on the right side of the intelligent inspection list to edit the inspection template.

- Filter Conditions: Configure project, service, environment, and version using ":" delimiters.
- Alert Notifications: Select and edit alert policies, including event severity levels, notification targets, and alert silence periods.

Click **Edit** to enter parameters, specify the detection objects, and save to start the inspection:

![image](../img/apm03.png)

You can reference the following example for configuring multiple projects, environments, versions, and services:

```toml
// Configuration Example:
configs = [
    "project1:service1:env1:version1",
    "project2:service2:env2:version2"
]

# Specify services to inspect; defaults to entire workspace
disabled_service = [
    "project2:service2:env2:version2"
]

# Set error rate threshold for services; default is 0
[service_error_rate_threshold]
"project1:service1:env1:version1"=0.1
"project2:service2:env2:version2"=0.2

# Set p99 latency threshold for services; default is 15 seconds
[service_p99_threshold]
"project1:service1:env1:version1"=15000000
"project2:service2:env2:version2"=90000000
```

> **Note**: In self-hosted DataFlux Func, when writing custom inspection functions, you can add filter conditions (refer to sample code configuration). Note that parameters configured in Guance Studio will override those set in custom inspection functions.

### Configuring Inspection in DataFlux Func

After configuring the required filter conditions in DataFlux Func, you can test by clicking the `run()` method directly on the page. After publishing, the script will execute normally. You can also view or modify configurations in Guance's "Monitoring / Intelligent Inspection".

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__runner import Runner
import guance_monitor_apm_performance__main as main

# Support for using filtering functions to filter the objects being inspected, for example:
def filter_project_servcie_sub(data):
    '''
    Filter project, service_sub, detect objects that meet requirements, return True if matched, False otherwise
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

## Viewing Events

Based on Guance's inspection algorithms, Intelligent Inspection identifies anomalies in APM metrics, such as sudden abnormalities in `resource`. For any anomalies, Intelligent Inspection generates corresponding events. Click the **View Related Events** button in the operation menu on the right side of the intelligent inspection list to view associated anomaly events.

![image](../img/apm04.png)

### Event Details Page

Click **Event** to view the details page of an intelligent inspection event, including event status, anomaly occurrence time, anomaly name, basic attributes, event details, alert notifications, history, and related events.

- Click the "View Monitor Configuration" icon in the top-right corner of the details page to view and edit the current intelligent inspection configuration.

#### Basic Attributes

- Detection Dimensions: Based on the configured filter conditions, support copying `key/value` pairs, adding to filters, and viewing related logs, containers, processes, security checks, traces, RUM, Synthetic Tests, and CI data.
- Extended Attributes: Select extended attributes to copy in `key/value` format, apply forward/reverse filtering.

![image](../img/apm05.png)

#### Event Details

- Event Overview: Describes the object and content of the anomaly inspection event.
- Error Trend: View performance metrics for the application over the past hour.
- Impact Analysis: View affected services and resources in the current trace.
- Trace Sampling: View detailed error times, services, resources, and trace IDs. Clicking on services or resources enters the respective data viewer; clicking on a trace ID opens the specific trace detail page.

![image](../img/apm06.png)
![image](../img/apm07.png)

#### History

Supports viewing detection objects, anomaly/recovery times, and duration.

![image](../img/apm08.png)

#### Related Events

Supports viewing related events through filtered fields and selected time component information.

![image](../img/apm09.png)

## FAQs

**1. How to configure the inspection frequency for APM Performance Check**

- In self-hosted DataFlux Func, add `fixed_crontab='0 * * * *', timeout=900` in the decorator when writing custom inspection functions, then configure it in "Management / Automatic Trigger Configuration".

**2. Why might there be no anomaly analysis in the inspection report**

If the inspection report lacks anomaly analysis, check the data collection status of the current `datakit`.

**3. Under what circumstances would an APM Performance Check event be generated**

Events are triggered when key metrics like error rates or P90 experience abnormal changes that impact upstream and downstream services.

**4. What should I do if a previously functioning script encounters errors during inspection**

Update the referenced script set in the DataFlux Func Script Market. Refer to the [Change Log](https://func.guance.com/doc/script-market-guance-changelog/) for updates and immediate script updates.

**5. During script upgrades, why does the Startup script set remain unchanged**

Delete the corresponding script set first, then click the upgrade button and configure the corresponding Guance API key to complete the upgrade.

**6. How to verify if the inspection is working after enabling**

In "Management / Automatic Trigger Configuration", check the inspection status. Ensure it is enabled and validate by executing the script. If it shows "Executed Successfully X minutes ago," the inspection is running correctly.