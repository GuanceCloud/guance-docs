# Troubleshooting
---

## How to determine successful initialization of the RUM SDK

1.Open the browser studio

![](../img/dev-tools.jpg)

2.Check whether the object `DATAFLUX_RUM` exists

exist:

![](../img/console.jpg)

not exist:

![](../img/console-2.jpg)

3.Execute `DATAFLUX_RUM.getInternalContext()` to check whether the object was initialized successfully

![](../img/console-1.jpg)

If the initialization is successful, the object information such as `session`, `application`, `view` corresponding to the current application page can be obtained.

## Initialization failed

1. If accessing by CDN, determine whether the current application is an `https` site.
2. Make sure the [configuration](../web/app-access.md#config) is correct (including the format and name of the configuration parameters).

## Initialization successful, but data is not reported or reported data is incomplete

1. Check the browser version information to determine whether the data corresponding to [browser support list](browser-support.md) is supported.
2. Check the initialization location of the RUM Browser SDK and consider initializing **as early as possible** in your application code.

## XHR/FETCH request is not associated with APM link

Check that the `allowedTracingOrigins` configuration in the initialization configuration is turned on and that the format is correct. (**If configured in a regular way, make sure that the array is not configured with a string, but with a regular expression.**)

Correct
 ```js
datafluxRum.init({
    applicationId: '<DATAFLUX_APPLICATION_ID>',
    datakitOrigin: '<DATAKIT ORIGIN>',
    env: 'production',
    version: '1.0.0',
    trackInteractions: true,
    allowedTracingOrigins: [/https:\\/\\/.*\\.my-api-domain\\.com/] // Regular can't have quotation marks
})
```
Incorrect
 ```js
datafluxRum.init({
    applicationId: '<DATAFLUX_APPLICATION_ID>',
    datakitOrigin: '<DATAKIT ORIGIN>',
    env: 'production',
    version: '1.0.0',
    trackInteractions: true,
    allowedTracingOrigins: ["/https:\\/\\/.*\\.my-api-domain\\.com/"]
})
```

## How to confirm APM and front-end XHR/FETCH association successfully

1. Open the browser studio
2. Confirm whether the Request Headers of the XHR/FETCH request contains the corresponding [request header keyword](../../application-performance-monitoring/collection/connect-web-app.md) information, as shown in the following figure for ddtrace-related Request Headers.
   
![](../img/console-4.jpg)
   
