# How to Enable User Access Monitoring
---

## Introduction

In the era of ubiquitous internet, users are spending more time on web pages, mini-programs, Android, iOS, and other media. The number of applications vying for user attention is increasing, and product and service updates are becoming more frequent. In this environment, understanding where users come from, which pages they view, how long they stay, and how fast they access content is not only beneficial for uncovering real user needs but also helps stabilize and improve conversion rates of existing traffic. This feedback loop can optimize both products and services, achieving true user growth and performance enhancement.

Guance provides user access monitoring for Web, Android, iOS, and mini-programs. After completing the application integration, you can quickly view and analyze various user browsing behaviors and related performance metrics in the workbench under "User Access Monitoring" (RUM). This helps measure the ultimate user experience of websites and applications.

## Prerequisites

- Install DataKit ([DataKit Installation Documentation](../datakit/datakit-install.md))
- Deploy DataKit so it is accessible over the public internet ([RUM Configuration Documentation](../integrations/rum.md))
- Supported operating systems: All platforms

## Method/Steps

DataKit supports the collection of user access monitoring data by default. You only need to complete the application integration to monitor user browsing behavior and related performance metrics via the Guance platform in real-time.

### Step 1: Create a New Task

1. Log in to the Guance console, go to the "User Access Monitoring" page, click "New Application" in the top-left corner, and input the "Application Name" and "Application ID" in the new window.
2. Select the "Application Type" and follow the prompts to configure the SDK for data collection.
3. Click "Create" to start monitoring user access for the relevant application.

![](img/1.rum_1.png)

### Step 2: Configure Application Integration

For example, to configure "Synchronous Loading" for a Web application, follow these steps:

a. Copy the code from the current page and modify the required configuration information as needed. For instance, change the `datakitOrigin` script address to the DataKit address (the host address where DataKit is installed).

b. Enter the target application and add the copied code to the first line of the corresponding HTML page.

c. Save and exit after making changes.

For more details, refer to the following documents:
- [Web Application Integration](../real-user-monitoring/web/app-access.md)
- [Android Application Integration](../real-user-monitoring/android/app-access.md)
- [iOS Application Integration](../real-user-monitoring/ios/app-access.md)
- [Mini-program Application Integration](../real-user-monitoring/miniapp/app-access.md)

### Step 3: View User Access Data

In the Guance workspace under "User Access Monitoring," click on any application to view related user behavior, sessions, page performance, resource performance, error exceptions, and more.

![](img/1.rum_2.png)

## Advanced References

### Data Sampling

Guance supports custom data sampling rates to control the volume of reported data, optimizing data storage and collection efficiency. During application integration configuration, you can define the percentage of data collected using `resourceSampleRate` (for resource class data) and `sampleRate` (for metric class data).

For more details, refer to the document [How to Configure RUM Sampling](../real-user-monitoring/web/sampling.md).

### Generating Metrics

To facilitate the design and implementation of new technical metrics based on your needs, Guance supports generating new metric data from existing data within the current workspace. This can be done through the "User Access Monitoring" - "Generate Metrics" feature.

For more details, refer to the document [User Access Monitoring - Generate Metrics](../real-user-monitoring/generate-metrics.md).

### Sourcemaps

When releasing applications in production environments, to prevent code leakage and other security issues, files are typically transformed and compressed during the build process. Sourcemaps serve as mapping files that record the original source code locations corresponding to the transformed and compressed code, bridging pre-processed and post-processed code for easier debugging. Guance provides Sourcemap functionality for Web applications, supporting the de-obfuscation of code to facilitate faster issue resolution during error tracking.

For more details, refer to the document [Sourcemap Conversion](../real-user-monitoring/explorer/error.md#sourcemap).

### Self-built Tracing

Guance supports creating new tracing tasks through "User Access Monitoring" to monitor custom trace paths in real-time. By predefining trace paths, you can filter trace data centrally, precisely query user experience data, and promptly identify vulnerabilities, anomalies, and risks.

For more details, refer to the document [Self-built Tracing](../real-user-monitoring/self-tracking.md).