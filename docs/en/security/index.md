---
icon: zy/security
---

# Data Security

In the era of cloud computing, data security is crucial throughout the entire lifecycle of digital information. Comprehensive data usage protection capabilities can help you gain greater visibility and insight, automatically establishing early warning mechanisms to enhance overall security protection, ensuring that data is available but not obtainable, while also meeting safety compliance requirements.

During the normal use of <<< custom_key.brand_name >>> products, <<< custom_key.brand_name >>> will process received data through a series of tools for risk assessment and handling at the security level, thus protecting the generated data.

## How to Reduce Data Risks?

<<< custom_key.brand_name >>> collects observability information from many sources of your infrastructure and services and manages it centrally for you to analyze and handle at any time. In this process, <<< custom_key.brand_name >>> servers send various types of data content. Most of the data collected during the normal use of <<< custom_key.brand_name >>> products almost does not contain private data. For data that may include unnecessary personal data, we provide relevant explanations and suggestions so that it does not get mixed with other data. <<< custom_key.brand_name >>> provides multiple methods to reduce the risks associated with data containing personal data.

### Data Security Considerations on the DataKit Side

#### HTTPS Data Upload

All Datakit data is uploaded using the HTTPS protocol to ensure the security of data communication.

#### Limited Issuance Mechanism

The center cannot issue commands to Datakit for execution; all requests are initiated by Datakit. Datakit can only periodically pull some related configurations from the center (such as Pipeline and blacklist configurations). The center cannot issue commands to Datakit for execution.

#### Field Value Desensitization During Tracing Collection

During the Tracing collection process, some SQL statement execution processes may be collected. The field values of these SQL statements will be desensitized, for example:

```sql
SELECT name from class where name = 'zhangsan'
```

will be desensitized into

```sql
SELECT name from class where name = ?
```

#### Pipeline and Blacklist Mechanism

If there are indeed some sensitive data in the data that cannot be removed during the collection process, then specific functions in the Pipeline (for example, the `cover()` function can replace some parts of a string with `*`) can be used to desensitize some sensitive data (such as phone numbers).

Additionally, configuring blacklist rules can also prevent some sensitive data from being uploaded.

### Sensitive Data Scanning

The feature of sensitive data scanning can be used to identify, label, and edit data containing personal privacy and other risky data. As a line of defense, it effectively prevents sensitive data from leaking out.

> For more details, refer to [Sensitive Data Scanning](../management/data-scanner.md).

### Logs

During the use of <<< custom_key.brand_name >>> product services, numerous log records are generated. Due to the strong relevance of log data itself, specific rules must be applied during the collection-analysis process to filter massive amounts of log data.

By configuring sensitive fields for log data, members with corresponding permissions will only see desensitized log data.

Data access permission control is another key method to reduce the security risks of log data. By configuring the query scope of log data access for different roles, data can be isolated, achieving comprehensive management and filtering of sensitive data.

> For more details, refer to [Multi-role Data Access Permission Control](../management/logdata-access.md).

### Snapshots

As an instant data copy, <<< custom_key.brand_name >>>'s snapshot service contains abnormal data filtering conditions and data records. When facing the need to share observable data, setting data desensitization rules or deciding the sharing method when sharing snapshots can generate access links with specified viewing permissions, automatically forming a data protection shield.

> For more details, refer to [Snapshots](../getting-started/function-details/snapshot.md).

### RUM

When collecting data related to user visits, the RUM (Real User Monitor) SDK will customize modifications and intercept data to prevent the flow of sensitive data.

> For more details, refer to [SDK Data Interception and Data Modification](./before-send.md).

#### Session Replay Privacy Settings {#session-replay}

Session Replay provides privacy controls to ensure no company exposes sensitive data or personal data. Moreover, the data is stored encrypted.
The default privacy options of Session Replay aim to protect end-user privacy and prevent sensitive organizational information from being collected.

##### Global Configuration

By enabling Session Replay, sensitive elements can be automatically masked, preventing them from being recorded by the RUM SDK.

To enable your privacy settings, set the `defaultPrivacyLevel` to `mask-user-input`, `mask`, or `allow` in your SDK configuration.

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

1. Mask user input mode: Masks most form fields such as inputs, text areas, and checkbox values, while recording all other texts as-is. Inputs are replaced with three asterisks (\*\*\*), and text areas are obfuscated with x characters retaining spaces.

**Note**: By default, `mask-user-input` is the privacy setting enabled when session replay is activated.

2. Mask mode: Masks all HTML texts, user inputs, images, and links. Texts on the application are replaced with X, presenting the page as a wireframe.

3. Allow mode: Records all data.

Some restrictions:

For data security considerations, regardless of what `defaultPrivacyLevel` you configure, the following elements will always be masked:

- Input elements of password, email, and tel types;
- Elements with the `autocomplete` attribute, such as credit card numbers, expiration dates, and security codes.

##### Custom Configuration

Session Replay supports the masking of sensitive elements, allowing you to flexibly set the content to be masked according to business needs, such as mobile phone numbers and other sensitive information. Below are specific operation methods:

###### Masking via Element Attributes

You can add the `data-gc-privacy` attribute to elements that need to be masked, supporting the following four attribute values:

• allow: Allows data collection without masking.
• mask: Masks content, displaying it in a masked format.
• mask-user-input: Masks user input, preventing the recording of sensitive input data.
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

###### Masking via Element Class Names

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

###### Using `shouldMaskNode` to Implement Custom Node Masking Policies

In certain special scenarios, customized masking processing may be required for specific DOM nodes. For example, in applications with higher security levels, it may be desirable to uniformly mask all text content on the page that contains numbers. This requirement can be achieved by configuring the `shouldMaskNode` callback function to implement more flexible privacy control policies.

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
  shouldMaskNode: (node, privacyLevel) => {
    if (node.nodeType === Node.TEXT_NODE) {
      // If it's a text node, check if the content contains digits
      const textContent = node.textContent || ''
      return /\d+/.test(textContent)
    }
    return false
  },
})

datafluxRum.startSessionReplayRecording()
```

In the above example, the `shouldMaskNode` function evaluates all text nodes. If the content includes digits (such as amounts or phone numbers), it automatically masks the content, thereby enhancing the privacy protection of user data.

Configuration Instructions and Recommendations

1. Priority Rules:

   • If both `data-gc-privacy` attributes and class names are set simultaneously, follow the project documentation to determine the priority.

2. Applicable Scenarios:

   • allow: Suitable for regular data that does not require masking.
   • mask: Suitable for sensitive data requiring masked display, such as phone numbers.
   • mask-user-input: Suitable for scenarios requiring protection of input content, such as password fields.
   • hidden: Suitable for content that should not be displayed or recorded.

3. Best Practices:

   • Prefer simple and clear methods (like class names or attributes) to ensure accurate configuration.
   • In high-sensitivity data scenarios, such as user privacy forms, recommend using `mask-user-input` or `hidden`.

Through the above methods, you can flexibly configure masking rules for sensitive elements, enhancing data security and meeting business compliance requirements.