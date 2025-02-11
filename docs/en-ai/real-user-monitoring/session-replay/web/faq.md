# Troubleshooting
---

## How to Determine if the RUM SDK Initialization Succeeded

1. Open the browser console:

   ![](../../img/dev-tools.jpg)

2. Check whether the object `DATAFLUX_RUM` exists:

   Exists:

   ![](../../img/console.jpg)

   Does not exist:

   ![](../../img/console-2.jpg)

3. Execute `DATAFLUX_RUM.getInternalContext()` to check if the object is initialized successfully:

   ![](../../img/console-1.jpg)

   If initialization succeeds, you can obtain information about objects such as the current application page's `session`, `application`, and `view`.

## Initialization Failure

1. If using a CDN method, ensure that the current application is an `https` site;
2. Verify that the [configuration](../../web/app-access.md#config) is correct (including the format and names of configuration parameters).

## Initialization Successful, but Data Not Reported or Partially Reported

1. Check the browser version information to confirm whether it matches the [browser support list](browser-support.md);
2. Check the initialization location of the RUM browser SDK and consider executing the initialization operation as early as possible in your application code.

## XHR/FETCH Requests Not Linked with APM Traces

Check if the `allowedTracingOrigins` configuration in the initialization settings is enabled and verify its format. (**If configured using regular expressions, ensure that the array contains actual regex patterns, not strings**)

Correct:
```js
datafluxRum.init({
    applicationId: '<DATAFLUX_APPLICATION_ID>',
    datakitOrigin: '<DATAKIT ORIGIN>',
    env: 'production',
    version: '1.0.0',
    trackInteractions: true,
    allowedTracingOrigins: [/https:\\/\\/.*\\.my-api-domain\\.com/] // Regex should not have quotes
})
```

Incorrect:
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

## How to Confirm That APM and Frontend XHR/FETCH Requests Are Successfully Linked

1. Open the browser console;
2. Confirm that the Request Headers of the XHR/FETCH requests include the corresponding [header keywords](../../../application-performance-monitoring/collection/connect-web-app.md), as shown in the following image for ddtrace-related headers:

   ![](../../img/console-4.jpg)