# Custom Inspection

<<< custom_key.brand_name >>> supports custom intelligent inspections via DataFlux Func, based on intelligent algorithms, automatically detecting infrastructure and application issues, helping users discover problems that have occurred and potential issues during the operation of IT systems. Through root cause analysis, it quickly identifies the causes of abnormal issues.

DataFlux Func is a platform for developing, managing, and executing functions. It is simple to use, no need to build Web services from scratch or manage servers and other infrastructure. Just write code and publish it, with simple configuration generating HTTP API interfaces for the functions.

This document primarily introduces how to use the "<<< custom_key.brand_name >>> Custom Inspection Core Package" script package in the DataFlux Func Script Market to implement inspection functions in a self-built DataFlux Func environment.

> Tip 1: Always use the latest version of DataFlux Func for operations.

> Tip 2: This script package will continuously add new features, please keep an eye on document updates.

## 1. Prerequisites

- [Install DataFlux Func](https://<<< custom_key.func_domain >>>/doc/quick-start/) 

- [Install Script Packages](https://<<< custom_key.func_domain >>>/doc/script-market-basic-usage/) 

## 2. Quick Start

To set up custom inspection, follow these steps:

1. In <<< custom_key.brand_name >>>'s "Management / API Key Management", create an API Key for operations.
2. In your self-built DataFlux Func, install the "<<< custom_key.brand_name >>> Custom Inspection Core Package" via the "Script Market".
3. In your self-built DataFlux Func, write a custom inspection processing function.
4. In your self-built DataFlux Func, through "Management / Automatic Trigger Configuration", create automatic trigger configurations for the written function.

### 2.1 Writing Code

A typical custom inspection processing function is as follows:

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__event_reporter import EventReporter

API_KEY_ID  = 'wsak_xxxxx'
API_KEY     = 'xxxxx'
GUANCE_NODE = None

# Register custom inspection
@self_hosted_monitor(API_KEY_ID, API_KEY, GUANCE_NODE)
@DFF.API('Custom Inspection Example')
def run(param1=1, param2=True, param3=None):
    '''
    This is an example of custom inspection
    Parameters:
        param1 {int} Parameter 1
        param2 {bool} Parameter 2
        param3 {str} Parameter 3
    '''
    # Generate event reporter
    event_reporter = EventReporter()

    # ... Execute inspection processing and generate data
    event = {
        'title'  : 'Custom Inspection Example',
        'message': f'''
            Custom inspection content supports Markdown format, such as:

            1. Parameter `param1` value is `{param1}`
            2. Parameter `param2` value is `{param2}`
            3. Parameter `param3` value is `{param3}`
            ''',
        'status'        : 'error',
        'dimension_tags': { 'host': 'my_host' },
    }

    # Use event reporter to report events
    event_reporter.report(event)
```

After publishing the script, the corresponding function will be registered in <<< custom_key.brand_name >>>, and can be seen in the <<< custom_key.brand_name >>> platform under "Monitoring / Intelligent Inspection".

![](img/self-hosted-monitor-list.png)

### 2.2 Code Explanation

Below is a step-by-step explanation of the code in this example.

#### Import Section

In order to properly use scripts provided by the Script Market, after installing the script package, you need to import these components using the `import` method.

~~~python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__event_reporter import EventReporter
~~~

`self_hosted_monitor` is a decorator for custom inspection functions; only functions decorated with this decorator will be registered in <<< custom_key.brand_name >>>.

`EventReporter` is an event reporter used to report event data.

#### Custom Inspection Registration and Function Definition Section

Custom inspections that need to be registered in <<< custom_key.brand_name >>> must simultaneously satisfy:

1. *First* decorate with the `@self_hosted_monitor` decorator.
2. *Then* decorate with the `@DFF.API(...)` decorator.

~~~python
API_KEY_ID  = 'wsak_xxxxx'
API_KEY     = 'xxxxx'
GUANCE_NODE = None

# Register custom inspection
@self_hosted_monitor(API_KEY_ID, API_KEY, GUANCE_NODE)
@DFF.API('Custom Inspection Example')
def run(param1=1, param2=True, param3=None):
    '''
    This is an example of custom inspection
    Parameters:
        param1 {int} Parameter 1
        param2 {bool} Parameter 2
        param3 {str} Parameter 3
    '''
~~~

Among them:

The decorator `@self_hosted_monitor` requires passing the API Key ID and API Key created in <<< custom_key.brand_name >>>'s "Management / API Key Management".

The title specified in the decorator `@DFF.API(...)` will appear as the title of the custom inspection after registration.

The content in the function documentation will appear as the documentation on the custom inspection configuration page after registration.

#### Other <<< custom_key.brand_name >>> Nodes

If you need to connect to non-default nodes (Hangzhou) of <<< custom_key.brand_name >>>, then you need to pass the additional <<< custom_key.brand_name >>> node name parameter. The specific code example is as follows:

~~~python
API_KEY_ID  = 'wsak_xxxxx'
API_KEY     = 'xxxxx'
GUANCE_NODE = 'aws'

@self_hosted_monitor(API_KEY_ID, API_KEY, GUANCE_NODE)
# Omitted below...
~~~

> Regarding the optional values of `GUANCE_NODE`, refer to [Available <<< custom_key.brand_name >>> Nodes](https://<<< custom_key.func_domain >>>/doc/ui-guide-development-module-guance-node/)

<!-- 
Optional values for `GUANCE_NODE` are as follows:

| <<< custom_key.brand_name >>> Node         | `GUANCE_NODE` Value |
| ------------------ | ----------------- |
| China Zone 1 (Hangzhou)   | `None`            |
| China Zone 2 (Ningxia)   | `aws`             |
| China Zone 3 (Zhangjiakou) | `cn3`             |
| Overseas Zone 1 (Oregon) | `us1`             |
-->


#### Event Section

The event data that needs to be reported is a simple `dict`, like:

~~~python
    event = {
        'dimension_tags': { 'host': 'my_host' },

        'status' : 'error',
        'title'  : 'Custom Inspection Example',
        'message': f'''
            Custom inspection content supports Markdown format, such as:

            1. Parameter `param1` value is `{param1}`
            2. Parameter `param2` value is `{param2}`
            3. Parameter `param3` value is `{param3}`
            ''',
    }
~~~

Specific field definitions are as follows:

| Field             | Type | Required | Description                                                             |
| ---------------- | ---- | -------- | ---------------------------------------------------------------- |
| `title`          | str  | Required | Event title, single-line plain text                                             |
| `message`        | str  | Required | Event content, supports basic Markdown syntax                                 |
| `status`         | str  | Required | Event level<br>Possible values: `info`, `warning`, `error`, `critical`, `ok` |
| `dimension_tags` | dict |          | Detection dimensions, such as: `{ "host": "my_host" }`                            |

*Note: Since DingTalk bots, Lark bots, and WeCom bots do not support all Markdown syntax, make appropriate choices when specifying the message field.*

#### EventReporter Usage Section

Using the event reporter is very simple, but note that *the `EventReporter` object must be instantiated inside the function body*.

Correct example:

~~~python
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('Custom Inspection Example')
def run(param1=1, param2=True, param3=None):
    event_reporter = EventReporter() # Correct example

    event = { ... }

    event_reporter.report(event)
~~~

*Incorrect example:*

~~~python
event_reporter = EventReporter() # Incorrect example

@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('Custom Inspection Example')
def run(param1=1, param2=True, param3=None):
    event = { ... }

    event_reporter.report(event)
~~~

Additionally, the `EventReporter.report(...)` method also supports reporting multiple events at once, such as:

~~~python
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('Custom Inspection Example')
def run(param1=1, param2=True, param3=None):
    event_reporter = EventReporter()

    events = [ { ... } ] # Multiple event data as an array

    event_reporter.report(events)
~~~

## 3. Configuring Custom Inspections in <<< custom_key.brand_name >>>

Registered custom inspection functions in <<< custom_key.brand_name >>> can be configured for running parameters and alert strategies on the <<< custom_key.brand_name >>> platform.

And the function documentation will also be displayed together, making it convenient for users to reference.

![](img/self-hosted-monitor-edit.png)

## 4. Configuring Automatic Triggers in Self-Built DataFlux Func

After completing the code and publishing it, navigate to the "Management / Automatic Trigger Configuration" section of your self-built DataFlux Func to create automatic trigger configurations for the function so that it actually runs.

![](img/self-hosted-monitor-cron-config.png)

*Note: The parameters for custom inspections are configured in <<< custom_key.brand_name >>>. The parameters specified in "Automatic Trigger Configuration" have no effect.*

After running for some time, you can view the generated events in <<< custom_key.brand_name >>>.

![](img/self-hosted-monitor-event.png)

## 5. Precautions

When using custom inspections, note the following points.

### 5.1 Association Between Functions and <<< custom_key.brand_name >>> Custom Inspections

Custom inspection functions in self-built DataFlux Func generate associated keys with <<< custom_key.brand_name >>> based on "Function ID + DataFlux Func Secret Configuration".

Therefore, if any of the following items are modified, the function will be associated with a different custom inspection:

- Function name (`def xxxx` part)
- Script ID where the function resides
- Script set ID where the function resides
- Different DataFlux Func instances (i.e., different Secrets)

### 5.2 Function Registration

Functions decorated with `@self_hosted_monitor` attempt to access <<< custom_key.brand_name >>> and register the function each time they execute.

During registration, the function's title, documentation, and parameter list are updated to <<< custom_key.brand_name >>>.

After registration, the decorator downloads the corresponding custom inspection configuration (parameter specification) from <<< custom_key.brand_name >>> and runs the function with the parameters specified in the custom inspection configuration. Parameters configured in the automatic trigger will not take effect.

### 5.3 Disabling Custom Inspections in <<< custom_key.brand_name >>>

You can disable custom inspections in the <<< custom_key.brand_name >>> platform.

However, since <<< custom_key.brand_name >>> cannot control DataFlux Func data in reverse, the automatic trigger configuration in self-built DataFlux Func will still execute normally.

After execution, the `@self_hosted_monitor` decorator accesses <<< custom_key.brand_name >>> and checks whether the corresponding custom inspection has been disabled, thus deciding whether the user-written function needs to be executed.

Therefore, in self-built DataFlux Func, the automatic trigger configuration for custom inspection functions always runs. Only when the corresponding <<< custom_key.brand_name >>> custom inspection is disabled does it immediately terminate processing.

![](img/self-hosted-monitor-disabled.png)

### 5.4 Deleting Custom Inspections in <<< custom_key.brand_name >>>

Custom inspections in <<< custom_key.brand_name >>> can be deleted. However, if the actual custom inspection exists, it will automatically recreate the custom inspection in <<< custom_key.brand_name >>> whenever it is published or run.

At the same time, since the UUID changes after deleting and recreating custom inspections, the two custom inspections before and after are not the same, and the events generated will not be associated.

## X. Appendix

### X.1 IM Platform Robot Markdown Support Documentation

- [DingTalk Custom Robots / Custom Robot Access](https://open.dingtalk.com/document/group/custom-robot-access)
- [Lark Bots / Message Cards / Construct Card Content / Markdown Module](https://open.feishu.cn/document/ukTMukTMukTM/uADOwUjLwgDM14CM4ATN)
- [WeCom Robots / Group Robot Configuration Instructions / markdown Type](https://developer.work.weixin.qq.com/document/path/91770#markdown%E7%B1%BB%E5%9E%8B)