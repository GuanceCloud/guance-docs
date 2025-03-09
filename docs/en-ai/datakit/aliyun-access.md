# Virtual Internet Access

---

## Overview {#overview}

If your system connected to Guance is deployed on Alibaba Cloud, this guide will instruct you on how to establish a private network connection from your host DataKit to the Guance platform by subscribing to the "Guance Data Gateway Virtual Internet" service via Compute Nest.

> Currently, only Alibaba Cloud users are supported.

The advantages of establishing a private network connection include:

- **Higher Bandwidth**: Does not consume public bandwidth of business systems; higher bandwidth is achieved through the virtual internet.
- **More Secure**: Data does not pass through the public network and remains entirely within Alibaba Cloud's private network, ensuring greater security.
- **Lower Costs**: Compared to high public bandwidth fees, the cost of the virtual internet is lower.

Currently available services are in `cn-hangzhou/cn-beijing`, with other regions coming soon. The architecture is as follows:

![not-set](imgs/aliyun_1.png)

## Subscribe to Service {#sub-service}

### Service Deployment Links {#service-dep}

| **Access Site**      | **Your Server's Region** | **Compute Nest Deployment Link**                                                                                                                                                            |
| -------------------- | ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| China Zone 1 (Hangzhou) | `cn-hangzhou` (Hangzhou) | [Guance Data Gateway Virtual Private Network - Hangzhou](https://computenest.console.aliyun.com/user/cn-hangzhou/serviceInstanceCreate?ServiceId=service-68c8fee7f0554d6b9baa){:target="_blank"}         |
| China Zone 1 (Hangzhou) | `cn-beijing` (Beijing)   | [Guance Data Gateway Virtual Private Network - Beijing to Hangzhou](https://computenest.console.aliyun.com/user/cn-hangzhou/serviceInstanceCreate?ServiceId=service-af3b4511d9214c9ebaba){:target="_blank"}   |
| China Zone 3 (Zhangjiakou) | `cn-beijing` (Beijing) | [Guance Data Gateway Virtual Private Network - Beijing to Zhangjiakou](https://computenest.console.aliyun.com/user/cn-hangzhou/serviceInstanceCreate?ServiceId=service-a22bc59ed53c4946b8ce){:target="_blank"} |
| China Zone 3 (Zhangjiakou) | `cn-hangzhou` (Hangzhou) | [Guance Data Gateway Virtual Private Network - Hangzhou to Zhangjiakou](https://computenest.console.aliyun.com/user/cn-hangzhou/serviceInstanceCreate?ServiceId=service-87a611279d9a42ceaeb2){:target="_blank"} |

### Default Private Network Gateway Endpoints for Different Regions {#region-endpoint}

| **Access Site**      | **Your Server's Region** | **Endpoint**                         |
| -------------------- | ------------------------ | ------------------------------------- |
| China Zone 1 (Hangzhou) | `cn-hangzhou` (Hangzhou) | `https://openway.guance.com`         |
| China Zone 1 (Hangzhou) | `cn-beijing` (Beijing)   | `https://beijing-openway.guance.com` |
| China Zone 3 (Zhangjiakou) | `cn-beijing` (Beijing) | `https://cn3-openway.guance.com`     |
| China Zone 3 (Zhangjiakou) | `cn-hangzhou` (Hangzhou) | `https://cn3-openway.guance.com`     |

**Virtual Internet services for other regions will be available soon.**

### Configure Service Subscription {#config-sub}

Log in with your Alibaba Cloud account and open the **service deployment link** above to subscribe to our virtual internet service. Taking `cn-hangzhou` as an example:

![not-set](imgs/aliyun_2.png)

1. First, select the subscription region, which must match the region where your cloud resources are deployed.
1. Choose the same VPC network where your system is deployed. **If multiple VPCs need to connect to the virtual internet, you can subscribe multiple times, once for each VPC.**
1. Select the installation group.
1. Choose availability zones and switches. If there are multiple availability zones and switches involved, you can add multiple entries.
1. Select “Use recommended custom domain name” and use the default recommended domain, such as `openway.guance.com` for `cn-hangzhou`.

Using the default `openway.guance.com` domain, it is important to note that if Datakit has already been deployed within the same VPC, the data network can seamlessly switch to the virtual intranet.

### Subscription Completion {#sub-com}

After subscription completion, the Compute Nest service will automatically create and configure the following under your cloud account:

1. A private network connection endpoint;
2. A cloud resolution PrivateZone that resolves to the default regional Endpoint domain.

### Cost Details {#cost}

Cost details consist of two parts:

1. The first part is the private network access fee directly billed to your Alibaba Cloud account, mainly including the fees for Alibaba Cloud’s PrivateLink and Cloud Resolution PrivateZone services. Refer to the [PrivateLink billing description](https://help.aliyun.com/document_detail/198081.html){:target="_blank"}, and [Cloud Resolution PrivateZone billing description](https://help.aliyun.com/document_detail/71338.html){:target="_blank"} on the Alibaba Cloud official website.
2. The second part is the cross-region network transmission traffic fee. For example, if your Alibaba Cloud resources are in the Beijing region and you connect to the Guance Hangzhou site, cross-region traffic transmission fees will be incurred, which will be billed to your Guance bill.

## How to Use {#how-to}

After subscription completion, connecting your Datakit to Guance is completely transparent, requiring no changes to Datakit configuration as the private network connection is automatically established. You can log into the cloud host and execute the `ping openway.guance.com` command to check the IP address returned. If it is an internal IP address, it indicates that a successful private network connection has been established with the Guance data gateway:

![not-set](imgs/aliyun_3.png)