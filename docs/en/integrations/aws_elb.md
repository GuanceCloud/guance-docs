---
title: 'AWS ELB'
tags: 
  - AWS
summary: 'Use the " Official Script Market " series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.'
__int_icon: 'icon/aws_api_gateway'
dashboard:

  - desc: 'AWS Application ELB dashboard'
    path: 'dashboard/zh/aws_application_elb'
  - desc: 'AWS Network ELB dashboard'
    path: 'dashboard/zh/aws_network_elb'

monitor:
  - desc: 'AWS Application ELB monitor'
    path: 'monitor/zh/aws_application_elb'
  - desc: 'AWS Network ELB monitor'
    path: 'monitor/zh/aws_network_elb'

---


<!-- markdownlint-disable MD025 -->
# AWS ELB
<!-- markdownlint-enable -->

Use the[ Guance  Synchronization]  series script package in the script market to synchronize data from cloud monitoring cloud assets to the Guance.


## config {#config}

### Install Func

Recommend opening [ Integrations - Extension - DataFlux Func (Automata)]  : All preconditions are installed automatically, Please continue with the script installation

If you deploy Func yourself,Refer to [Self-Deployment of Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}

### Installation script

> Tip: Please prepare AWS AK that meets the requirements in advance (For simplicity's sake, You can directly grant the global read-only permission for CloudWatch `CloudWatchReadOnlyAccess`)  

To synchronize the monitoring data of AWS ELB cloud resources, we install the corresponding collection script :

AWS Application ELB select[Guance Integration ( AWS-ApplicationELBCollect )]  (ID: `guance_aws_applicationelb`)

AWS Network ELB select[Guance Integration ( AWS-NetworkELBCollect )]  (ID: `guance_aws_networkelb`)

AWS Gateway ELB select[Guance Integration ( AWS-GatewayELBCollect )]  (ID: `guance_aws_gatewayelb`)

AWS Classic ELB select[Guance Integration ( AWS-ELBCollect )]  (ID: `guance_aws_elb`)

Click  [Install]  and enter the corresponding parameters: AWS AK, AWS account name.

tap [Deploy startup Script]  , The system automatically creates `Startup` script sets , And automatically configure the corresponding startup script.

Then, in the collection script, add the collector_configs and cloudwatch_change the regions in configs to the actual regions

After this function is enabled, you can view the automatic triggering configuration in[ Management / Crontab Config]  . Click [ Run ]  , you can immediately execute once, without waiting for a regular time. After a while, you can view task execution records and corresponding logs.

We collected some configurations by default, as described in the Metrics column [Configure custom cloud object metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verify

1. In[ Management / Crontab Config]  check whether the automatic triggering configuration exists for the corresponding task,In addition, you can view task records and logs to check whether exceptions exist
2. On the Guance platform, click [Infrastructure / Custom] to check whether asset information exists
3. On the Guance platform, press [ Metrics]   to check whether monitoring data exists

## Metric {#metric}
Configure AWS Cloud - cloud monitoring. The default metric set is as follows. You can collect more metrics by configuring them

[AWS Application Load Balancer details](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html){:target="_blank"}

[AWS Network Load Balancer details](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-cloudwatch-metrics.html){:target="_blank"}

[AWS Gateway Load Balancer details](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/cloudwatch-metrics.html){:target="_blank"}

[AWS Classic Load Balancer details](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-cloudwatch-metrics.html){:target="_blank"}

### Application Load Balancer Metric

| Metric | Description |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `ActiveConnectionCount`                           | The total number of concurrent TCP connections active from clients to the load balancer and from the load balancer to targets. Reporting criteria: There is a nonzero value. **Statistics**: The most useful statistic is Sum.**Dimensions**:`LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

| `ConsumedLCUs`    | The number of load balancer capacity units (LCU) used by your load balancer. You pay for the number of LCUs that you use per hour. For more information, see Elastic Load Balancing pricing.**Reporting criteria**: Always reported. **Statistics**: All. **Dimensions**: `LoadBalancer` |

| `DesyncMitigationMode_NonCompliant_Request_Count`   | The number of requests that do not comply with RFC 7230. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`, `AvailabilityZone` `LoadBalancer` |

| `HTTPCode_ELB_3XX_Count`       | The number of HTTP 3XX redirection codes that originate from the load balancer. This count does not include response codes generated by targets. **Reporting criteria**: There is a nonzero value. **Statistics**: The only meaningful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

| `HTTPCode_ELB_4XX_Count`          | The number of HTTP 4XX client error codes that originate from the load balancer. This count does not include response codes generated by targets. Client errors are generated when requests are malformed or incomplete. These requests were not received by the target, other than in the case where the load balancer returns an HTTP 460 error code. This count does not include any response codes generated by the targets. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. Minimum, Maximum, and Average all return 1.**Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

| `HTTPCode_ELB_5XX_Count`     | The number of HTTP 5XX server error codes that originate from the load balancer. This count does not include any response codes generated by the targets. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. Minimum, Maximum, and Average all return 1.**Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

| `HTTPCode_ELB_500_Count`     | The number of HTTP 500 error codes that originate from the load balancer. **Reporting criteria**: There is a nonzero value. **Statistics**: The only meaningful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

| `HTTPCode_ELB_502_Count`    | The number of HTTP 502 error codes that originate from the load balancer. **Reporting criteria**: There is a nonzero value. **Statistics**: The only meaningful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

| `HTTPCode_ELB_503_Count` | The number of HTTP 503 error codes that originate from the load balancer. **Reporting criteria**: There is a nonzero value. **Statistics**: The only meaningful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

| `HTTPCode_ELB_504_Count` | The number of HTTP 504 error codes that originate from the load balancer. **Reporting criteria**: There is a nonzero value. **Statistics**: The only meaningful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

| `NewConnectionCount` | The total number of new TCP connections established from clients to the load balancer and from the load balancer to targets. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

| `ProcessedBytes` | The total number of bytes processed by the load balancer over IPv4 and IPv6 (HTTP header and HTTP payload). This count includes traffic to and from clients and Lambda functions, and traffic from an Identity Provider (IdP) if user authentication is enabled. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

| `RequestCount` | The number of requests processed over IPv4 and IPv6. This metric is only incremented for requests where the load balancer node was able to choose a target. Requests that are rejected before a target is chosen are not reflected in this metric. **Reporting criteria**: Always reported. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

`AWS/ApplicationELB` namespace includes the following metrics for targets.

| Metric                                                         | Description                                                         |
| :--------------------------------------------------------  --- | :------------------------------------------------------------------ |
| `HTTPCode_Target_2XX_Count`, `HTTPCode_Target_3XX_Count`, `HTTPCode_Target_4XX_Count`, `HTTPCode_Target_5XX_Count` | The number of targets that are considered healthy. **Reporting criteria**: Reported if health checks are enabled. **Statistics**: The most useful statistics are Average, Minimum, and Maximum. **Dimensions**: `TargetGroup` `LoadBalancer`, `TargetGroup` `AvailabilityZone` `LoadBalancer`, `AvailabilityZone` `TargetGroup` `LoadBalancer` |
| `TargetResponseTime`                                         | The time elapsed, in seconds, after the request leaves the load balancer until a response from the target is received. This is equivalent to the target_processing_time field in the access logs. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistics are Average and pNN.NN (percentiles). **Dimensions**: `TargetGroup` `LoadBalancer`, `TargetGroup` `AvailabilityZone` `LoadBalancer`, `AvailabilityZone` `TargetGroup` `LoadBalancer` |

`AWS/ApplicationELB` namespace includes the following metrics for target group health. For more information, see [Target group health](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/target-group-health.html){:target="_blank"}.

| Metric                                                         | Description                                                         |
| :--------------------------------------------------------  --- | :------------------------------------------------------------------ |
| `UnhealthyRoutingRequestCount` | The number of requests that are routed using the routing failover action (fail open). **Statistics**: The most useful statistic is Sum. **Dimensions**:`LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |

### Network Load Balancer Metric

| Metric                                          | Description                                                  |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `ActiveFlowCount`                           | The total number of concurrent flows (or connections) from clients to targets. This metric includes connections in the SYN_SENT and ESTABLISHED states. TCP connections are not terminated at the load balancer, so a client opening a TCP connection to a target counts as a single flow. **Reporting criteria**: Always reported.**Statistics**: Always reported. **Dimensions**: `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ActiveFlowCount_TCP`                           | The total number of concurrent TCP flows (or connections) from clients to targets. This metric includes connections in the SYN_SENT and ESTABLISHED state. TCP connections are not terminated at the load balancer, so a client opening a TCP connection to a target counts as a single flow. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistics are Average, Maximum, and Minimum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ConsumedLCUs`                           | The number of load balancer capacity units (LCU) used by your load balancer. You pay for the number of LCUs that you use per hour. **Reporting criteria**: Always reported. **Statistics**: All. **Dimensions**: `LoadBalancer` |
| `ConsumedLCUs_TCP`                           | The number of load balancer capacity units (LCU) used by your load balancer for TCP. You pay for the number of LCUs that you use per hour. **Reporting criteria**: There is a nonzero value. **Statistics**: All. **Dimensions**: `LoadBalancer` |
| `NewFlowCount`                           | The total number of new flows (or connections) established from clients to targets in the time period. **Reporting criteria**: Always reported. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `NewFlowCount_TCP`                           | The total number of new TCP flows (or connections) established from clients to targets in the time period. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `PeakPacketsPerSecond`                           | Highest average packet rate (packets processed per second), calculated every 10 seconds during the sampling window. This metric includes health check traffic. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Maximum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ProcessedBytes`                           | The total number of bytes processed by the load balancer, including TCP/IP headers. This count includes traffic to and from targets, minus health check traffic. **Reporting criteria**: Always reported. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ProcessedBytes_TCP`                           | The total number of bytes processed by TCP listeners. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ProcessedPackets`                           | The total number of packets processed by the load balancer. This count includes traffic to and from targets, including health check traffic. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `TCP_Client_Reset_Count`                           | The total number of reset (RST) packets sent from a client to a target. These resets are generated by the client and forwarded by the load balancer. **Reporting criteria**: Always reported. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `TCP_ELB_Reset_Count`                           | The total number of reset (RST) packets generated by the load balancer. **Reporting criteria**: Always reported. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `TCP_Target_Reset_Count`                           | The total number of reset (RST) packets sent from a target to a client. These resets are generated by the target and forwarded by the load balancer. **Reporting criteria**: Always reported. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `UnhealthyRoutingFlowCount`                           | The number of flows (or connections) that are routed using the routing failover action (fail open). **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

### Gateway Load Balancer Metric

| Metric                                        | Description                                                  |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `ActiveFlowCount`                           | The total number of concurrent flows (or connections) from clients to targets. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistics are Average, Maximum, and Minimum. **Dimensions**: `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ConsumedLCUs`                           | The number of load balancer capacity units (LCU) used by your load balancer. You pay for the number of LCUs that you use per hour. **Reporting criteria**: Always reported. **Statistics**: All. **Dimensions**: `LoadBalancer` |
| `HealthyHostCount`                           | The number of targets that are considered healthy. **Reporting criteria**: Reported if health checks are enabled. **Statistics**: The most useful statistics are Maximum and Minimum. **Dimensions**: `LoadBalancer``TargetGroup`,`AvailabilityZone``LoadBalancer``TargetGroup` |
| `NewFlowCount`                           | The total number of new flows (or connections) established from clients to targets in the time period. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ProcessedBytes`                           | The total number of bytes processed by the load balancer. This count includes traffic to and from targets, but not health check traffic. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `UnHealthyHostCount`                           | The number of targets that are considered unhealthy. **Reporting criteria**: Reported if health checks are enabled. **Statistics**: The most useful statistics are Maximum and Minimum. **Dimensions**: `LoadBalancer``TargetGroup`,`AvailabilityZone``LoadBalancer``TargetGroup` |

### Classic Load Balancer Metric

| Metric                                   | Description                                                  |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `BackendConnectionErrors`                           | The number of connections that were not successfully established between the load balancer and the registered instances. Because the load balancer retries the connection when there are errors, this count can exceed the request rate. Note that this count also includes any connection errors related to health checks.**Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. Note that Average, Minimum, and Maximum are reported per load balancer node and are not typically useful. However, the difference between the minimum and maximum (or peak to average or average to trough) might be useful to determine whether a load balancer node is an outlier. **Example**: Suppose that your load balancer has 2 instances in us-west-2a and 2 instances in us-west-2b, and that attempts to connect to 1 instance in us-west-2a result in back-end connection errors. The sum for us-west-2a includes these connection errors, while the sum for us-west-2b does not include them. Therefore, the sum for the load balancer equals the sum for us-west-2a. |
| `DesyncMitigationMode_NonCompliant_Request_Count`                           | [HTTP listener] The number of requests that do not comply with RFC 7230. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. |
| `HealthyHostCount`                           | The number of healthy instances registered with your load balancer. A newly registered instance is considered healthy after it passes the first health check. If cross-zone load balancing is enabled, the number of healthy instances for the LoadBalancerName dimension is calculated across all Availability Zones. Otherwise, it is calculated per Availability Zone. **Reporting criteria**: There are registered instances. **Statistics**: The most useful statistics are Average and Maximum. These statistics are determined by the load balancer nodes. Note that some load balancer nodes might determine that an instance is unhealthy for a brief period while other nodes determine that it is healthy. **Example**: Suppose that your load balancer has 2 instances in us-west-2a and 2 instances in us-west-2b, us-west-2a has 1 unhealthy instance, and us-west-2b has no unhealthy instances. With the AvailabilityZone dimension, there is an average of 1 healthy and 1 unhealthy instance in us-west-2a, and an average of 2 healthy and 0 unhealthy instances in us-west-2b. |
| `HTTPCode_Backend_2XX, HTTPCode_Backend_3XX, HTTPCode_Backend_4XX, HTTPCode_Backend_5XX`                           | [HTTP listener] The number of HTTP response codes generated by registered instances. This count does not include any response codes generated by the load balancer. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. Note that Minimum, Maximum, and Average are all 1. **Example**: Suppose that your load balancer has 2 instances in us-west-2a and 2 instances in us-west-2b, and that requests sent to 1 instance in us-west-2a result in HTTP 500 responses. The sum for us-west-2a includes these error responses, while the sum for us-west-2b does not include them. Therefore, the sum for the load balancer equals the sum for us-west-2a. |
| `HTTPCode_ELB_4XX`                           | [HTTP listener] The number of HTTP 4XX client error codes generated by the load balancer. Client errors are generated when a request is malformed or incomplete. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. Note that Minimum, Maximum, and Average are all 1. **Example**: Suppose that your load balancer has us-west-2a and us-west-2b enabled, and that client requests include a malformed request URL. As a result, client errors would likely increase in all Availability Zones. The sum for the load balancer is the sum of the values for the Availability Zones. |
| `HTTPCode_ELB_5XX`                           | [HTTP listener] The number of HTTP 5XX server error codes generated by the load balancer. This count does not include any response codes generated by the registered instances. The metric is reported if there are no healthy instances registered to the load balancer, or if the request rate exceeds the capacity of the instances (spillover) or the load balancer. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. Note that Minimum, Maximum, and Average are all 1. **Example**: Suppose that your load balancer has us-west-2a and us-west-2b enabled, and that instances in us-west-2a are experiencing high latency and are slow to respond to requests. As a result, the surge queue for the load balancer nodes in us-west-2a fills and clients receive a 503 error. If us-west-2b continues to respond normally, the sum for the load balancer equals the sum for us-west-2a. |
| `Latency`                           | [HTTP listener] The total time elapsed, in seconds, from the time the load balancer sent the request to a registered instance until the instance started to send the response headers. [TCP listener] The total time elapsed, in seconds, for the load balancer to successfully establish a connection to a registered instance. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Average. Use Maximum to determine whether some requests are taking substantially longer than the average. Note that Minimum is typically not useful. **Example**: Suppose that your load balancer has 2 instances in us-west-2a and 2 instances in us-west-2b, and that requests sent to 1 instance in us-west-2a have a higher latency. The average for us-west-2a has a higher value than the average for us-west-2b. |
| `RequestCount`                           | The number of requests completed or connections made during the specified interval (1 or 5 minutes). [HTTP listener] The number of requests received and routed, including HTTP error responses from the registered instances. [TCP listener] The number of connections made to the registered instances. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. Note that Minimum, Maximum, and Average all return 1. **Example**: Suppose that your load balancer has 2 instances in us-west-2a and 2 instances in us-west-2b, and that 100 requests are sent to the load balancer. There are 60 requests sent to us-west-2a, with each instance receiving 30 requests, and 40 requests sent to us-west-2b, with each instance receiving 20 requests. With the AvailabilityZone dimension, there is a sum of 60 requests in us-west-2a and 40 requests in us-west-2b. With the LoadBalancerName dimension, there is a sum of 100 requests. |
| `SpilloverCount`                           | The total number of requests that were rejected because the surge queue is full. [HTTP listener] The load balancer returns an HTTP 503 error code. [TCP listener] The load balancer closes the connection. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Sum. Note that Average, Minimum, and Maximum are reported per load balancer node and are not typically useful. **Example**: Suppose that your load balancer has us-west-2a and us-west-2b enabled, and that instances in us-west-2a are experiencing high latency and are slow to respond to requests. As a result, the surge queue for the load balancer node in us-west-2a fills, resulting in spillover. If us-west-2b continues to respond normally, the sum for the load balancer will be the same as the sum for us-west-2a. |
| `SurgeQueueLength`                           | The total number of requests (HTTP listener) or connections (TCP listener) that are pending routing to a healthy instance. The maximum size of the queue is 1,024. Additional requests or connections are rejected when the queue is full. **Reporting criteria**: There is a nonzero value. **Statistics**: The most useful statistic is Maximum, because it represents the peak of queued requests. The Average statistic can be useful in combination with Minimum and Maximum to determine the range of queued requests. Note that Sum is not useful. **Example**: Suppose that your load balancer has us-west-2a and us-west-2b enabled, and that instances in us-west-2a are experiencing high latency and are slow to respond to requests. As a result, the surge queue for the load balancer nodes in us-west-2a fills, with clients likely experiencing increased response times. If this continues, the load balancer will likely have spillovers (see the SpilloverCount metric). If us-west-2b continues to respond normally, the max for the load balancer will be the same as the max for us-west-2a. |
| `UnHealthyHostCount`                           | The number of unhealthy instances registered with your load balancer. An instance is considered unhealthy after it exceeds the unhealthy threshold configured for health checks. An unhealthy instance is considered healthy again after it meets the healthy threshold configured for health checks. **Reporting criteria**: There are registered instances. **Statistics**: The most useful statistics are Average and Minimum. These statistics are determined by the load balancer nodes. Note that some load balancer nodes might determine that an instance is unhealthy for a brief period while other nodes determine that it is healthy. **Example**: See HealthyHostCount. |

### Metric for Application Load Balancers

To filter the metrics for your Application / Network / Gateway Load Balancer .

| Metric               | Description                                                         |
| :----------------- | :----------------------------------------------------------- |
| `AvailabilityZone` | Filters the metric data by Availability Zone.                                       |
| `LoadBalancer`     | Filters the metric data by load balancer. Specify the load balancer as follows: `app/load-balancer-name/1234567890123456` (the final portion of the load balancer ARN). |
| `TargetGroup`      | Filters the metric data by target group. Specify the target group as follows: `targetgroup/target-group-name/1234567890123456` (the final portion of the target group ARN). |


To filter the metrics for your Classic Load Balancer .

| Metric               | Description                                                        |
| :----------------- | :---------------------------------------------------------------------- |
| `AvailabilityZone` | Filters the metric data by the specified Availability Zone.             |
| `LoadBalancerName` | Filters the metric data by the specified load balancer.                 |

## Object {#object}

The collected AWS ELB object data structure can be seen from the [ Infrastructure - Custom]  object data

```json
{
  "measurement": "aws_aelb",
  "tags": {
    "name"                 : "app/openway/8e8d762xxxxxx",
    "RegionId"             : "cn-northwest-1",
    "LoadBalancerArn"      : "arn:aws-cn:elasticloadbalancing:cn-northwest-1:588271xxxxx:loadbalancer/app/openway/8e8d762xxxxxx",
    "State"                : "active",
    "Type"                 : "application",
    "VpcId"                : "vpc-2exxxxx",
    "Scheme"               : "internet-facing",
    "DNSName"              : "openway-203509xxxx.cn-northwest-1.elb.amazonaws.com.cn",
    "LoadBalancerName"     : "openway",
    "CanonicalHostedZoneId": "ZM7IZAIxxxxxx"
  },
  "fields": {
    "CreatedTime"         : "2022-03-09T06:13:31Z",
    "ListenerDescriptions": "{JSON data}",
    "AvailabilityZones"   : "{Availability Zone JSON data}",
    "message"             : "{Instance JSON data}"
  }
}
```

> *Notice: `tags`,`fields`*The fields in this section may change with subsequent updates*
>
> > Remind 1: AWS ELB metric set is divided into four types according to different types of load balancing:
> >
> > 1. The index set of Application ELB is `aws_aelb`
> > 2. The index set of Network ELB is `aws_nelb`
> > 3. The index set of Gateway ELB is `aws_gelb`
> > 4. The index set of Classic ELB is `aws_elb`
> >
> > Remind 2: `tags.name` can be set in two ways:
> >
> > 1. Classic Load Balancers use the field of LoadBalancerName.
> > 2. Application,Network,Gateway Load Balancers intercept the end of the load balancer ARN (LoadBalancerArn).
> >
> > Take Network Load Balancer for example:
> >
> > ```txt
> > LoadBalancerArn is `arn:awS-cn:elasticloadbalancing:cn-northwest-1:xxxx1335135:loadbalancer/net/k8s-forethou-kodongin-xxxxa46f01/xxxxe75ae81d08c2`
> > ```
> >
> > `tags.name` is `net/k8s-forethou-kodongin-xxxxa46f01/xxxxe75ae81d08c2`
> >
> > Remind 3:
> >
> > - `fields.message`,`tags.AvailabilityZones` are post serialized character for JSON.
> > - `tags.state` means Load Balancers status,value:`active`,`provisioning`,`active_impaired`,`failed` (Classic ELB does not exist this field ).
> > - `tags.Type`means Load Balancers type,value:`application`,`network`,`gateway`,`classic`.
> > - `tags.Scheme`means Load Balancers mode,value:`internet-facing`,`internal`.
> > - `fields.ListenerDescriptions`This field is a list of listeners for the load balance.
> > - `fields.AvailabilityZones` This field indicates the Amazon Route 53 availability zone information associated with the load balancer.
