# How to Configure RUM Sampling
---

## Overview

Guance supports collecting Web, Android, iOS and Miniapp application data, and by default, collecting user access data according by the full volume. You can set up sampling to collect user access data to save data storage and reduce cost.

The following will introduce how to collect 90% of user access data of Web application as an example.

## Sampling Setting

There are three ways to access the web application: NPM access, synchronous loading and asynchronous loading. Login to Guance Console, enter "Real User Monitoring" page, click "New Application" in the upper right corner, enter "Application Name" and customize "Application ID" in the new window, and click "Create" to select the application type to get access.

- Application Name (required): The name of the application used to identify the current implementation of user access monitoring.
- Application ID (required): The unique identification of the application in the current workspace, which is used for SDK data collection and upload matching, and corresponds to the field: app_id after data entry. This field only supports English, numeric, underscore input, up to 48 characters.

![](../img/sampling.png)

Take "synchronous loading" as an example, add `sampleRate: 90` to the code, and then copy and paste it into the first line of the HTML of the page you need to access, you can collect the user access data of the web application at a rate of 90%.

> Note: After setting the sampling, the initialization will generate a random number between 0-100, when this random number is less than the collection rate you set, then the data related to the current user visit will be reported, otherwise it will not be reported.

The "NPM Access" and "Asynchronous Loading" can be set in the same way. For more information, please refer to the document [Web Application Access](web/app-access.md).

```
<script src="https://static.guance.com/browser-sdk/v2/dataflux-rum.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_RUM &&
    window.DATAFLUX_RUM.init({
      applicationId: 'guance_sampling',
      datakitOrigin: '<DATAKIT ORIGIN>', // 协议（包括：//），域名（或IP地址）[和端口号]
      sampleRate: 90,
      env: 'production',
      version: '1.0.0',
      trackInteractions: true,
      
    })
</script>
```

## Other Application Sampling

- The iOS sampling settings can be found in [iOS Application Access](ios/app-access.md).
- Android sampling settings can be found in [Android Application Access](android/app-access.md).
- The miniapp sampling settings can be found in [Miniapp Application Access](miniapp/app-access.md).

