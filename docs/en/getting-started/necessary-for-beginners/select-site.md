# Choose a Registration Site
---

## Introduction

Guance provides multiple registration and login sites, and you can choose a suitable site to register and log in according to your actual situation. At present, Guance supports the following four sites.

> Note: The accounts and data of different sites are independent of each other, so it is impossible to share and migrate data with each other. Please choose carefully.

| Site | Login Address URL | Operator |
| --- | --- | --- |
| China 1 (Hangzhou) | [https://auth.guance.com/](https://auth.guance.com/login/pwd) | Alibaba Cloud (Hangzhou, China) |
| China 2 (Ningxia) | [https://aws-auth.guance.com/](https://aws-auth.guance.com/login/pwd) | AWS (Ningxia, China) |
| China 4 (Guangzhou) | [https://cn4-auth.guance.com/](https://cn4-auth.guance.com/login/pwd) | Huawei Cloud (Guangzhou, China) |
| Overseas Region 1 (Oregon)| [https://us1-auth.guance.com/](https://us1-auth.guance.com/) | AWS (Oregon, USA) |


## How to Choose a Site

Guance currently provides four sites: "China 1 (Hangzhou)", "China 2 (Ningxia)", "China 4 (Guangzhou)" and "Overseas 1 (Oregon)". You can choose the sites to register and log in according to your settlement method.

Guance provides Guance enterprise account settlement and cloud account settlement. For more details, please refer to the doc [Guance settlement method](../../billing/billing-account/index.md) 。

- If you choose Alibaba Cloud account for settlement, you can consider choosing "China 1 (Hangzhou)";
- If you choose AWS account for settlement, you can consider choosing "China 2 (Ningxia)";
- If you select the "China 4 (Guangzhou)" site, you will be opened for Guance enterprise account settlement by default;
- If your server is overseas, you can consider selecting "Overseas Area 1 (Oregon)", and use AWS account for settlement by default.

## How to Choose a plan

There are three plans of Guance: experience plan, commercial plan and private cloud deployment plan. Experience plan and commercial plan are SaaS deployment methods, which can be used directly by online registration; Private cloud deployment plan is a plan independently deployed for customers in their own environment, and customers can open registration and use for their users according to their own business conditions.

The following is the difference between the scope of services supported by Experience Plan and Commercial Plan.

| **Differences** | **Projects**         | **Experience Plan**                           | **Commercial Plan**                                                   |
| -------- | ---------------- | ------------------------------------ | ------------------------------------------------------------ |
| Data     | DataKit Number     | Not Limited                                 | Not Limited                                                         |
|          | Daily data reporting limit | Limited data is reported, and excess data is no longer reported.       | Not Limited                                                         |
|          | Data storage strategy     | 7-day cycle                             | Customize the storage policy, please refer to the documentation for more details [data storage strategy](../../billing/billing-method/data-storage.md) |
| Function     | Infrastructure         | Available                                   | Available                                                           |
|          | Log             | Available                                   | Available                                                           |
|          | Backup log         | /                                    | Available                                                           |
|          | APM     | Available                                   | Available                                                           |
|          | RUM     | Available                                   | Available                                                           |
|          | CI Visability monitoring    | Available                                   | Available                                                           |
|          | Scheck         | Available                                   | Available                                                           |
|          | Monitoring             | Available                                   | Available                                                           |
|          | Usability monitoring       | Dialing in China                           | Global dialing                                                     |
|          | SMS alarm notification     | /                                    | Available                                                           |
|          | DataFlux Func    | Available                                   | Available                                                           |
|          | Account permissions         | Read-only, standard permissions are promoted to administrators without auditing | Read-only, standard permissions are promoted to administrators, and need to be approved by expense center administrators           |
| Services     | Basic services         | Community, phone, work order support (5 x 8 hours)     | Community, phone, work order support (5 x 8 hours)                             |
|          | Training services         | Regular training on observability                     | Regular training on observability                                             |
|          | Expert services         | /                                    | Professional product technical expert support                                         |
|          | Value-added services         | /                                    | Internet professional operation and maintenance service                                           |
|          | Monitoring digital combat screen   | /                                    | Customizable                                                       |

???+ attention

    - If the data quota is fully used for different billing items in the experience plan, the data will stop being reported and updated; Infrastructure and event data still support reporting and updating, and you can still see infrastructure list data and event data;
    - The experience plan supports online upgrade to the commercial plan, and there is no charge if it is not upgraded. Once it is upgraded to the commercial plan, it cannot be refunded;
    - After the experience plan is upgraded to the commercial plan, the collected data will continue to be reported to the Guance workspace, but the data collected during the experience plan will not be viewed;
    - Timeseries and backup log statistics are full data, and other billing items are incremental data; Incremental data statistics reset the free quota at 0:00 every day, which is valid on the same day.




## Register Login Account

After you have selected the site and confirmed the registered plan, you can register and log in to the Guance workspace for use. For more registration details, please refer to the doc [register commercial plan](../../billing/commercial-register.md) 。

After logging into the Guance workspace, you can try [deploy the first DataKit](deploy-datakit.md).

