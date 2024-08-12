# How to Configure APM Sampling
---

Guance APM supports the analysis and management of trace data collected by collectors that comply with the Opentracing protocol. By default, APM data is collected in full, i.e., data is generated with each call. If not limited, the large amount of data collected will take up too much data storage. You can save data storage and reduce costs by setting up a sampling method to collect APM data.

Here's how to configure APM data at a sampling rate of 5%, *using the [DDtrace collector](../../datakit/ddtrace.md) as an example*.

## Preconditions

- [Register for Guance](https://auth.guance.one/login/pwd);
- [Install DataKit](../../datakit/datakit-install.md); 
- [Open DDtrace collector](../../datakit/ddtrace.md). 

## Sampling Settings

Before you start collecting APM data, you need to configure ddtrace according to different languages. 

The following is an example of a Webserver Flask application commonly used in Python to show how to sample APM data. In the example, `SERVICE_A` provides the HTTP service and calls the `SERVICE_B` HTTP service. 

### Step 1: Install the ddtrace runtime environment

```python
pip install ddtrace
```

### Step 2: Install the flask package

```python
pip install flask
```

### Step 3: Configure Sampling

???+ abstract "Sampling Configuration"

    Create `SERVICE_A` and `SERVICE_B`, configure sampling 5% for `SERVICE_A`, and `SERVICE_B` is collected by default.

When creating, you need to reference ddtrace and set service name, service name mapping relationship, project name, environment name and version number related information through environment variable, and to configure DataKit trace API service address (the specific address is 9529 depending on DataKit address).

> See [Python Flask Complete Sample](../../integrations/apm/ddtrace-python.md).

#### 1. SERVICE_A

```python
# -*- encoding: utf8 -*-
#--------- service_a.py ----------

from flask import Flask, request
import requests, os
from ddtrace import tracer,sampler

# Set the service name
os.environ["DD_SERVICE"] = "SERVICE_A"

# Set service name mappings
os.environ["DD_SERVICE_MAPPING"] = "postgres:postgresql,defaultdb:postgresql"

# Set the project name, environment name and version number through the environment variable
os.environ["DD_TAGS"] = "project:your_project_name,env=test,version=v1"

# Configure the DataKit trace API service address
tracer.configure(
    hostname = "localhost",  # Depending on the specific DataKit address
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

# Start service A: The HTTP service starts on port 54321
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

# Set the service name
os.environ["DD_SERVICE"] = "SERVICE_B"

# Set service name mappings
os.environ["DD_SERVICE_MAPPING"] = "postgres:postgresql,defaultdb:postgresql"

# Set the project name, environment name and version number through the environment variable
os.environ["DD_TAGS"] = "project:your_project_name,env=test,version=v1"

tracer.configure(
    hostname = "localhost",  # Depending on the specific DataKit address
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

# Start service B: The HTTP service starts on port 54322
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=54322, debug=True)

```

### Step 4: Start and call SERVICE_A and SERVICE_B 

```python
# Start two services in the background:
(ddtrace-run python3 service_a.py &> a.log &)
(ddtrace-run python3 service_b.py &> b.log &)

# Invoke service A, leading it to invoke service B, which generates the corresponding trace data (where multiple triggers can be performed)
curl http://localhost:54321/a

# Stop both services separately
curl http://localhost:54321/stop
curl http://localhost:54322/stop
```

### Step 5: View the effect in the Guance Workspace

Log in to the Guance workspace, and you can see the collected `SERVICE_A` and `SERVICE_B` trace data.

???+ warning

    Application performance sampling is based on trace. If there are 100 traces and the sampling rate is set to 5%, 5% of them will be randomly collected, that is, 5 traces and all Spans under them will be randomly reported to the Guance workspace.
    
    In this example, `SERVICE_A` provides the HTTP service and calls `SERVICE_B` the HTTP service, that is, service A calls service B as a trace, assuming there are 100 traces, i.e. five of them are reported randomly.

![](../img/sample_explor.png)

## More Readings

- The above is the sampling rate of APM configured through the client. In addition to the above methods, you can also directly configure the sampling rate through DataKit, just turn on the sampling in the application performance collector configuration.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Datakit Samplers</font>](../../integrations/datakit-tracing.md#samplers)


</div>

```python
  ## Sampler config uses to set global sampling strategy.
  ## sampling_rate used to set global sampling rate.
  [inputs.tracer.sampler]
    sampling_rate = 1.0
```

- After setting the application performance sampling, you might miss important APM datas. You can ensure the key APM datas are reported by configuring filters, such as setting `keep_rare_resource = true`, then the APM datas that are judged to be rare will be reported directly to Guance.


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Datakit Filters</font>](../../integrations/datakit-tracing.md#filters)


</div>