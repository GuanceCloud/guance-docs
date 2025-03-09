# Custom Addition of Action

---

After initializing RUM, use the `addAction('<NAME>', '<JSON_OBJECT>')` API to add custom Action metric data outside of the collected data.

### Adding an Action

=== "CDN"

    [Download file](https://<<< custom_key.static_domain >>>/miniapp-sdk/v2/dataflux-rum-miniapp.js) and include it locally.

    ```javascript
    const { datafluxRum } = require('./lib/dataflux-rum-miniapp.js')
    datafluxRum.addAction('<NAME>', '<JSON_OBJECT>');

    // Code example
    datafluxRum && datafluxRum.addAction('cart', {
        amount: 42,
        nb_items: 2,
        items: ['socks', 't-shirt'],
    });
    ```

=== "NPM"

    [Introduction](https://developers.weixin.qq.com/miniprogram/dev/devtools/npm.html)

    ```javascript
    const { datafluxRum } = require('@cloudcare/rum-miniapp')
    datafluxRum.addAction('<NAME>', '<JSON_OBJECT>');

    // Code example
    datafluxRum && datafluxRum.addAction('cart', {
        amount: 42,
        nb_items: 2,
        items: ['socks', 't-shirt'],
    });
    ```

### How to Add Custom Actions Using the RUM SDK and Avoid Field Conflicts

When adding custom data using `window.DATAFLUX_RUM.addAction`, it's important to avoid conflicts with predefined fields in the SDK. Conflicting fields can result in invalid data settings. Below is an incorrect example and some considerations:

Example code (with field conflict)

```js
window.DATAFLUX_RUM.addAction('test action', {
  view_url: 'a', // Conflicts with the SDK's predefined "view_url" field, making this field invalid.
  b: 'b',
  c: 'c',
})
```

Improved code and explanation

To resolve conflicts, avoid using the same names as predefined SDK fields by using custom field names or prefixes:

```js
// Recommended custom field naming to avoid conflicts
window.DATAFLUX_RUM.addAction('test action', {
  custom_view_url: 'a', // Use a custom field name to avoid conflicts with the SDK
  b: 'b',
  c: 'c',
})
```

Considerations

1. Field naming principles:
   • Avoid using predefined SDK fields (such as `view_url`, `view_name`, etc.). These fields may be used for internal logic by the SDK, leading to conflicts.
   • Add prefixes (such as `custom_`, `user_`) to distinguish custom data.
2. Impact of field conflicts:
   • If field names conflict, the SDK will ignore the custom values for those fields.
   • It is particularly important to check for field name conflicts when the required data is not being passed correctly.

Below is a list of reserved fields:

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