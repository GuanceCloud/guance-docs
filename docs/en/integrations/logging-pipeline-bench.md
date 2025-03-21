---
title: 'DataKit Log Collector Performance Testing'
skip: 'not-searchable-on-index-page'
---

## Environment and Tools {#env-tools}

- Operating System: Ubuntu 20.04.2 LTS
- CPU: Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz
- Memory: 16GB Speed 2133 MT/s
- DataKit: 1.1.8-rc1
- Log Text (nginx access log):

``` not-set
172.17.0.1 - - [06/Jan/2017:16:16:37 +0000] "GET /datadoghq/company?test=var1%20Pl HTTP/1.1" 401 612 "http://www.perdu.com/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36" "-"
```

- Number of Logs: 100k lines
- Pipeline Used: See below

## Test Results {#result}

| Test Conditions                                                                                                   | Time Consumed |
| :--                                                                                                              | ---           |
| Without using Pipeline, pure log text processing (including encoding, multiline detection, and field detection)      | 3 seconds 63  |
| Using the full version of the Pipeline (see Appendix One)                                                        | 43 seconds 70 |
| Using a single-match Pipeline, discarding multiple match formats such as NGINX error logs, only targeting *access.log* (see Appendix Two) | 16 seconds 91 |
| Using an optimized single-match Pipeline, replacing performance-heavy patterns (see Appendix Three)                 | 4 seconds 40  |

<!-- markdownlint-disable MD046 -->
???+ attention

    During the time consumed by the Pipeline, a single CPU core was fully loaded with usage consistently around 100%. When the processing of 100k logs ended, the CPU usage dropped. Memory consumption remained stable during testing without noticeable increases. The time consumed is calculated by the DataKit program, which may vary in different environments.
<!-- markdownlint-enable -->

## Comparison {#compare}

Using Fluentd to collect the same 100k log lines, the CPU usage rose from 43% to 77% within 3 seconds and then dropped, indicating that the processing had already finished.

Due to Fluentd's Meta-Data caching mechanism, results are output in batches, making it impossible to accurately calculate the exact time consumed.

Fluentd’s Pipeline matching mode is singular and does not perform multi-format Pipelines for the same data source (for example, nginx only supports access logs but not error logs).

## Conclusion {#conclusion}

For DataKit log collection under a single-match Pipeline mode, the processing time differs by about 30% compared to Fluentd.

However, if the full-version all-match Pipeline is used, the time consumed significantly increases.

## Appendix (Pipeline) {#appendix}

### Full Version/All-Match Pipeline {#full-match}

```python
add_pattern("date2", "%{YEAR}[./]%{MONTHNUM}[./]%{MONTHDAY} %{TIME}")

# access log
grok(_, "%{IPORHOST:client_ip} %{NOTSPACE:http_ident} %{NOTSPACE:http_auth} \\[%{HTTPDATE:time}\\] \"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}\" %{INT:status_code} %{INT:bytes}")

# access log
add_pattern("access_common", "%{IPORHOST:client_ip} %{NOTSPACE:http_ident} %{NOTSPACE:http_auth} \\[%{HTTPDATE:time}\\] \"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}\" %{INT:status_code} %{INT:bytes}")
grok(_, '%{access_common} "%{NOTSPACE:referrer}" "%{GREEDYDATA:agent}')
user_agent(agent)

# error log
grok(_, "%{date2:time} \\[%{LOGLEVEL:status}\\] %{GREEDYDATA:msg}, client: %{IPORHOST:client_ip}, server: %{IPORHOST:server}, request: \"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}\", (upstream: \"%{GREEDYDATA:upstream}\", )?host: \"%{IPORHOST:ip_or_host}\"")
grok(_, "%{date2:time} \\[%{LOGLEVEL:status}\\] %{GREEDYDATA:msg}, client: %{IPORHOST:client_ip}, server: %{IPORHOST:server}, request: \"%{GREEDYDATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}\", host: \"%{IPORHOST:ip_or_host}\"")
grok(_,"%{date2:time} \\[%{LOGLEVEL:status}\\] %{GREEDYDATA:msg}")

group_in(status, ["warn", "notice"], "warning")
group_in(status, ["error", "crit", "alert", "emerg"], "error")

cast(status_code, "int")
cast(bytes, "int")

group_between(status_code, [200,299], "OK", status)
group_between(status_code, [300,399], "notice", status)
group_between(status_code, [400,499], "warning", status)
group_between(status_code, [500,599], "error", status)


nullif(http_ident, "-")
nullif(http_auth, "-")
nullif(upstream, "")
default_time(time)
```

### Single-Match Pipeline {#single-match}

```python
# access log
grok(_, "%{IPORHOST:client_ip} %{NOTSPACE:http_ident} %{NOTSPACE:http_auth} \\[%{HTTPDATE:time}\\] \"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}\" %{INT:status_code} %{INT:bytes}")

cast(status_code, "int")
cast(bytes, "int")

default_time(time)
```

### Optimized Single-Match Pipeline {#optimized-pl}

In this example, the extremely resource-intensive `IPORHOST` is replaced with `NOTSPACE`:

```python
# access log
grok(_, "%{NOTSPACE:client_ip} %{NOTSPACE:http_ident} %{NOTSPACE:http_auth} \\[%{HTTPDATE:time}\\] \"%{DATA:http_method} %{GREEDYDATA:http_url} HTTP/%{NUMBER:http_version}\" %{INT:status_code} %{INT:bytes}")

cast(status_code, "int")
cast(bytes, "int")

default_time(time)
```