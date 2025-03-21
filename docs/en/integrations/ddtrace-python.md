---
title     : 'DDTrace Python'
summary   : 'DDTrace Python Integration'
tags      :
  - 'DDTRACE'
  - 'PYTHON'
  - 'APM'
__int_icon: 'icon/ddtrace'
---

## Install Dependencies {#dependence}

Install DDTrace SDK

```shell
pip install ddtrace
```

## Run Application {#instrument}

<!-- markdownlint-disable MD046 -->
=== "HOST Application"

    > Note: Here, use `ddtrace-run` to start the Python application.
    
    ```shell linenums="1"
    DD_SERVICE="<YOUR-SERVICE-Name>" \
      DD_ENV="<YOUR-ENV-NAME>" \
      DD_LOGS_INJECTION=true \
      ddtrace-run python my_app.py
    ```

=== "Kubernetes"

    ```yaml hl_lines="10-19" linenums="1"
    apiVersion: apps/v1
    kind: Deployment
    spec:
      template:
        spec:
          containers:
            - name: <CONTAINER_NAME>
              image: <CONTAINER_IMAGE>/<TAG>
              env:
                - name: DD_AGENT_HOST
                  value: "datakit-service.datakit.svc"
                - name: DD_TRACE_AGENT_PORT
                  value: "9529"
                - name: DD_ENV
                  value: <YOUR-ENV-NAME>
                - name: DD_SERVICE
                  value: <YOUR-SERVICE-NAME>
                - name: DD_LOGS_INJECTION
                  value: "true"
    ```
<!-- markdownlint-enable -->

In addition, there are several other common options that can be enabled.

### Profiling {#instrument-profile}

```shell linenums="1"
DD_PROFILING_ENABLED=true \
  ddtrace-run python my_app.py
```

### Sampling Rate {#instrument-sampling}

Set a sampling rate of 0.8, meaning only 80% of traces will be retained.

```shell linenums="1"
DD_TRACE_SAMPLE_RATE="0.8" \
  ddtrace-run python my_app.py
```

### Enable Python Runtime Metrics Collection {#instrument-py-runtime-metrics}

> This requires enabling the [statsd collector](statsd.md).

```shell linenums="1"
DD_RUNTIME_METRICS_ENABLED=true \
  ddtrace-run python my_app.py
```

## Code Examples {#example}

```python title="service_a.py"
from flask import Flask, request
import requests, os
from ddtrace import tracer

app = Flask(__name__)

def shutdown_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()

@app.route('/a',  methods=['GET'])
def index():
    requests.get('http://127.0.0.1:54322/b')
    return 'OK', 200

@app.route('/stop',  methods=['GET'])
def stop():
    shutdown_server()
    return 'Server shutting down...\n'

# Start service A: HTTP service runs on port 54321
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=54321, debug=True)
```

```python title="service_b.py"
from flask import Flask, request
import os, time, requests
from ddtrace import tracer

app = Flask(__name__)

def shutdown_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()

@app.route('/b',  methods=['GET'])
def index():
    time.sleep(1)
    return 'OK', 200

@app.route('/stop',  methods=['GET'])
def stop():
    shutdown_server()
    return 'Server shutting down...\n'

# Start service B: HTTP service runs on port 54322
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=54322, debug=True)
```

## Run {#run}

Here we use Flask, a commonly used Web Server in Python. In the example, `SERVICE_A` provides an HTTP service and calls the `SERVICE_B` HTTP service.

- Run `SERVICE_A`

```shell
DD_SERVICE=SERVICE_A \
DD_SERVICE_MAPPING=postgres:postgresql,defaultdb:postgresql \
DD_TAGS=project:your_project_name,env:test,version:v1 \
DD_AGENT_HOST=localhost \
DD_AGENT_PORT=9529 \
ddtrace-run python3 service_a.py &> a.log &
```

- Run `SERVICE_B`

```shell
DD_SERVICE=SERVICE_B \
DD_SERVICE_MAPPING=postgres:postgresql,defaultdb:postgresql \
DD_TAGS=project:your_project_name,env:test,version:v1 \
DD_AGENT_HOST=localhost \
DD_AGENT_PORT=9529 \
ddtrace-run python3 service_b.py &> b.log &
```

Call Service A, which triggers it to call Service B, generating corresponding trace data (this can be executed multiple times).

```shell
curl http://localhost:54321/a
```

Stop both services respectively

```shell
curl http://localhost:54321/stop
curl http://localhost:54322/stop
```

## Supported Environment Variables {#envs}

Commonly supported environment variables are listed below. For a complete list of Python environment variables, refer to the [DataDog Official Documentation](https://docs.datadoghq.com/tracing/trace_collection/library_config/python/){:target="_blank"}.

- `DD_ENV`: Sets the environment variable for the service.
- `DD_VERSION`: APP version number.
- `DD_SERVICE`: Used to set the service name of the application. When setting middleware for integration with frameworks like Pylons, Flask, or Django, this value is passed. For Tracing without Web integration, it is recommended to set the service name within your code.
- `DD_SERVICE_MAPPING`: Defines service name mappings for renaming services in Tracing.
- `DD_TAGS`: Adds default Tags to each Span; format is `key:val,key:val`.
- `DD_AGENT_HOST`: The hostname listened by Datakit; defaults to localhost.
- `DD_AGENT_PORT`: The port listened by Datakit; defaults to 9529.
- `DD_TRACE_SAMPLE_RATE`: Sets the sampling rate from 0.0(0%) ~ 1.0(100%).