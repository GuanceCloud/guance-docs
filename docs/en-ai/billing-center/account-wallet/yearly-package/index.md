# Annual Package
---

Guance provides multiple packages to help enterprises comprehensively observe IT infrastructure, application systems, and other enterprise assets at lower prices. According to different stages of enterprise development, there are three types of package bundles: Startup Acceleration Bundle, Entrepreneurship Development Bundle, and Enterprise Standard Bundle. Additionally, Guance offers traffic packages for enterprises to use in combination with their own needs and selected bundles.

In the Guance Billing Center, a single account can bind multiple workspaces simultaneously for annual package fee statistics. Any usage exceeding the package is billed according to [Pay-as-you-go](../../../../billing-method/index.md), and only supports one settlement method: [Guance Billing Center Account Settlement](../../../../billing/billing-account/enterprise-account.md).

## Package Pricing

### Startup Acceleration Bundle

| **Billing Item** | **Capacity** | **Pay-as-you-go Price (372 days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 20 units | **￥ 72,168** | **￥ 42,000** |
| Log Data | 40 million |  |  |
| APM Trace | 5 million |  |  |
| RUM PV | 400,000 |  |  |
| Triggers | 190,000 |  |  |

### Entrepreneurship Development Bundle

| **Billing Item** | **Capacity** | **Pay-as-you-go Price (372 days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 100 units | **￥ 517,080** | **￥ 280,000** |
| Log Data | 400 million |  |  |
| APM Trace | 50 million |  |  |
| RUM PV | 2 million |  |  |
| Triggers | 1.4 million |  |  |

### Enterprise Standard Bundle

| **Billing Item** | **Capacity** | **Pay-as-you-go Price (372 days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 200 units | **￥ 1,019,280** | **￥ 510,000** |
| Log Data | 800 million |  |  |
| APM Trace | 100 million |  |  |
| RUM PV | 4 million |  |  |
| Triggers | 2.4 million |  |  |

### Traffic Packages

Traffic packages offer different discounts based on the purchased capacity size; please contact your client manager for details.

| **Traffic Package** | **Base Unit** | **Purchased Base Capacity** | **Default Data Retention Policy** | **Unit Price** | **Price per Day** |
| --- | --- | --- | --- | --- | --- |
| DataKit | 1 | 20 units | / | 3 | 60 |
| Log Data (million entries) | 1 million | 1 million entries | 14 days | 1.5 | 1.5 |
| Backup Logs (million entries) | 10 million | 10 million entries | / | 2 | 2 |
| APM Trace (ten thousand entries) | 1 million | 1 million entries | 7 days | 3 | 3 |
| User PV (ten thousand entries) | 100 thousand | 100 thousand entries | 7 days | 1 | 10 |
| API Calls (ten thousand times) | 10 thousand | 100 thousand times | / | 1 | 10 |
| Triggers (ten thousand times) | 10 thousand | 300 thousand times | / | 1 | 30 |
| SMS | 1 | 100 messages | / | 0.1 | 10 |

### Notes

- Once the package's capacity limit is exceeded, additional usage can be purchased through traffic packages or charged according to the "pay-as-you-go" method based on the **default data retention policy unit price**.
- For items involving tiered billing, the default data retention policies are as follows: log data (14 days), APM Trace (7 days), user access PV (7 days).
- If the data retention policy for tiered billing items is not the default, such as log data (30 days or 60 days), APM Trace (14 days), user access PV (14 days), then when the Guance billing platform issues invoices, it will need to adjust the reported usage and data retention policy accordingly. The adjustment factors are as follows:
   - Log data conversion factor: default 14 days, 30 days usage * 2, 60 days usage * 3
   - APM Trace conversion factor: default 7 days, 14 days usage * 2
   - User access PV conversion factor: default 7 days, 14 days usage * 2

#### Conversion Explanation

Assuming daily increments of 1 million for log data, APM Trace, and user access PV:

1. Log Data

| Data Retention Policy | 14 days (default) | 30 days | 60 days |
| --- | --- | --- | --- |
| Usage | 1 million | 1 million | 1 million |
| Converted Actual Usage | 1 million | 1 million * 2 = 2 million | 1 million * 3 = 3 million |

2. APM Trace

| Data Retention Policy | 7 days (default) | 14 days |
| --- | --- | --- |
| Usage | 1 million | 1 million |
| Converted Actual Usage | 1 million | 1 million * 2 = 2 million |

3. User Access PV

| Data Retention Policy | 7 days (default) | 14 days |
| --- | --- | --- |
| Usage | 1 million | 1 million |
| Converted Actual Usage | 1 million | 1 million * 2 = 2 million |

### Package Examples

#### Package + Pay-as-you-go

Assume the Startup Acceleration Bundle has been purchased, with log data retention set to 30 days and APM Trace and user access PV retention set to 14 days.

According to the notes, log data retention is 30 days, APM Trace and user access PV retention are 14 days, so the conversion factor is 2 (i.e., "usage * 2"). The cost calculation for one day is as follows:

| Billing Item | Package Usage | Day1 |  |  |  |
| --- | --- | --- | --- | --- | --- |
|  |  | Usage | Converted | Excess | Excess Pay-as-you-go |
| DataKit | 20 units | 25 units | 25 units | 5 units | 5 * 3 = 15 |
| Log Data | 40 million | 40 million | 80 million | 40 million | 40 million / 1 million * 1.5 = 60 |
| APM Trace | 5 million | 5 million | 10 million | 5 million | 5 million / 1 million * 3 = 15 |
| User Access PV | 400,000 | 400,000 | 800,000 | 400,000 | 400,000 / 10,000 * 1 = 40 |
| Triggers | 190,000 | 210,000 | 210,000 | 20,000 | 20,000 / 10,000 * 1 = 2 |
| Excess Pay-as-you-go Cost | / | 132 CNY |  |  |  |

Based on the above example's usage and data retention policy, the excess cost for one day = 15 + 60 + 15 + 40 + 2 = 132 CNY.

**Note**: Excess usage is charged based on the default data retention policy unit price.

#### Package + Traffic Package + Pay-as-you-go

Assume the Startup Acceleration Bundle has been purchased, and an additional log data traffic package of 20 million entries is purchased with an 80% discount applied. The log data retention is set to 30 days, and APM Trace and user access PV retention are set to 14 days.

According to the notes, log data retention is 30 days, APM Trace and user access PV retention are 14 days, so the conversion factor is 2 (i.e., "usage * 2"). The cost calculation for one day is as follows:

| Billing Item | Package Usage | Log Data Traffic Package | Day1 |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
|  |  |  | Usage | Converted | Excess | Excess Pay-as-you-go |
| DataKit | 20 units |  | 25 units | 25 units | 5 units | 5 * 3 = 15 |
| Log Data | 40 million | 30 million | 40 million | 80 million | 10 million | 10 million / 1 million * 1.5 = 15 |
| APM Trace | 5 million |  | 5 million | 10 million | 5 million | 5 million / 1 million * 3 = 15 |
| User Access PV | 400,000 |  | 400,000 | 800,000 | 400,000 | 400,000 / 10,000 * 1 = 40 |
| Triggers | 190,000 |  | 210,000 | 210,000 | 20,000 | 20,000 / 10,000 * 1 = 2 |
| Excess Pay-as-you-go Cost | / | (30 million / 1 million * 1.5) * 80% = 36 CNY | 87 CNY |  |  |  |

Based on the above example's usage and data retention policy, the excess cost for one day = 36 + 15 + 15 + 15 + 40 + 2 = 123 CNY.

From the above examples, using the traffic package discount saves 9 CNY in excess pay-as-you-go costs.

---