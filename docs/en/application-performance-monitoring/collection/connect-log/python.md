# Python Log Association Link Data
---


The `Python` application log associates link data through the following steps:

- Open log and link functions in application
- Datakit starts collecting link data (see [link](../../../datakit/ddtrace.md)) and configuring the `Pipeline` script for log cutting (see [link](../../../datakit/pipeline.md)), start Datakit
- Start the Python application

## Application Open Log and Link

Take the following `log_connect_trace.py` source file as an example:

```python
import os
import logging
from flask import Flask
from ddtrace import tracer

os.environ["DD_SERVICE"] = "Python-App"    # Set the service name
os.environ["DD_ENV"] = "Testing"          # Set the environment name
os.environ["DD_VERSION"] = "V1.1"         # Set version number
os.environ["DD_LOGS_INJECTION"] = "true"  # Turn on log injection

# Set the data ip address and port of datakit receiving link
tracer.configure(
    hostname="127.0.0.1",
    port="9529",
)

log = logging.getLogger(__name__)
log.level = logging.INFO

app = Flask(__name__)

@app.route('/a',  methods=['GET'])
def index():
    # Print a log
    log.info('Hello, World!')
    return "abcdefg", 200

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=10001, debug=True)
```

## Open the Application

Open the Python application with the following command:

```shell
ddtrace-run python log_connect_trace.py 
```

After accessing http://127.0.0.1:10001/a through the browser, the corresponding link and log data can be generated.

The link data received by Datakit will be converted into the following protocol format and stored uniformly:

```
ddtrace,env=Testing,host=DESKTOP-7BK497S,http_method=GET,http_status_code=200,operation=flask.request,service=Python-App,span_type=entry,status=ok,type=web,version=V1.1 duration=5367i,message="{\"name\":\"flask.request\",\"service\":\"Python-App\",\"resource\":\"GET /a\",\"type\":\"web\",\"start\":1623982028783232000,\"duration\":5367000,\"meta\":{\"env\":\"Testing\",\"flask.endpoint\":\"index\",\"flask.url_rule\":\"/a\",\"flask.version\":\"1.1.2\",\"http.method\":\"GET\",\"http.status_code\":\"200\",\"http.url\":\"http://127.0.0.1:10001/a\",\"runtime-id\":\"dc06b9410fff47b78bef654495b54fa0\",\"version\":\"V1.1\"},\"metrics\":{\"_dd.agent_psr\":1,\"_dd.measured\":1,\"_dd.tracer_kr\":1,\"_sampling_priority_v1\":1,\"system.pid\":188},\"span_id\":18269734886327436313,\"trace_id\":16108321602917563239,\"parent_id\":0,\"error\":0}",parent_id="0",pid="188",resource="GET /a",span_id="18269734886327436313",start=1623982028783232i,trace_id="16108321602917563239" 1623982028783232000
ddtrace,env=Testing,host=DESKTOP-7BK497S,operation=flask.try_trigger_before_first_request_functions,service=Python-App,span_type=exit,status=ok,type=custom,version=V1.1 duration=61i,message="{\"name\":\"flask.try_trigger_before_first_request_functions\",\"service\":\"Python-App\",\"resource\":\"flask.try_trigger_before_first_request_functions\",\"type\":\"\",\"start\":1623982028784194000,\"duration\":61000,\"meta\":{\"env\":\"Testing\",\"version\":\"V1.1\"},\"span_id\":6068109889842015244,\"trace_id\":16108321602917563239,\"parent_id\":18269734886327436313,\"error\":0}",parent_id="18269734886327436313",resource="flask.try_trigger_before_first_request_functions",span_id="6068109889842015244",start=1623982028784194i,trace_id="16108321602917563239" 1623982028784194000
ddtrace,env=Testing,host=DESKTOP-7BK497S,operation=flask.preprocess_request,service=Python-App,span_type=exit,status=ok,type=custom,version=V1.1 duration=78i,message="{\"name\":\"flask.preprocess_request\",\"service\":\"Python-App\",\"resource\":\"flask.preprocess_request\",\"type\":\"\",\"start\":1623982028785899000,\"duration\":78000,\"meta\":{\"env\":\"Testing\",\"version\":\"V1.1\"},\"span_id\":15145974691361995518,\"trace_id\":16108321602917563239,\"parent_id\":18269734886327436313,\"error\":0}",parent_id="18269734886327436313",resource="flask.preprocess_request",span_id="15145974691361995518",start=1623982028785899i,trace_id="16108321602917563239" 1623982028785899000
ddtrace,env=Testing,host=DESKTOP-7BK497S,operation=flask.dispatch_request,service=Python-App,span_type=local,status=ok,type=custom,version=V1.1 duration=814i,message="{\"name\":\"flask.dispatch_request\",\"service\":\"Python-App\",\"resource\":\"flask.dispatch_request\",\"type\":\"\",\"start\":1623982028786105000,\"duration\":814000,\"meta\":{\"env\":\"Testing\",\"version\":\"V1.1\"},\"span_id\":2238238695909728580,\"trace_id\":16108321602917563239,\"parent_id\":18269734886327436313,\"error\":0}",parent_id="18269734886327436313",resource="flask.dispatch_request",span_id="2238238695909728580",start=1623982028786105i,trace_id="16108321602917563239" 1623982028786105000
ddtrace,env=Testing,host=DESKTOP-7BK497S,operation=__main__.index,service=Python-App,span_type=exit,status=ok,type=custom,version=V1.1 duration=514i,message="{\"name\":\"__main__.index\",\"service\":\"Python-App\",\"resource\":\"/a\",\"type\":\"\",\"start\":1623982028786357000,\"duration\":514000,\"meta\":{\"env\":\"Testing\",\"version\":\"V1.1\"},\"span_id\":12837828046733169079,\"trace_id\":16108321602917563239,\"parent_id\":2238238695909728580,\"error\":0}",parent_id="2238238695909728580",resource="/a",span_id="12837828046733169079",start=1623982028786357i,trace_id="16108321602917563239" 1623982028786357000
ddtrace,env=Testing,host=DESKTOP-7BK497S,operation=flask.process_response,service=Python-App,span_type=exit,status=ok,type=custom,version=V1.1 duration=69i,message="{\"name\":\"flask.process_response\",\"service\":\"Python-App\",\"resource\":\"flask.process_response\",\"type\":\"\",\"start\":1623982028787387000,\"duration\":69000,\"meta\":{\"env\":\"Testing\",\"version\":\"V1.1\"},\"span_id\":17909178282057225013,\"trace_id\":16108321602917563239,\"parent_id\":18269734886327436313,\"error\":0}",parent_id="18269734886327436313",resource="flask.process_response",span_id="17909178282057225013",start=1623982028787387i,trace_id="16108321602917563239" 1623982028787387000
ddtrace,env=Testing,host=DESKTOP-7BK497S,operation=flask.do_teardown_request,service=Python-App,span_type=exit,status=ok,type=custom,version=V1.1 duration=98i,message="{\"name\":\"flask.do_teardown_request\",\"service\":\"Python-App\",\"resource\":\"flask.do_teardown_request\",\"type\":\"\",\"start\":1623982028788124000,\"duration\":98000,\"meta\":{\"env\":\"Testing\",\"version\":\"V1.1\"},\"span_id\":11203277115975583667,\"trace_id\":16108321602917563239,\"parent_id\":18269734886327436313,\"error\":0}",parent_id="18269734886327436313",resource="flask.do_teardown_request",span_id="11203277115975583667",start=1623982028788124i,trace_id="16108321602917563239" 1623982028788124000
ddtrace,env=Testing,host=DESKTOP-7BK497S,operation=flask.do_teardown_appcontext,service=Python-App,span_type=exit,status=ok,type=custom,version=V1.1 duration=55i,message="{\"name\":\"flask.do_teardown_appcontext\",\"service\":\"Python-App\",\"resource\":\"flask.do_teardown_appcontext\",\"type\":\"\",\"start\":1623982028788407000,\"duration\":55000,\"meta\":{\"env\":\"Testing\",\"version\":\"V1.1\"},\"span_id\":16231665078240518932,\"trace_id\":16108321602917563239,\"parent_id\":18269734886327436313,\"error\":0}",parent_id="18269734886327436313",resource="flask.do_teardown_appcontext",span_id="16231665078240518932",start=1623982028788407i,trace_id="16108321602917563239" 1623982028788407000
```

The resulting log data is as follows:

```
2021-06-18 10:07:08,786 INFO [__main__] [lt.py:26] [dd.service.name=Python-App dd.env=Testing dd.version=V1.1 dd.trace_id=16108321602917563239 dd.span_id=12837828046733169079] - Hello, World!
```

In addition to being specified in the source file, the DDtrace-related configuration can also be implemented by injecting environment variables when starting the application:

```shell
DD_SERVICE="Python-App" \
DD_ENV="Testing" \
DD_VERSION="V1.1" \
DD_LOGS_INJECTION="true" \
DD_AGENT_HOST="127.0.0.1" \
DATADOG_TRACE_AGENT_PORT="9529" \
ddtrace-run python log_connect_trace.py 
```

## Configure the Pipeline Script

Log data also needs to be cut and converted before it can be associated with link data, which can be realized by configuring Pipeline script as follows:

```shell
grok(_, "%{TIMESTAMP_ISO8601:time}%{SPACE}%{WORD:level}%{SPACE}%{NOTSPACE}%{SPACE}%{NOTSPACE}%{SPACE}\\[%{GREEDYDATA:trace}\\]%{SPACE}-%{SPACE}%{GREEDYDATA:message}")

grok(trace,"%{EMAILLOCALPART}=%{EMAILLOCALPART:service}?%{SPACE}%{EMAILLOCALPART}=%{EMAILLOCALPART:env}?%{SPACE}%{EMAILLOCALPART}=%{EMAILLOCALPART:version}?%{SPACE}%{EMAILLOCALPART}=%{NUMBER:trace_id}?%{SPACE}%{EMAILLOCALPART}=%{NUMBER:span_id}?")

drop_key(trace)

default_time(time)
```

The data cut by the Pipeline script is as follows, and the log data is associated with the link data through field information such as `trace_id` and `span_id`.

```json
{
    "env": "Testing",
    "level": "INFO",
    "message": "Hello, World!",
    "service": "Python-App",
    "span_id": "12837828046733169079",
    "time": 1623982028786000000,
    "trace_id": "16108321602917563239",
    "version": "V1.1"
}
```
