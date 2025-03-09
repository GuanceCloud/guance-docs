# How to Enable User Access Monitoring
---

## Introduction

In the era of universal internet usage, users spend more time accessing web pages, mini-programs, Android, iOS, and other media. Applications that strive to capture user attention are increasing, and product and service updates are becoming more frequent. In this context, gaining a detailed understanding of where users come from, which pages they view, how long they stay, and the speed of their visits not only helps uncover the true needs behind each user behavior but also stabilizes and improves conversion rates for existing traffic. This data can further enhance both products and services, truly achieving user growth and performance improvements.

<<< custom_key.brand_name >>> provides user access data monitoring for Web, Android, iOS, and mini-programs. After completing the application integration, you can quickly view and analyze various applications' user browsing behaviors and related performance metrics on the workbench's "User Access Monitoring" page, to evaluate the final user experience of websites and applications.

## Prerequisites

- Install DataKit ([DataKit Installation Documentation](../datakit/datakit-install.md))
- Deploy DataKit to be publicly accessible ([RUM Configuration Documentation](../integrations/rum.md))
- Supported operating systems: All platforms

## Methods/Steps

DataKit supports user access monitoring data collection by default. You only need to complete the application integration to monitor user browsing behaviors and related performance metrics in real-time via the <<< custom_key.brand_name >>> platform.

### Step 1: Create a Task

1. Log in to the <<< custom_key.brand_name >>> console, go to the "User Access Monitoring" page, click "Create Application" in the top-left corner, and input the "Application Name" and "Application ID" in the new window.
2. Select the "Application Type" and follow the prompts to configure SDK settings for data collection.
3. Click "Create" to start user access monitoring for the selected application.

![](img/1.rum_1.png)

### Step 2: Configure Application Integration

Taking the configuration of "Synchronous Loading" for a Web application as an example, the steps are as follows:

a. Copy the code from the current page and modify it according to the required configuration information. For instance, change the `datakitOrigin` address to the DataKit address (the host address where DataKit is installed).

b. Enter the target application and add the copied code to the first line of the corresponding HTML page.

c. Save the changes after modification.

For more details, refer to the following documentation:
- [Configure Web Application Integration](../real-user-monitoring/web/app-access.md)
- [Configure Android Application Integration](../real-user-monitoring/android/app-access.md)
- [Configure iOS Application Integration](../real-user-monitoring/ios/app-access.md)
- [Configure Mini-program Application Integration](../real-user-monitoring/miniapp/app-access.md)

### Step 3: View User Access Data

On the <<< custom_key.brand_name >>> workspace's "User Access Monitoring" page, click on any application to view related user access behaviors, sessions, page performance, resource performance, error exceptions, and other data.

![](img/1.rum_2.png)

## Advanced References

### Data Sampling

<<< custom_key.brand_name >>> supports custom data sampling rates to control the volume of data reported, optimizing data storage and collection efficiency. You can define the data collection percentage using `resourceSampleRate` (sampling rate for resource-type data) and `sampleRate` (sampling rate for metric-type data) when configuring application integration.

For more details, refer to the documentation [How to Configure User Access Monitoring Sampling](../real-user-monitoring/web/sampling.md).

### Generate Metrics

To facilitate the design and implementation of new technical metrics based on your needs, <<< custom_key.brand_name >>> supports generating new metric data from existing data within the current workspace. This can be done through the "User Access Monitoring" - "Generate Metrics" feature.

For more details, refer to the documentation [User Access Monitoring - Generate Metrics](../real-user-monitoring/generate-metrics.md).

### Sourcemaps

When deploying applications in production environments, files are often transformed and compressed to prevent code leaks and other security issues. Sourcemaps serve as information files that record the original source code locations corresponding to the transformed and compressed code, bridging pre-processed and post-processed code for easier bug location in production environments. <<< custom_key.brand_name >>> provides Sourcemap functionality for Web applications, supporting the de-obfuscation of code to facilitate debugging and help users solve problems faster.

For more details, refer to the documentation [Sourcemap Conversion](../real-user-monitoring/explorer/error.md#sourcemap).

### Self-tracking

<<< custom_key.brand_name >>> allows you to create self-tracking tasks through "User Access Monitoring" to monitor custom trace paths in real-time. By predefining trace paths, you can filter and precisely query user access experiences, promptly identifying vulnerabilities, anomalies, and risks.

For more details, refer to the documentation [Self-tracking](../real-user-monitoring/self-tracking.md).