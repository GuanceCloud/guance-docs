# How to Configure Application Performance Monitoring Sampling
---


<<< custom_key.brand_name >>>'s **APM** feature supports the analysis and management of trace data collected by collectors that conform to the Opentracing protocol. By default, application performance data is collected in full volume, meaning that every call generates data. Without restrictions, this can result in a large amount of collected data, consuming excessive storage. You can save on data storage and reduce costs by setting sampling rates for collecting application performance data.

Below, we will use *[DDtrace Collector](../../integrations/ddtrace.md)* as an example to introduce how to configure a 5% sampling rate for application performance data.

## Prerequisites

- [Register and log in to <<< custom_key.brand_name >>>](https://<<< custom_key.studio_main_site_auth >>>/login/pwd);  
- [Install DataKit](../../datakit/datakit-install.md);   
- [Enable DDtrace collector](../../integrations/ddtrace.md). 

## Sampling Configuration

Before starting to collect application performance data, you need to configure DDtrace according to different languages.

Below, we will take a commonly used Python Webserver Flask application as an example to explain how to sample application performance data. In the example, `SERVICE_A` provides HTTP services and calls the `SERVICE_B` HTTP service.

### Step 1: Install DDtrace Runtime Environment

```python
pip install ddtrace
```

### Step 2: Install flask Package

```python
pip install flask
```

### Step 3: Configure Sampling

???+ abstract "Sampling Configuration Description"

    Create `SERVICE_A` and `SERVICE_B`, configure sampling at 5% for `SERVICE_A`, and use the default collection for `SERVICE_B`.

When creating them, reference DDtrace and set the service name, service name mapping relationship, and configure the project name, environment name, version number information through environment variables. Additionally, configure the DataKit trace API service address (the specific address depends on the DataKit address with port number 9529).

> Refer to [Python Flask Complete Example](../../integrations/apm/ddtrace-python.md).

#### 1. SERVICE_A

```python
# -*- encoding: utf8 -*-
#--------- service_a.py ----------

from flask import Flask, request
import requests, os
from ddtrace import tracer,sampler

# Set service name
os.environ["DD_SERVICE"] = "SERVICE_A"

# Set service name mapping relationship
os.environ["DD_SERVICE_MAPPING"] = "postgres:postgresql,defaultdb:postgresql"

# Set project name, environment name, version number via environment variables
os.environ["DD_TAGS"] = "project:your_project_name,env=test,version=v1"

# Configure DataKit trace API service address
tracer.configure(
    hostname = "localhost",  # Depends on the specific DataKit address
    port     = "9529",
    sampler  = sampler.RateSampler(0.05),
)

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

# Start service A: HTTP service starts on port 54321
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

# Set service name mapping relationship
os.environ["DD_SERVICE_MAPPING"] = "postgres:postgresql,defaultdb:postgresql"

# Set project name, environment name, version number via environment variables
os.environ["DD_TAGS"] = "project:your_project_name,env=test,version=v1"

tracer.configure(
    hostname = "localhost",  # Depends on the specific DataKit address
    port="9529",
)

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

# Start service B: HTTP service starts on port 54322
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=54322, debug=True)

```

### Step 4: Start and Call `SERVICE_A` and `SERVICE_B`

```python
# Start both services in the background:
(ddtrace-run python3 service_a.py &> a.log &)
(ddtrace-run python3 service_b.py &> b.log &)

# Call service A, which triggers a call to service B, thus generating corresponding trace data (this can be executed multiple times).
curl http://localhost:54321/a

# Stop both services
curl http://localhost:54321/stop
curl http://localhost:54322/stop
```

### Step 5: View Results in <<< custom_key.brand_name >>> Workspace

Log into the <<< custom_key.brand_name >>> workspace, where you can see the collected `SERVICE_A` and `SERVICE_B` trace data.

???+ warning

    Application performance sampling is based on traces. If there are 100 traces and the sampling rate is set to 5%, then 5% of these traces will be randomly sampled, meaning 5 traces and all their Spans will be reported to the <<< custom_key.brand_name >>> workspace.
    
    In this example, `SERVICE_A` provides HTTP services and calls the `SERVICE_B` HTTP service, which forms one trace. Assuming there are 100 traces, 5 of them will be randomly reported.

![](../img/sample_explor.png)

## Further Reading

- The above method configures the sampling rate for application performance monitoring via client-side settings. Alternatively, you can directly configure the sampling rate through DataKit by enabling sampling in the application performance collector configuration.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Datakit Samplers</font>](../../integrations/datakit-tracing.md#samplers)


</div>



```python
  ## Sampler config used to set global sampling strategy.
  ## sampling_rate used to set global sampling rate.
  [inputs.tracer.sampler]
    sampling_rate = 1.0
```

- After setting the application performance sampling, some important traces might be missed. You can ensure critical traces are reported by configuring filters, such as setting `keep_rare_resource = true`. Traces deemed rare will be directly reported to <<< custom_key.brand_name >>>.


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Datakit Filters</font>](../../integrations/datakit-tracing.md#filters)


</div>