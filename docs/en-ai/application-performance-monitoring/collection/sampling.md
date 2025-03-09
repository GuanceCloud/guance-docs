# How to Configure Application Performance Monitoring Sampling
---

<<< custom_key.brand_name >>>'s **APM** feature supports the analysis and management of trace data collected by collectors that comply with the Opentracing protocol. By default, application performance data is collected in full volume, meaning every call generates data. Without restrictions, this can lead to a large amount of collected data, consuming excessive storage. You can configure sampling to collect APM data, reducing storage usage and lowering costs.

Below, we will use *[DDtrace Collector](../../integrations/ddtrace.md)* as an example to explain how to configure a 5% sampling rate for APM data.

## Prerequisites

- [Register and log in to <<< custom_key.brand_name >>>](https://auth.guance.com/login/pwd);
- [Install DataKit](../../datakit/datakit-install.md);
- [Enable DDtrace Collector](../../integrations/ddtrace.md).

## Sampling Configuration

Before starting to collect APM data, you need to configure DDtrace according to different programming languages.

The following example uses a common Python Webserver Flask application to illustrate how to sample APM data. In this example, `SERVICE_A` provides an HTTP service and calls the `SERVICE_B` HTTP service.

### Step 1: Install DDtrace Runtime Environment

```python
pip install ddtrace
```

### Step 2: Install Flask Package

```python
pip install flask
```

### Step 3: Configure Sampling

???+ abstract "Sampling Configuration Explanation"

    Create `SERVICE_A` and `SERVICE_B`, configuring `SERVICE_A` to sample at 5%, while `SERVICE_B` collects data by default.

When creating services, you need to reference DDtrace, set the service names, define service name mappings, and configure environment variables for project name, environment name, version number, etc. Additionally, configure the DataKit trace API service address (the port number is 9529, depending on your specific DataKit address).

> Refer to the [Complete Python Flask Example](../../integrations/apm/ddtrace-python.md).

#### 1. SERVICE_A

```python
# -*- encoding: utf8 -*-
#--------- service_a.py ----------

from flask import Flask, request
import requests, os
from ddtrace import tracer, sampler

# Set service name
os.environ["DD_SERVICE"] = "SERVICE_A"

# Set service name mapping
os.environ["DD_SERVICE_MAPPING"] = "postgres:postgresql,defaultdb:postgresql"

# Set project name, environment name, and version via environment variables
os.environ["DD_TAGS"] = "project:your_project_name,env=test,version=v1"

# Configure DataKit trace API service address
tracer.configure(
    hostname="localhost",  # Depending on your specific DataKit address
    port="9529",
    sampler=sampler.RateSampler(0.05),
)

app = Flask(__name__)

def shutdown_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()

@app.route('/a', methods=['GET'])
def index():
    requests.get('http://127.0.0.1:54322/b')
    return 'OK', 200

@app.route('/stop', methods=['GET'])
def stop():
    shutdown_server()
    return 'Server shutting down...\n'

# Start service A: HTTP service runs on port 54321
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=54321, debug=True)
```

*Example:*

![](../img/sampler.png)

#### 2. SERVICE_B

```python
# -*- encoding: utf8 -*-

#--------- service_b.py ----------

from flask import Flask, request
import os, time, requests
from ddtrace import tracer

# Set service name
os.environ["DD_SERVICE"] = "SERVICE_B"

# Set service name mapping
os.environ["DD_SERVICE_MAPPING"] = "postgres:postgresql,defaultdb:postgresql"

# Set project name, environment name, and version via environment variables
os.environ["DD_TAGS"] = "project:your_project_name,env=test,version=v1"

tracer.configure(
    hostname="localhost",  # Depending on your specific DataKit address
    port="9529",
)

app = Flask(__name__)

def shutdown_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is None:
        raise RuntimeError('Not running with the Werkzeug Server')
    func()

@app.route('/b', methods=['GET'])
def index():
    time.sleep(1)
    return 'OK', 200

@app.route('/stop', methods=['GET'])
def stop():
    shutdown_server()
    return 'Server shutting down...\n'

# Start service B: HTTP service runs on port 54322
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=54322, debug=True)
```

### Step 4: Start and Call `SERVICE_A` and `SERVICE_B`

```python
# Start both services in the background:
(ddtrace-run python3 service_a.py &> a.log &)
(ddtrace-run python3 service_b.py &> b.log &)

# Call service A, which triggers a call to service B, generating corresponding trace data (this command can be executed multiple times to trigger more events)
curl http://localhost:54321/a

# Stop both services
curl http://localhost:54321/stop
curl http://localhost:54322/stop
```

### Step 5: View Results in <<< custom_key.brand_name >>> Workspace

Log in to the <<< custom_key.brand_name >>> workspace to view the collected `SERVICE_A` and `SERVICE_B` trace data.

???+ warning

    APM sampling is based on traces. If there are 100 traces and the sampling rate is set to 5%, then 5% of the traces are randomly sampled, i.e., 5 traces and all their spans are reported to the <<< custom_key.brand_name >>> workspace.
    
    In this example, `SERVICE_A` provides an HTTP service and calls the `SERVICE_B` HTTP service, forming a single trace. Assuming there are 100 traces, 5 traces are randomly reported.

![](../img/sample_explor.png)

## Further Reading

- The above method configures the sampling rate through client-side settings. Alternatively, you can directly configure the sampling rate via DataKit by enabling the sampling option in the APM collector configuration.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Datakit Samplers</font>](../../integrations/datakit-tracing.md#samplers)


</div>

```python
  ## Sampler config used to set global sampling strategy.
  ## sampling_rate used to set global sampling rate.
  [inputs.tracer.sampler]
    sampling_rate = 1.0
```

- After setting up APM sampling, you might miss important traces. You can ensure critical traces are reported by configuring filters, such as setting `keep_rare_resource = true`, which ensures rare traces are directly reported to <<< custom_key.brand_name >>>.


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Datakit Filters</font>](../../integrations/datakit-tracing.md#filters)


</div>