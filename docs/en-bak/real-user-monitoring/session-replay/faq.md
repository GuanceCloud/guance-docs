# Troubleshooting
---

## How to determine if RUM SDK initialization is successful

I. Open the browser console:

<img src="../../img/dev-tools.jpg" width="60%" >

II. Check if the object `DATAFLUX_RUM` exists:

Exists:

![](../img/console.jpg)

Does not exist:

![](../img/console-II.jpg)

III. Execute `DATAFLUX_RUM.getInternalContext()` to check if the object is initialized successfully:

![](../img/console-I.jpg)

If initialization is successful, you can obtain information about the current application page, such as `session`, `application`, `view` and other objects.

## Initialization failure

I. If you are using the CDN method, make sure that the current application is an `https` site.
II. Check the [configuration](app-access.md#config) for correctness (including the format and names of configuration parameters).

## Successful initialization, but no data is reported or incomplete data is reported

I. Check the browser version information to determine if the corresponding data is supported according to the [browser support list](browser-support.md).
II. Check the initialization position of the RUM browser SDK and consider performing the initialization operation as early as possible in the application code.

## XHR/FETCH requests are not associated with APM traces

Check if the `allowedTracingOrigins` configuration in the initialization is enabled and verify that the format is correct. (**If configured using regular expressions, make sure that the items in the array are regular expressions and not strings**)

Correct:

```
datafluxRum.init({
   applicationId: '<DATAFLUX_APPLICATION_ID>',
   datakitOrigin: '<DATAKIT ORIGIN>',
   env: 'production',
   version: 'I.0.0',
   trackInteractions: true,
   allowedTracingOrigins: [/https:\\\\/\\\\/.*\\\\.my-api-domain\\\\.com/] // The regular expression should not be in quotes
})

```

Incorrect:

```
datafluxRum.init({
   applicationId: '<DATAFLUX_APPLICATION_ID>',
   datakitOrigin: '<DATAKIT ORIGIN>',
   env: 'production',
   version: 'I.0.0',
   trackInteractions: true,
   allowedTracingOrigins: ["/https:\\\\/\\\\/.*\\\\.my-api-domain\\\\.com/"]
})

```

## How to confirm the successful association of APM and frontend XHR/FETCH

I. Open the browser console.
II. Confirm if the Request Headers of XHR/FETCH requests contain the corresponding [header keywords](https://www.notion.so/application-performance-monitoring/collection/connect-web-app.md) information. The following image shows the ddtrace-related request headers:

![](../img/console-4.jpg)

---