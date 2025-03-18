# React Native Session Replay

![](https://img.shields.io/badge/dynamic/json?label=npm-package&color=orange&query=$.version&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/react-native/feature/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=react-native&color=green&query=$.react_native&uri=https://static.<<< custom_key.brand_main_domain >>>/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native)

## Prerequisites

* Ensure you have [configured and initialized the `@cloudcare/react-native-mobile` RUM settings](../../../react-native/app-access.md), and enabled View monitoring.
* React Native Session Replay is currently an alpha feature, requiring version `@cloudcare/react-native-mobile:0.4.0` or higher.

## Code Usage {#code_sample}

```typescript
  import {
  SessionReplayPrivacy,
  FTReactNativeSessionReplay,
  FTSessionReplayConfig
} from '@cloudcare/react-native-mobile';

  let sessionReplayConfig:FTSessionReplayConfig = {
    sampleRate:1,
    privacy:SessionReplayPrivacy.ALLOW
  }
  await FTReactNativeSessionReplay.sessionReplayConfig(sessionReplayConfig);
```

| Property       | Type                 | Required | Description                                                         |
| -------------- | -------------------- | -------- | ------------------------------------------------------------------- |
| sampleRate     | number               | No       | Sampling rate, value range [0,1], 0 means no collection, 1 means full collection, default value is 1. This sampling rate is based on the RUM sampling rate. |
| privacy        | SessionReplayPrivacy | No       | Set the privacy level for content masking in Session Replay. Default is `SessionReplayPrivacy.MASK`. <br/>`SessionReplayPrivacy.ALLOW`: Do not mask private data except for sensitive input controls, such as password inputs.<br/>`SessionReplayPrivacy.MASK_USER_INPUT`: Mask some user input data, including text in input fields, Switches, etc.<br>`SessionReplayPrivacy.MASK`: Mask private data, including text, Switches, etc.; |