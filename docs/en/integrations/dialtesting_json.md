---
title     : 'Custom Dial Testing Tasks'
summary   : 'Customize dial testing collectors to tailor dial testing tasks'
tags:
  - 'TESTING'
  - 'NETWORK'
__int_icon      : 'icon/dialtesting'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---


In some cases, it may not be possible to connect to the SAAS dial testing service. In such scenarios, we can define dial testing tasks using a local JSON file.

## Configuration {#config}

### Configure Collector {#config-inputs}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/network` directory under the DataKit installation directory, copy `dialtesting.conf.sample` and rename it as `dialtesting.conf`. An example is shown below:

    ```toml
    [[inputs.dialtesting]]
      server = "file://</path/to/your/local.json>"
    
      # Note: Taking Linux as an example, assuming your json directory is /some/path/my.json, then
      # the server should be written as file:///some/path/my.json
    
      # Note, it's recommended to fill in all the following tags (do not modify the tag keys here), which facilitates displaying complete dial test results on the page.
      [inputs.dialtesting.tags] 
        country  = "<specify-datakit-country>"  # Country where DataKit is deployed
        province = "<specify-datakit-province>" # Province where DataKit is deployed
        city     = "<specify-datakit-city>"     # City where DataKit is deployed
        isp      = "<specify-datakit-ISP>"      # Specifies the network service provider for DataKit
        region   = "<your-region>"              # You can arbitrarily specify a region name
    ```

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via the [ConfigMap method](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

---

### Configure Dial Testing Task {#config-task}

Currently, dial testing supports four types of tests: HTTP, TCP, ICMP, WEBSOCKET services. The JSON format is as follows:

```json
{
  "<Dial Test Type>": [
    {Dial Test Task 1},
    {Dial Test Task 2},
       ...
    {Dial Test Task n},
  ]
}
```

Below is a specific example of a dial test:

```json
{
  "HTTP": [
    {
      "name": "baidu-json-test",
      "method": "GET",
      "url": "http://baidu.com",
      "post_url": "https://<your-dataway-host>?token=<your-token>",
      "status": "OK",
      "frequency": "10s",
      "success_when_logic": "and",
      "success_when": [
        {
          "response_time": "1000ms",
          "header": {
            "Content-Type": [
              {
                "contains": "html"
              }
            ]
          },
          "status_code": [
            {
              "is": "200"
            }
          ]
        }
      ],
      "advance_options": {
        "request_options": {
          "auth": {}
        },
        "request_body": {}
      },
      "update_time": 1645065786362746
    }
  ],
  "TCP": [
    {
      "name": "tcp-test",
      "host": "www.baidu.com",
      "port": "80",
      "status": "OK",
      "frequency": "10s",
      "success_when_logic": "or",
      "success_when": [
        {
          "response_time": [
            {
              "is_contain_dns": true,
              "target": "10ms"
            }
          ]
        }
      ],
      "update_time": 1641440314550918
    }
  ]
}
```

> After editing this JSON, it is recommended to use some [online tools](https://www.json.cn/){:target="_blank"} to verify if the JSON format is correct. If the JSON format is incorrect, it will result in the dial test not functioning properly.

After configuring, simply restart DataKit.

### Dial Testing Task Field Definitions {#field-def}

Dial testing task fields include "common fields" and "additional fields" specific to each dial test task.

#### Common Fields {#pub}

The common field definitions for dial testing tasks are as follows:

| Field                 | Type   | Required | Description                                                                                     |
| :---                 | ---    | ---      | ---                                                                                  |
| `name`               | string | Y        | Name of the dial testing service                                                                         |
| `status`             | string | Y        | Status of the dial testing service, such as `OK/stop`                                                           |
| `frequency`          | string | Y        | Frequency of the dial test                                                                             |
| `success_when_logic` | string | N        | Logical relationship between `success_when` conditions, such as `and/or`, default is `and`                         |
| `success_when`       | object | Y        | See below                                                                             |
| `advance_options`    | object | N        | See below                                                                             |
| `post_url`           | string | N        | Send the dial test results to the workspace pointed to by this Token; if not filled, send to the current DataKit workspace |
| `tags_info`           | string | N        | Custom tags for the dial test task, such as: `t1,t2` |
| `workspace_language`  | string | N        | Current workspace language, such as: `zh`, `en` |

#### HTTP Dial Testing {#http}

Additional Fields

| Field              | Type   | Required | Description                                    |
| :---              | ---    | ---      | ---                                     |
| `method`          | string | Y        | HTTP request method                           |
| `url`             | string | Y        | Complete HTTP request address                    |
| `post_script`     | string | N        | Pipeline script, used for result judgment and variable extraction                    |

Overall JSON structure is as follows:

``` json
{
  "HTTP": [
    {
      "name": "baidu-json-test",
      "method": "GET",
      "url": "http://baidu.com",
      "post_url": "https://<your-dataway-host>?token=<your-token>",
      "status": "OK",
      "frequency": "10s",
      "success_when_logic": "and",
      "success_when": ...,
      "advance_options": ...,
      "post_script":...,
    },
    {
      ... another HTTP dialtesting
    }
  ]
}
```

##### `success_when` Definition {#http-success-when}

Used to define the criteria for determining whether a dial test succeeds or fails, mainly including the following aspects:

- HTTP Request Return Body Judgment (`body`)

| Field              | Type   | Required | Description                                      |
| :---              | ---    | ---      | ---                                       |
| `is`              | string | N        | Whether the returned body equals the specified field                   |
| `is_not`          | string | N        | Whether the returned body does not equal the specified field                 |
| `match_regex`     | string | N        | Whether the returned body contains the substring matching the regular expression   |
| `not_match_regex` | string | N        | Whether the returned body does not contain the substring matching the regular expression |
| `contains`        | string | N        | Whether the returned body contains the specified substring             |
| `not_contains`    | string | N        | Whether the returned body does not contain the specified substring           |

For example:

```json
"success_when": [
  {
    "body": [
      {
        "match_regex": "\\d\\d.*",
      }
    ]
  }
]
```

Here, multiple validation rules can be configured for `body`, determined by `success_when_logic`. When set to `and`, **if any rule fails, the current dial test is considered failed**; when set to `or`, **if any rule passes, the current dial test is considered successful**; the default is an `and` relationship. The same principle applies to the validation rules below.

> Note that the regular expressions need to be correctly escaped; the actual regular expression in the example is `\d\d.*`.

- HTTP Request Return Header Judgment (`header`)

| Field              | Type   | Required | Description                                                       |
| :---              | ---    | ---      | ---                                                        |
| `is`              | string | N        | Whether the specified header field equals the specified value                     |
| `is_not`          | string | N        | Whether the specified header field does not equal the specified value                   |
| `match_regex`     | string | N        | Whether the specified header field contains the substring matching the regular expression   |
| `not_match_regex` | string | N        | Whether the specified header field does not contain the substring matching the regular expression |
| `contains`        | string | N        | Whether the specified header field contains the specified substring             |
| `not_contains`    | string | N        | Whether the specified header field does not contain the specified substring           |

For example:

```json
"success_when": [
  {
    "header": {
       "Content-Type": [
         {
           "contains": "html"
         }
       ]
    }
  }
]
```

Since there may be various types of headers to judge, multiple headers can also be configured for inspection:

```json
"success_when": [
  {
    "header": {
       "Content-Type": [
         {
           "contains": "some-header-value"
         }
       ],

       "Etag": [
         {
           "match_regex": "\\d\\d-.*"
         }
       ]
    }
  }
]
```

- HTTP Request Return Status Code (`status_code`)

| Field              | Type   | Required | Description                                             |
| :---              | ---    | ---      | ---                                              |
| `is`              | string | N        | Whether the returned status code equals the specified field                   |
| `is_not`          | string | N        | Whether the returned status code does not equal the specified field                 |
| `match_regex`     | string | N        | Whether the returned status code contains the substring matching the regular expression   |
| `not_match_regex` | string | N        | Whether the returned status code does not contain the substring matching the regular expression |
| `contains`        | string | N        | Whether the returned status code contains the specified substring             |
| `not_contains`    | string | N        | Whether the returned status code does not contain the specified substring           |

For example:

```json
"success_when": [
  {
    "status_code": [
      {
        "is": "200"
      }
    ]
  }
]
```

> For a determined URL test, its HTTP response generally has only one return, so usually only one validation rule is configured here (although multiple configurations in an array are supported).

- HTTP Request Response Time (`response_time`)

Only one time value can be entered here. If the response time of the request is less than the specified value, the dial test is judged as successful, for example:

```json
"success_when": [
  {
    "response_time": "100ms"
  }
]
```

> Note that the time units specified here are `ns` (nanoseconds) / `us` (microseconds) / `ms` (milliseconds) / `s` (seconds) / `m` (minutes) / `h` (hours). For HTTP dial testing, the `ms` unit is generally used.

The several judgment criteria listed above can be combined, determined by `success_when_logic`. When set to `and`, **if any rule fails, the current dial test is considered failed**; when set to `or`, **if any rule passes, the current dial test is considered successful**; the default is an `and` relationship. For example:

```json
"success_when": [
  {
    "response_time": "1000ms",
    "header": { HTTP header related judgment },
    "status_code": [ HTTP status code related judgment ],
    "body": [ HTTP body related judgment ]
  }
]
```

##### `advance_options` Definition {#http-advance-options}

Advanced options are mainly used to adjust specific dial test behaviors, mainly including the following aspects:

- HTTP Request Options (`request_options`)

| Field              | Type              | Required | Description                       |
| :---              | ---               | ---      | ---                        |
| `follow_redirect` | bool              | N        | Whether to support redirection         |
| `headers`         | map[string]string | N        | Specify a group of Headers for HTTP requests |
| `cookies`         | string            | N        | Specify the request Cookie          |
| `auth`            | object            | N        | Specify the request authentication method         |

Among these, `auth` only supports basic username/password authentication, defined as follows:

| Field       | Type   | Required | Description       |
| :---       | ---    | ---      | ---        |
| `username` | string | Y        | Username     |
| `password` | string | Y        | Password     |

`request_options` Example:

```json
"advance_options": {
  "request_options": {
    "auth": {
        "username": "Zhang San",
        "password": "fawaikuangtu"
      },
    "headers": {
      "X-Prison-Breaker": "Zhang San",
      "X-Prison-Break-Password": "fawaikuangtu"
    },
    "follow_redirect": false
  },
}
```

- HTTP Request Body (`request_body`)

| Field        | Type   | Required | Description                                    |
| :---        | ---    | ---      | ---                                     |
| `body_type` | string | N        | Body type, i.e., the value of the request header `Content-Type` |
| `body`      | string | N        | Request Body                               |

`request_body` Example:

```json
"advance_options": {
  "request_body": {
    "body_type": "text/html",
    "body": "Fill in the request body, pay attention to various complex escapes here"
  }
}
```

- HTTP Request Certificate (`certificate`)

| Field                              | Type   | Required | Description             |
| :---                              | ---    | ---      | ---              |
| `ignore_server_certificate_error` | bool   | N        | Whether to ignore certificate errors |
| `private_key`                     | string | N        | Private key              |
| `certificate`                     | string | N        | Certificate             |
| `ca`                              | string | N        | Not currently in use       |

`certificate` Example:

```json
"advance_options": {
  "certificate": {
    "ignore_server_certificate_error": false,
    "private_key": "<your-private-key>",
    "certificate": "<your-certificate-key>"
  },
}
```

`private_key` Example:

``` not-set
-----BEGIN PRIVATE KEY-----
MIIxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxNn+/x
9WKHZvRf3lbLY7GAR/emacU=
-----END PRIVATE KEY-----
```

Below is the `certificate` example:

```not-set
-----BEGIN CERTIFICATE-----
MIIxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxWDR/+
InEHyg==
-----END CERTIFICATE-----
```

On Linux, the key pair can be generated with the following command:

```shell
openssl req -newkey rsa:2048 -x509 -sha256 -days 3650 -nodes -out example.crt -keyout example.key
```

- HTTP Request Proxy (`proxy`)

| Field      | Type              | Required | Description                                 |
| :---      | ---               | ---      | ---                                  |
| `url`     | string            | N        | Proxy URL, such as `http://1.2.3.4:4321` |
| `headers` | map[string]string | N        | Specify a group of Headers for HTTP requests           |

`proxy` Example:

```json
"advance_options": {
  "request_options": {
    "proxy": {
      "url": "http://1.2.3.4:4321",
      "headers": {
        "X-proxy-header": "my-proxy-foobar"
      }
    }
  },
}
```

##### `post_script` Definition {#post_script}

`post_script` is a [Pipeline](../pipeline/use-pipeline/index.md) script used to evaluate dial test results and extract variables.

##### Injected Variables {#inject-variables}

To facilitate the handling of HTTP responses and evaluation of test results within `post_script`, predefined variables can be used when writing scripts. Specifically:

- `response`: Response Object

| Field              | Type   | Description                                    |
| :---              | ---    | ---                                     |
| `status_code`     | number | Response status code                           |
| `header`          | json | Response header, format is `{"header1": ["value1", "value2"]}`|
| `body`            | string | Response content|

- `result`: Test Result

| Field              | Type   | Description                                    |
| :---              | ---    | ---                                     |
| `is_failed`     | bool | Whether it failed                           |
| `error_message`     | string | Reason for failure                           |

- `vars`: Extracted Variables

JSON object, key as variable name, value as variable value, e.g., `vars["token"] = "123"`

##### Example {#example}

```javascript

body = load_json(response["body"])

if body["code"] == "200" {
  result["is_failed"] = false
  vars["token"] = body["token"]
} else {
  result["is_failed"] = true
  result["error_message"] = body["message"]
}

```

In the script above, first use `load_json` to parse the response content into a JSON object, then check if the response status code is 200. If it is 200, extract the token from the response content and set it in `vars`; otherwise, set `result`'s `is_failed` to true, and set `error_message` to the message in the response content.

#### TCP Dial Testing {#tcp}

##### Additional Fields {#tcp-extra}

| Field              | Type   | Required | Description                                    |
| :---              | ---    | ---      | ---                                     |
| `host`          | string | Y        | TCP host address                           |
| `port`             | string | Y        | TCP port                    |
| `timeout`             | string | N        | TCP connection timeout time                    |
| `message`       | string | N        | TCP message sent                |

Complete JSON structure is as follows:

``` json
{
    "TCP": [
        {
            "name": "tcp-test",
            "host": "www.baidu.com",
            "port": "80",
            "message": "hello",
            "timeout": "10ms",
            "enable_traceroute": true,
            "post_url": "https://<your-dataway-host>?token=<your-token>",
            "status": "OK",
            "frequency": "60s",
            "success_when_logic": "and",
            "success_when": [
                {
                    "response_time":[ 
                        {
                            "is_contain_dns": true,
                            "target": "10ms"
                        }
                    ],
                    "response_message": [
                        {
                            "is": "hello"
                        }
                    ],
                    "hops": [
                        {
                            "op": "eq",
                            "target": 20
                        }
                    ]
                }
            ]
        }
    ]
}
```

##### `success_when` Definition {#tcp-success-when}

- TCP Response Time Judgment (`response_time`)

`response_time` is an array object, each object parameter is as follows:

| Field              | Type   | Required | Description                                                       |
| :---              | ---    | ---      | ---                                                        |
| `target`          | string | Y        | Determine if the response time is less than this value                     |
| `is_contain_dns`  | bool | N        | Indicate whether the response time includes DNS resolution time                     |

```json
"success_when": [
  {
    "response_time": [
      {
        "is_contain_dns": true,
        "target": "10ms"
      }
    ]
  }
]
```

- Return Message Judgment (`response_message`)

`response_message` is an array object, each object parameter is as follows:

| Field              | Type   | Required | Description                                                |
| :---              | ---    | ---      | ---                                                 |
| `is`              | string | N        | Whether the returned message equals the specified field                   |
| `is_not`          | string | N        | Whether the returned message does not equal the specified field                 |
| `match_regex`     | string | N        | Whether the returned message contains the substring matching the regular expression   |
| `not_match_regex` | string | N        | Whether the returned message does not contain the substring matching the regular expression |
| `contains`        | string | N        | Whether the returned message contains the specified substring             |
| `not_contains`    | string | N        | Whether the returned message does not contain the specified substring           |

For example:

```json
"success_when": [
  {
    "response_message": [
      {
        "is": "reply",
      }
    ]
  }
]
```

- Network Hops (`hops`)

`hops` is an array object, each object parameter is as follows:

| Field              | Type   | Required | Description                                      |
| :---              | ---    | ---      | ---                                       |
| `op`              | string | Y        | Comparison relation, possible values `eq(=),lt(<),leq(<=),gt(>),geq(>=)`|
| `target`          | float | Y        | Determination value                 |

```json
"success_when": [
  {
    "hops": [
      {
        "op": "eq",
        "target": 20
      }
    ]
  }
]
```

#### ICMP Dial Testing {#icmp}

##### Additional Fields {#icmp-extra}

| Field              | Type   | Required | Description                                    |
| :---              | ---    | ---      | ---                                     |
| `host`            | string | Y        | Host address                           |
| `packet_count`    | int |   N         | Number of ICMP packets sent  
| `timeout`             | string | N    | Connection timeout time

Complete JSON structure is as follows:

``` json
{
    "ICMP": [
        {
            "name": "icmp-test",
            "host": "www.baidu.com",
            "timeout": "10ms",
            "packet_count": 3,
            "enable_traceroute": true,
            "post_url": "https://<your-dataway-host>?token=<your-token>",
            "status": "OK",
            "frequency": "10s",
            "success_when_logic": "and",
            "success_when": [
                {
                    "response_time": [
                        {
                            "func": "avg",
                            "op": "leq",
                            "target": "50ms"
                        }
                    ],
                    "packet_loss_percent": [
                        {
                            "op": "leq",
                            "target": 20
                        }
                    ],
                    "hops": [
                        {
                            "op": "eq",
                            "target": 20
                        }
                    ],
                    "packets": [
                        {
                            "op": "geq",
                            "target": 1
                        }
                    ]
                }
            ]
        }
    ]
}
```

##### `success_when` Definition {#icmp-success-when}

- ICMP Packet Loss Rate (`packet_loss_percent`)

Fill in specific values, as an array object, each object parameter is as follows:

| Field              | Type   | Required | Description                                      |
| :---              | ---    | ---      | ---                                       |
| `op`              | string | Y        | Comparison relation, possible values `eq(=),lt(<),leq(<=),gt(>),geq(>=)`|
| `target`          | float | Y        | Determination value                 |

```json
"success_when": [
  {
    "packet_loss_percent": [
      {
        "op": "leq",
        "target": 20
      }
    ]
  }
]
```

- ICMP Response Time (`response_time`)

Fill in specific times, as an array object, each object parameter is as follows:

| Field              | Type   | Required | Description                                      |
| :---              | ---    | ---      | ---                                       |
| `func`            | string | Y        | Statistical type, possible values `avg,min,max,std`|
| `op`              | string | Y        | Comparison relation, possible values `eq(=),lt(<),leq(<=),gt(>),geq(>=)`|
| `target`          | string | Y        | Determination value                 |

```json
"success_when": [
  {
     "response_time": [
        {
          "func": "avg",
          "op": "leq",
          "target": "50ms"
        }
      ],
  }
]
```

- Network Hops (`hops`)

`hops` is an array object, each object parameter is as follows:

| Field              | Type   | Required | Description                                      |
| :---              | ---    | ---      | ---                                       |
| `op`              | string | Y        | Comparison relation, possible values `eq(=),lt(<),leq(<=),gt(>),geq(>=)`|
| `target`          | float | Y        | Determination value                 |

```json
"success_when": [
  {
    "hops": [
      {
        "op": "eq",
        "target": 20
      }
    ]
  }
]
```

- Captured Packets (`packets`)

`packets` is an array object, each object parameter is as follows:

| Field              | Type   | Required | Description                                      |
| :---              | ---    | ---      | ---                                       |
| `op`              | string | Y        | Comparison relation, possible values `eq(=),lt(<),leq(<=),gt(>),geq(>=)`|
| `target`          | float | Y        | Determination value                 |

```json
"success_when": [
  {
    "packets": [
      {
        "op": "eq",
        "target": 20
      }
    ]
  }
]
```

#### WEBSOCKET Dial Testing {#ws}

##### Additional Fields {#ws-extra}

| Field              | Type   | Required | Description                                    |
| :---              | ---    | ---      | ---                                     |
| `url`          | string | Y        | Websocket connection address, such as ws://localhost:8080  |
| `message`       | string | Y        | Message sent after a successful Websocket connection                |

Complete JSON structure is as follows:

```json
{
    "WEBSOCKET": [
        {
            "name": "websocket-test",
            "url": "ws://localhost:8080",
            "message": "hello",
            "post_url": "https://<your-dataway-host>?token=<your-token>",
            "status": "OK",
            "frequency": "10s",
            "success_when_logic": "and",
            "success_when": [
                {
                    "response_time": [
                        {
                            "is_contain_dns": true,
                            "target": "10ms"
                        }
                    ],
                    "response_message": [
                        {
                            "is": "hello1"
                        }
                    ],
                    "header": {
                        "status": [
                            {
                                "is": "ok"
                            }
                        ]
                    }
                }
            ],
            "advance_options": {
                "request_options": {
                    "timeout": "10s",
                    "headers": {
                        "x-token": "aaaaaaa",
                        "x-header": "111111"
                    }
                },
                "auth": {
                    "username": "admin",
                    "password": "123456"
                }
            }
        }
    ]
}
```

##### `success_when` Definition {#ws-success-when}

- Response Time Judgment (`response_time`)

`response_time` is an array object, each object parameter is as follows:

| Field             | Type   | Required | Description                              |
| :---             | ---    | ---      | ---                               |
| `target`         | string | Y        | Determine if the response time is less than this value          |
| `is_contain_dns` | bool   | N        | Indicate whether the response time includes DNS resolution time |

```json
"success_when": [
  {
    "response_time": [
      {
        "is_contain_dns": true,
        "target": "10ms"
      }
    ]
  }
]
```

- Return Message Judgment (`response_message`)

`response_message` is an array object, each object parameter is as follows:

| Field              | Type   | Required | Description                                                |
| :---              | ---    | ---      | ---                                                 |
| `is`              | string | N        | Whether the returned message equals the specified field                   |
| `is_not`          | string | N        | Whether the returned message does not equal the specified field                 |
| `match_regex`     | string | N        | Whether the returned message contains the substring matching the regular expression   |
| `not_match_regex` | string | N        | Whether the returned message does not contain the substring matching the regular expression |
| `contains`        | string | N        | Whether the returned message contains the specified substring             |
| `not_contains`    | string | N        | Whether the returned message does not contain the specified substring           |

For example:

```json
"success_when": [
  {
    "response_message": [
      {
        "is": "reply",
      }
    ]
  }
]
```

- Request Return Header Judgment (`header`)

`header` is a dictionary-type object, each element's value being an array object, with the corresponding parameters as follows:

| Field              | Type   | Required | Description                                                       |
| :---              | ---    | ---      | ---                                                        |
| `is`              | string | N        | Whether the specified header field equals the specified value                     |
| `is_not`          | string | N        | Whether the specified header field does not equal the specified value                   |
| `match_regex`     | string | N        | Whether the specified header field contains the substring matching the regular expression   |
| `not_match_regex` | string | N        | Whether the specified header field does not contain the substring matching the regular expression |
| `contains`        | string | N        | Whether the specified header field contains the specified substring             |
| `not_contains`    | string | N        | Whether the specified header field does not contain the specified substring           |

For example:

```json
"success_when": [
  {
    "header": {
       "Status": [
         {
           "is": "ok"
         }
       ]
    }
  }
]
```

##### `advance_options` Definition {#ws-advance-options}

- Request Options (`request_options`)

| Field              | Type              | Required | Description                       |
| :---              | ---               | ---      | ---                        |
| `timeout` | string              | N        | Connection timeout time         |
| `headers` | map[string]string | N        | Specify a group of Headers for the request |

```json
"advance_options": {
  "request_options": {
    "timeout": "30ms",
    "headers": {
      "X-Token": "xxxxxxxxxx"
    }
  },
}
```

- Authentication Information (`auth`)

Supports ordinary username and password authentication (Basic access authentication).

| Field       | Type   | Required | Description       |
| :---       | ---    | ---      | ---        |
| `username` | string | Y        | Username     |
| `password` | string | Y        | Password     |

```json
"advance_options": {
  "auth": {
    "username": "admin",
    "password": "123456"
  },
}
```