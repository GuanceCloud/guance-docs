---
title     : 'OpenTelemetry Python'
summary   : 'OpenTelemetry Python 集成'
tags      :
  - 'PYTHON'
  - 'OTEL'
  - '链路追踪'
__int_icon: 'icon/opentelemetry'
---


## 配置 {#config}

在使用 OTEL 发送 Trace 到 DataKit 之前，请先确定您已经配置好了[采集器](opentelemetry.md)。


本页面展示了如何在 OpenTelemetry 中使用 Python 自动装配。示例基于一个 OpenTracing 示例。你可以从 opentelemetry-python 仓库下载或查看本页面中使用的[源文件](https://github.com/open-telemetry/opentelemetry-python/tree/main/docs/examples/auto-instrumentation)。

该示例使用了三个不同的脚本。它们的主要区别在于装配的方式：

- `server_manual.py`：手动装配。
- `server_automatic.py`：自动装配。
- `server_programmatic.py`：编程式装配。

编程式装配是一种仅需在应用程序中添加少量装配代码的装配方式。只有某些装配库在编程式使用时提供额外的功能，从而让你对装配过程有更大的控制。

请分别运行第一个脚本（不使用自动装配代理）和第二个脚本（使用代理）。它们应该会产生相同的结果，这表明自动装配代理与手动装配执行相同的操作。

自动装配通过装配库在运行时使用猴子补丁（monkey-patching）动态重写方法和类，从而减少了将 OpenTelemetry 集成到应用程序代码中的工作量。下面，你将看到手动、自动和编程式装配在 Flask 路由中的区别。

<!-- markdownlint-disable MD046 MD034 -->

### 安装依赖库

在运行以下 demo 前，需要先安装当前依赖

> pip install opentelemetry-api opentelemetry-instrumentation

### Automatically-instrumented

- 安装依赖

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

- 启动

> opentelemetry-instrument --service_name auto-instrument-service --traces_exporter console,otlp --metrics_exporter none  --exporter_otlp_endpoint http://0.0.0.0:4317 python server_automatic.py

- 访问

> curl http://localhost:8082/server_request?param=automatic

### Manually instrumented

- 安装依赖

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


# 添加 ConsoleSpanExporter 和 OTLPSpanExporter 到 TracerProvider
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

- 运行

> export OTEL_SERVICE_NAME="manual-instrument-service"
>
> python server_manual.py

- 访问

> curl http://localhost:8082/server_request?param=manual

### Programmatically-instrumented

可以单独使用装配库（例如 opentelemetry-instrumentation-flask），这可能具有自定义选项的优势。然而，选择这种方式意味着你将放弃通过 opentelemetry-instrument 启动应用程序时的自动装配，因为这两种方法是互斥的。

- 安装依赖

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


- 运行

> export OTEL_SERVICE_NAME="programmatic-instrument-service"
>
> python server_programmatic.py

- 访问

> curl http://localhost:8082/server_request?param=programmatic

<!-- markdownlint-enable -->

### 效果

![opentelemetry python instrument to guance](imgs/opentelemetry-python.png)
