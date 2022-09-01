---

# 概述
“观测云” 系统可观测平台，为客户应用系统提供**全链路的可观测性**的云服务平台，根据客户应用系统的实际使用场景与特点提供了多种部署方案供选择。可选的 “观测云” 部署方案包括：**SaaS 商业版**、**SaaS 独占版**、**本地部署版**。
# 版本说明 
三种不同的部署方案，都采用按量计费的收费模式，也就是功能本身免费，都是基于数据收费，能很好的适配大中小不同应用规模的客户，根据数据量的大小支付不同的费用。

## SaaS 商业版
是我们部署在云上的 SaaS 公有版本，客户可以开箱即用，迅速拥有一套强大的系统可观测平台，只需要安装 DataKit 后配置相关数据采集器即完成了可观测接入。

相比于本地部署版，SaaS 版有很多优势：
**更高性能： **
“观测云” 的可观测数据主要为时序指标数据（InfluxDB），和日志文本类数据（Elasticsearch），需要巨量的数据来完成对系统的可观测目的，对系统资源的消耗很大。使用云上资源，由云提供了强大的硬件能力支撑。

**更弹性：**
相比部署版本，用户无需关心资源的扩容，用户也无需再为扩容的资源买单。可以专注与自己的可观测数据。

**更安全：**
每个用户的工作空间数据都是独立 DB 级别隔离，数据查询天然限定在自己的 DB 内，无需担心数据安全问题。
所有数据按照等保三的要求，存储在阿里云存储之上。

**更可靠：**
我们是小步快走模式，迭代升级速度快，每周都会进行问题 fix，每两周一个新版本上线。
由驻云庞大的 SRE 团队保障平台的安全稳定运行。

**更及时的专家支持：**
SRC 团队可以通过客户授权及时响应客户的需求。

**网络拓扑结构：**

![SaaS 敏捷版 .png](https://cdn.nlark.com/yuque/0/2021/png/21511589/1625194283179-eaafc709-553b-47c5-af98-eeab33d11ffc.png#clientId=ud665ae2c-877c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u882fd7ce&margin=%5Bobject%20Object%5D&name=SaaS%20%E6%95%8F%E6%8D%B7%E7%89%88%20.png&originHeight=414&originWidth=615&originalType=binary&ratio=1&rotation=0&showTitle=false&size=21630&status=done&style=none&taskId=u375c75e7-91db-4a5b-9e54-faa53d2f835&title=)

## SaaS 独占版
与 SaaS 商业版类似，也是在云上部署，但是客户独享使用，拥有** SaaS **商业版** **的所有优势。
另外，独占版本，我们为每个客户在各自独立的阿里云账号内部署一套 “观测云”，每个客户独占使用，安全级别更高。
计费也是按量方式，但由于是客户独享使用，SRC 团队单独提供支持，所以价格上相比 SaaS 商业版要贵 20% ~ 30%。

**网络拓扑结构：**
![SaaS 独占版.png](https://cdn.nlark.com/yuque/0/2021/png/21511589/1625194299947-b0f90809-61e6-4645-badd-354c70df47b9.png#clientId=ud665ae2c-877c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u0624c4a4&margin=%5Bobject%20Object%5D&name=SaaS%20%E7%8B%AC%E5%8D%A0%E7%89%88.png&originHeight=405&originWidth=792&originalType=binary&ratio=1&rotation=0&showTitle=false&size=27291&status=done&style=none&taskId=u8f99abc3-f7fe-4a07-8086-b55a5d22108&title=)
## 本地部署版
与 SaaS 独占版类似，是客户独享使用，但是部署在客户的本地物理机资源上，需要用户自己准备服务资源，需要一笔一次性的资源费用，大概15万的服务器资源费用（具体要看被监测对象规模）。
本地物理资源上部署，失去了在云上的所有优势，所有安全、可靠性都要自己保证，资源无法弹性。
另外，如果用户被监测对象云上云下混合，“观测云” 部署在没有固定公网 IP 的本地机房，还需要云运营商专线拉到本地机房，才能将云上的监测对象数据采集到本地 “观测云” 系统中，其中光专线就是一大块成本。

**网络拓扑结构：**
![本地部署版.png](https://cdn.nlark.com/yuque/0/2021/png/21511589/1625194314180-3cd8fb9a-9359-42bb-b5ba-0f0d839b7d4d.png#clientId=ud665ae2c-877c-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u6bfa5cf3&margin=%5Bobject%20Object%5D&name=%E6%9C%AC%E5%9C%B0%E9%83%A8%E7%BD%B2%E7%89%88.png&originHeight=453&originWidth=544&originalType=binary&ratio=1&rotation=0&showTitle=false&size=21180&status=done&style=none&taskId=u954259aa-56e9-4f1a-8458-f443943e4a7&title=)

综上所述，SaaS 商业版是最便捷、接入速度最快、成本最低的接入方案。


---

观测云是一款面向开发、运维、测试及业务团队的实时数据监测平台，能够统一满足云、云原生、应用及业务上的监测需求，快速实现系统可观测。**立即前往观测云，开启一站式可观测之旅：**[www.guance.com](https://www.guance.com)
![logo_2.png](https://cdn.nlark.com/yuque/0/2022/png/21511848/1642761909015-750c7ecd-81ba-4abf-b446-7b8e97abe76e.png#clientId=ucc58c24e-d7a9-4&crop=0&crop=0&crop=1&crop=1&from=drop&id=u1f1c3a96&margin=%5Bobject%20Object%5D&name=logo_2.png&originHeight=169&originWidth=746&originalType=binary&ratio=1&rotation=0&showTitle=false&size=139415&status=done&style=none&taskId=u420e6521-1eac-4f17-897f-53a63d36ff8&title=)
