# Annual Subscription Packages
---

<<< custom_key.brand_name >>> offers various packages to help enterprises comprehensively monitor IT infrastructure, application systems, and other corporate assets at lower prices. Depending on the different stages of enterprise development, there are three package options: Startup Acceleration Package, Growth Development Package, and Enterprise Standard Package. Additionally, <<< custom_key.brand_name >>> provides traffic packages for enterprises to use according to their needs and in conjunction with the selected packages.

In the <<< custom_key.brand_name >>> Billing Center, a single account can bind multiple workspaces to calculate annual subscription package fees. Any usage exceeding the package limits is billed based on [pay-as-you-go](../../../../billing-method/index.md) pricing, and only supports settlement via a [<<< custom_key.brand_name >>> Billing Center account](../../../../billing/billing-account/enterprise-account.md).

## Package Pricing

### Startup Acceleration Package

| **Billing Item** | **Capacity** | **Pay-As-You-Go Price (372 days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 20 units | **￥72,168** | **￥42,000** |
| Log Data | 40 million |  |  |
| APM Trace | 5 million |  |  |
| RUM PV | 400 thousand |  |  |
| Task Triggers | 190 thousand |  |  |

### Growth Development Package

| **Billing Item** | **Capacity** | **Pay-As-You-Go Price (372 days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 100 units | **￥517,080** | **￥280,000** |
| Log Data | 400 million |  |  |
| APM Trace | 50 million |  |  |
| RUM PV | 2 million |  |  |
| Task Triggers | 1.4 million |  |  |

### Enterprise Standard Package

| **Billing Item** | **Capacity** | **Pay-As-You-Go Price (372 days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 200 units | **￥1,019,280** | **￥510,000** |
| Log Data | 800 million |  |  |
| APM Trace | 100 million |  |  |
| RUM PV | 4 million |  |  |
| Task Triggers | 2.4 million |  |  |

### Traffic Packages

Traffic packages offer different discounts based on the purchased capacity size; please contact your customer manager for details.

| **Traffic Package** | **Base Unit** | **Purchased Base Capacity** | **Default Data Retention Policy** | **Unit Price** | **Price (per day)** |
| --- | --- | --- | --- | --- | --- |
| DataKit | 1 | 20 units | / | 3 | 60 |
| Log Data (in million entries) | 1 million | 1 million entries | 14 days | 1.5 | 1.5 |
| Backup Logs (in million entries) | 10 million | 10 million entries | / | 2 | 2 |
| APM Trace (in million entries) | 1 million | 1 million entries | 7 days | 3 | 3 |
| User PV (in ten thousand entries) | 100 thousand | 100 thousand entries | 7 days | 1 | 10 |
| API Calls (in ten thousand calls) | 10 thousand | 100 thousand calls | / | 1 | 10 |
| Task Triggers (in ten thousand calls) | 10 thousand | 300 thousand calls | / | 1 | 30 |
| SMS | 1 | 100 messages | / | 0.1 | 10 |

### Notes

- Once the package capacity limit is exceeded, additional usage can be covered by purchasing traffic packages or billed according to the "pay-as-you-go" method based on the **default data retention policy unit price**.
- The data retention policies for tiered billing items follow the default strategy: log data (14 days), APM Trace (7 days), and user PV (7 days).
- If the data retention policy for tiered billing items does not follow the default strategy (e.g., log data (30 days or 60 days), APM Trace (14 days), user PV (14 days)), then when the <<< custom_key.brand_name >>> billing platform generates invoices, it will adjust the usage based on the workspace-reported usage and data retention policy. The conversion factors are as follows:
   - Log data conversion factor: Default 14 days, 30 days usage * 2, 60 days usage * 3
   - APM Trace conversion factor: Default 7 days, 14 days usage * 2
   - User PV conversion factor: Default 7 days, 14 days usage * 2

#### Conversion Explanation

Assuming daily increments of 1 million for log data, APM Trace, and user PV:

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

3. User PV

| Data Retention Policy | 7 days (default) | 14 days |
| --- | --- | --- |
| Usage | 1 million | 1 million |
| Converted Actual Usage | 1 million | 1 million * 2 = 2 million |

### Package Examples

#### Package + Pay-As-You-Go

Assume the Startup Acceleration Package has been purchased, with a log data retention policy of 30 days and an APM Trace and user PV retention policy of 14 days.

According to the notes, the data retention policy for log data is 30 days, and for APM Trace and user PV is 14 days, so the conversion factor is 2 (i.e., "usage * 2"). The cost calculation for one day would be as follows:

| Billing Item | Package Usage | Day 1 |  |  |  |
| --- | --- | --- | --- | --- | --- |
|  |  | Usage | Converted | Excess | Excess Pay-As-You-Go Calculation |
| DataKit | 20 units | 25 units | 25 units | 5 units | 5 * 3 = 15 |
| Log Data | 40 million | 40 million | 80 million | 40 million | 40 million / 1 million * 1.5 = 60 |
| APM Trace | 5 million | 5 million | 10 million | 5 million | 5 million / 1 million * 3 = 15 |
| User PV | 400 thousand | 400 thousand | 800 thousand | 400 thousand | 400 thousand / 10 thousand * 1 = 40 |
| Task Triggers | 190 thousand | 210 thousand | 210 thousand | 20 thousand | 20 thousand / 10 thousand * 1 = 2 |
| Excess Pay-As-You-Go Cost | / | 132 CNY |  |  |  |

Based on the above example usage and data retention policies, the excess cost for one day = 15 + 60 + 15 + 40 + 2 = 132 CNY.

**Note**: Excess usage beyond the package is billed based on the default data retention policy unit price.

#### Package + Traffic Package + Pay-As-You-Go

Assume the Startup Acceleration Package has been purchased, along with a log data traffic package of 20 million entries at an 80% discount rate, with a log data retention policy of 30 days and an APM Trace and user PV retention policy of 14 days.

According to the notes, the data retention policy for log data is 30 days, and for APM Trace and user PV is 14 days, so the conversion factor is 2 (i.e., "usage * 2"). The cost calculation for one day would be as follows:

| Billing Item | Package Usage | Log Data Traffic Package | Day 1 |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
|  |  |  | Usage | Converted | Excess | Excess Pay-As-You-Go Calculation |
| DataKit | 20 units |  | 25 units | 25 units | 5 units | 5 * 3 = 15 |
| Log Data | 40 million | 30 million | 40 million | 80 million | 10 million | 10 million / 1 million * 1.5 = 15 |
| APM Trace | 5 million |  | 5 million | 10 million | 5 million | 5 million / 1 million * 3 = 15 |
| User PV | 400 thousand |  | 400 thousand | 800 thousand | 400 thousand | 400 thousand / 10 thousand * 1 = 40 |
| Task Triggers | 190 thousand |  | 210 thousand | 210 thousand | 20 thousand | 20 thousand / 10 thousand * 1 = 2 |
| Excess Pay-As-You-Go Cost | / | (30 million / 1 million * 1.5) * 80% = 36 CNY | 87 CNY |  |  |

Based on the above example usage and data retention policies, the excess cost for one day = 36 + 15 + 15 + 15 + 40 + 2 = 123 CNY.

From the above examples, using the traffic package discount saves 9 CNY in excess pay-as-you-go costs.

---