# 自定义用户访问监测 SDK 采集数据内容
---

默认情况下，RUM SDK 自动采集小程序端数据上传到 DataKit，大部分应用场景是不需要主动修改这些数据的，但也存在一些特定场景，需要通过设置不同类型的标识去定位分析一些数据，所以针对这些情况，RUM SDK 提供了一些特定的 API 方面用户在自己的应用系统中，加入自己特定的逻辑：

1. 自定义标识用户（ID、name、email）
2. 自定义添加额外的数据 TAG
3. 自定义添加 Action

