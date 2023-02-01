# Service List
---

## Introduction

Apply performance monitoring service list supports real-time viewing of ownership, dependency, performance, associated instrument version and association analysis of different services, quickly discovering and solving service performance problems, and helping teams efficiently build and managing large-scale end-to-end distributed applications.

In the service list, you can:

- Quickly obtain team ownership and emergency contact information of services, and establish connection with emergency contacts in time in case of performance failure.
- View and configure custom fields for service-associated log analysis.
- View the invocation map of the service to help quickly understand and analyze the upstream and downstream dependencies of the service.
- Real-time access to service resource performance metrics, including requests, errors and response times.
- Associate various custom instrumentation versions, and visually display the trend analysis of various metrics of service performance for different teams.

![](img/9.service_list_7.gif)

## Service List

The service list can help you quickly get the name of the service, team ownership and emergency contact information, warehouse configuration, relationships and related help documentation.

In "Application Performance Monitoring"-"Service", click any service name to open and view "Service List".

![](img/9.service_list_1.1.png)

### Configure Service List

In "Application Performance Monitoring"-"Service", select any operation button on the right side of "Service" to open the service list for configuration, including the service team, emergency contact mailbox, warehouse configuration, log association analysis custom field and help document address. Click on the doc in the upper right corner to see [How to configure the service manifest through the Open API](../open-api/tracing/service-catelogs-get.md).

![](img/9.service_list_2.1.png)

#### Association Analysis {#analysis}

When configuring the service list, it supports configuring the field values of the global link association log. After the configuration is completed, you can directly view the relevant log data based on the field values configured in the service list on the Link Details page and the Association Log page.

Note:

- On the log page of the link details page, the default includes three field options: "trace_id", "host" and "all sources". Select any option of the default field, and display `log=[]` in the service list "Association Analysis";
- The link details page log page and the service list association analysis configuration custom field influence each other, that is, if the custom field is configured on the link details page log page, `log=[]` displays the information of the custom field, and supports the configuration and display of multiple custom fields.

Figure 1: Configure the Association Custom Field on the Association Log page of the Link Details page

![](img/9.service_list_6.png)

Figure 2: Display Associated Custom Fields in the Service List Association Log

![](img/9.service_list_1.2.png)

## Service Performance {#detail}

In "Application Performance Monitoring"-"Service", click any service; or click the service icon and click "View Service Details" to sideslip the link service performance page in the service map.

In service performance, you can view the number of requests, error rate, response time, response time distribution and other chart analysis of the service; you can also view the resource performance metrics contained in the service through keyword search; Click on the resource name of the service to jump directly to "link" to view the link status of the corresponding resource.

**Note: The text content of the search input needs to be case sensitive.**

![](img/9.service_list_3.png)



## Call Map

In "Application Performance Monitoring"-"Service", click any service name to open and view "Call Map". The invocation map can help you quickly understand and analyze the upstream and downstream dependencies of a service. For more details, please refer to the doc [service map](service.md#map) 。

![](img/9.service_list_4.png)

## Associate Dashboard

On the Application Performance Monitoring service details page, you can add related gauge versions to the service, and visually display the trend analysis of various metrics of service performance for different teams (related fields: service). For more details, please refer to the doc [bind inner dashboard](../scene/built-in-view/bind-view.md).

![](img/9.service_list_5.png)
