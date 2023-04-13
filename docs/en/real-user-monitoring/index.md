---
icon: zy/real-user-monitoring
---
# Real User Monitoring
---

## Overview

Guance supports collecting user access data of Web, Android, iOS, Miniapp and third-party frameworks, which can help you quickly monitor users' usage behavior and problems. By viewing and analyzing the user access data, you can quickly understand the user access environment, trace the user operation path, decompose the response time of user operation and understand the application performance metrics of a series of call chains caused by user operation.

## Precondition

To enable the Real User Monitoring, Firstly it needs to deploy a public network DataKit as an Agent, through this Agent，the client users access data will be reported to the Guance workspace. For the specific datakit installation method and configuration method, see [datakit Installation Document](../datakit/datakit-install.md).

After the DataKit installation is completed, enable the [RUM Collector](. /datakit/rum.md), and access the application configuration, and then start collecting the relevant data accessed by users.

You can click the following link to view the corresponding application access configuration:

|               Application Access Configuration               |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [Web Application Access](web/app-access.md){ .md-button .md-button--primary } | [Android Application Access](android/app-access.md){ .md-button .md-button--primary } | [iOS Application Access](ios/app-access.md){ .md-button .md-button--primary } |
| [Miniapp Application Access](miniapp/app-access.md){ .md-button .md-button--primary } | [React Native Application Access](react-native/app-access.md){ .md-button .md-button--primary } | [Flutter Application Access](flutter/app-access.md){ .md-button .md-button--primary } |



## Deployment Architecture

![](img/rum-arch_1.png)

## Usage Scenarios

- Deep insight into user access and improve user experience: comprehensively analyze user access behavior through Session, View, Resource, Action, Long Task and Error explorers, and know the running status of applications in real time;

- Data association analysis: automatically associate logs, traces, network requests, access errors, etc. through rich tag functions, and quickly locate application problems;
- Error tracking: support the association of error traces, locate the upstream and downstream span of error traces, and quickly discover performance problems; Through Sourcemap conversion, restore the confused code, facilitate the location of the source code during error troubleshooting, and solve the problem faster.

## Function Introduction

- [Web Monitoring](web/app-analysis.md): multi-dimensional scenario analysis, including page performance, resource loading, JS errors and other scenarios; The explorer supports quick retrieval and filtering of data such as pages, resources and JS errors, etc.
- [Android Monitoring](android/app-analysis.md): multi-dimensional scenario analysis, including page performance, resource loading and other scenarios; The explorer supports quick retrieval and filtering of data such as pages, resources, crashes and jamming, etc.
- [iOS Monitoring](ios/app-analysis.md): multi-dimensional scenario analysis, including page performance, resource loading and other scenarios; The explorer supports quick retrieval and filtering of data such as pages, resources, crashes and jamming, etc.
- [Miniapp Monitoring](miniapp/app-analysis.md): multi-dimensional scenario analysis, including page performance, resource loading, request loading, JS error and other scenarios; The explorer supports quick retrieval and filtered viewing of data such as pages, resources, requests, JS errors, etc.
- [Explorer](explorer.md): understand the impact of each user session, page performance, resources, long tasks, errors in operation and delays on users, and comprehensively understand and improve the running status and usage of applications through search, filtering and association analysis, so as to improve the user experience.
- [Self Tracking](self-tracking.md): supports real-time monitoring of tracks based on custom ID tracks. Through the preset tracking track, centrally filter user access data and accurately query the user behavior, access experience, resource request, error report, etc., so as to discover loopholes, anomalies and risks in time.
- [User Access Metrics Detection](../monitoring/monitor/real-user-detection.md): Support for timely discovery and resolution of performance issues for different applications by configuring user access monitors.

## Data Storage Policy

Guance provides users with three data storage time choices of 3 days, 7 days and 14 days to access data, which can be adjusted in "Management"-"Basic Settings"-"Change Data Storage Policy" as required. For more data storage policies, please refer to the document [Data Storage Policies](https://preprod-docs.cloudcare.cn/billing/billing-method/data-storage/).

## Data Billing Rules

Guance supports on-demand purchasing and pay-as-you-go billing. Real User Monitoring billing counts the number of PVs generated by all page views in a day under the current space, and uses gradient billing mode.  For more billing rules, please refer to the document [billing method](../billing/billing-method/index.md).
