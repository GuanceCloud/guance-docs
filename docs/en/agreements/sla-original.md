
# Guance SaaS Service Level Agreement
---


This Service Level Agreement (hereinafter referred to as "SLA") stipulates the service availability level indicators and compensation scheme of the Guance SaaS Service (referred to as "Guance SaaS Service") provided by Guance to users.

**1. Definition**

1.1 Service cycle: A service cycle is a natural month. If the user uses the Guance SaaS Service for less than one month, the accumulated usage time of the Guance SaaS Service in the current month will be taken as a service cycle.

1.2 Total minutes of service cycle: The total number of days in the service cycle → 24 (hours) → 60 (minutes) is calculated.

1.3 Service instance: The "workspace" created by the user in the Guance SaaS site.

1.4 Minutes of service unavailability: If all attempts by a user to establish a connection with a specified Guance SaaS Service instance fail for 5 consecutive minutes (or more), the Guance SaaS Service instance will be deemed unavailable during this period of time. The sum of the unavailable minutes of a single Guance SaaS Service instance in a service cycle is the service unavailable minutes.

1.5 Monthly service fee: The cash payment part of the billing fee incurred by users for a single Guance SaaS Service instance in a natural month (excluding gift vouchers, discount vouchers, etc.).

**2. Service Availability**

2.1 Service Availability Calculation Formula

Service availability is calculated as follows with a single service instance as the dimension:

Service Availability = (Total Service Cycle Minutes-Service Unavailable Minutes)/Total Service Cycle Minutes × 100%

2.2 Service Availability Commitment

The availability of Guance SaaS Service is not less than 99.90%, that is, the monthly unavailable time is ≤ 43.2 min. If the Guance SaaS Service instance fails to meet the aforesaid availability commitment, the user can be compensated according to Article 4 of this agreement.

**3. Service Unavailable**

3.1 The following are service unavailable scenarios

(1) Log in to Guance (SaaS site) or display page continuously for more than 5 minutes due to the user's network or equipment;

(2) The data query of various data viewers, views and monitors due to the user's network or equipment failed (the query returned 5xx error code) for more than 5 consecutive minutes;

(3) The monitor does not operate normally for more than 15 minutes according to the configured rules;

(4) The data writing failure rate caused by the failure of Guance reaches more than 15% for more than 10 consecutive minutes not due to the configuration of DataKit (for example, the failure rate of data writing caused by the failure of Guance is caused by the failure of Pipeline cutting fields before and after);

(5) The data reported by the DataKit data collector compiled and published by the Guance officer due to the user's network or equipment is received and returned with 5xx errors for more than 10 consecutive minutes;

3.2 Exceptions

The length of service unavailability due to the following reasons is not included in the service unavailability time:

(1) Guance notifies the user 12 hours in advance during the working hours, which is caused by the system maintenance, including but not limited to the overhaul, maintenance and optimization of equipment, systems and software services, as well as the planned applicability fluctuations such as cutover, maintenance and simulation exercises;

(2) Any failure or configuration adjustment other than the network or equipment on which the normal operation of the Guance service depends;

(3) The user's application program is caused by the attack behavior of the customer identified by both parties afterwards;

(4) The loss or leakage of data, orders and passwords caused by improper maintenance or confidentiality of users;

(5) Caused by the negligence of the user or the operation authorized by the user;

(6) Caused by the user's failure to follow the suggestions of Guance products;

(7) The sudden growth of user scale data traffic (exceeding 100% of the growth in the same hour of the previous working day, with the minimum growth exceeding 50 million documents, including logs, links, RUM, events, dial testing, infrastructure, etc.) does not inform Guance in advance of the usability reduction;

(8) Caused by other force majeure (the resulting service costs need not be borne by users).

**4. Compensation Programme**

4.1 Compensation Standard

For each the Guance SaaS Service instance, according to the monthly service availability of a single instance, the compensation service voucher is calculated according to the standard in the following table (Table 5), and the amount of the compensation voucher shall not exceed 100% of the monthly service fee paid by the user in the month when the service availability commitment is not met.

4.2 Time Limit for Compensation Application

Users can claim compensation after the fifth (5) working days of each natural month for instances where service availability commitments have not been met in the previous month. Claims for compensation shall be filed by ticket or email no later than two (2) months after the end of the relevant month in which the Guance SaaS Service fails to meet the service availability commitment.

**5. Others**

| Availability Interval                       | Compensation Standard                             |   
| ------------------------------ | ------------------------------------ |
| 99.00% ≤ Service Availability < 99.90%                       | Compensate 15% of Monthly Service Fee                             |
| 95.00% ≤ service Availability < 99.00%                       | Compensate 30% of Monthly Service Fee                             |
| Service Availability < 95.00%                       | Compensate 100% of Monthly Service Fee   

Guance reserves the right to make amendments to the terms of SLA. In case of any modification of this SLA clause, Guance will notify you by website publicity or email 3 days in advance.


