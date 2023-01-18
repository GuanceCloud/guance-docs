# Long Task
---

## Overview

View long tasks that block the main thread for more than 50ms while the user is using the application, including page addresses, task time spent, etc.

In the Long Task explorer, you can:

- Track every long task of each user access, including action type, action name, action time, etc..
- Combined with associated resource requests, resource errors, logs, and other data, comprehensively analyze the performance of user accessing business applications, and help quickly identify and optimize application code issues.

## Precondition

Guance Cloud supports collecting errors, resources, requests, performance metrics, etc. by means of introducing SDK scripts. For details, you can refer to [Rum Collector Configuration](... /... /datakit/rum.md).

## Long Task Explorer

In the Real User Monitoring explorer, you can switch to the "long_task explorer" to query and analyze the resource loading performance when users access, you can quickly view the resource address, status code, request method resource loading time, etc. when users access.

![](../img/1.rum_longtask_1.png)

### Long Task Detail

Click on the data you need to view in the list, in the row out details page, you can view the long task details accessed by users, including properties, performance details, associated links, associated errors, associated logs, etc., and support viewing performance details by filtering and searching. More details page introduction can be found in the document [View Explorer Details Page](view.md) .

![](../img/1.rum_longtask_2.png)

