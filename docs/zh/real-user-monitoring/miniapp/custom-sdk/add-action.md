# 自定义添加 Action

---

初始化 RUM 后，使用 `addAction（'<NAME>'，'<JSON_OBJECT>'）` API，可以自定义添加采集之外的 Action 指标数据。

### 添加 Action

=== "CDN"

    [下载文件](https://static.<<< custom_key.brand_main_domain >>>/miniapp-sdk/v2/dataflux-rum-miniapp.js)本地方式引入

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    datafluxRum.addAction('<NAME>'，'<JSON_OBJECT>');

    // Code example
    datafluxRum && datafluxRum.addAction('cart', {
        amount: 42,
        nb_items: 2,
        items: ['socks', 't-shirt'],
    });
    ```

=== "NPM"

    [引入](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html)

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')
    datafluxRum.addAction('<NAME>'，'<JSON_OBJECT>');

    // Code example
    datafluxRum && datafluxRum.addAction('cart', {
        amount: 42,
        nb_items: 2,
        items: ['socks', 't-shirt'],
    });
    ```

### 如何使用 RUM SDK 添加自定义 Action 并避免字段冲突

在使用 window.DATAFLUX_RUM.addAction 添加自定义数据时，需要注意避免与 SDK 预置字段冲突。冲突的字段会导致数据设置无效。以下是一个错误的示例以及注意事项：

示例代码（包含字段冲突）

```js
window.DATAFLUX_RUM.addAction('test action', {
  view_url: 'a', // 与 SDK 预置字段 "view_url" 冲突，导致此字段无效。
  b: 'b',
  c: 'c',
})
```

改进代码与说明

可以通过避免使用与 SDK 预置字段相同的名称，改为自定义字段名或前缀来解决冲突：

```js
// 推荐的自定义字段命名方式，避免冲突
window.DATAFLUX_RUM.addAction('test action', {
  custom_view_url: 'a', // 使用自定义字段名，避免与 SDK 冲突
  b: 'b',
  c: 'c',
})
```

注意事项

1. 字段命名原则：
   • 避免使用 SDK 预置字段（如 view*url, view_name, 等常用字段）。这些字段可能被 SDK 用于内置逻辑，导致冲突。
   • 可添加前缀（如 custom*、user\_）区分自定义数据。
2. 字段冲突的影响：
   • 如果字段名称冲突，SDK 会忽略该字段的自定义值。
   • 在未能正确传递所需数据时，检查字段命名是否冲突尤为重要。

以下是预留字段对照表:

```json
[
  "sdk_name",
  "sdk_version",
  "app_id",
  "env",
  "service",
  "version",
  "source",
  "userid",
  "user_email",
  "user_name",
  "session_id",
  "session_type",
  "session_sampling",
  "is_signin",
  "os",
  "os_version",
  "os_version_major",
  "browser",
  "browser_version",
  "browser_version_major",
  "screen_size",
  "network_type",
  "device",
  "view_id",
  "view_referrer",
  "view_url",
  "view_host",
  "view_path",
  "view_name",
  "view_path_group",
  "view_url_query",
  "action_id",
  "action_ids",
  "view_in_foreground",
  "display",
  "session_has_replay",
  "is_login",
  "page_states",
  "session_sample_rate",
  "session_replay_sample_rate",
  "drift",
  "action_type",
  "action_name",
  "duration",
  "action_error_count",
  "action_resource_count",
  "action_frustration_types",
  "action_long_task_count",
  "action_target",
  "action_position"
]
```
