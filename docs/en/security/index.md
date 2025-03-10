---
icon: zy/security
---

# Data Security

In the era of cloud computing, data security is critical throughout the entire lifecycle of digital information. Comprehensive data usage protection capabilities can help you gain greater visibility and insight, automatically establish security warning mechanisms, thereby enhancing overall security protection capabilities, ensuring data availability without unauthorized access, and ensuring compliance with security regulations.

During normal use of <<< custom_key.brand_name >>> products, <<< custom_key.brand_name >>> will process received data through a series of tools for risk assessment and handling at the security level, thus protecting the generated data.

## How to Reduce Data Risk?

<<< custom_key.brand_name >>> collects observability information from many sources of your infrastructure and services and manages it centrally for you to analyze and handle at any time. In this process, <<< custom_key.brand_name >>> servers send various types of data content. Most of the data collected due to normal use of <<< custom_key.brand_name >>> products almost does not contain private data. For data that may include unnecessary personal data, we provide relevant explanations and recommendations so that it does not get mixed up with other data. <<< custom_key.brand_name >>> provides multiple methods to reduce the risk of data containing personal information.

### DataKit Side Data Security Considerations

#### HTTPS Data Upload

All DataKit data is uploaded using the HTTPS protocol to ensure secure data communication.

#### Limited Command Issuance Mechanism

The center cannot issue commands to DataKit for execution; all requests are initiated by DataKit. DataKit can only periodically pull related configurations (such as Pipeline and blacklist configurations) from the center. The center cannot issue commands to DataKit for execution.

#### Tracing Field Value Masking

During the tracing collection process, some SQL statements' execution processes might be collected, and the field values of these SQL statements will be masked, for example:

```sql
SELECT name FROM class WHERE name = 'zhangsan'
```

will be masked as

```sql
SELECT name FROM class WHERE name = ?
```

#### Pipeline and Blacklist Mechanisms

If there are indeed sensitive data in the data that cannot be removed during the collection process, they can be masked using specific functions in Pipelines (for example, the `cover()` function can replace certain parts of strings with `*`). Additionally, configuring blacklist rules can prevent the upload of sensitive data.

### Sensitive Data Scanning

Sensitive data scanning can be used to identify, label, and edit data containing personal privacy and other risky data. As a line of defense, it effectively prevents sensitive data from leaking out.

> For more details, refer to [Sensitive Data Scanning](../management/data-scanner.md).

### Logs

Using <<< custom_key.brand_name >>> products generates numerous log records. Due to the strong association of log data itself, specific rules need to be applied during the collection and analysis process to filter massive amounts of log data.

By configuring sensitive fields for log data, members with corresponding permissions can only see masked log data.

Data access control is another key method to reduce the security risks associated with log data. By configuring different roles with corresponding log data access query scopes, data isolation can be achieved, leading to comprehensive management and filtering of sensitive data.

> For more details, refer to [Multi-role Data Access Control](../management/logdata-access.md).

### Snapshots

<<< custom_key.brand_name >>>'s snapshot service acts as an immediate data copy, containing anomaly data filtering conditions and data records. When sharing observational data, setting data masking rules or deciding on the sharing method when generating snapshots can create access links with specified viewing permissions, automatically forming a data protection shield.

> For more details, refer to [Snapshots](../getting-started/function-details/snapshot.md).

### RUM

When collecting user visit-related data, the RUM (Real User Monitor) SDK modifies and intercepts data to prevent sensitive data from being transmitted.

> For more details, refer to [SDK Data Interception and Modification](./before-send.md).

#### Session Replay Privacy Settings {#session-replay}

Session Replay provides privacy controls to ensure that no company exposes sensitive data or personal data. Data is stored encrypted.
The default privacy options for Session Replay aim to protect end-user privacy and prevent sensitive organizational information from being collected.

##### Global Configuration

By enabling Session Replay, sensitive elements can be automatically masked, preventing them from being recorded by the RUM SDK.

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

After updating the configuration, you can override HTML document elements using the following privacy options:

:material-numeric-1-circle-outline: Mask User Input Mode: Masks most form fields such as input, text areas, and checkbox values, while recording all other text as-is. Inputs are replaced with three asterisks (\*\*\*), and text areas are obfuscated with x characters.

**Note**: By default, `mask-user-input` is the privacy setting enabled when session replay is turned on.

:material-numeric-2-circle-outline: Mask Mode: Masks all HTML text, user inputs, images, and links. Text on the application is replaced with X, rendering the page as a wireframe.

:material-numeric-3-circle-outline: Allow Mode: Records all data.

Some limitations:

For data security considerations, regardless of the configured `defaultPrivacyLevel`, the following elements will always be masked:

- Input elements of type password, email, and tel.
- Elements with the `autocomplete` attribute, such as credit card numbers, expiration dates, and security codes.

##### Custom Configuration

Session Replay supports masking sensitive elements, allowing you to flexibly configure what needs to be masked based on business requirements, such as phone numbers and other sensitive information. Here are the specific methods:

Masking via Element Attributes

Add the `data-gc-privacy` attribute to elements that need to be masked, supporting the following four attribute values:

• allow: Allows data collection without masking.
• mask: Masks content, displaying it in a masked format.
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

Supports masking by adding specific class names to elements. Currently supported class names include:

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

Configuration Instructions and Recommendations

1. Priority Rules:

   • If both `data-gc-privacy` attributes and class names are set, follow the priority rules outlined in the project documentation.

2. Applicable Scenarios:

   • allow: Suitable for regular data that doesn't need masking.
   • mask: Suitable for sensitive data that needs to be displayed in masked format, such as phone numbers.
   • mask-user-input: Suitable for scenarios where user input needs protection, such as password fields.
   • hidden: Suitable for content that should not be displayed or recorded.

3. Best Practices:

   • Prefer simple and clear methods (such as class names or attributes) to ensure accurate configuration.
   • In high-sensitivity data scenarios, such as user privacy forms, it's recommended to use `mask-user-input` or `hidden`.

By using the above methods, you can flexibly configure masking rules for sensitive elements, enhancing data security and meeting business compliance requirements.