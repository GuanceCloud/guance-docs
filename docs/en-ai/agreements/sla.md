# <<< custom_key.brand_name >>> SaaS Service Level Agreement
---

Effective Date: August 20, 2024

This Service Level Agreement (SLA) specifies the service availability level and compensation plan for the <<< custom_key.brand_name >>> SaaS service provided by <<< custom_key.brand_name >>> to users.

1. Definitions

1.1 Service Period: A service period is one calendar month. If a user uses the <<< custom_key.brand_name >>> SaaS service for less than one month, the cumulative usage time of the <<< custom_key.brand_name >>> SaaS service in that month will be considered as one service period.

1.2 Total Minutes in a Service Period: The total number of days in the service period × 24 (hours) × 60 (minutes).

1.3 Service Instance: A "workspace" created by the user on the <<< custom_key.brand_name >>> SaaS site.

1.4 Unavailable Minutes: If all attempts to establish a connection with a specified <<< custom_key.brand_name >>> SaaS service instance fail continuously for 5 minutes or longer, or if multiple services fail simultaneously for more than 15 minutes, this period is considered unavailable. The sum of unavailable minutes for a single <<< custom_key.brand_name >>> SaaS service instance within a service period is the total unavailable minutes.

1.5 Monthly Service Fee: The cash payment portion of the bill for a single <<< custom_key.brand_name >>> SaaS service instance used by the user in one calendar month (excluding gifted vouchers, discount coupons, etc.).

2. Service Availability

2.1 Calculation Formula for Service Availability

Service availability is calculated on a per-service-instance basis as follows:

Service Availability = (Total Minutes in Service Period - Unavailable Minutes) / Total Minutes in Service Period × 100%

2.2 Service Availability Commitment

The <<< custom_key.brand_name >>> SaaS service availability is guaranteed to be no less than 99.90%, meaning the monthly downtime should not exceed 43.2 minutes. If the <<< custom_key.brand_name >>> SaaS service instance does not meet this availability commitment, users can receive compensation according to Article 4 of this agreement.

3. Service Unavailability

3.1 Scenarios of Service Unavailability

(1) Inability to log in to <<< custom_key.brand_name >>> (SaaS site) or display pages for more than 5 consecutive minutes due to reasons other than the user's own network or device issues;

(2) Data query failures (API returns 5xx error codes) for various data explorers, views, monitors, etc., for more than 5 consecutive minutes due to reasons other than the user's own network or device issues;

(3) Monitors do not operate normally according to configured rules for more than 15 minutes;

(4) Data write failure rate exceeds 15% for more than 10 consecutive minutes due to faults in <<< custom_key.brand_name >>> causing conflicts from inconsistent field slicing before and after Pipeline configuration;

(5) DataKit data collector interfaces receive 5xx errors for more than 10 consecutive minutes due to reasons other than user's own network or device issues, using the official <<< custom_key.brand_name >>> compiled DataKit;

(6) After logging into <<< custom_key.brand_name >>> normally, performing standard queries on saved content fails to return results within 5 minutes, including but not limited to incomplete, irregular displays, timeouts, or other error messages;

3.2 Exclusions

Downtime caused by the following reasons is not counted towards service unavailability time:

(1) System maintenance notified by <<< custom_key.brand_name >>> at least 12 hours in advance during working hours, including but not limited to equipment, system, software service inspections, maintenance, optimization, cutover, drills, and planned availability fluctuations (within 120 minutes during workdays and 240 minutes outside workdays; any additional time requires separate notice and user confirmation);

(2) Failures or configuration adjustments outside <<< custom_key.brand_name >>>'s network or equipment that support normal service operation;

(3) Issues caused by confirmed hacker attacks on the user’s application;

(4) Issues caused by improper maintenance or confidentiality breaches leading to loss or leakage of data, passwords, etc.;

(5) Issues caused by user negligence or authorized operations;

(6) Issues caused by the user not following <<< custom_key.brand_name >>> product documentation or usage recommendations;

(7) Large-scale data traffic surges (exceeding 100% growth over the same hour of the previous workday, with a minimum increase of 50 million documents, including logs, traces, RUM PV, events, tests, infrastructure, etc.) without prior written notification to <<< custom_key.brand_name >>>;

(8) Other force majeure events (users are also not liable for service fees arising from these events).

4. Compensation Plan

4.1 Compensation Standards

For each <<< custom_key.brand_name >>> SaaS service instance, compensation service vouchers are calculated based on the monthly service availability of a single instance according to the table below (Table 5), with the compensation voucher amount not exceeding 100% of the monthly service fee paid by the user in the month when the availability commitment was not met.

4.2 Compensation Application Deadline

Users can submit compensation applications for instances that did not meet the service availability commitment in the previous month starting from the fifth (5th) business day of each calendar month. Applications must be submitted via ticket or email no later than two (2) months after the end of the relevant month when the <<< custom_key.brand_name >>> SaaS service did not meet the availability commitment.

5. Other

Service Availability Compensation Standards

| Availability Range | Compensation Standard |
| ------------------ | ---------------------- |
| 99.00% ≤ Service Availability < 99.90% | 15% of Monthly Service Fee |
| 95.00% ≤ Service Availability < 99.00% | 30% of Monthly Service Fee |
| Service Availability < 95.00% | 100% of Monthly Service Fee |

<<< custom_key.brand_name >>> reserves the right to modify this SLA. Any modifications to this SLA will be notified to you 3 days in advance via website announcement or email.