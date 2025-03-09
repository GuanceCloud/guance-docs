# React Native Session Replay

![](https://img.shields.io/badge/dynamic/json?label=npm-package&color=orange&query=$.version&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/react-native/feature/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=react-native&color=green&query=$.react_native&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native)

## Prerequisites

* Ensure you have [configured and initialized the `@cloudcare/react-native-mobile` RUM settings](../../../react-native/app-access.md), and enabled View monitoring.
* React Native Session Replay is currently an alpha feature, requiring version `@cloudcare/react-native-mobile:0.4.0` or higher.

## Code Invocation {#code_sample}

```typescript
import {
  SessionReplayPrivacy,
  FTReactNativeSessionReplay,
  FTSessionReplayConfig
} from '@cloudcare/react-native-mobile';

let sessionReplayConfig: FTSessionReplayConfig = {
  sampleRate: 1,
  privacy: SessionReplayPrivacy.ALLOW
}
await FTReactNativeSessionReplay.sessionReplayConfig(sessionReplayConfig);
```

| Property   | Type                 | Required | Description                                                         |
| ---------- | -------------------- | -------- | ------------------------------------------------------------------- |
| sampleRate | number               | No       | Sampling rate, ranging from [0,1], where 0 means no collection, and 1 means full collection. The default value is 1. This sampling rate is based on the RUM sampling rate. |
| privacy    | SessionReplayPrivacy | No       | Sets the privacy level for content masking in Session Replay. Default is `SessionReplayPrivacy.MASK`.<br/>`SessionReplayPrivacy.ALLOW`: No masking except for sensitive input controls like password fields<br/>`SessionReplayPrivacy.MASK_USER_INPUT`: Masks some user input data, including text in input fields, Switches, etc.<br>`SessionReplayPrivacy.MASK`: Masks all private data, including text, Switches, etc. |