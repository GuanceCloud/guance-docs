# Troubleshooting
---

## How to Determine if the RUM SDK Initialization is Successful

1. Open the browser console:

   ![dev-tools](../../img/dev-tools.jpg)

2. Check whether the object `DATAFLUX_RUM` exists:

   Exists:

   ![](../../img/console.jpg)

   Does not exist:

   ![](../../img/console-2.jpg)

3. Execute `DATAFLUX_RUM.getInternalContext()` to check if the object has been initialized successfully:

   ![](../../img/console-1.jpg)

   If initialization is successful, you can retrieve information about objects such as the current application page's `session`, `application`, and `view`.

## Initialization Failed

1. If you are integrating via CDN, ensure that your application is an `https` site;
2. Verify the [configuration](../../web/app-access.md#config) is correct (including the format and names of configuration parameters).

## Initialization Succeeded, but Data Is Not Reported or Partially Reported

1. Check the browser version information and confirm that it supports the data according to the [browser support list](browser-support.md);
2. Check the initialization position of the RUM browser SDK and consider executing the initialization operation as early as possible in your application code.

## XHR/FETCH Requests Are Not Associated with the APM Trace

Check if the `allowedTracingOrigins` configuration in the initialization settings is enabled and verify that the format is correct. (If using a regular expression, ensure that the array contains actual regular expressions, not strings)

Correct
```js
datafluxRum.init({
    applicationId: '<DATAFLUX_APPLICATION_ID>',
    datakitOrigin: '<DATAKIT ORIGIN>',
    env: 'production',
    version: '1.0.0',
    trackInteractions: true,
    allowedTracingOrigins: [/https:\\/\\/.*\\.my-api-domain\\.com/] // Regular expressions should not be quoted
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

## How to Confirm That APM and Frontend XHR/FETCH Are Successfully Linked

1. Open the browser console;
2. Confirm that the Request Headers of the XHR/FETCH requests contain the corresponding [header keywords](../../../application-performance-monitoring/collection/connect-web-app.md), as shown in the following image for ddtrace-related headers:
   
   ![](../../img/console-4.jpg)