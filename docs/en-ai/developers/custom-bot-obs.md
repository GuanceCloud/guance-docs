# Self-hosted Inspection

Guance supports custom intelligent inspections through DataFlux Func, which automatically detects issues in infrastructure and applications based on smart algorithms. This helps users identify problems that have occurred and potential issues during the operation of IT systems, enabling quick root cause analysis to pinpoint the source of anomalies.

DataFlux Func is a platform for developing, managing, and executing functions. It is simple to use, requiring no setup of web services from scratch or management of servers and other infrastructure. Users only need to write code, publish it, and configure it to generate HTTP API interfaces.

This document primarily introduces how to implement inspection functions using the "Guance Self-hosted Inspection Core Package" script package from the DataFlux Func Script Market in a self-hosted DataFlux Func environment.

> Tip 1: Always use the latest version of DataFlux Func for operations.

> Tip 2: This script package will continuously add new features, so please keep an eye on document updates.

## 1. Prerequisites

- [Install DataFlux Func](https://func.guance.com/doc/quick-start/) 

- [Install Script Package](https://func.guance.com/doc/script-market-basic-usage/) 

## 2. Quick Start

To set up self-hosted inspections, follow these steps:

1. Create an API Key for operations in Guance's "Management / API Key Management"
2. Install the "Guance Self-hosted Inspection Core Package" via the "Script Market" in your self-hosted DataFlux Func
3. Write a self-hosted inspection processing function in your self-hosted DataFlux Func
4. Create automatic trigger configurations for the written function through "Management / Automatic Trigger Configuration" in your self-hosted DataFlux Func

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
    This is a self-hosted inspection example.
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

After publishing the script, the corresponding function is registered with Guance and can be viewed in the "Monitoring / Intelligent Inspection" section of the Guance platform.

![](img/self-hosted-monitor-list.png)

### 2.2 Code Explanation

The following is a step-by-step explanation of the code in this example.

#### Import Section

To use the scripts provided by the Script Market, you need to import these components using the `import` statement after installing the script package.

~~~python
from guance_monitor__register import self_hosted_monitor
from guance_monitor__event_reporter import EventReporter
~~~

`self_hosted_monitor` is a decorator for self-hosted inspection functions, ensuring they are registered with Guance.

`EventReporter` is an event reporter used to report event data.

#### Self-hosted Inspection Registration and Function Definition

A self-hosted inspection function must meet the following conditions to be registered with Guance:

1. *First*, decorate with `@self_hosted_monitor`
2. *Then*, decorate with `@DFF.API(...)`

~~~python
API_KEY_ID  = 'wsak_xxxxx'
API_KEY     = 'xxxxx'
GUANCE_NODE = None

# Register self-hosted inspection
@self_hosted_monitor(API_KEY_ID, API_KEY, GUANCE_NODE)
@DFF.API('Self-hosted Inspection Example')
def run(param1=1, param2=True, param3=None):
    '''
    This is a self-hosted inspection example.
    Parameters:
        param1 {int}  Parameter 1
        param2 {bool} Parameter 2
        param3 {str}  Parameter 3
    '''
~~~

The decorator `@self_hosted_monitor` requires the API Key ID and API Key created in Guance's "Management / API Key Management".

The title specified in the `@DFF.API(...)` decorator will appear as the title of the self-hosted inspection after registration.

The content in the function documentation will appear as the documentation on the configuration page of the self-hosted inspection after registration.

#### Other Guance Nodes

If you need to connect to non-default nodes (Hangzhou) of Guance, you need to pass the node name parameter. For example:

~~~python
API_KEY_ID  = 'wsak_xxxxx'
API_KEY     = 'xxxxx'
GUANCE_NODE = 'aws'

@self_hosted_monitor(API_KEY_ID, API_KEY, GUANCE_NODE)
# Omitted...
~~~

> Refer to [Available Guance Nodes](https://func.guance.com/doc/ui-guide-development-module-guance-node) for optional values of `GUANCE_NODE`.

<!-- 
Optional values for `GUANCE_NODE` are as follows:

| Guance Node          | `GUANCE_NODE` Value |
| -------------------- | ------------------- |
| China Region 1 (Hangzhou) | `None`             |
| China Region 2 (Ningxia)  | `aws`              |
| China Region 3 (Zhangjiakou) | `cn3`            |
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

Field definitions are as follows:

| Field             | Type | Required | Description                                                             |
| ----------------- | ---- | -------- | ----------------------------------------------------------------------- |
| `title`           | str  | Yes      | Event title, single-line plain text                                     |
| `message`         | str  | Yes      | Event content, supports basic Markdown syntax                           |
| `status`          | str  | Yes      | Event level<br>Possible values: `info`, `warning`, `error`, `critical`, `ok` |
| `dimension_tags`  | dict | No       | Detection dimensions, e.g., `{ "host": "my_host" }`                     |

*Note: Since DingTalk bots, Feishu bots, and Enterprise WeChat bots do not support all Markdown syntax, choose carefully when specifying the `message` field*

#### EventReporter Usage

Using the event reporter is straightforward, but note that *the `EventReporter` object must be instantiated inside the function body*.

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

Additionally, the `EventReporter.report(...)` method supports reporting multiple events at once, like:

~~~python
@self_hosted_monitor(API_KEY_ID, API_KEY)
@DFF.API('Self-hosted Inspection Example')
def run(param1=1, param2=True, param3=None):
    event_reporter = EventReporter()

    events = [ { ... } ] # Multiple event data as an array

    event_reporter.report(events)
~~~

## 3. Configuring Self-hosted Inspections in Guance

Once registered with Guance, self-hosted inspection functions can be configured for running parameters and alert strategies in the Guance platform.

The function documentation will also be displayed, providing a reference for users.

![](img/self-hosted-monitor-edit.png)

## 4. Configuring Automatic Triggers in Self-hosted DataFlux Func

After completing and publishing the code, go to "Management / Automatic Trigger Configuration" in your self-hosted DataFlux Func to create automatic trigger configurations. Only then will the function actually run.

![](img/self-hosted-monitor-cron-config.png)

*Note: Self-hosted inspection parameters are configured in Guance, and parameters specified in "Automatic Trigger Configuration" do not take effect.*

After some time, you can view generated events in Guance.

![](img/self-hosted-monitor-event.png)

## 5. Precautions

When using self-hosted inspections, pay attention to the following points.

### 5.1 Association between Functions and Self-hosted Inspections

Self-hosted inspection functions in self-hosted DataFlux Func are associated with Guance based on "Function ID + DataFlux Func Secret Configuration".

Therefore, if any of the following items are modified, the function will be associated with a different self-hosted inspection:

- Function name (`def xxxx` part)
- Function script ID
- Function script set ID
- Different DataFlux Func (i.e., different Secret)

### 5.2 Function Registration

Functions decorated with `@self_hosted_monitor` attempt to register with Guance each time they execute.

During registration, the function's title, documentation, and parameter list are updated in Guance.

After registration, the decorator downloads the corresponding self-hosted inspection configuration from Guance (parameter settings) and runs the function with the parameters specified in the self-hosted inspection configuration. Parameters configured in automatic triggers do not take effect.

### 5.3 Disabling Self-hosted Inspections in Guance

Self-hosted inspections can be disabled in the Guance platform.

However, since Guance cannot control DataFlux Func data in reverse, the automatic trigger configuration in self-hosted DataFlux Func will continue to execute normally.

After execution, the `@self_hosted_monitor` decorator checks whether the corresponding self-hosted inspection has been disabled and decides whether to execute the user-defined function.

Thus, in self-hosted DataFlux Func, the automatic trigger configuration for self-hosted inspection functions will always run. It only ends processing immediately if the corresponding Guance self-hosted inspection is disabled.

![](img/self-hosted-monitor-disabled.png)

### 5.4 Deleting Self-hosted Inspections in Guance

Self-hosted inspections in Guance can be deleted. However, if the actual self-hosted inspection exists, it will automatically recreate itself in Guance upon publication or execution.

Since the UUID changes after deletion and recreation, the two self-hosted inspections are not the same, and events generated will not be associated.

## X. Appendix

### X.1 Markdown Support Documentation for Various IM Platform Bots

- [DingTalk Custom Bot / Custom Bot Access](https://open.dingtalk.com/document/group/custom-robot-access)
- [Feishu Bot / Message Card / Constructing Card Content / Markdown Module](https://open.feishu.cn/document/ukTMukTMukTM/uADOwUjLwgDM14CM4ATN)
- [Enterprise WeChat Bot / Group Bot Configuration / Markdown Type](https://developer.work.weixin.qq.com/document/path/91770#markdown%E7%B1%BB%E5%9E%8B)