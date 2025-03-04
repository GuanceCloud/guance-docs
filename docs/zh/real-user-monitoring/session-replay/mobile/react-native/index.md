# React Native 会话重放

![](https://img.shields.io/badge/dynamic/json?label=npm-package&color=orange&query=$.version&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/react-native/feature/session_replay/version.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=platform&color=lightgrey&query=$.platform&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native) ![](https://img.shields.io/badge/dynamic/json?label=react-native&color=green&query=$.react_native&uri=https://<<< custom_key.static_domain >>>/ft-sdk-package/badge/react-native/info.json&link=https://github.com/GuanceCloud/datakit-react-native)

## 前置条件

* 确保您已[设置并初始化`@cloudcare/react-native-mobile` RUM 配置](../../../react-native/app-access.md)，并开启 View 的监控采集。
* React Native 会话重放目前为 alpha 功能，需要使用 `@cloudcare/react-native-mobile:0.4.0` 及以上的版本。

## 代码调用 {#code_sample}

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

| 属性       | 类型                 | 必须 | 含义                                                         |
| ---------- | -------------------- | ---- | ------------------------------------------------------------ |
| sampleRate | number               | 否   | 采样率，取值范围 [0,1]，0 表示不采集，1 表示全采集，默认值为 1。此采样率是 RUM 采样基础上的采样率。 |
| privacy    | SessionReplayPrivacy | 否   | 设置 Session Replay 中内容屏蔽的隐私级别。默认``SessionReplayPrivacy.MASK``。<br/>`SessionReplayPrivacy.ALLOW`: 除了敏感输入控件外不进行遮蔽隐私数据，例如密码输入<br/>`SessionReplayPrivacy.MASK_USER_INPUT`:遮蔽用户输入的部份数据，包括输入框中文字、Switch等<br>`SessionReplayPrivacy.MASK`：遮蔽隐私数据，包括文字、Switch等； |

