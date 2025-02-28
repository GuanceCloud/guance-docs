# 浏览器日志采集

---

通过 Web 浏览器或者 Javascript 客户端主动发送不同等级的日志数据(`对应的 source:browser_log` 指标类型日志数据)到[<<< custom_key.brand_name >>>](https://www.guance.com/)。


- 自定义日志数据采集，通过 SDK 接入客户端应用中，针对不同场景采集不同日志数据；
- 自动收集应用端的错误信息（包括网络错误，console 错误，以及 js 错误）上报到<<< custom_key.brand_name >>>；
- 自定义错误等级（`debug`,`critical`,`error`,`info`,`warn`），自定义 Logger 对象，以及自定义 Log 字段；
- 自动收集 [RUM](../real-user-monitoring/web/app-access.md) 相关数据，关联 RUM 业务场景。

## 开始使用

### 前置条件

- **DataKit**：通过 DataKit 日志采集 API 发送日志数据到<<< custom_key.brand_name >>>平台；

- **引入 SDK**：可通过 `NPM`,`CDN 同步`或 `CDN 异步`的方式引入 SDK 到应用中；

- **支持的浏览器**：支持所有 PC 端、移动端的浏览器。

### 选择接入

| 接入方式     | 简介                                                                                                                                                             |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| NPM          | 通过把 SDK 代码一起打包到你的前端项目中，此方式可以确保对前端页面的性能不会有任何影响，不过可能会错过 SDK 初始化之前的的请求、错误的收集。                       |
| CDN 异步加载 | 通过 CDN 加速缓存，以异步脚本引入的方式，引入 SDK 脚本，此方式可以确保 SDK 脚本的下载不会影响页面的加载性能，不过可能会错过 SDK 初始化之前的的请求、错误的收集。 |
| CDN 同步加载 | 通过 CDN 加速缓存，以同步脚本引入的方式，引入 SDK 脚本，此方式可以确保能够收集到所有的错误，资源，请求，性能指标。不过可能会影响页面的加载性能。                 |

#### NPM

```javascript
import { datafluxLogs } from '@cloudcare/browser-logs'
datafluxLogs.init({
  datakitOrigin: '<DataKit的域名或IP>', // DK方式接入时需要配置
  clientToken: 'clientToken', // 公网 OpenWay 接入时,需要填写
  site: '公网 OpenWay 地址', // 公网 OpenWay 接入时,需要填写
  //service: 'browser',
  //forwardErrorsToLogs:true
})
```

#### CDN 异步加载

```html
<script>
  ;(function (h, o, u, n, d) {
    h = h[d] = h[d] || {
      q: [],
      onReady: function (c) {
        h.q.push(c)
      },
    }
    d = o.createElement(u)
    d.async = 1
    d.src = n
    n = o.getElementsByTagName(u)[0]
    n.parentNode.insertBefore(d, n)
  })(window, document, 'script', 'https://<<< custom_key.static_domain >>>/browser-sdk/v3/dataflux-logs.js', 'DATAFLUX_LOGS')
  DATAFLUX_LOGS.onReady(function () {
    DATAFLUX_LOGS.init({
      datakitOrigin: '<DataKit的域名或IP>', // DK方式接入时需要配置
      clientToken: 'clientToken', // 公网 OpenWay 接入时,需要填写
      site: '公网 OpenWay 地址', // 公网 OpenWay 接入时,需要填写
      //service: 'browser',
      //forwardErrorsToLogs:true
    })
  })
</script>
```

#### CDN 同步加载

```html
<script src="https://<<< custom_key.static_domain >>>/browser-sdk/v3/dataflux-logs.js" type="text/javascript"></script>
<script>
  window.DATAFLUX_LOGS &&
    window.DATAFLUX_LOGS.init({
      datakitOrigin: '<DataKit的域名或IP>', // DK方式接入时需要配置
      clientToken: 'clientToken', // 公网 OpenWay 接入时,需要填写
      site: '公网 OpenWay 地址', // 公网 OpenWay 接入时,需要填写
      //service: 'browser',
      //forwardErrorsToLogs:true
    })
</script>
```

## 配置

### 初始化参数

| **参数**               | **类型**    | **是否必须** | **默认值** | **描述**                                                                                                                                 |
| ---------------------- | ----------- | ------------ | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| `datakitOrigin`        | String      | 是           |            | DataKit 数据上报 Origin 注释：`协议（包括：//），域名（或 IP 地址）[和端口号] `例如：https://www.datakit.com, http://100.20.34.3:8088。  |
| `clientToken`          | String      | 是           |            | 以 openway 方式上报数据令牌，从<<< custom_key.brand_name >>>控制台获取，必填（公共 openway 方式接入）。                                                         |
| `site`                 | String      | 是           |            | 以 公共 openway 方式上报数据地址，从<<< custom_key.brand_name >>>控制台获取，必填（公共 openway 方式接入）。                                                    |
| `service`              | String      | 否           | `browser`  | 日志 Service 名称                                                                                                                        |
| `env`                  | String      | 否           |            | Web 应用当前环境， 如 Prod：线上环境；Gray：灰度环境；Pre：预发布环境 Common：日常环境；Local：本地环境；                                |
| `version`              | String      | 否           |            | Web 应用的版本号                                                                                                                         |
| `sessionSampleRate`    | Number      | 否           | `100`      | 指标数据收集百分比：`100` 表示全收集，`0` 表示不收集                                                                                     |
| `forwardErrorsToLogs`  | Boolean     | 否           | `true`     | 设置为 `false` 表示停止采集 console.error、 js、以及网络错误上报到<<< custom_key.brand_name >>>日志数据中                                                       |
| `silentMultipleInit`   | Boolean     | 否           | `false`    | 不允许有多个日志对象被初始化                                                                                                             |
| `forwardConsoleLogs`   | 字符串/数组 |              |            | 需要采集浏览器 console 日志类型，可选值：`error`, `log`, `info`, `warn`, `error`                                                         |
| `storeContextsToLocal` | Boolean     | 否           |            | 版本要求:`>3.1.2`。是否把用户自定义数据缓存到本地 localstorage，例如： `setUser`, `addGlobalContext` api 添加的自定义数据。              |
| `storeContextsKey`     | String      | 否           |            | 版本要求:`>3.1.18`。定义存储到 localstorage 的 key ，默认不填，自动生成, 该参数主要是为了区分在同一个域名下，不同子路径共用 store 的问题 |

## 使用

SDK 在应用中初始化后，通过暴露的 JS API 可以自定义配置日志数据。

```javascript
logger.debug | info | warn | error | critical (message: string, messageContext = Context)
```

### NPM

```javascript
import { datafluxLogs } from '@cloudcare/browser-logs'

datafluxLogs.logger.info('Button clicked', { name: 'buttonName', id: 123 })
```

### CDN 异步

```javascript
DATAFLUX_LOGS.onReady(function () {
  DATAFLUX_LOGS.logger.info('Button clicked', { name: 'buttonName', id: 123 })
})
```

### CDN 同步

```javascript
window.DATAFLUX_LOGS && DATAFLUX_LOGS.logger.info('Button clicked', { name: 'buttonName', id: 123 })
```

## 返回数据结构

```json
{
  "service": "browser",
  "session": {
    "id": "c549c2b8-4955-4f74-b7f8-a5f42fc6e79b"
  },
  "type": "logger",
  "_dd": {
    "sdk_name": "Web LOG SDK",
    "sdk_version": "1.0.0",
    "env": "",
    "version": ""
  },
  "device": {
    "os": "Mac OS",
    "os_version": "10.14.6",
    "os_version_major": "10",
    "browser": "Chrome",
    "browser_version": "90.0.4430.85",
    "browser_version_major": "90",
    "screen_size": "2560*1440",
    "network_type": "3g",
    "divice": "PC"
  },
  "user": {},
  "date": 1621321916756,
  "view": {
    "referrer": "",
    "url": "http://localhost:8080/",
    "host": "localhost:8080",
    "path": "/",
    "path_group": "/",
    "url_query": "{}",
    "id": "5dce64f4-8d6d-411a-af84-c41653ccd94a"
  },
  "application": {
    "id": "app_idxxxxxx"
  },
  "message": "XHR error get http://testing-ft2x-api.cloudcare.cn/api/v1/workspace/xxx",
  "status": "error",
  "tags": {},
  "error": {
    "source": "network",
    "stack": "Failed to load"
  },
  "resource": {
    "method": "get",
    "status": 0,
    "status_group": 0,
    "url": "http://testing-ft2x-api.cloudcare.cn/api/v1/workspace/xxx",
    "url_host": "testing-ft2x-api.cloudcare.cn",
    "url_path": "/api/v1/workspace/xxx",
    "url_path_group": "/api/?/workspace/xxx"
  }
}
```

## Status 参数

初始化 SDk 后，可以使用提供 `log` API，定义不同类型的状态。

```javascript
log (message: string, messageContext: Context, status? = 'debug' | 'info' | 'warn' | 'error' | 'critical')
```

### NPM

```javascript
import { datafluxLogs } from '@cloudcare/browser-logs'

datafluxLogs.logger.log(<MESSAGE>,<JSON_ATTRIBUTES>,<STATUS>);
```

### CDN 异步

```javascript
DATAFLUX_LOGS.onReady(function () {
  DATAFLUX_LOGS.logger.log(<MESSAGE>,<JSON_ATTRIBUTES>,<STATUS>);
})
```

### CDN 同步

```javascript
window.DATAFLUX_LOGS && DATAFLUX_LOGS.logger.log(<MESSAGE>,<JSON_ATTRIBUTES>,<STATUS>);
```

## 参数说明

| **参数**            | **描述**                                                    |
| ------------------- | ----------------------------------------------------------- |
| `<MESSAGE>`         | <<< custom_key.brand_name >>>日志中的 Message 字段                                 |
| `<JSON_ATTRIBUTES>` | 描述 Message 的额外数据，是一个 Json 对象                   |
| `<STATUS>`          | 日志的等级，可选值 `debug`,`info`,`warn`,`error`,`critical` |

## 自定义添加额外的数据 TAG

---

初始化 LOG 后，使用 `setGlobalContextProperty(key:string，value:any)` API 向从应用程序收集的所有 LOG 事件添加额外的 TAG。

### 添加 TAG

=== "CDN 同步"

    ``` javascript
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.setGlobalContextProperty('<CONTEXT_KEY>', '<CONTEXT_VALUE>');

    // Code example
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.setGlobalContextProperty('isvip', 'xxxx');
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.setGlobalContextProperty('activity', {
        hasPaid: true,
        amount: 23.42
    });
    ```

=== "CDN 异步"

    ``` javascript
    DATAFLUX_LOGS.onReady(function() {
        DATAFLUX_LOGS.setGlobalContextProperty('<CONTEXT_KEY>', '<CONTEXT_VALUE>');
    })

    // Code example
    DATAFLUX_LOGS.onReady(function() {
        DATAFLUX_LOGS.setGlobalContextProperty('isvip', 'xxxx');
    })
    DATAFLUX_LOGS.onReady(function() {
        DATAFLUX_LOGS.setGlobalContextProperty('activity', {
            hasPaid: true,
            amount: 23.42
        });
    })

    ```

=== "NPM"

    ``` javascript
    import { datafluxLogs } from '@cloudcare/browser-logs'
    datafluxLogs.setGlobalContextProperty('<CONTEXT_KEY>', <CONTEXT_VALUE>);

    // Code example
    datafluxLogs && datafluxLogs.setGlobalContextProperty('isvip', 'xxxx');
    datafluxLogs.setGlobalContextProperty('activity', {
        hasPaid: true,
        amount: 23.42
    });
    ```

### 替换 TAG（覆盖）

=== "CDN 同步"

    ```javascript
    window.DATAFLUX_LOGS &&
         window.DATAFLUX_LOGS.setGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

    // Code example
    window.DATAFLUX_LOGS &&
         window.DATAFLUX_LOGS.setGlobalContext({
            codeVersion: 34,
        });
    ```

=== "CDN 异步"

    ```javascript
     window.DATAFLUX_LOGS.onReady(function() {
         window.DATAFLUX_LOGS.setGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });
    })

    // Code example
     window.DATAFLUX_LOGS.onReady(function() {
         window.DATAFLUX_LOGS.setGlobalContext({
            codeVersion: 34,
        })
    })
    ```

=== "NPM"

    ```javascript
    import { datafluxLogs } from '@cloudcare/browser-logs'

    datafluxLogs.setGlobalContext({ '<CONTEXT_KEY>': '<CONTEXT_VALUE>' });

    // Code example
    datafluxLogs.setGlobalContext({
        codeVersion: 34,
    });
    ```

### 获取所有设置的自定义 TAG

=== "CDN 同步"

    ```javascript
    var context = window.DATAFLUX_LOGS &&  window.DATAFLUX_LOGS.getGlobalContext();

    ```

=== "CDN 异步"

    ```javascript
     window.DATAFLUX_LOGS.onReady(function() {
        var context =  window.DATAFLUX_LOGS.getGlobalContext();
    });
    ```

=== "NPM"

    ```javascript
    import { datafluxLogs } from '@cloudcare/browser-logs'

    const context = datafluxLogs.getGlobalContext();

    ```

### 移除特定 key 对应的自定义 TAG

=== "CDN 同步"

    ```javascript
    var context = window.DATAFLUX_LOGS &&  window.DATAFLUX_LOGS.removeGlobalContextProperty('<CONTEXT_KEY>');

    ```

=== "CDN 异步"

    ```javascript
     window.DATAFLUX_LOGS.onReady(function() {
        var context =  window.DATAFLUX_LOGS.removeGlobalContextProperty('<CONTEXT_KEY>');
    });
    ```

=== "NPM"

    ```javascript
    import { datafluxLogs } from '@cloudcare/browser-logs'

    const context = datafluxLogs.removeGlobalContextProperty('<CONTEXT_KEY>');
    ```

### 移除所有的自定义 TAG

=== "CDN 同步"

    ```javascript
    var context = window.DATAFLUX_LOGS &&  window.DATAFLUX_LOGS.clearGlobalContext();

    ```

=== "CDN 异步"

    ```javascript
     window.DATAFLUX_LOGS.onReady(function() {
        var context =  window.DATAFLUX_LOGS.clearGlobalContext();
    });
    ```

=== "NPM"

    ```javascript
    import { datafluxLogs } from '@cloudcare/browser-logs'

    const context = datafluxLogs.clearGlobalContext();
    ```

## 自定义用户标识

---

SDK 默认情况下，自动会给用户生成一个唯一标识 ID。这个 ID 不带任何标识属性，只能区别出不同用户属性。为此我们提供了额外的 API 去给当前用户添加不同的标识属性。

| 属性       | 类型   | 描述               |
| ---------- | ------ | ------------------ |
| user.id    | string | 用户 ID            |
| user.name  | string | 用户昵称或者用户名 |
| user.email | string | 用户邮箱           |

**注意**：以下属性是可选的，但建议至少提供其中一个。

### 添加用户标识

=== "CDN 同步"

    ```javascript
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
    ```

=== "CDN 异步"

    ```javascript
    window.DATAFLUX_LOGS.onReady(function() {
        window.DATAFLUX_LOGS.setUser({
            id: '1234',
            name: 'John Doe',
            email: 'john@doe.com',
        })
    })
    ```

=== "NPM"

    ```javascript
    import { datafluxLogs } from '@cloudcare/browser-logs'
    datafluxLogs.setUser({
        id: '1234',
        name: 'John Doe',
        email: 'john@doe.com',
    })
    ```

### 移除用户标识

=== "CDN 同步"

    ```javascript
    window.DATAFLUX_LOGS && window.DATAFLUX_LOGS.clearUser()
    ```

=== "CDN 异步"

    ```javascript
    window.DATAFLUX_LOGS.onReady(function() {
        window.DATAFLUX_LOGS.clearUser()
    })
    ```

=== "NPM"

    ```javascript
    import { datafluxLogs } from '@cloudcare/browser-logs'
    datafluxLogs.clearUser()
    ```
