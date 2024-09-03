# Annual Package
---

Guance provides a variety of packages to help enterprises comprehensively observe IT infrastructure, application systems and other enterprise assets at a lower price. According to different development stages of enterprises, it is divided into three packages: start-up acceleration package, start-up development package and enterprise standard package. In addition, Guance also provides traffic packages for enterprises to use according to their own needs and packages.

In the Guance Billing Center, an account can be bound to multiple workspaces at the same time for annual package fee statistics, and the excess package is counted according to [pay-as-you-go](../../../../billing/billing-method/index.md), and only one settlement method of [Guance Billing Center account settlement](../../../../billing/billing-account/enterprise-account.md) is supported.

## Package Price

### Start-up Acceleration Package

| **Billing Item** | **Capacity** | **Pay-as-you-go price (372 days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 20 sets | **￥ 72,168** | **￥ 42,000** |
| Log data | 40 million |  |  |
| AP Trace | 5 million |  |  |
| User access PV | 400,000 |  |  |
| Task call | 190,000 |  |  |


### Entrepreneurship Development Package

| **Billing Item** | **Capacity** | **Pay-as-you-go price (372 days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 100 sets | **￥ 517,080** | **￥ 280,000** |
| Log data | 0.4 billion |  |  |
| AP Trace | 50 million |  |  |
| User access PV | 2 million |  |  |
| Task call | 1.40 million |  |  |


### Enterprise Standard Package

| **Billing Item** | **Capacity** | **Pay-as-you-go price (372 days)** | **Package Price** |
| --- | --- | --- | --- |
| DataKit | 200 sets | **￥ 1019,280** | **￥ 510,000** |
| Log data | 0.8 billion |  |  |
| AP Trace | 0.1 billion |  |  |
| User access PV | 4 million |  |  |
| Task call | 2.4 million |  |  |


### Traffic Package

Traffic package will be given different discounts according to the size of the purchased Capacity. For details, please contact the account manager.

| **Traffic Package** | **Basic Unit** | **Buy Basic Capacity** | **Default Data Storage Strategy** | **Unit Price** | **Price(per day)** |
| --- | --- | --- | --- | --- | --- |
| DataKit | 1 | 20 | / | 3 | 60 |
| Log data (10,000 pieces) | 1 million | 1 million times | 14 days | 1.5 | 1.5 |
| Backup logs (10,000) | 10 million | 10 million times | / | 2 | 2 |
| Apply Trace (10,000) | 1 million | 1 million times | 7 days | 3 | 3 |
| User PV (10,000) | 10,000 | 100,000 | 7 days | 1 | 10 |
| API calls (10,000 times) | 10,000 | 100,000 times | / | 1 | 10 |
| Task calls (10,000 times) | 10,000 | 300,000 times | / | 1 | 30 |
| SMS | 1 | 100 | / | 0.1 | 10 |


### Notes

- Once the limited Capacity of the package package is exceeded, the excess part can be purchased as a traffic package or settled according to the "pay-as-you-go" method based on the **unit price of the default data storage strategy**.
- According to the default policy, the Data Storage Strategy related to gradient Billing Item in the package is log data (14 days), application Trace (7 days) and user access PV (7 days).
- If the data storage strategy of gradient Billing Item involved in the package is not in accordance with the default strategy, such as log data (30 days or 60 days), application of Trace (14 days) and user access to PV (14 days), then when observing the bill issued by the cloud billing platform, it is necessary to make corresponding conplan according to the usage reported by the workspace and the data storage strategy. The conplan strategy is as follows:
   - Log data conplan factor: default 14-day, 30-day usage * 2, 60-day usage * 3
   - Application Performance Trace Conplan Factor: Default 7 Days, 14 Days Usage * 2
   - User access PV conplan factor: default 7 days, 14 days usage * 2


#### Conplan Instructions

Assume that log data, application performance Trace, and user access PV increase by 1 million per day.

1.Log data

| Data Storage Strategy | 14 days(by default) | 30 days | 60 days |
| --- | --- | --- | --- |
| Usage | 1 million | 1 million | 1 million |
| Actual statistical usage after conplan | 1 million | 1 million*2=2 million | 1 million*3=3 million |


2.AP Trace

| Data Storage Strategy | 7 days(by default) | 14 days |
| --- | --- | --- |
| Usage | 1 million | 1 million |
| Actual statistical usage after conplan | 1 million | 1 million*2=2 million |


3.User access PV

| Data Storage Strategy | 7 days(by default) | 14 days |
| --- | --- | --- |
| Usage | 1 million | 1 million |
| Actual statistical usage after conplan | 1 million | 100万*2=200万 |


### Package Example

#### Package + Pay-as-you-go

Assuming that the startup acceleration package has been purchased, the log data selection in the Data Storage Strategy is 30 days, and the application performance Trace and user access PV selection are 14 days.

According to the description of precautions, if the log data in the Data Storage Strategy is selected for 30 days, and the application performance Trace and user access PV are selected for 14 days, the conplan factor is 2 (that is, the conplan policy "usage*2"), and the cost statistics for 1 day are as follows:

| Billing Item | Package Usage | Day1 |  |  |  |
| --- | --- | --- | --- | --- | --- |
|  |  | Usage | After conplan | Excess quantity | Excess statistics by quantity |
| DataKit | 20 | 25 | 25 | 5 | 5*3=15 |
| Log data | 40 million | 40 million | 80 million | 40 million | 40 million/1 million*1.5=60 |
| AP Trace | 5 million | 5 million | 10 million | 5 million | 5 million/100 million*3=15 |
| User access PV | 400,000 | 400,000 | 800,000 | 400,000 | 400,000/100,000*1=40 |
| Task call | 190,000 | 210,000 | 210,000 | 20,000 | 20,000/10,000*1=2 |
| Excess cost by volume statistics | / | 132 yuan |  |  |  |

According to the usage and data storage strategy of the above example, the excess cost for one day is 15+60+15+40+2=132 yuan.<br />Note: For the part exceeding the package, the "pay-as-you-go" method is based on the unit price of the default data saving strategy.


#### Package + Traffic Package + Pay-as-you-go

Assuming that the start-up acceleration package has been purchased, and the log data traffic package is 20 million yuan, the price discount of the traffic package is calculated at 80%, the log data in the Data Storage Strategy is selected for 30 days, and the application performance Trace and user access PV are selected for 14 days.

According to the description of precautions, if the log data in the Data Storage Strategy is selected for 30 days, and the application performance Trace and user access PV are selected for 14 days, the conplan factor is 2 (that is, the conplan policy "usage*2"), and the cost statistics for 1 day are as follows:

| Billing Item | Package usage | Log class data traffic packet | Day1 |  |  |  |
| --- | --- | --- | --- | --- | --- | --- |
|  |  |  | Usage | After conplan | Excess quantity | Excess statistics by quantity |
| DataKit | 20 |  | 25 | 25 | 5| 5*3=15 |
| Log data | 400,000 | 300,000 | 400,000 | 800,000 | 100,000 | 100,000/1 million*1.5=15 |
| AP Trace | 5million |  | 5 million | 100,000 | 5 million | 5 million/1 million*3=15 |
| User access PV | 400,000 |  | 400,000 | 800,000 | 400,000 | 400,000/10,000*1=40 |
| Task call | 190,000 |  | 210,000 | 210,000 | 20,000 | 20,000/10,000*1=2 |
| Excess cost by volume statistics | / | （30 million/1 million*1.5）*80%=36yuan | 87 yuan |  |  |  |

According to the usage and data storage strategy of the above example, the excess cost for one day is 36+15+15+15+40+2=123 yuan.

As can be seen from the above example, after using the traffic package discount, the excess statistical cost by volume saves 9 yuan.


---


