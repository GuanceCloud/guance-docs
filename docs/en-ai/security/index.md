---
icon: zy/security
---

# Data Security

In the era of cloud computing, data security is critical throughout the entire lifecycle of digital information. Comprehensive data protection capabilities can help you gain greater visibility and insight, automatically establish security alert mechanisms, thereby enhancing overall security defense capabilities, ensuring data availability without access, and achieving compliance.

During the normal use of Guance products, Guance will process received data through a series of tools to assess and handle security risks at the data level, thus protecting the generated data.

## How to Reduce Data Risks?

Guance collects observability information from many sources within your infrastructure and services and manages it centrally for you to analyze and process at any time. In this process, Guance's servers send various types of data content. Most of the data collected during the normal use of Guance products does not contain private data. For data that may include unnecessary personal data, we provide relevant explanations and suggestions so that you do not confuse it with other data. Guance offers multiple methods to reduce the risk of data containing personal information.

### DataKit Side Data Security Considerations

#### HTTPS Data Upload

All DataKit data is uploaded using the HTTPS protocol to ensure secure data communication.

#### Limited Command Issuance Mechanism

The center cannot issue commands to DataKit for execution; all requests are initiated by DataKit. DataKit can only periodically pull some related configurations (such as Pipeline and blacklist configurations) from the center. The center cannot issue commands to DataKit for execution.

#### Tracing Collection Field Value Masking

During the Tracing collection process, SQL statements' execution processes might be collected, and the field values of these SQL statements will be masked, for example:

```sql
SELECT name from class where name = 'zhangsan'
```

will be masked into

```sql
SELECT name from class where name = ?
```

#### Pipeline and Blacklist Mechanisms

If there are indeed sensitive data items that cannot be removed during the collection process, they can be masked using specific functions in Pipelines (for example, the `cover()` function can replace certain parts of strings with `*`).

Additionally, configuring blacklist rules can prevent some sensitive data from being uploaded.

### Sensitive Data Scanning

Sensitive data scanning can identify, tag, and edit data containing personal privacy and other risky information. As a line of defense, it effectively prevents sensitive data from leaking out.

> For more details, refer to [Sensitive Data Scanning](../management/data-scanner.md).

### Logs

During the use of Guance products and services, numerous log records are generated. Due to the strong correlation of log data itself, specific rules need to be applied during the collection and analysis process to filter massive amounts of log data.

By configuring sensitive fields for log data, members with corresponding permissions can only see masked log data.

Data access permission control is another key method to reduce the security risks of log data. By configuring the query scope of log data access for different roles, data can be isolated, achieving comprehensive management and filtering of sensitive data.

> For more details, refer to [Multi-role Data Access Permission Control](../management/logdata-access.md).

### Snapshots

Guance's snapshot service acts as an instant data copy containing anomaly data filtering conditions and data records. When sharing observational data, setting data masking rules or determining sharing methods when generating snapshots can create access links with specified viewing permissions, automatically forming a data protection shield.

> For more details, refer to [Snapshots](../getting-started/function-details/snapshot.md).

### RUM

When collecting data related to user visits, the RUM (Real User Monitor) SDK modifies and intercepts data to prevent the flow of sensitive data.

> For more details, refer to [SDK Data Interception and Modification](./before-send.md).

#### Session Replay Privacy Settings {#session-replay}

Session Replay provides privacy controls to ensure that no company exposes sensitive or personal data. Data is stored encrypted.
The default privacy settings of Session Replay aim to protect end-user privacy and prevent the collection of sensitive organizational information.

##### Global Configuration

By enabling Session Replay, sensitive elements can be automatically blocked from being recorded by the RUM SDK.

To enable your privacy settings, set `defaultPrivacyLevel` to `mask-user-input`, `mask`, or `allow` in your SDK configuration.

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

After updating the configuration, you can override HTML document elements with the following privacy options:

:material-numeric-1-circle-outline: Mask user input mode: Masks most form fields such as inputs, text areas, and checkbox values while recording all other text as-is. Inputs are replaced with three asterisks (\*\*\*), and text areas are obfuscated with x characters.

**Note**: By default, `mask-user-input` is the privacy setting enabled when session replay is activated.

:material-numeric-2-circle-outline: Mask mode: Masks all HTML text, user input, images, and links. Text on the application is replaced with X, rendering the page as a wireframe.

:material-numeric-3-circle-outline: Allow mode: Records all data.

Some restrictions:

For data security considerations, regardless of the `defaultPrivacyLevel` you configure, the following elements will always be masked:

- Input elements of type password, email, and tel.
- Elements with the `autocomplete` attribute, such as credit card numbers, expiration dates, and security codes.

##### Custom Configuration

Session Replay supports masking sensitive elements, allowing you to flexibly set what needs to be masked based on business requirements, such as phone numbers and other sensitive information. Here’s how to do it:

Masking via Element Attributes

Add the `data-gc-privacy` attribute to elements you want to mask, supporting the following attribute values:

• allow: Allows data collection without masking.
• mask: Masks content, displaying it in masked form.
• mask-user-input: Masks user input to prevent recording sensitive input data.
• hidden: Completely hides content.

Example code:

```html
<!-- Allow data collection -->
<div class="mobile" data-gc-privacy="allow">13523xxxxx</div>

<!-- Mask content -->
<div class="mobile" data-gc-privacy="mask">13523xxxxx</div>

<!-- Mask user input -->
<input class="mobile" data-gc-privacy="mask-user-input" value="13523xxxxx" />

<!-- Hide content -->
<div class="mobile" data-gc-privacy="hidden">13523xxxxx</div>
```

Masking via Element Class Names

Supports masking functionality by adding specific class names to elements. Currently supported class names are:

• gc-privacy-allow: Allows data collection.
• gc-privacy-mask: Masks content.
• gc-privacy-mask-user-input: Masks user input.
• gc-privacy-hidden: Completely hides content.

Example code:

```html
<!-- Allow data collection -->
<div class="mobile gc-privacy-allow">13523xxxxx</div>

<!-- Mask content -->
<div class="mobile gc-privacy-mask">13523xxxxx</div>

<!-- Mask user input -->
<input class="mobile gc-privacy-mask-user-input" value="13523xxxxx" />

<!-- Hide content -->
<div class="mobile gc-privacy-hidden">13523xxxxx</div>
```

Configuration Guidelines and Recommendations

1. Priority Rules:
   
   • If both `data-gc-privacy` attributes and class names are set, follow the project documentation to determine priority.

2. Applicable Scenarios:

   • allow: Suitable for regular data that does not need masking.
   • mask: Suitable for sensitive data requiring masked display, such as phone numbers.
   • mask-user-input: Suitable for scenarios where input content needs protection, such as password fields.
   • hidden: Suitable for content that should not be displayed or recorded.

3. Best Practices:

   • Prefer simple and clear methods (like class names or attributes) to ensure accurate configuration.
   • In highly sensitive data scenarios, such as user privacy forms, consider using `mask-user-input` or `hidden`.

By following these methods, you can flexibly configure masking rules for sensitive elements, enhancing data security and meeting business compliance requirements.