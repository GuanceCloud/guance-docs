---
icon: zy/real-user-monitoring
---
# RUM PV
---

<video controls="controls" poster="https://static.<<< custom_key.brand_main_domain >>>/dataflux/help/video/rum.png" >
      <source id="mp4" src="https://static.<<< custom_key.brand_main_domain >>>/dataflux/help/video/rum.mp4" type="video/mp4">
</video>

Real User Monitoring (RUM) is a real-time monitoring technology used to monitor user behavior and performance in Web and MOBILE applications.

- User Behavior: RUM captures real user operation data in Web and MOBILE applications, including page load times, network requests, user interactions, and error information.
- Performance Analysis: Helps developers and businesses analyze application performance, identify performance bottlenecks, and optimize user experience.
- Error Management: Real-time tracking and recording of errors and exceptions in the application for quick identification and problem resolution.
- User Experience: Through multi-dimensional analysis of user behavior (such as user journeys, SESSION REPLAY), gain deeper insights into user habits and improve application quality.
- Multi-platform Support: Suitable for real-time monitoring needs of Web, MOBILE applications (iOS, Android), and various platforms.


## Data Sources

Through RUM Headless automated deployment, collect user access data from Web, Android, iOS, mini-programs, and third-party frameworks.


![](img/rum-arch_1.png)

## How to Enable

1. Deploy a public DataKit as an Agent to report client-side data to the workspace;
2. [Install DataKit](../datakit/datakit-install.md);
3. After installation, enable the [RUM collector](../integrations/rum.md);
4. [Integrate application configurations](#get-applications), start collecting user access data.


## Start Configuration {#create}

Go to **User Analysis > Service List > Create**.

![](img/rum_get_started.png)

### Integrate Applications {#get-applications}

:material-numeric-1-circle: [Web](web/app-access.md)            
:material-numeric-2-circle: [Android](android/app-access.md)            
:material-numeric-3-circle: [iOS](ios/app-access.md)       
:material-numeric-4-circle: [Mini Program](miniapp/app-access.md)       
:material-numeric-5-circle: [React Native](react-native/app-access.md)      
:material-numeric-6-circle: [Flutter](flutter/app-access.md)     
:material-numeric-7-circle: [UniApp](uni-app/app-access.md)            
:material-numeric-8-circle: [macOS](macos/app-access.md)      
:material-numeric-9-circle: [C++](cpp/app-access.md)       


???+ warning "Change Application ID"

    - Changing the application ID will synchronously update the configuration information in the SDK;
    - After the SDK updates successfully, the new analysis views and Explorer lists will only display the latest `app_id` associated data; old application ID data will no longer be shown;
    - The user access Metrics detection monitors need to be updated to the latest application ID configuration or recreate Metrics detection based on the new `app_id` data;
    - Old application ID data can be viewed and analyzed through built-in user access views, custom dashboards, or DQL tools;
    - If no associated analysis dashboard was added during custom application configuration, it will not be possible to navigate to the analysis dashboard.


## Session Replay

RUM focuses on user operations and sessions, capturing user sessions in Web, mini-programs, Android, iOS, and other applications. [Session Replay](./session-replay/index.md) uses modern browser APIs to capture user operation data in real time and replay operation paths, effectively reproducing and resolving errors.


## Data Analysis


### Explorer {#explorer}

After completing data collection, besides using the analysis dashboard, you can use the [Explorer](./explorer/index.md) to delve into detailed data for each user session (Session), page performance (View), errors (Error), etc., fully grasp and optimize the application's operational status and user experience.

![](img/explorer-rum.gif)

### Analysis Dashboard {#panel}

User Analysis > [Analysis Dashboard](./app-analysis.md) covers multiple analysis scenarios across different ports, displaying various metrics data related to performance, resources, and errors. You can understand the real user front-end experience through key performance indicators, quickly identify issues with user access to the application, and improve user access performance.

![](img/panel-rum.gif)





## Tracing

User Analysis supports configuring [Create] tracing tasks to monitor chain trajectories in real time, achieving precise root cause analysis; ensuring complete context transmission across chains in different environments, preventing context loss that leads to chain interruption; supporting zero-code end-to-end testing via browser plugins, facilitating quick validation and issue resolution.



## Generate Metrics

Facing massive raw data, User Analysis > [Generate Metrics](../metrics/generate-metrics.md) can quickly simplify multi-dimensional analysis processes, helping Dev & Ops teams and business parties efficiently handle data. This feature automatically generates Metrics based on existing data within the current space and links in real time with custom dashboards, supporting regular statistical analysis by dimensions, accelerating data insights, and improving decision-making efficiency.