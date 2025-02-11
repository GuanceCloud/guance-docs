# Session Replay
---

## What is Session Replay

Session Replay leverages powerful APIs provided by modern browsers to capture user operation data from web applications, generating video records that can be replayed. This allows for a deeper understanding of the user experience at the time of interaction. Combined with RUM performance data, Session Replay aids in error localization, reproduction, and resolution, as well as promptly identifying defects in usage patterns and design of web applications.


## Session Replay Record

Session Replay Record is part of the RUM SDK. It captures snapshots of the browser's DOM and CSS by tracking and recording events on the webpage (such as DOM modifications, mouse movements, clicks, and input events) along with their timestamps. These events are then reconstructed and replayed in the appropriate timeline using Guance.

Session Replay Record supports all browsers supported by the RUM Browser SDK, except IE11.

The Session Replay Record feature is integrated into the RUM SDK, so no additional packages or external plugins are required.


## Collector Configuration

Before using Session Replay, you need to [install DataKit](../../datakit/datakit-install.md) and then enable the `session_replay_endpoints` parameter for the [RUM collector](../../integrations/rum.md).

**Note**: The Session Replay feature requires upgrading DataKit to version 1.5.5 or higher.

## Integration Configuration

**Note**: The Session Replay feature requires upgrading the SDK to version `3.0` or higher.

- [Web End](./web/index.md);
- [Mobile End](./mobile/index.md).