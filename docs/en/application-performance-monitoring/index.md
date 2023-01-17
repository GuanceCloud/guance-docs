---
icon: zy/application-performance-monitoring
---
# Application Performance Monitoring
---

## Introduction

Application performance monitoring supports the collector using Opentracing protocol, which realizes end-to-end link analysis for distributed architecture applications, and carries out correlation analysis with infrastructure, log and user access monitoring in order to quickly locate and solve faults and improve user experience.

## Deploy the Architecture

The best deployment scheme is to deploy DataKit in each application server, and send the data to the Guance Cloud center through the DataKit of the host where the service is located, which can better integrate the server host index, application log, system log and application service link data of the application service, and carry out the association analysis of various data.

![](img/1.apm-2.png)

## Usage Scene

- Efficient management of large-scale distributed applications: you can view the ownership, dependency and performance metrics of different services in real time through service list, and quickly discover and solve service performance problems;
- End-to-end distributed link analysis: through flame diagram, you can easily observe the flow and execution efficiency of each Span in the whole link;
- Data association analysis: automatically associate data such as infrastructure, logs and user access monitoring for analysis through rich label functions;
- Method-level code performance tracking: By collecting Profile data, the associated code execution fragments of link-related Span are obtained, which can visually show performance bottlenecks and help developers find the direction of code optimization.



## Function Introduction

- [Service, service map and service list](service.md): it supports viewing key performance indicators of services, service call relationship map and team ownership of different services, view service performance metrics and their dependencies and related data in real time, and discover and solve service bottlenecks in time;
- [Overview](overview.md): it supports to view the number of online services, P90 service response time, service maximum impact time, service error number, service error rate statistics, and P90 service, resources, operation response time Top10 ranking, service error rate, resource 5xx error rate, resource 4xx error rate Top10 ranking;
- [Link observer](explorer.md): it supports the query and analysis of all link data collected and reported, intuitively views the context and execution efficiency of each Span in the link through flame diagram, and helps to quickly locate performance problems through correlation analysis of different data;
- [Error tracing](error.md): it supports to view the historical trend and distribution of similar errors in links, and to help quickly locate error problems;
- [Profile](profile.md): it supports viewing the usage of CPU, memory and I/O during the running of the application program, and displays the calling relationship and execution efficiency of each method, class and thread in real time through flame graph to help optimize code performance;
- [Application performance metrics monitoring](../monitoring/monitor/application-performance-detection.md): it enables timely detection of abnormal links by configuring application performance monitors.

## Data Storage Policy

Guance Cloud provides three data storage time choices for application performance data: 3 days, 7 days and 14 days, which can be adjusted in "Management"-"Basic Settings"-"Change Data Storage Policy" as required. See the document [Data storage policy](https://preprod-docs.cloudcare.cn/billing/billing-method/data-storage/).

## Data Billing Rules

Guance Cloud supports the billing method of purchasing on demand and paying according to quantity. The performance monitoring billing is applied to count the number of trace_id in the current space, and the gradient billing mode is adopted. For more billing rules, please refer to the document [billing method](../billing/billing-method/index.md).
