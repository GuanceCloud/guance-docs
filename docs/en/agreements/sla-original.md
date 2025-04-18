# <<< custom_key.brand_name >>> SaaS Service Level Agreement
---

This Service Level Agreement (Service Level Agreement, hereinafter referred to as "SLA") stipulates the service availability level indicators and compensation plan for the <<< custom_key.brand_name >>> SaaS services provided by <<< custom_key.brand_name >>> to users.

1. Definitions

1.1 Service Period: A service period is one calendar month. If a user uses <<< custom_key.brand_name >>> SaaS services for less than one month, the cumulative usage time of <<< custom_key.brand_name >>> SaaS services in that month will be considered as one service period.

1.2 Total Minutes in a Service Period: The total number of days in the service period × 24 (hours) × 60 (minutes).

1.3 Service Instance: A workspace created by the user on the <<< custom_key.brand_name >>> SaaS site.

1.4 Unavailable Minutes: When all attempts by a user to establish a connection with a specified <<< custom_key.brand_name >>> SaaS service instance fail continuously for five minutes or longer, it is considered that the <<< custom_key.brand_name >>> SaaS service instance was unavailable during this time. The sum of unavailable minutes for a single <<< custom_key.brand_name >>> SaaS service instance within a service period is the total unavailable minutes.

1.5 Monthly Service Fee: The cash payment portion of the billing fees generated by a single <<< custom_key.brand_name >>> SaaS service instance in a calendar month (excluding gifted vouchers, discount coupons, etc.).

2. Service Availability

2.1 Service Availability Calculation Formula

Service availability is calculated on a per-service-instance basis using the following formula:

Service Availability = (Total minutes in a service period - Unavailable minutes) / Total minutes in a service period × 100%

2.2 Service Availability Commitment

The service availability of <<< custom_key.brand_name >>> SaaS services is no less than 99.90%, meaning the monthly unavailable duration ≤ 43.2 minutes. If the <<< custom_key.brand_name >>> SaaS service instance does not meet this availability commitment, users can receive compensation according to Article 4 of this agreement.

3. Service Unavailability

3.1 Scenarios Considered as Service Unavailability

(1) Inability to log in to <<< custom_key.brand_name >>> (SaaS site) or display pages for more than five consecutive minutes due to reasons other than the user's own network or equipment issues;

(2) Data query failures (API returns 5xx error codes) for various data explorers, views, monitors, etc., lasting more than five consecutive minutes due to reasons other than the user's own network or equipment issues;

(3) Monitors failing to operate normally according to configured rules for more than 15 minutes;

(4) Data write failure rates exceeding 15% for over 10 minutes due to faults in <<< custom_key.brand_name >>> causing data write failures (excluding DataKit configuration issues such as inconsistent field slicing before and after Pipeline leading to type conflicts preventing central writes);

(5) Interfaces receiving 5xx error responses from the official <<< custom_key.brand_name >>>-compiled DataKit data collector reporting data for more than 10 consecutive minutes due to reasons other than user network or equipment issues.

3.2 Exclusions

Unavailability caused by the following reasons is not counted towards unavailability time:

(1) Scheduled system maintenance performed by <<< custom_key.brand_name >>> during working hours after notifying users at least 12 hours in advance, including but not limited to maintenance, optimization, and planned availability fluctuations of devices, systems, software services, cutover, maintenance, simulation exercises, etc.;

(2) Failures or configuration adjustments outside the network and equipment necessary for the normal operation of <<< custom_key.brand_name >>> services;

(3) Incidents caused by confirmed hacker attacks on the user’s application after mutual agreement;

(4) Incidents caused by improper maintenance or confidentiality leading to the loss or leakage of data, passwords, etc.;

(5) Incidents caused by negligence or authorized operations by the user;

(6) Incidents caused by the user not following <<< custom_key.brand_name >>> product documentation or usage recommendations;

(7) Incidents caused by sudden large-scale data traffic growth (exceeding 100% growth compared to the same hour of the previous workday, with a minimum increase of 50 million documents, including logs, traces, RUM PV, events, synthetic tests, infrastructure, etc.) without prior written notice to <<< custom_key.brand_name >>> resulting in reduced availability;

(8) Incidents caused by other force majeure (users are also not responsible for service fees incurred due to these incidents).

4. Compensation Plan

4.1 Compensation Criteria

For each <<< custom_key.brand_name >>> SaaS service instance, compensation service vouchers are calculated based on the monthly service availability of a single instance as shown in Table 5, with the voucher amount not exceeding 100% of the monthly service fee paid by the user for the month in which the availability commitment was not met.

4.2 Compensation Application Deadline

Users can apply for compensation for instances that did not meet the service availability commitment in the previous month starting from the fifth (5th) business day of each calendar month. Compensation applications should not be later than two (2) months after the end of the relevant month when the <<< custom_key.brand_name >>> SaaS service did not meet the service availability commitment, via ticket or email.

5. Other

Service availability compensation standards

| Availability Range | Compensation Standard |
| ------------------ | ---------------------- |
| 99.00% ≤ Service Availability < 99.90% | 15% of Monthly Service Fee |
| 95.00% ≤ Service Availability < 99.00% | 30% of Monthly Service Fee |
| Service Availability < 95.00% | 100% of Monthly Service Fee |

<<< custom_key.brand_name >>> reserves the right to modify this SLA. Any modifications to this SLA will be notified to you three (3) days in advance via website announcements or emails.

---

Based on the trusted cloud data storage durability formula P = 1-u*{[1-(1-u’)<sup>w</sup>]}<sup>n-1</sup>

<<< custom_key.brand_name >>> data storage durability P = 1-0.3%*{[1-(1-0.0125%)<sup>1</sup>]}<sup>(3-1)</sup> ≈ 99.999999995%

Formula Explanation:

- n: n=3, each piece of data has 3 replicas
- u: u=2/12/50*100%=0.3%, monthly disk failure rate is 0.3%
- u': u'=2/12/24/50*100%=0.0125%, hourly disk failure rate is 0.0125%
- w: Data recovery time w hours, w = detection time + recovery time = 15 minutes + 45 minutes = 1 hour