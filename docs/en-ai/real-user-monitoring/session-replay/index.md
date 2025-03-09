# Session Replay
---

## What is Session Replay

Session Replay leverages the powerful API capabilities provided by modern browsers to capture user operation data from web applications, generating video records that allow for replay and in-depth understanding of the user experience at the time. Combined with RUM performance data, Session Replay aids in error localization, reproduction, and resolution, and promptly identifies defects in the usage patterns and design of web applications.


## Session Replay Record

The Session Replay Record is part of the RUM SDK. The Record captures snapshots of the browser's DOM and CSS by tracking and logging events occurring on the webpage (such as DOM modifications, mouse movements, clicks, and input events) along with their timestamps. It then reconstructs the webpage through <<< custom_key.brand_name >>> and replays the recorded events in the view at appropriate times.

Session Replay Record supports all browsers supported by the RUM Browser SDK, except IE11.

The Session Replay Record feature is integrated into the RUM SDK, so no additional packages or external plugins are required.


## Collector Configuration

Before using Session Replay, you need to [install DataKit](../../datakit/datakit-install.md), and then enable the Session Replay parameter `session_replay_endpoints` for the [RUM collector](../../integrations/rum.md).

**Note**: The Session Replay feature requires upgrading DataKit to version 1.5.5 or higher.

## Integration Configuration

**Note**: The Session Replay feature requires upgrading the SDK to version `3.0` or higher.

- [Web](./web/index.md);
- [Mobile](./mobile/index.md).