---
icon: zy/security
---

# 数据安全

在云计算时代，数据安全在数字信息的整个生命周期中都至关重要。全面的数据使用保护能力能帮助您获得更大的可见性和洞察力，自动建立安全预警机制，从而增强整体安全防护能力，让数据实现可用不可得，且做到安全合规。

在正常使用观测云产品的过程中，观测云会通过一系列工具对接收到的数据进行安全层面的风险预估和处理，从而保护产生的数据。

## 如何降低数据风险？

观测云从您的基础设施和服务的许多来源收集可观测性信息，并将其集中管理，供您随时分析处理。在这个过程中，观测云的服务器会发送各种类型的数据内容。因正常使用观测云产品而收集的大多数数据几乎不包含私人数据。对于可能包含不必要的个人数据，我们均会提供相关说明和建议，使您不会与其他数据混淆。观测云提供多种方式，以期减少包含个人数据的数据风险。

### DataKit 侧的数据安全考虑

#### HTTPS 数据上传

所有 Datakit 的数据均采用 HTTPS 协议上传，保证数据通信的安全性。

#### 有限的下发机制

中心无法下发指令给 Datakit 执行，所有请求都是 Datakit 主动发起。Datakit 只能定期从中心拉取一些相关配置（比如 Pipeline 和黑名单配置）。中心无法下发命令给 Datakit 执行。

#### Tracing 采集过程中的字段值脱敏

在 Tracing 采集过程中，可能会采集一些 SQL 语句的执行过程，这些 SQL 语句的字段取值，都会被脱敏掉，比如：

```sql
SELECT name from class where name = 'zhangsan'
```

会被脱敏成

```sql
SELECT name from class where name = ?
```

#### Pipeline 和黑名单机制

如果数据中确有一些敏感数据无法在采集过程中去除，那么可以通过 Pipeline 的一些特定函数（比如 `cover()` 函数可以将字符串中一些部位替换成 `*`）来脱敏一些敏感数据（比如手机号等）。

另外，通过配置黑名单规则，也能阻止一些敏感数据的上传。

### 敏感数据扫描

敏感数据扫描这一功能可用来识别、标记、编辑包含个人隐私等诸多风险性数据。其作为一道安全防线，能有效防止敏感数据向外流出。

> 更多详情，可参考 [敏感数据扫描](../management/data-scanner.md)。

### 日志

在观测云的产品服务使用过程会产生诸多日志记录。由于日志数据本身极强的关联性，在采集——分析的过程中需要采用特定规则处理才能实现海量日志数据的过滤。

通过为日志数据配置敏感字段，相应权限的成员则只能看到脱敏后的日志数据。

数据访问权限控制是降低日志数据安全风险的另一个关键方法。通过为不同角色配置对应的日志数据访问查询范围从而隔离数据，达到综合管理和过滤敏感数据的目的。

> 更多详情，可参考 [多角色数据访问权限控制](../management/logdata-access.md)。

### 快照

观测云的快照服务作为一种即时的数据副本，内含异常数据筛选条件和数据记录。在面对共享观测数据的需求时，通过分享快照时设置数据脱敏规则或决定分享方式，能生成指定查看权限的访问链接，自动形成数据防护罩。

> 更多详情，可参考 [快照](../getting-started/function-details/snapshot.md)。

### RUM

在采集用户访问的相关数据时，RUM（Real User Monitor）SDK 会针对数据进行自定义修改和拦截，避免敏感数据流动。

> 更多详情，可参考 [SDK 数据拦截以及数据修改](./before-send.md)。

#### Session Replay 隐私设置 {#session-replay}

Session Replay 提供隐私控制，以确保任何公司都不会暴露敏感数据或个人数据。并且数据是加密存储的。
Session Replay 的默认隐私选项旨在保护最终用户隐私并防止敏感的组织信息被收集。

##### 全局配置

通过开启 Session Replay，可以自动屏蔽敏感元素，使其不被 RUM SDK 记录。

要启用您的隐私设置，请在您的 SDK 配置中将 defaultPrivacyLevel 设置为 mask-user-input、mask 或 allow。

```js
import { datafluxRum } from '@cloudcare/browser-rum'

datafluxRum.init({
  applicationId: '<DATAFLUX_APPLICATION_ID>',
  datakitOrigin: '<DATAKIT ORIGIN>',
  service: 'browser',
  env: 'production',
  version: '1.0.0',
  sessionSampleRate: 100,
  sessionReplaySampleRate: 100,
  trackInteractions: true,
  defaultPrivacyLevel: 'mask-user-input' | 'mask' | 'allow',
})

datafluxRum.startSessionReplayRecording()
```

更新配置后，您可以使用以下隐私选项覆盖 HTML 文档的元素：

:material-numeric-1-circle-outline: Mask user input mode：屏蔽大多数表单字段，例如输入、文本区域和复选框值，同时按原样记录所有其他文本。输入被替换为三个星号 (\*\*\*)，文本区域被保留空间的 x 字符混淆。

**注意**：默认情况下，`mask-user-input` 是启用会话重放时的隐私设置。

:material-numeric-2-circle-outline: Mask mode：屏蔽所有 HTML 文本、用户输入、图像和链接。应用程序上的文本被替换为 X，将页面呈现为线框。

:material-numeric-3-circle-outline: Allow mode：记录所有数据。

一些限制：

为了数据安全考虑，不管您配置的 `defaultPrivacyLevel` 是何种模式，以下元素都会被屏蔽：

- password、email 和 tel 类型的输入元；
- 具有 `autocomplete` 属性的元素，例如信用卡号、到期日期和安全代码。

##### 自定义配置

Session Replay 支持对敏感元素的屏蔽功能，您可以根据业务需求灵活设置需要屏蔽的内容，例如手机号等敏感信息。以下为具体的操作方法：

通过元素属性配置屏蔽

可以为需要屏蔽的元素添加 data-gc-privacy 属性，支持以下四种属性值：

• allow：允许数据采集，无屏蔽处理。       
• mask：遮罩内容，将内容以掩码形式显示。       
• mask-user-input：遮罩用户输入，防止记录敏感输入数据。        
• hidden：完全隐藏内容。     

示例代码：

```html
<!-- 允许数据采集 -->
<div class="mobile" data-gc-privacy="allow">13523xxxxx</div>

<!-- 遮罩内容 -->
<div class="mobile" data-gc-privacy="mask">13523xxxxx</div>

<!-- 遮罩用户输入 -->
<input class="mobile" data-gc-privacy="mask-user-input" value="13523xxxxx" />

<!-- 隐藏内容 -->
<div class="mobile" data-gc-privacy="hidden">13523xxxxx</div>
```

通过元素类名配置屏蔽

支持通过为元素添加特定的类名实现屏蔽功能。目前支持以下类名：

• gc-privacy-allow：允许数据采集。
• gc-privacy-mask：遮罩内容。
• gc-privacy-mask-user-input：遮罩用户输入。
• gc-privacy-hidden：完全隐藏内容。

示例代码：

```html
<!-- 允许数据采集 -->
<div class="mobile gc-privacy-allow">13523xxxxx</div>

<!-- 遮罩内容 -->
<div class="mobile gc-privacy-mask">13523xxxxx</div>

<!-- 遮罩用户输入 -->
<input class="mobile gc-privacy-mask-user-input" value="13523xxxxx" />

<!-- 隐藏内容 -->
<div class="mobile gc-privacy-hidden">13523xxxxx</div>
```

配置说明和建议

1. 优先级规则：
   
   • 如果同时设置了 data-gc-privacy 属性和类名，建议按照项目文档说明确定优先级。

2. 适用场景：

   • allow：适用于无需屏蔽的常规数据。     
   • mask：适用于需要掩码显示的敏感数据，例如手机号。       
   • mask-user-input：适用于需要保护输入内容的场景，例如密码框。      
   • hidden：适用于不希望显示或记录的内容。       

3. 最佳实践：

   • 优先选择简单清晰的方式（如类名或属性），确保配置准确。     
   • 在高敏感数据场景中，如用户隐私表单，建议使用 mask-user-input 或 hidden。     

通过以上方法，您可以灵活配置敏感元素的屏蔽规则，提升数据安全性并满足业务合规需求。
