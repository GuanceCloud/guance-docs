# Virtual Internet Access

---

## Overview {#overview}

If your system connected to Guance is deployed on Alibaba Cloud, this guide will instruct you on how to establish a private network connection from your host DataKit to the Guance platform by subscribing to the "Guance Data Gateway Virtual Internet" service via ComputeNest.

> Currently only supports Alibaba Cloud users.

The advantages of establishing a private network connection are:

- **Higher Bandwidth**: Does not consume public bandwidth of business systems; higher bandwidth is achieved through the virtual internet.
- **More Secure**: Data does not pass through the public network but remains entirely within Alibaba Cloud's private network, ensuring greater security.
- **Lower Costs**: Compared to the high costs of public bandwidth, the cost of using the virtual internet is lower.

Currently available services are in the `cn-hangzhou/cn-beijing` regions, with other regions coming soon. The architecture is as follows:

![not-set](imgs/aliyun_1.png)

## Subscribe to Service {#sub-service}

### Service Deployment Links {#service-dep}

| **Access Site**          | **Your Server Region**     | **ComputeNest Deployment Link**                                                                                                                                                            |
| ------------------------ | -------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| China Zone 1 (Hangzhou)  | `cn-hangzhou` (Hangzhou)   | [Guance Data Gateway Virtual Private Network - Hangzhou](https://computenest.console.aliyun.com/user/cn-hangzhou/serviceInstanceCreate?ServiceId=service-68c8fee7f0554d6b9baa){:target="_blank"}         |
| China Zone 1 (Hangzhou)  | `cn-beijing` (Beijing)     | [Guance Data Gateway Virtual Private Network - Beijing to Hangzhou](https://computenest.console.aliyun.com/user/cn-hangzhou/serviceInstanceCreate?ServiceId=service-af3b4511d9214c9ebaba){:target="_blank"}   |
| China Zone 3 (Zhangjiakou)| `cn-beijing` (Beijing)    | [Guance Data Gateway Virtual Private Network - Beijing to Zhangjiakou](https://computenest.console.aliyun.com/user/cn-hangzhou/serviceInstanceCreate?ServiceId=service-a22bc59ed53c4946b8ce){:target="_blank"} |
| China Zone 3 (Zhangjiakou)| `cn-hangzhou` (Hangzhou)  | [Guance Data Gateway Virtual Private Network - Hangzhou to Zhangjiakou](https://computenest.console.aliyun.com/user/cn-hangzhou/serviceInstanceCreate?ServiceId=service-87a611279d9a42ceaeb2){:target="_blank"} |

### Default Endpoints for Different Regions {#region-endpoint}

| **Access Site**          | **Your Server Region**     | **Endpoint**                         |
| ------------------------ | -------------------------- | ------------------------------------- |
| China Zone 1 (Hangzhou)  | `cn-hangzhou` (Hangzhou)   | `https://openway.guance.com`         |
| China Zone 1 (Hangzhou)  | `cn-beijing` (Beijing)     | `https://beijing-openway.guance.com` |
| China Zone 3 (Zhangjiakou)| `cn-beijing` (Beijing)    | `https://cn3-openway.guance.com`     |
| China Zone 3 (Zhangjiakou)| `cn-hangzhou` (Hangzhou)  | `https://cn3-openway.guance.com`     |

**Virtual internet services for other regions will be launched soon.**

### Configure Service Subscription {#config-sub}

Log in with your Alibaba Cloud account and open the **Service Deployment Link** to subscribe to our virtual internet service. Using `cn-hangzhou` as an example:

![not-set](imgs/aliyun_2.png)

1. First, select the subscription region, which must match the region where your cloud resources are deployed.
1. Select the same VPC network as the cloud resources of the system to be connected. **If multiple VPCs need to connect to the virtual internet, you can subscribe multiple times, once for each VPC.**
1. Choose the installation group.
1. Select availability zones and switches. If there are multiple availability zones and switches involved, you can add multiple entries.
1. Check "Use recommended custom domain name" and use the default recommended domain name, such as `openway.guance.com` for `cn-hangzhou`.

Using the default `openway.guance.com` domain name is important because if DataKit has already been deployed within the same VPC, it can seamlessly switch the data network to the virtual intranet.

### Subscription Completion {#sub-com}

After completing the subscription, the ComputeNest service will automatically create and configure the following in your cloud account:

1. A private network connection endpoint;
2. A cloud DNS PrivateZone that resolves to the default regional Endpoint domain name.

### Cost Information {#cost}

Costs mainly consist of two parts:

1. The first part is the private network access fee charged directly to your Alibaba Cloud account by Alibaba Cloud, primarily including the fees for Alibaba Cloud's PrivateLink and PrivateZone services. Refer to Alibaba Cloud's [PrivateLink Pricing](https://help.aliyun.com/document_detail/198081.html){:target="_blank"} and [PrivateZone Pricing](https://help.aliyun.com/document_detail/71338.html){:target="_blank"}.
2. The second part is the cross-region network traffic fee. For example, if your Alibaba Cloud resources are in the Beijing Region and you connect to the Guance Hangzhou site, you will incur cross-region traffic charges, which will be billed to your Guance account.

## How to Use {#how-to}

After completing the subscription, connecting your DataKit to Guance is completely transparent and requires no changes to the DataKit configuration. A private network connection is automatically established. You can log into the cloud host and run the `ping openway.guance.com` command to check the IP address returned. If it is an internal IP address, it indicates that a private network connection to the Guance data gateway has been successfully established:

![not-set](imgs/aliyun_3.png)