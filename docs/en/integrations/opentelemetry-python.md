---
title     : 'OpenTelemetry Python'
summary   : 'OpenTelemetry Python Integration'
tags      :
  - 'PYTHON'
  - 'OTEL'
  - 'APM'
__int_icon: 'icon/opentelemetry'
---


## Configuration {#config}

Before using OTEL to send Traces to DataKit, please ensure that you have configured the [collector](opentelemetry.md).


This page shows how to use Python auto-instrumentation in OpenTelemetry. The example is based on an OpenTracing example. You can download or view the [source files](https://github.com/open-telemetry/opentelemetry-python/tree/main/docs/examples/auto-instrumentation) used in this page from the opentelemetry-python repository.

The example uses three different scripts. Their main differences lie in the instrumentation methods:

- `server_manual.py`: Manual instrumentation.
- `server_automatic.py`: Automatic instrumentation.
- `server_programmatic.py`: Programmatic instrumentation.

Programmatic instrumentation is a method that requires adding only a small amount of instrumentation code to the application. Only certain instrumentation libraries provide additional features when used programmatically, giving you more control over the instrumentation process.

Please run the first script (without using the automatic instrumentation agent) and the second script (using the agent). They should produce the same results, indicating that the automatic instrumentation agent performs the same operations as manual instrumentation.

Automatic instrumentation reduces the effort required to integrate OpenTelemetry into application code by dynamically rewriting methods and classes at runtime using monkey-patching through instrumentation libraries. Below, you will see the differences between manual, automatic, and programmatic instrumentation in Flask routes.

<!-- markdownlint-disable MD046 MD034 -->

### Install Dependency Libraries

Before running the following demo, you need to install the current dependencies first.

> pip install opentelemetry-api opentelemetry-instrumentation

### Automatically-instrumented

- Install dependencies

> pip install opentelemetry-instrumentation-flask

- `server_automatic.py`

```python
from flask import Flask, request

app = Flask(__name__)


@app.route("/server_request")
def server_request():
    print(request.args.get("param"))
    return "served"


if __name__ == "__main__":
    app.run(port=8082)
```

- Start

> opentelemetry-instrument --service_name auto-instrument-service --traces_exporter console,otlp --metrics_exporter none  --exporter_otlp_endpoint http://0.0.0.0:4317 python server_automatic.py

- Access

> curl http://localhost:8082/server_request?param=automatic

### Manually instrumented

- Install dependencies

> pip install opentelemetry-exporter-otlp-proto-grpc

- `server_manual.py`

```python

from flask import Flask, request

from opentelemetry.instrumentation.wsgi import collect_request_attributes
from opentelemetry.propagate import extract
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import (
    BatchSpanProcessor,
    ConsoleSpanExporter,
)
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter

from opentelemetry.trace import (
    SpanKind,
    get_tracer_provider,
    set_tracer_provider,
)

app = Flask(__name__)

set_tracer_provider(TracerProvider())
tracer = get_tracer_provider().get_tracer(__name__)


# Add ConsoleSpanExporter and OTLPSpanExporter to TracerProvider
get_tracer_provider().add_span_processor(
    BatchSpanProcessor(ConsoleSpanExporter())
)
get_tracer_provider().add_span_processor(
    BatchSpanProcessor(OTLPSpanExporter())
)


@app.route("/server_request")
def server_request():
    with tracer.start_as_current_span(
        "server_request",
        context=extract(request.headers),
        kind=SpanKind.SERVER,
        attributes=collect_request_attributes(request.environ),
    ):
        print(request.args.get("param"))
        return "served"


if __name__ == "__main__":
    app.run(port=8082)
```

- Run

> export OTEL_SERVICE_NAME="manual-instrument-service"
>
> python server_manual.py

- Access

> curl http://localhost:8082/server_request?param=manual

### Programmatically-instrumented

You can use instrumentation libraries separately (e.g., opentelemetry-instrumentation-flask), which may offer the advantage of custom options. However, choosing this method means you will not benefit from automatic instrumentation when starting the application via opentelemetry-instrument, as these two methods are mutually exclusive.

- Install dependencies

> pip install opentelemetry-exporter-otlp-proto-grpc

- `server_programmatic.py`

```python

from flask import Flask, request

from opentelemetry.instrumentation.flask import FlaskInstrumentor
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import (
    BatchSpanProcessor,
    ConsoleSpanExporter,
)
from opentelemetry.exporter.otlp.proto.grpc.trace_exporter import OTLPSpanExporter
from opentelemetry.trace import get_tracer_provider, set_tracer_provider

set_tracer_provider(TracerProvider())
get_tracer_provider().add_span_processor(
    BatchSpanProcessor(ConsoleSpanExporter())
)
get_tracer_provider().add_span_processor(
    BatchSpanProcessor(OTLPSpanExporter())
)

instrumentor = FlaskInstrumentor()

app = Flask(__name__)

instrumentor.instrument_app(app)
# instrumentor.instrument_app(app, excluded_urls="/server_request")


@app.route("/server_request")
def server_request():
    print(request.args.get("param"))
    return "served"


if __name__ == "__main__":
    app.run(port=8082)
```


- Run

> export OTEL_SERVICE_NAME="programmatic-instrument-service"
>
> python server_programmatic.py

- Access

> curl http://localhost:8082/server_request?param=programmatic

<!-- markdownlint-enable -->

### Effect

![opentelemetry python instrument to guance](imgs/opentelemetry-python.png)