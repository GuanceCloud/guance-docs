# Self-hosted Inspection

<<< custom_key.brand_name >>> supports custom intelligent inspections through DataFlux Func, based on intelligent algorithms, automatically detecting infrastructure and application issues, helping users identify problems that have occurred and potential issues in the operation of IT systems. By performing root cause analysis, it quickly identifies the reasons for anomalies.

DataFlux Func is a platform for developing, managing, and executing functions. It is easy to use, requiring no setup of web services from scratch or management of servers and other infrastructure. You only need to write and publish code, with simple configuration generating HTTP API interfaces for the functions.

This document primarily introduces how to use the script package 「<<< custom_key.brand_name >>> Self-hosted Inspection Core Package」from the DataFlux Func Script Market to implement inspection functions in self-hosted DataFlux Func.

> Tip 1: Always use the latest version of DataFlux Func for operations.

> Tip 2: This script package will continuously add new features, please keep an eye on document updates.

## 1. Prerequisites

- [Install DataFlux Func](https://func.guance.com/doc/quick-start/) 

- [Install Script Packages](https://func.guance.com/doc/script-market-basic-usage/) 

## 2. Quick Start

To set up self-hosted inspections, follow these steps:

1. Create an API Key for operations in <<< custom_key.brand_name >>>「Manage / API Key Management」
2. Install the 「<<< custom_key.brand_name >>> Self-hosted Inspection Core Package」in your self-hosted DataFlux Func via the 「Script Market」
3. Write the self-hosted inspection processing function in your self-hosted DataFlux Func
4. Create automatic trigger configurations for the written function in your self-hosted DataFlux Func through 「Manage / Automatic Trigger Configuration」

### 2.1 Writing Code

A typical self-hosted inspection processing function is as follows:

```python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__event_reporter import EventReporter

API_KEY_ID  = 'wsak_xxxxx'
API_KEY     = 'xxxxx'
GUANCE_NODE = None

# Register self-hosted inspection
@self_hosted_monitor(API_KEY_ID, API_KEY, GUANCE_NODE)
@DFF.API('Self-hosted Inspection Example')
def run(param1=1, param2=True, param3=None):
    '''
    This is an example of a self-hosted inspection.
    Parameters:
        param1 {int}  Parameter 1
        param2 {bool} Parameter 2
        param3 {str}  Parameter 3
    '''
    # Generate event reporter
    event_reporter = EventReporter()

    # ... Perform inspection processing and generate data
    event = {
        'title'  : 'Self-hosted Inspection Example',
        'message': f'''
            Self-hosted inspection content supports Markdown format, such as:

            1. The value of `param1` is `{param1}`
            2. The value of `param2` is `{param2}`
            3. The value of `param3` is `{param3}`
            ''',
        'status'        : 'error',
        'dimension_tags': { 'host': 'my_host' },
    }

    # Report events using the event reporter
    event_reporter.report(event)
```

After publishing the script, the corresponding function is registered to <<< custom_key.brand_name >>>, and can be seen in the <<< custom_key.brand_name >>> platform under 「Monitoring / Intelligent Inspection」.

![](img/self-hosted-monitor-list.png)

### 2.2 Code Explanation

The following is a step-by-step explanation of the code in this example.

#### Import Section

To properly use scripts provided by the Script Market, after installing the script package, you need to import these components using the `import` method.

~~~python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__event_reporter import EventReporter
~~~

`self_hosted_monitor` is a decorator for self-hosted inspection functions, which registers functions decorated with this decorator to <<< custom_key.brand_name >>>.

`EventReporter` is an event reporter used to report event data.

#### Self-hosted Inspection Registration and Function Definition Section

For self-hosted inspections that need to be registered to <<< custom_key.brand_name >>>, they must meet the following conditions:

1. *First* decorate with the `@self_hosted_monitor` decorator
2. *Then* decorate with the `@DFF.API(...)` decorator

~~~python
API_KEY_ID  = 'wsak_xxxxx'
API_KEY     = 'xxxxx'
GUANCE_NODE = None

# Register self-hosted inspection
@self_hosted_monitor(API_KEY_ID, API_KEY, GUANCE_NODE)
@DFF.API('Self-hosted Inspection Example')
def run(param1=1, param2=True, param3=None):
    '''
    This is an example of a self-hosted inspection.
    Parameters:
        param1 {int}  Parameter 1
        param2 {bool} Parameter 2
        param3 {str}  Parameter 3
    '''
~~~

Where:

The decorator `@self_hosted_monitor` requires the API Key ID and API Key created in <<< custom_key.brand_name >>>「Manage / API Key Management」to be passed in.

The title specified in the `@DFF.API(...)` decorator appears as the title of the self-hosted inspection after registration.

The content in the function documentation appears as the documentation on the self-hosted inspection configuration page after registration.

#### Other <<< custom_key.brand_name >>> Nodes

If you need to connect to non-default nodes (Hangzhou) of <<< custom_key.brand_name >>>, you need to pass in additional <<< custom_key.brand_name >>> node name parameters. The specific code example is as follows:

~~~python
API_KEY_ID  = 'wsak_xxxxx'
API_KEY     = 'xxxxx'
GUANCE_NODE = 'aws'

@self_hosted_monitor(API_KEY_ID, API_KEY, GUANCE_NODE)
# Omitted...
~~~

> For available values of `GUANCE_NODE`, refer to [Available <<< custom_key.brand_name >>> Nodes](https://func.guance.com/doc/ui-guide-development-module-guance-node/)

<!-- 
The available values of `GUANCE_NODE` are as follows:

| <<< custom_key.brand_name >>> Node         | `GUANCE_NODE` Value |
| ------------------ | ----------------- |
| China Region 1 (Hangzhou)   | `None`            |
| China Region 2 (Ningxia)   | `aws`             |
| China Region 3 (Zhangjiakou) | `cn3`             |
| Overseas Region 1 (Oregon) | `us1`             |
-->

#### Event Section

The event data to be reported is a simple `dict`, like:

~~~python
    event = {
        'dimension_tags': { 'host': 'my_host' },

        'status' : 'error',
        'title'  : 'Self-hosted Inspection Example',
        'message': f'''
            Self-hosted inspection content supports Markdown format, such as:

            1. The value of `param1` is `{param1}`
            2. The value of `param2` is `{param2}`
            3. The value of `param3` is `{param3}`
            ''',
    }
~~~

The specific field definitions are as follows:

| Field             | Type | Required | Description                                                             |
| ---------------- | ---- | -------- | ---------------------------------------------------------------- |
| `title`          | str  | Yes      | Event title, single-line plain text                                             |
| `message`        | str  | Yes      | Event content, supports basic Markdown syntax                                 |
| `status`         | str  | Yes      | Event level<br>Options: `info`, `warning`, `error`, `critical`, `ok` |
| `dimension_tags` | dict | Optional | Detection dimensions, e.g., `{ "host": "my_host" }`                            |

*Note: Since DingTalk bots, Lark bots, and WeCom bots do not fully support all Markdown syntax, please make appropriate choices when specifying the message field.*

#### EventReporter Usage Section

Using the event reporter is very simple, but note that *you must instantiate the `EventReporter` object inside the function body*.

Correct example:

~~~python
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('Self-hosted Inspection Example')
def run(param1=1, param2=True, param3=None):
    event_reporter = EventReporter() # Correct example

    event = { ... }

    event_reporter.report(event)
~~~

*Incorrect example:*

~~~python
event_reporter = EventReporter() # Incorrect example

@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('Self-hosted Inspection Example')
def run(param1=1, param2=True, param3=None):
    event = { ... }

    event_reporter.report(event)
~~~

Additionally, the `EventReporter.report(...)` method also supports reporting multiple events at once, such as:

~~~python
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('Self-hosted Inspection Example')
def run(param1=1, param2=True, param3=None):
    event_reporter = EventReporter()

    events = [ { ... } ] # Multiple event data as an array

    event_reporter.report(events)
~~~

## 3. Configuring Self-hosted Inspections in <<< custom_key.brand_name >>>

Self-hosted inspection functions registered in <<< custom_key.brand_name >>> can be configured to run parameters and alert strategies in the <<< custom_key.brand_name >>> platform.

The function's documentation will also be displayed together for reference by users.

![](img/self-hosted-monitor-edit.png)

## 4. Configuring Automatic Trigger Settings in Self-hosted DataFlux Func

After completing and publishing the code, go to the 「Manage / Automatic Trigger Configuration」section in your self-hosted DataFlux Func to create automatic trigger configurations. Only then will the function actually run.

![](img/self-hosted-monitor-cron-config.png)

*Note: Self-hosted inspection parameters are configured in <<< custom_key.brand_name >>>. Parameters specified in 「Automatic Trigger Configuration」do not take effect.*

After running for some time, you can view the generated events in <<< custom_key.brand_name >>>.

![](img/self-hosted-monitor-event.png)

## 5. Precautions

When using self-hosted inspections, pay attention to the following points.

### 5.1 Association Between Functions and <<< custom_key.brand_name >>> Self-hosted Inspections

Self-hosted inspection functions in self-hosted DataFlux Func are associated with <<< custom_key.brand_name >>> based on 「Function ID + DataFlux Func Secret Configuration」, generating an association key.

Therefore, if any of the following items are modified, the function will be associated with a different self-hosted inspection:

- Function name (`def xxxx` part)
- Script ID where the function resides
- Script set ID where the function resides
- Different DataFlux Func (i.e., different Secret)

### 5.2 Function Registration

Functions decorated with `@self_hosted_monitor` will attempt to access <<< custom_key.brand_name >>> and register the function each time they execute.

During registration, the function's title, documentation, and parameter list will also be updated to <<< custom_key.brand_name >>>.

After registration, the decorator will download the corresponding self-hosted inspection configuration from <<< custom_key.brand_name >>> (parameter specification) and run the function with the parameters specified in the self-hosted inspection configuration. Parameters configured in automatic triggers will not take effect.

### 5.3 Disabling Self-hosted Inspections in <<< custom_key.brand_name >>>

Self-hosted inspections can be disabled in the <<< custom_key.brand_name >>> platform.

However, since <<< custom_key.brand_name >>> cannot control DataFlux Func data in reverse, the automatic trigger configuration in self-hosted DataFlux Func will still execute normally.

After execution, the `@self_hosted_monitor` decorator will check whether the corresponding self-hosted inspection has been disabled by accessing <<< custom_key.brand_name >>>, deciding whether to execute the user-written function.

Therefore, in self-hosted DataFlux Func, the automatic trigger configuration for self-hosted inspection functions will always run. Only when encountering a disabled self-hosted inspection in <<< custom_key.brand_name >>>, it will immediately end processing.

![](img/self-hosted-monitor-disabled.png)

### 5.4 Deleting Self-hosted Inspections in <<< custom_key.brand_name >>>

Self-hosted inspections in <<< custom_key.brand_name >>> can be deleted. However, if the actual self-hosted inspection exists, it will automatically recreate the self-hosted inspection in <<< custom_key.brand_name >>> upon publishing or running.

Since the UUID changes after deleting and recreating the self-hosted inspection, the two self-hosted inspections are not the same, and events generated will not be associated.

## X. Appendix

### X.1 IM Platform Bot Markdown Support Documentation

- [DingTalk Custom Bots / Custom Bot Access](https://open.dingtalk.com/document/group/custom-robot-access)
- [Lark Bots / Message Cards / Construct Card Content / Markdown Module](https://open.feishu.cn/document/ukTMukTMukTM/uADOwUjLwgDM14CM4ATN)
- [WeCom Bots / Group Bot Configuration / Markdown Type](https://developer.work.weixin.qq.com/document/path/91770#markdown%E7%B1%BB%E5%9E%8B)