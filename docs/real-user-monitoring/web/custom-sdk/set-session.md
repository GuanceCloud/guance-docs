# 自定义设置会话
---


通过自定义设置 session ID 可以跟踪特定 session 下的整个会话流程。例如：通过设定 session ID 为`debug_session_xx`, SDK会把上报数据中的 session ID 替换为您指定的 ID。数据上报完成后，您可以根据这个 session ID **在 **[DataFlux](https://console.dataflux.cn)** 平台跟踪到会话周期内所有**`视图`、`错误`、`操作`、`资源`数据。

### 添加session

#### CDN 同步

```javascript
window.DATAFLUX_RUM && window.DATAFLUX_RUM.addDebugSession('debug_session_xx') 
// session ID 最好能指定为特定场景下，可以识别的字符
```

#### CDN 异步

```javascript
DATAFLUX_RUM.onReady(function() {
    DATAFLUX_RUM.addDebugSession('debug_session_xx') 
})
// session ID 最好能指定为特定场景下，可以识别的字符
```

#### NPM

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'
datafluxRum.addDebugSession()
// session ID 最好能指定为特定场景下，可以识别的字符
```

注意：设置的 session ID 默认情况下在无任何操作或者不主动移除的情况，会话过期时长为15分钟。 

### 获取session 信息

如果在设置了自定义 session 的情况下，通过获取 session 信息 API ，能够获取当前状态下设置的 id(session ID)、created(创建时间)。

#### CDN 同步

```javascript
window.DATAFLUX_RUM && window.DATAFLUX_RUM.getDebugSession() 
// {
//	created: 1628653003152, 毫秒时间戳,
//  format_created: 2021-08-11 11:39:32.455, 格式化时间,
//  id: xxxx, 设置的自定义id
// }
```

#### CDN异步

```javascript
DATAFLUX_RUM.onReady(function() {
    DATAFLUX_RUM.getDebugSession() 
    // {
    //	created: 1628653003152, 毫秒时间戳,
    //  format_created: 2021-08-11 11:39:32.455, 格式化时间,
    //  id: xxxx, 设置的自定义id
    // }
})

```

#### NPM

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'
datafluxRum.getDebugSession()
// {
//	created: 1628653003152, 毫秒时间戳,
//  format_created: 2021-08-11 11:39:32.455, 格式化时间,
//  id: xxxx, 设置的自定义id
// }

```

### 移除自定义session
#### CDN 同步

```javascript
window.DATAFLUX_RUM && window.DATAFLUX_RUM.clearDebugSession() 
```

#### CDN 异步

```javascript
DATAFLUX_RUM.onReady(function() {
    DATAFLUX_RUM.clearDebugSession() 
})

```

#### NPM

```javascript
import { datafluxRum } from '@cloudcare/browser-rum'
datafluxRum.clearDebugSession()
```
