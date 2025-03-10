# AWS Private Internet Access

---

## Overview {#overview}

Amazon PrivateLink is a highly available and scalable technology that enables you to connect your VPC privately to services as if these services were within your own VPC. You do not need to use an internet gateway, NAT device, public IP addresses, Amazon Direct Connect connection, or Amazon Site-to-Site VPN connection to allow communication with services in private subnets. Therefore, you can control specific API endpoints, sites, and services accessible from the VPC. Amazon PrivateLink can help you save on some traffic costs.

Benefits of establishing a private network connection:

- **Higher Bandwidth**: Does not consume public bandwidth of business systems, achieving higher bandwidth through endpoint services.
- **More Secure**: Data does not pass through the public internet, ensuring data remains within the private network for enhanced security.
- **Lower Costs**: Compared to high fees for public bandwidth, the cost of virtual internet access is lower.

Currently available regions are **cn-northwest-1, us-west-2, ap-southeast-1**. Other regions will be available soon. The architecture is as follows:

![not-set](https://static.guance.com/images/datakit/aws_privatelink.png)

## Prerequisites {#prerequisite}

1. First, select the subscription region, which must match the region where your cloud resources for Guance are deployed.
2. Choose the same VPC network where your cloud resources are deployed. **If multiple VPCs need to connect to the endpoint service, subscribe multiple times, once for each VPC.**

## Subscribe to Service {#sub-service}

### Service Deployment Links {#service-dep}

| **Access Region** | **Your Server's Region**       | **Endpoint Service Name**                                      |
| ----------------- | ------------------------------ | -------------------------------------------------------------- |
| China Region 2 (Ningxia) | `cn-northwest-1` (Ningxia) | `cn.com.amazonaws.vpce.cn-northwest-1.vpce-svc-070f9283a2c0d1f0c` |
| Overseas Region 1 (Oregon) | `us-west-2` (Oregon)     | `com.amazonaws.vpce.us-west-2.vpce-svc-084745e0ec33f0b44`      |
| Asia-Pacific Region 1 (Singapore) | `ap-southeast-1` (Singapore) | `com.amazonaws.vpce.ap-southeast-1.vpce-svc-070194ed9d834d571` |

### Default Endpoint for Private Network Gateway in Different Regions {#region-endpoint}

| **Access Region** | **Your Server's Region**       | **Endpoint**                                                |
| ----------------- | ------------------------------ | ------------------------------------------------------------ |
| China Region 2 (Ningxia) | `cn-northwest-1` (Ningxia) | `https://aws-openway.guance.com`                             |
| Overseas Region 1 (Oregon) | `us-west-2` (Oregon)     | `https://us1-openway.guance.com`                             |
| Asia-Pacific Region 1 (Singapore) | `ap-southeast-1` (Singapore) | `https://ap1-openway.guance.one`                            |

### Configure Service Subscription {#config-sub}

#### Step One: Authorize Account ID {#accredit-id}

Open the Amazon console via the following links:
- [China Region](https://console.amazonaws.cn/console/home){:target="_blank"}
- [Overseas Region](https://console.aws.amazon.com/console/home){:target="_blank"}

Obtain the account ID in the top-right corner, copy this "Account ID," and **inform** our customer manager at Guance to add it to our whitelist.

![not-set](https://static.guance.com/images/datakit/aws_privatelink_id.png)

#### Step Two: Create Endpoint {#create-endpoint}

1. Open the Amazon VPC console via the following links:
   - [China Region](https://console.amazonaws.cn/vpc/){:target="_blank"}
   - [Overseas Region](https://console.amazonaws.cn/vpc/){:target="_blank"}
2. In the navigation pane, select **Endpoint** (Endpoint Service).
3. Create an endpoint.
4. **Service Settings**: Input the service name and verify. Select VPC, availability zone, and enable port 443 in the security group.
5. Wait for creation to complete and obtain the endpoint service address.

![not-set](https://static.guance.com/images/datakit/aws-privatelink-dns.png)

#### Step Three: Route 53 Resolve Endpoint {#route-53}

1. Open the Amazon Route 53 console via the following links:
   - [China Region](https://console.amazonaws.cn/route53/v2/hostedzones/){:target="_blank"}
   - [Overseas Region](https://console.aws.amazon.com/route53/v2/hostedzones/){:target="_blank"}
2. Create a hosted zone.
3. Domain: `guance.com`, Type: Private Hosted Zone, Region: DK's region, VPC ID: Customer’s VPC ID.
4. Create a record.
5. Record Name: Refer to [Endpoint](aws-access.md#region-endpoint) address, Record Type: `CNAME`, Value: [Create Endpoint](aws-access.md#create-endpoint) service address.

![not-set](https://static.guance.com/images/datakit/aws_privatelink_route53.png)

#### Verification {#verify}

Run the following command on EC2:

```shell
dig aws-openway.guance.com
```

Result:

```shell
; <<>> DiG 9.16.38-RH <<>> aws-openway.guance.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 22545
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;aws-openway.guance.com.      IN    A

;; ANSWER SECTION:
aws-openway.guance.com. 296 IN  CNAME    vpce-0d431e354cf9ad4f1-h1y2auf6.vpce-svc-070f9283a2c0d1f0c.cn-northwest-1.vpce.amazonaws.com.cn.
vpce-0d431e354cf9ad4f1-h1y2auf6.vpce-svc-070f9283a2c0d1f0c.cn-northwest-1.vpce.amazonaws.com.cn. 56 IN A 172.31.38.12

;; Query time: 0 msec
;; SERVER: 172.31.0.2#53(172.31.0.2)
;; WHEN: Thu May 18 11:23:04 UTC 2023
;; MSG SIZE  rcvd: 176
```

### Cost Details {#cost}

Taking Oregon as an example:

| Name                                                        | Cost     | Documentation                                                         | Notes                   |
| ----------------------------------------------------------- | -------- | --------------------------------------------------------------------- | ----------------------- |
| Data transfer out from Amazon EC2 to the internet            | $0.09/GB | [Documentation](https://aws.amazon.com/cn/ec2/pricing/on-demand/#Data_Transfer){:target="_blank"} | Charged by traffic      |
| Interface VPC endpoint                                       | $0.01/H  | [Documentation](https://aws.amazon.com/cn/privatelink/pricing/?nc1=h_ls){:target="_blank"} | Charged by AZ and hour  |
| Data transfer out from interface VPC endpoint                | $0.01/GB | [Documentation](https://aws.amazon.com/cn/privatelink/pricing/?nc1=h_ls){:target="_blank"} | Charged by traffic      |

The main cost components are:

1. Interface VPC endpoint [service charges](https://aws.amazon.com/cn/privatelink/pricing/?nc1=h_ls){:target="_blank"}
2. Traffic charges for the endpoint

Comparison:

Assuming the client transmits **200GB** of outbound traffic and **10GB** of inbound traffic **daily**:

|          |              Internet               | PrivateLink                                                  |
| :------: | :---------------------------------: | ------------------------------------------------------------ |
| Formula  | Internet Outbound Traffic × Internet Outbound Traffic Fee × 30 | Interface VPC Endpoint Service × 3 Availability Zones × 24 Hours × 30 Days + (Interface VPC Endpoint Outbound Traffic Fee × Interface VPC Endpoint Outbound Traffic + Interface VPC Endpoint Inbound Traffic Fee × Interface VPC Endpoint Inbound Traffic) × 30 |
| Calculation |         0.09 × 200 × 30           | 0.01 × 3 × 24 × 30 + (0.01 × 200 + 0.01 × 10) × 30 |
| Monthly Total |             $540.0              | $84.6 |