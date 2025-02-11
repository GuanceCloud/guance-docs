---
title     : 'Custom Dial Testing Tasks'
summary   : 'Customize dial testing collectors to tailor dial testing tasks'
tags:
  - 'Dial Testing'
  - 'Network'
__int_icon      : 'icon/dialtesting'
dashboard :
  - desc  : 'None'
    path  : '-'
monitor   :
  - desc  : 'None'
    path  : '-'
---


In some cases, it may not be possible to connect to the SAAS dial testing service. In such situations, we can define dial testing tasks through a local JSON file.

## Configuration {#config}

### Configuring Collectors {#config-inputs}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Navigate to the `conf.d/network` directory under the DataKit installation directory, copy `dialtesting.conf.sample` and rename it to `dialtesting.conf`. An example is as follows:

    ```toml
    [[inputs.dialtesting]]
      server = "file://</path/to/your/local.json>"

      # Note: Taking Linux as an example, assuming your JSON directory is /some/path/my.json, then
      # server should be written as file:///some/path/my.json

      # Note: It is recommended to fill in all the following tags (do not modify these tag keys) for complete display of dial testing results on the page.
      [inputs.dialtesting.tags] 
        country  = "<specify-datakit-country>"  # Country where DataKit is deployed
        province = "<specify-datakit-province>" # Province where DataKit is deployed
        city     = "<specify-datakit-city>"     # City where DataKit is deployed
        isp      = "<specify-datakit-ISP>"      # Network service provider of DataKit
        region   = "<your-region>"              # You can specify any region name
    ```

=== "Kubernetes"

    Currently, you can enable the collector by injecting the collector configuration via [ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->

---

### Configuring Dial Testing Tasks {#config-task}

Currently, dial testing supports four types of tests: HTTP, TCP, ICMP, and WEBSOCKET services. The JSON format is as follows:

```json
{
  "<Dial Testing Type>": [
    {Dial Testing Task 1},
    {Dial Testing Task 2},
       ...
    {Dial Testing Task n},
  ]
}
```

Here is a specific dial testing example:

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

> After editing this JSON, it's recommended to validate the JSON format using some [online tools](https://www.json.cn/){:target="_blank"}. If the JSON format is incorrect, it will cause the dial test to fail.

After configuring, simply restart DataKit.

### Dial Testing Task Field Definitions {#field-def}

Dial testing task fields include "common fields" and "additional fields" specific to each type of dial testing task.

#### Common Fields {#pub}

The common fields for dial testing tasks are defined as follows:

| Field                 | Type   | Required | Description                                                                                 |
| :---                  | ---    | ---      | ---                                                                                  |
| `name`               | string | Y        | Name of the dial testing service                                                                         |
| `status`             | string | Y        | Status of the dial testing service, e.g., `OK/stop`                                                           |
| `frequency`          | string | Y        | Frequency of dial testing                                                                             |
| `success_when_logic` | string | N        | Logical relationship between `success_when` conditions, e.g., `and/or`, defaults to `and`                         |
| `success_when`       | object | Y        | See below for details                                                                             |
| `advance_options`    | object | N        | See below for details                                                                             |
| `post_url`           | string | N        | URL to send dial testing results to the workspace pointed to by this Token; if not filled, sends to the current DataKit workspace |
| `tags_info`           | string | N        | Custom tags for the dial testing task, e.g., `t1,t2` |
| `workspace_language`  | string | N        | Language of the current workspace, e.g., `zh`, `en` |

#### HTTP Dial Testing {#http}

Additional fields

| Field              | Type   | Required | Description                                    |
| :---              | ---    | ---      | ---                                     |
| `method`          | string | Y        | HTTP request method                           |
| `url`             | string | Y        | Full HTTP request URL                    |

Overall JSON structure:

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
      "success_when": ...,
      "advance_options": ...
    },
    {
      ... another HTTP dial testing
    }
  ]
}
```

##### `success_when` Definition {#http-success-when}

Used to define the criteria for determining whether a dial test succeeds or fails. There are several aspects:

- HTTP Response Body Judgment (`body`)

| Field              | Type   | Required | Description                                      |
| :---              | ---    | ---      | ---                                       |
| `is`              | string | N        | Whether the returned body equals the specified field                   |
| `is_not`          | string | N        | Whether the returned body does not equal the specified field                 |
| `match_regex`     | string | N        | Whether the returned body contains a substring matching the regex   |
| `not_match_regex` | string | N        | Whether the returned body does not contain a substring matching the regex |
| `contains`        | string | N        | Whether the returned body contains the specified substring             |
| `not_contains`    | string | N        | Whether the returned body does not contain the specified substring           |

Example:

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

The `body` can have multiple validation rules, with their relationship determined by `success_when_logic`. When set to `and`, **if any rule fails, the current dial test is considered failed**; when set to `or`, **if any rule passes, the current dial test is considered successful**. By default, it is `and`. All verification rules follow this principle.

> Note that the regex must be correctly escaped; the actual regex in the example is `\d\d.*`.

- HTTP Response Header Judgment (`header`)

| Field              | Type   | Required | Description                                                       |
| :---              | ---    | ---      | ---                                                        |
| `is`              | string | N        | Whether the specified header field equals the specified value                     |
| `is_not`          | string | N        | Whether the specified header field does not equal the specified value                   |
| `match_regex`     | string | N        | Whether the specified header field contains a substring matching the regex   |
| `not_match_regex` | string | N        | Whether the specified header field does not contain a substring matching the regex |
| `contains`        | string | N        | Whether the specified header field contains the specified substring             |
| `not_contains`    | string | N        | Whether the specified header field does not contain the specified substring           |

Example:

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

Since there can be multiple types of headers to check, multiple headers can also be configured here:

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

- HTTP Response Status Code (`status_code`)

| Field              | Type   | Required | Description                                             |
| :---              | ---    | ---      | ---                                              |
| `is`              | string | N        | Whether the returned status code equals the specified value                   |
| `is_not`          | string | N        | Whether the returned status code does not equal the specified value                 |
| `match_regex`     | string | N        | Whether the returned status code contains a substring matching the regex   |
| `not_match_regex` | string | N        | Whether the returned status code does not contain a substring matching the regex |
| `contains`        | string | N        | Whether the returned status code contains the specified substring             |
| `not_contains`    | string | N        | Whether the returned status code does not contain the specified substring           |

Example:

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

> For a specific URL dial test, generally, only one HTTP response is received, so usually only one validation rule is configured (although multiple configurations are supported).

- HTTP Response Time (`response_time`)

Only one time value can be entered here. If the request response time is less than the specified value, the dial test is considered successful, for example:

```json
"success_when": [
  {
    "response_time": "100ms"
  }
]
```

> Note that the time units available are `ns` (nanoseconds), `us` (microseconds), `ms` (milliseconds), `s` (seconds), `m` (minutes), and `h` (hours). For HTTP dial testing, generally use the `ms` unit.

All the judgment criteria listed above can be combined, with their relationship determined by `success_when_logic`. When set to `and`, **if any rule fails, the current dial test is considered failed**; when set to `or`, **if any rule passes, the current dial test is considered successful**. By default, it is `and`. Example:

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

Advanced options are mainly used to adjust specific dial testing behaviors, including:

- HTTP Request Options (`request_options`)

| Field              | Type              | Required | Description                       |
| :---              | ---               | ---      | ---                        |
| `follow_redirect` | bool              | N        | Whether to support redirection         |
| `headers`         | map[string]string | N        | HTTP request headers |
| `cookies`         | string            | N        | Request cookies          |
| `auth`            | object            | N        | Request authentication         |

The `auth` only supports basic username/password authentication, defined as follows:

| Field       | Type   | Required | Description       |
| :---       | ---    | ---      | ---        |
| `username` | string | Y        | Username     |
| `password` | string | Y        | Password |

Example of `request_options`:

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
| `body_type` | string | N        | Body type, i.e., the value of the `Content-Type` header |
| `body`      | string | N        | Request body                               |

Example of `request_body`:

```json
"advance_options": {
  "request_body": {
    "body_type": "text/html",
    "body": "Fill in the request body, note various complex escapes"
  }
}
```

- HTTP Request Certificate (`certificate`)

| Field                              | Type   | Required | Description             |
| :---                              | ---    | ---      | ---              |
| `ignore_server_certificate_error` | bool   | N        | Whether to ignore certificate errors |
| `private_key`                     | string | N        | Private key              |
| `certificate`                     | string | N        | Certificate             |
| `ca`                              | string | N        | Not currently used       |

Example of `certificate`:

```json
"advance_options": {
  "certificate": {
    "ignore_server_certificate_error": false,
    "private_key": "<your-private-key>",
    "certificate": "<your-certificate-key>"
  },
}
```

Example of `private_key`:

```not-set
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

Example of `certificate`:

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

On Linux, you can generate this key pair using the following command:

```shell
openssl req -newkey rsa:2048 -x509 -sha256 -days 3650 -nodes -out example.crt -keyout example.key
```

- HTTP Request Proxy (`proxy`)

| Field      | Type              | Required | Description                                 |
| :---      | ---               | ---      | ---                                  |
| `url`     | string            | N        | Proxy URL, e.g., `http://1.2.3.4:4321` |
| `headers` | map[string]string | N        | HTTP request headers           |

Example of `proxy`:

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

#### TCP Dial Testing {#tcp}

##### Additional Fields {#tcp-extra}

| Field              | Type   | Required | Description                                    |
| :---              | ---    | ---      | ---                                     |
| `host`          | string | Y        | TCP host address                           |
| `port`             | string | Y        | TCP port                    |
| `timeout`             | string | N        | TCP connection timeout                    |
| `message`       | string | N        | Message sent during TCP connection                |

Complete JSON structure:

```json
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

`response_time` is an array of objects, each with parameters as follows:

| Field              | Type   | Required | Description                                                       |
| :---              | ---    | ---      | ---                                                        |
| `target`          | string | Y        | Determine if the response time is less than this value                     |
| `is_contain_dns`  | bool | N        | Indicates whether the response time includes DNS resolution time                     |

Example:

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

- Returned Message Judgment (`response_message`)

`response_message` is an array of objects, each with parameters as follows:

| Field              | Type   | Required | Description                                                |
| :---              | ---    | ---      | ---                                                 |
| `is`              | string | N        | Whether the returned message equals the specified field                   |
| `is_not`          | string | N        | Whether the returned message does not equal the specified field                 |
| `match_regex`     | string | N        | Whether the returned message contains a substring matching the regex   |
| `not_match_regex` | string | N        | Whether the returned message does not contain a substring matching the regex |
| `contains`        | string | N        | Whether the returned message contains the specified substring             |
| `not_contains`    | string | N        | Whether the returned message does not contain the specified substring           |

Example:

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

`hops` is an array of objects, each with parameters as follows:

| Field              | Type   | Required | Description                                      |
| :---              | ---    | ---      | ---                                       |
| `op`              | string | Y        | Comparison operator, values can be `eq(=),lt(<),leq(<=),gt(>),geq(>=)`|
| `target`          | float | Y        | Target value                 |

Example:

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
| `timeout`             | string | N    | Connection timeout

Complete JSON structure:

```json
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

- ICMP Packet Loss Percentage (`packet_loss_percent`)

Enter a specific value, which is an array of objects, each with parameters as follows:

| Field              | Type   | Required | Description                                      |
| :---              | ---    | ---      | ---                                       |
| `op`              | string | Y        | Comparison operator, values can be `eq(=),lt(<),leq(<=),gt(>),geq(>=)`|
| `target`          | float | Y        | Target value                 |

Example:

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

Enter a specific time, which is an array of objects, each with parameters as follows:

| Field              | Type   | Required | Description                                      |
| :---              | ---    | ---      | ---                                       |
| `func`            | string | Y        | Statistical type, values can be `avg,min,max,std`|
| `op`              | string | Y        | Comparison operator, values can be `eq(=),lt(<),leq(<=),gt(>),geq(>=)`|
| `target`          | string | Y        | Target value                 |

Example:

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

`hops` is an array of objects, each with parameters as follows:

| Field              | Type   | Required | Description                                      |
| :---              | ---    | ---      | ---                                       |
| `op`              | string | Y        | Comparison operator, values can be `eq(=),lt(<),leq(<=),gt(>),geq(>=)`|
| `target`          | float | Y        | Target value                 |

Example:

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

- Packet Count (`packets`)

`packets` is an array of objects, each with parameters as follows:

| Field              | Type   | Required | Description                                      |
| :---              | ---    | ---      | ---                                       |
| `op`              | string | Y        | Comparison operator, values can be `eq(=),lt(<),leq(<=),gt(>),geq(>=)`|
| `target`          | float | Y        | Target value                 |

Example:

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
| `url`          | string | Y        | Websocket connection URL, e.g., ws://localhost:8080  |
| `message`       | string | Y        | Message sent after successful websocket connection                |

Complete JSON structure:

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

`response_time` is an array of objects, each with parameters as follows:

| Field             | Type   | Required | Description                              |
| :---             | ---    | ---      | ---                               |
| `target`         | string | Y        | Determine if the response time is less than this value          |
| `is_contain_dns` | bool   | N        | Indicates whether the response time includes DNS resolution time |

Example:

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

- Returned Message Judgment (`response_message`)

`response_message` is an array of objects, each with parameters as follows:

| Field              | Type   | Required | Description                                                |
| :---              | ---    | ---      | ---                                                 |
| `is`              | string | N        | Whether the returned message equals the specified field                   |
| `is_not`          | string | N        | Whether the returned message does not equal the specified field                 |
| `match_regex`     | string | N        | Whether the returned message contains a substring matching the regex   |
| `not_match_regex` | string | N        | Whether the returned message does not contain a substring matching the regex |
| `contains`        | string | N        | Whether the returned message contains the specified substring             |
| `not_contains`    | string | N        | Whether the returned message does not contain the specified substring           |

Example:

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

- Request Response Header Judgment (`header`)

`header` is a dictionary-type object, where each element's value is an array of objects, with parameters as follows:

| Field              | Type   | Required | Description                                                       |
| :---              | ---    | ---      | ---                                                        |
| `is`              | string | N        | Whether the specified header field equals the specified value                     |
| `is_not`          | string | N        | Whether the specified header field does not equal the specified value                   |
| `match_regex`     | string | N        | Whether the specified header field contains a substring matching the regex   |
| `not_match_regex` | string | N        | Whether the specified header field does not contain a substring matching the regex |
| `contains`        | string | N        | Whether the specified header field contains the specified substring             |
| `not_contains`    | string | N        | Whether the specified header field does not contain the specified substring           |

Example:

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
| `timeout` | string              | N        | Connection timeout         |
| `headers` | map[string]string | N        | Headers specified for the request |

Example:

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

Supports basic username and password authentication (Basic access authentication).

| Field       | Type   | Required | Description       |
| :---       | ---    | ---      | ---        |
| `username` | string | Y        | Username     |
| `password` | string | Y        | Password |

Example:

```json
"advance_options": {
  "auth": {
    "username": "admin",
    "password": "123456"
  },
}
```