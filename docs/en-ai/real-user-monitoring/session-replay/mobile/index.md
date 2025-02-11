# Mobile Session Replay
Mobile session replay extends the observability of mobile applications by recording and replaying each user interaction, making it easier to reproduce the scenarios at the time of crashes and errors. Additionally, recordings can uncover actual user interactions, providing insights into product usability. Currently, this feature is in the alpha stage and is applicable to native Android and iOS applications.

## DataKit Setup {#datakit_setup}

Before using session replay, if you are deploying locally, you need to [install DataKit](../../../datakit/datakit-install.md) first, then enable the `session_replay_endpoints` parameter for the [RUM collector](../../../integrations/rum.md). If you are using a public DataWay, no additional configuration is required.

**Note**: The session replay feature requires upgrading DataKit to version 1.5.5 or higher.

## Integration
<div class="grid cards" markdown>
- [Android](./android/index.md)
- [iOS](./ios/index.md)
- [React Native](./react-native/index.md)  
</div>

## Viewing Session Replay
The method for viewing session replays on mobile devices is the same as on web; refer to the [web session replay access method](../web/index.md#view_replay).

## Third-party Library Support
* [dd-sdk-android-session-replay](https://github.com/DataDog/dd-sdk-android/tree/develop/features/dd-sdk-android-session-replay)
* [dd-sdk-ios/DatadogSessionReplay](https://github.com/DataDog/dd-sdk-ios/tree/develop/DatadogSessionReplay)
* [@datadog/mobile-react-native-session-replay](https://github.com/DataDog/dd-sdk-reactnative/tree/develop/packages/react-native-session-replay)