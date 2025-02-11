---
title: 'Pythond'
summary: 'Collect data through Python extensions'
tags:
  - 'PYTHON'
__int_icon: 'icon/pythond'
dashboard:
  - desc: 'None available'
    path: '-'
monitor:
  - desc: 'None available'
    path: '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

Pythond is a comprehensive solution for periodically triggering user-defined Python collection scripts.

## Configuration {#config}

Navigate to the *conf.d/pythond* directory under the DataKit installation directory, copy *pythond.conf.sample*, and rename it to *pythond.conf*. An example is as follows:

```toml
[[inputs.pythond]]
  # Python input name
  name = 'some-python-inputs'  # required

  # System environments to run Python
  #envs = ['LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH',]

  # Python path (recommended absolute Python path)
  cmd = "python3" # required. python3 is recommended.

  # Python scripts relative path
  dirs = []
```

### Python Environment {#req-python}

Currently in alpha phase, **only compatible with Python 3+**. Tested versions:

- [x] 3.10.1

The following libraries need to be installed:

- requests

Installation method is as follows:

```shell
# python3
python3 -m pip install requests
```

The above installation requires pip. If you don't have it, you can refer to the following method ([source](https://pip.pypa.io/en/stable/installation/){:target="_blank"}):

```shell
# Linux/MacOS
python -m ensurepip --upgrade

# Windows
py -m ensurepip --upgrade
```

### Writing User-defined Scripts {#add-script}

Create a directory named after the "Python package name" under the `datakit/python.d` directory, then create Python scripts (`*.py`) within this directory.

For example, if the package name is `Demo`, its path structure would be as follows. Here, `demo.py` is the Python script, and the filename of the Python script can be customized:

```shell
datakit
   └── python.d
       ├── Demo
       │   ├── demo.py
```

The Python script needs to inherit from the `DataKitFramework` class and override the `run` method.

> The source code file path for the `DataKitFramework` class is `datakit_framework.py` located at `datakit/python.d/core/datakit_framework.py`.

<!-- markdownlint-disable MD046 -->
???- note "Python Script Source Code Example"

    ```python
    #encoding: utf-8

    from datakit_framework import DataKitFramework

    class Demo(DataKitFramework):
        name = 'Demo'
        interval = 10 # triggered interval seconds.

        # if your datakit ip is 127.0.0.1 and port is 9529, you won't need use this,
        # just comment it.
        # def __init__(self, **kwargs):
        #     super().__init__(ip = '127.0.0.1', port = 9529)

        # General report example.
        def run(self):
            print("Demo")
            data = [
                    {
                        "measurement": "abc",
                        "tags": {
                        "t1": "b",
                        "t2": "d"
                        },
                        "fields": {
                        "f1": 123,
                        "f2": 3.4,
                        "f3": "strval"
                        },
                        # "time": 1624550216 # you don't need this
                    },

                    {
                        "measurement": "def",
                        "tags": {
                        "t1": "b",
                        "t2": "d"
                        },
                        "fields": {
                        "f1": 123,
                        "f2": 3.4,
                        "f3": "strval"
                        },
                        # "time": 1624550216 # you don't need this
                    }
                ]

            in_data = {
                'M':data, # 'M' for metrics, 'L' for logging, 'R' for rum, 'O' for object, 'CO' for custom object, 'E' for event.
                'input': "datakitpy"
            }

            return self.report(in_data) # you must call self.report here

        # # KeyEvent report example.
        # def run(self):
        #     print("Demo")

        #     tags = {"tag1": "val1", "tag2": "val2"}
        #     date_range = 10
        #     status = 'info'
        #     event_id = 'event_id'
        #     title = 'title'
        #     message = 'message'
        #     kwargs = {"custom_key1":"custom_value1", "custom_key2": "custom_value2", "custom_key3": "custom_value3"}

        #     # Feed df_source=user event.
        #     user_id="user_id"
        #     return self.feed_user_event(
        #         user_id,
        #         tags, date_range, status, event_id, title, message, **kwargs
        #         )

        #     # Feed df_source=monitor event.
        #     dimension_tags='{"host":"web01"}' # dimension_tags must be the String(JSON format).
        #     return self.feed_monitor_event(
        #         dimension_tags,
        #         tags, date_range, status, event_id, title, message, **kwargs
        #         )

        #     # Feed df_source=system event.
        #     return self.feed_system_event(
        #         tags, date_range, status, event_id, title, message, **kwargs
        #         )

        # # metrics, logging, object example.
        # def run(self):
        #     print("Demo")

        #     measurement = "mydata"
        #     tags = {"tag1": "val1", "tag2": "val2"}
        #     fields = {"custom_field1": "val1","custom_field2": 1000}
        #     kwargs = {"custom_key1":"custom_value1", "custom_key2": "custom_value2", "custom_key3": "custom_value3"}

        #     # Feed metrics example.
        #     return self.feed_metric(
        #         measurement=measurement,
        #         tags=tags,
        #         fields=fields,
        #         **kwargs
        #         )

        #     # Feed logging example.
        #     message = "This is the message for testing"
        #     return self.feed_logging(
        #         source=measurement,
        #         tags=tags,
        #         message=message,
        #         **kwargs
        #         )

        #     # Feed object example.
        #     name = "name"
        #     return self.feed_object(
        #         cls=measurement,
        #         name=name,
        #         tags=tags,
        #         fields=fields,
        #         **kwargs
        #         )
    ```
<!-- markdownlint-enable -->

Python SDK API definition (see details in `datakit_framework.py`):

- Reporting metrics data: `feed_metric(self, input=None, measurement=None, tags=None, fields=None, time=None, **kwargs)`;
- Reporting logging data: `feed_logging(self, input=None, source=None, tags=None, message=None, time=None, **kwargs)`;
- Reporting object data: `feed_object(self, input=None, cls=None, name=None, tags=None, fields=None, time=None, **kwargs)`; (`cls` stands for `class`. Since `class` is a keyword in Python, it is abbreviated as `cls`)

### Writing Pythond Event Reporting {#report-event}

You can use the following three built-in functions to report events:

- Reporting events with `df_source = user`: `feed_user_event(self, df_user_id=None, tags=None, df_date_range=10, df_status=None, df_event_id=None, df_title=None, df_message=None, **kwargs)`
- Reporting events with `df_source = monitor`: `feed_monitor_event(self, df_dimension_tags=None, tags=None, df_date_range=10, df_status=None, df_event_id=None, df_title=None, df_message=None, **kwargs)`
- Reporting events with `df_source = system`: `feed_system_event(self, tags=None, df_date_range=10, df_status=None, df_event_id=None, df_title=None, df_message=None, **kwargs)`

Common event field descriptions:

| Field Name      | Type                  | Required | Description                                                                 |
| --------------- | --------------------- | -------- | --------------------------------------------------------------------------- |
| df_date_range   | Integer               | Yes      | Time range. Unit is seconds                                                 |
| df_source       | String                | Yes      | Data source. Values are `system`, `monitor`, `user`                        |
| df_status       | Enum                  | Yes      | Status. Values are `ok`, `info`, `warning`, `error`, `critical`, `nodata`  |
| df_event_id     | String                | Yes      | Event ID                                                                    |
| df_title        | String                | Yes      | Title                                                                       |
| df_message      | String                | No       | Detailed description                                                        |
| {other fields}  | `kwargs`, e.g., `k1=5, k2=6` | No       | Other additional fields                                                    |

- When `df_source = monitor`:

Events generated by Guance's monitoring features, with the following additional fields:

| Additional Field Name | Type             | Required | Description                          |
| --------------------- | ---------------- | -------- | ------------------------------------ |
| df_dimension_tags     | String(JSON)     | Yes      | Detection dimension tags, e.g., `{"host":"web01"}` |

- When `df_source = user`:

Events created directly by users, with the following additional fields:

| Additional Field Name | Type   | Required | Description    |
| --------------------- | ------ | -------- | -------------- |
| df_user_id            | String | Yes      | User ID        |

- When `df_source = system`:

System-generated events, with no additional fields.

Usage example:

```python
#encoding: utf-8

from datakit_framework import DataKitFramework

class Demo(DataKitFramework):
    name = 'Demo'
    interval = 10 # triggered interval seconds.

    # if your datakit ip is 127.0.0.1 and port is 9529, you won't need use this,
    # just comment it.
    # def __init__(self, **kwargs):
    #     super().__init__(ip = '127.0.0.1', port = 9529)

    # KeyEvent report example.
    def run(self):
        print("Demo")

        tags = {"tag1": "val1", "tag2": "val2"}
        date_range = 10
        status = 'info'
        event_id = 'event_id'
        title = 'title'
        message = 'message'
        kwargs = {"custom_key1":"custom_value1", "custom_key2": "custom_value2", "custom_key3": "custom_value3"}

        # Feed df_source=user event.
        user_id="user_id"
        return self.feed_user_event(
            df_user_id=user_id,
            tags=tags, df_date_range=date_range, df_status=status, df_event_id=event_id, df_title=title, df_message=message, **kwargs
            )

        # Feed df_source=monitor event.
        dimension_tags='{"host":"web01"}' # dimension_tags must be the String(JSON format).
        return self.feed_monitor_event(
            df_dimension_tags=dimension_tags,
            tags=tags, df_date_range=date_range, df_status=status, df_event_id=event_id, df_title=title, df_message=message, **kwargs
            )

        # Feed df_source=system event.
        return self.feed_system_event(
            tags=tags, df_date_range=date_range, df_status=status, df_event_id=event_id, df_title=title, df_message=message, **kwargs
            )
```

### Git Support {#git}

Supports using git repositories. Once the git repo feature is enabled, the paths specified in the conf's args are relative to `gitrepos`. For example, in the following situation, args should be set to `mytest`:

```shell
├── datakit
└── gitrepos
    └── myconf
        ├── conf.d
        │   └── pythond.conf
        └── python.d
            └── mytest
                └── mytest.py
```

## Complete Example {#example}

Step 1: Write a class that inherits from `DataKitFramework`:

```python
from datakit_framework import DataKitFramework

class MyTest(DataKitFramework):
    name = 'MyTest'
    interval = 10 # triggered interval seconds.

    # if your datakit ip is 127.0.0.1 and port is 9529, you won't need use this,
    # just comment it.
    # def __init__(self, **kwargs):
    #     super().__init__(ip = '127.0.0.1', port = 9529)

    def run(self):
        print("MyTest")
        data = [
                {
                    "measurement": "abc",
                    "tags": {
                      "t1": "b",
                      "t2": "d"
                    },
                    "fields": {
                      "f1": 123,
                      "f2": 3.4,
                      "f3": "strval"
                    },
                    # "time": 1624550216 # you don't need this
                },

                {
                    "measurement": "def",
                    "tags": {
                      "t1": "b",
                      "t2": "d"
                    },
                    "fields": {
                      "f1": 123,
                      "f2": 3.4,
                      "f3": "strval"
                    },
                    # "time": 1624550216 # you don't need this
                }
            ]

        in_data = {
            'M':data,
            'input': "datakitpy"
        }

        return self.report(in_data) # you must call self.report here
```

Step 2: We do not enable the git repo feature here. Place `test.py` in the `mytest` folder under `python.d`:

```shell
└── python.d
    ├── mytest
    │   ├── test.py
```

Step 3: Configure *pythond.conf*:

```toml
[[inputs.pythond]]

  # Python collector name
  name = 'some-python-inputs'  # required

  # Environment variables needed to run the Python collector
  #envs = ['LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH',]

  # Path to the Python executable (absolute path is recommended)
  cmd = "python3" # required. python3 is recommended.

  # Relative path to user scripts (enter the folder name; all modules and .py files in the subdirectories will be applied)
  dirs = ["mytest"]
```

Step 4: Restart DataKit:

```shell
sudo datakit service -R
```

## FAQ {#faq}

### :material-chat-question: How to Troubleshoot Errors {#log}

If the results are not as expected, check the following log files:

- `~/_datakit_pythond_cli.log`
- `_datakit_pythond_framework_[pythond name]_.log`

### Error Message "[module] not found" {#found}

1. First, check if the module name case matches;
2. If issue `1` is resolved, then check if all modules imported in the Python script are installed;
</example>
</example>