---
title: 'AWS ELB'
tags: 
  - AWS
summary: 'Use the "Guance Cloud Sync" series of script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_elb'

dashboard:
  - desc: 'Built-in View for AWS Application ELB'
    path: 'dashboard/en/aws_application_elb'
  - desc: 'Built-in View for AWS Network ELB'
    path: 'dashboard/en/aws_network_elb'

monitor:
  - desc: 'Monitor for AWS Application ELB'
    path: 'monitor/en/aws_application_elb'
  - desc: 'Monitor for AWS Network ELB'
    path: 'monitor/en/aws_network_elb'

---


<!-- markdownlint-disable MD025 -->
# AWS ELB
<!-- markdownlint-enable -->

Use the "Guance Cloud Sync" series of script packages in the script market to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed. Please proceed with script installation.

If you deploy Func on your own, refer to [Self-deploy Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Amazon Web Services AK that meets the requirements in advance (for simplicity, you can directly grant `CloudWatchReadOnlyAccess` read-only permissions)

To synchronize monitoring data for ECS cloud resources, install the corresponding collection script:

For AWS Application Load Balancer (AWS Application ELB), select "Guance Integration (AWS-ApplicationELB Collection)" (ID: `guance_aws_applicationelb`)

For AWS Network Load Balancer (AWS Network ELB), select "Guance Integration (AWS-NetworkELB Collection)" (ID: `guance_aws_networkelb`)

For AWS Gateway Load Balancer (AWS Gateway ELB), select "Guance Integration (AWS-GatewayELB Collection)" (ID: `guance_aws_gatewayelb`)

For AWS Classic Load Balancer, select "Guance Integration (AWS-ELB Collection)" (ID: `guance_aws_elb`)

After clicking 【Install】, enter the required parameters: Amazon Web Services AK, Amazon Web Services account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and configure the corresponding startup scripts. Ensure that 'regions' in the startup script matches the actual regions where the ELB is located.

Once enabled, you can see the corresponding automatic trigger configuration under "Management / Automatic Trigger Configuration". Click 【Execute】to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect logs, also enable the corresponding log collection script. If you need to collect billing information, enable the cloud billing collection script.


By default, some configurations have been collected. For more details, see the Metrics section [Customize Cloud Object Metrics](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Management / Automatic Trigger Configuration", confirm whether the corresponding tasks have the automatic trigger configuration, and check the corresponding task records and logs for any anomalies.
2. On the Guance platform, in "Infrastructure / Custom", check if there is asset information.
3. On the Guance platform, in "Metrics", check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon Web Services CloudWatch, the default metric sets are as follows. You can collect more metrics through configuration:

[Amazon Web Services CloudWatch Application Load Balancer Metric Details](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html){:target="_blank"}

[Amazon Web Services CloudWatch Network Load Balancer Metric Details](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-cloudwatch-metrics.html){:target="_blank"}

[Amazon Web Services CloudWatch Gateway Load Balancer Metric Details](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/cloudwatch-metrics.html){:target="_blank"}

[Amazon Web Services CloudWatch Classic Load Balancer Metric Details](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-cloudwatch-metrics.html){:target="_blank"}

### Application Load Balancer Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `ActiveConnectionCount`                           | Total number of concurrent active TCP connections from clients to the load balancer and from the load balancer to targets. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ClientTLSNegotiationErrorCount`                  | Number of TLS connections initiated by clients that failed to establish a session with the load balancer due to TLS errors. Possible causes include cipher or protocol mismatches or clients closing connections because they cannot verify the server certificate. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ConsumedLCUs`                                    | Number of load balancer capacity units (LCU) used by the load balancer. You pay for the number of LCU used per hour. For more information, see [Elastic Load Balancing Pricing](http://aws.amazon.com/elasticloadbalancing/pricing/){:target="_blank"}. **Reporting Standard**: Always reported **Statistics**: All dimensions `LoadBalancer` |
| `DesyncMitigationMode_NonCompliant_Request_Count` | Number of requests that do not conform to RFC 7230 standards. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `DroppedInvalidHeaderRequestCount`                | Number of HTTP headers removed by the load balancer before routing requests with invalid header fields. This only occurs when the `routing.http.drop_invalid_header_fields.enabled` property is set to `true`. **Reporting Standard**: Non-zero value **Statistics**: All dimensions `AvailabilityZone`, `LoadBalancer` |
| `ForwardedInvalidHeaderRequestCount`              | Number of HTTP headers with invalid HTTP header fields routed by the load balancer. This only occurs when the `routing.http.drop_invalid_header_fields.enabled` property is set to `false`. **Reporting Standard**: Always reported **Statistics**: All dimensions `AvailabilityZone`, `LoadBalancer` |
| `GrpcRequestCount`                                | Number of gRPC requests processed via IPv4 and IPv6. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistics are `Sum`, `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTP_Fixed_Response_Count`                       | Number of successful fixed response operations. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTP_Redirect_Count`                             | Number of successful redirect operations. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTP_Redirect_Url_Limit_Exceeded_Count`          | Number of redirect operations that could not be completed because the URL in the response location header was greater than 8K. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_3XX_Count`                          | Number of HTTP 3XX redirect codes generated by the load balancer. This count does not include response codes generated by targets. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_4XX_Count`                          | Number of HTTP 4XX client error codes generated by the load balancer. This count does not include response codes generated by targets. If the request format is incorrect or incomplete, client errors are generated. Except for cases where the load balancer returns [HTTP 460 error code](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-troubleshooting.html#http-460-issues){:target="_blank"}, targets do not receive these requests. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistics are `Sum`, `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_5XX_Count`                          | Number of HTTP 5XX server error codes generated by the load balancer. This count does not include response codes generated by targets. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistics are `Sum`, `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_500_Count`                          | Number of HTTP 500 error codes generated by the load balancer. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_502_Count`                          | Number of HTTP 502 error codes generated by the load balancer. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_503_Count`                          | Number of HTTP 503 error codes generated by the load balancer. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_504_Count`                          | Number of HTTP 504 error codes generated by the load balancer. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `IPv6ProcessedBytes`                              | Total number of bytes processed by the load balancer via IPv6. This count is included in `ProcessedBytes`. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `IPv6RequestCount`                                | Number of IPv6 requests received by the load balancer. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistics are `Sum`, `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `NewConnectionCount`                              | Total number of new TCP connections established from clients to the load balancer and from the load balancer to targets. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `NonStickyRequestCount`                           | Number of requests chosen by the load balancer for a new target because it cannot use an existing sticky session. For example, the request is the first request from a new client and does not provide a sticky cookie, provides a sticky cookie but does not specify a registered target in this target group, the sticky cookie format is incorrect or expired, or an internal error prevents the load balancer from reading the sticky cookie. **Reporting Standard**: Sticky sessions are enabled on the target group. **Statistics**: The only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ProcessedBytes`                                  | Total number of bytes processed by the load balancer via IPv4 and IPv6 (HTTP headers and HTTP payload). This count includes traffic to and from clients and Lambda functions, as well as traffic from identity providers (IdP) if user authentication is enabled. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `RejectedConnectionCount`                         | Number of connections rejected due to the load balancer reaching the connection limit. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `RequestCount`                                    | Number of requests processed via IPv4 and IPv6. This metric only increments for requests where the load balancer nodes can choose a target. Requests rejected before choosing a target are not reflected in this metric. **Reporting Standard**: Always reported **Statistics**: The most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `TargetGroup`, `LoadBalancer` |
| `RuleEvaluations`                                 | Number of rules processed by the load balancer given the average request rate over one hour. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistic is `Sum`. Dimensions `LoadBalancer` |



The `AWS/ApplicationELB` namespace includes the following metrics for targets.

| Metric                                                         | Description                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `HealthyHostCount`                                           | Number of targets considered healthy. **Reporting Standard**: Reported when health checks are enabled **Statistics**: The most useful statistics are `Average`, `Minimum`, and `Maximum`. Dimensions `TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer``AvailabilityZone`, `TargetGroup`, `LoadBalancer` |
| `HTTPCode_Target_2XX_Count`, `HTTPCode_Target_3XX_Count`, `HTTPCode_Target_4XX_Count`, `HTTPCode_Target_5XX_Count` | Number of HTTP response codes generated by targets. It does not include response codes generated by the load balancer. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistic is `Sum`. `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer``TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `RequestCountPerTarget`                                      | Average number of requests received by each target in the target group. You must specify the target group using the `TargetGroup` dimension. If the target is a Lambda function, this metric does not apply. **Reporting Standard**: Always reported **Statistics**: The only valid statistic is `Sum`. This represents the average, not the total. Dimensions `TargetGroup``AvailabilityZone`, `TargetGroup`, `LoadBalancer` |
| `TargetConnectionErrorCount`                                 | Number of times connections between the load balancer and targets fail to establish successfully. If the target is a Lambda function, this metric does not apply. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistic is `Sum`. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer``TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `TargetResponseTime`                                         | Time taken for a request to leave the load balancer until receiving a response from the target (in seconds). This is equivalent to the `target_processing_time` field in access logs. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistics are `Average` and `pNN.NN` (percentile). Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer``TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `TargetTLSNegotiationErrorCount`                             | Number of TLS connections initiated by the load balancer that fail to establish a session with the target. Possible causes include cipher or protocol mismatches. If the target is a Lambda function, this metric does not apply. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistic is `Sum`. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer``TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `UnHealthyHostCount`                                         | Number of targets considered unhealthy. **Reporting Standard**: Reported when health checks are enabled **Statistics**: The most useful statistics are `Average`, `Minimum`, and `Maximum`. Dimensions `TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer``AvailabilityZone`, `TargetGroup`, `LoadBalancer` |



The `AWS/ApplicationELB` namespace includes the following metrics for target group health. For more information, see [Target Group Health](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/target-group-health.html){:target="_blank"}.

| Metric                           | Description                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| `HealthyStateDNS`              | Number of zones that meet DNS health state requirements. **Statistics**: The most useful statistic is `Min`. Dimensions `LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `HealthyStateRouting`          | Number of zones that meet routing health state requirements. **Statistics**: The most useful statistic is `Min`. Dimensions `LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `UnhealthyRoutingRequestCount` | Number of requests routed using routing failure transfer operation (fail open). **Statistics**: The most useful statistic is `Sum`. Dimensions `LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `UnhealthyStateDNS`            | Number of zones that do not meet DNS health state requirements and are marked as unhealthy in DNS. **Statistics**: The most useful statistic is `Min`. Dimensions `LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `UnhealthyStateRouting`        | Number of zones that do not meet routing health state requirements and thus the load balancer distributes traffic to all targets in the zone (including unhealthy targets). **Statistics**: The most useful statistic is `Min`. Dimensions `LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |



The `AWS/ApplicationELB` namespace includes the following metrics for Lambda functions registered as targets.

| Metric                         | Description                                                         |
| :--------------------------- | :----------------------------------------------------------- |
| `LambdaInternalError`        | Number of requests to Lambda functions that failed due to issues with the load balancer or AWS Lambda. To get the error reason code, see the error_reason field in the access logs. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `TargetGroup``TargetGroup`, `LoadBalancer` |
| `LambdaTargetProcessedBytes` | Total number of bytes processed by the load balancer for requests to and responses from Lambda functions. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `LoadBalancer` |
| `LambdaUserError`            | Number of requests to Lambda functions that failed due to issues with the Lambda function. For example, the load balancer lacks permission to call the function, receives malformed JSON from the function, or the request or response size exceeds 1 MB. To get the error reason code, see the error_reason field in the access logs. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `TargetGroup``TargetGroup`, `LoadBalancer` |

The `AWS/ApplicationELB` namespace includes the following metrics for user authentication.

| Metric                            | Description                                                         |
| :------------------------------ | :----------------------------------------------------------- |
| `ELBAuthError`                  | Number of times user authentication could not be completed due to misconfigured authentication actions, the load balancer being unable to connect to the IdP, or the load balancer failing to complete the authentication process due to internal errors. To get the error reason code, see the error_reason field in the access logs. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthFailure`                | Number of times user authentication could not be completed due to the IdP rejecting user access or multiple uses of the authorization code. To get the error reason code, see the error_reason field in the access logs. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthLatency`                | Time taken (in milliseconds) to query ID tokens and user information from the IdP. If any of these operations fail, this indicates the failure time. **Reporting Standard**: Non-zero value **Statistics**: All statistics are meaningful. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthRefreshTokenSuccess`    | Number of times the load balancer successfully refreshed user claims using the refresh token provided by the IdP. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthSuccess`                | Number of successful authentication operations. This metric increments when the load balancer retrieves user identity claims from the IdP and completes the verification workflow. **Reporting Standard**: Non-zero value **Statistics**: The most useful statistic is `Sum`. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthUserClaimsSizeExceeded` | Number of times the configured IdP returns user claims larger than 11K bytes. **Reporting Standard**: Non-zero value **Statistics**: The only meaningful statistic is `Sum`. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer` |

### Network Load Balancer Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `ActiveFlowCount`                           | Total number of concurrent flows (or connections) from clients to targets. This metric includes connections in SYN_SENT and ESTABLISHED states. TCP connections are not terminated at the load balancer, so a client with an open TCP connection to a target is counted as one flow. **Reporting Standard**: Always reported. **Statistics**: The most useful statistics are Average, Maximum, and Minimum. **Dimensions**: `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ActiveFlowCount_TCP`                           | Total number of concurrent TCP flows (or connections) from clients to targets. This metric includes connections in SYN_SENT and ESTABLISHED states. TCP connections are not terminated at the load balancer, so a client with an open TCP connection to a target is counted as one flow. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistics are Average, Maximum, and Minimum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ConsumedLCUs`                           | Number of load balancer capacity units (LCU) used by the load balancer. You pay for the number of LCU used per hour. **Reporting Standard**: Always reported. **Statistics**: All. **Dimensions**: `LoadBalancer` |
| `ConsumedLCUs_TCP`                           | Number of load balancer capacity units (LCU) used by the load balancer for TCP. You pay for the number of LCU used per hour. **Reporting Standard**: Non-zero value. **Statistics**: All. **Dimensions**: `LoadBalancer` |
| `NewFlowCount`                           | Total number of new flows (or connections) established from clients to targets within the period. **Reporting Standard**: Always reported. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `NewFlowCount_TCP`                           | Total number of new TCP flows (or connections) established from clients to targets within the period. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `PeakPacketsPerSecond`                           | Highest average packet rate (packets per second processed) during a 10-second sampling window. This metric includes health check traffic. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Maximum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ProcessedBytes`                           | Total number of bytes processed by the load balancer, including TCP/IP headers. This count includes traffic to and from targets, excluding health check traffic. **Reporting Standard**: Always reported. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ProcessedBytes_TCP`                           | Total number of bytes processed by the TCP listener. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ProcessedPackets`                           | Total number of packets processed by the load balancer. This count includes traffic to and from targets and health check traffic. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `TCP_Client_Reset_Count`                           | Total number of reset (RST) packets sent from clients to targets. These resets are generated by clients and forwarded by the load balancer. **Reporting Standard**: Always reported. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `TCP_ELB_Reset_Count`                           | Total number of reset (RST) packets generated by the load balancer. **Reporting Standard**: Always reported. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `TCP_Target_Reset_Count`                           | Total number of reset (RST) packets sent from targets to clients. These resets are generated by targets and forwarded by the load balancer. **Reporting Standard**: Always reported. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `UnhealthyRoutingFlowCount`                           | Number of flows (or connections) routed using routing failure transfer operation (fail open). **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

### Gateway Load Balancer Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :----------------------------------------------------------- |
| `ActiveFlowCount`                           | Total number of concurrent flows (or connections) from clients to targets. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistics are Average, Maximum, and Minimum. **Dimensions**: `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ConsumedLCUs`                           | Number of load balancer capacity units (LCU) used by the load balancer. You pay for the number of LCU used per hour. **Reporting Standard**: Always reported. **Statistics**: All. **Dimensions**: `LoadBalancer` |
| `HealthyHostCount`                           | Number of targets considered healthy. **Reporting Standard**: Reported when health checks are enabled. **Statistics**: The most useful statistics are Maximum and Minimum. **Dimensions**: `LoadBalancer``TargetGroup`,`AvailabilityZone``LoadBalancer``TargetGroup` |
| `NewFlowCount`                           | Total number of new flows (or connections) established from clients to targets within the period. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ProcessedBytes`                           | Total number of bytes processed by the load balancer. This count includes traffic to and from targets but excludes health check traffic. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `UnHealthyHostCount`                           | Number of targets considered unhealthy. **Reporting Standard**: Reported when health checks are enabled. **Statistics**: The most useful statistics are Maximum and Minimum. **Dimensions**: `LoadBalancer``TargetGroup`,`AvailabilityZone``LoadBalancer``TargetGroup` |

### Classic Load Balancer Metrics

| Metric                                                         | Description                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| `BackendConnectionErrors`                                    | Number of times connections between the load balancer and registered instances fail to establish successfully. Since the load balancer retries connections when errors occur, this count may exceed the request rate. Note that this count also includes all connection errors related to health checks. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Sum. Note that Average, Minimum, and Maximum report per load balancer node and are generally not useful. However, differences between minimum and maximum values (or peak-to-average, average-to-trough) can indicate anomalies among load balancer nodes. **Example**: Assume your load balancer has 2 instances each in us-west-2a and us-west-2b, and connection attempts to 1 instance in us-west-2a result in backend connection errors. The sum value for us-west-2a includes these connection errors, while the sum value for us-west-2b does not. Therefore, the sum value for the load balancer equals the sum value for us-west-2a. |
| `DesyncMitigationMode_NonCompliant_Request_Count`            | [HTTP Listener] Number of requests that do not conform to RFC 7230 standards. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Sum. **Dimensions**: `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `HealthyHostCount`                                           | Number of healthy instances registered with the load balancer. New registered instances are considered healthy after passing the first health check. If cross-zone load balancing is enabled, the number of healthy instances across all availability zones is calculated for the LoadBalancerName dimension. Otherwise, this number is calculated for each availability zone. **Reporting Standard**: Registered instances exist. **Statistics**: The most useful statistics are Average and Maximum. These statistics are determined by load balancer nodes. Note that some load balancer nodes may temporarily consider an instance unhealthy while others consider it healthy. **Example**: Assume your load balancer has 2 instances each in us-west-2a and us-west-2b, and 1 instance in us-west-2a is unhealthy, while us-west-2b has no unhealthy instances. For the AvailabilityZone dimension, us-west-2a averages 1 healthy and 1 unhealthy instance, while us-west-2b averages 2 healthy and 0 unhealthy instances. |
| `HTTPCode_Backend_2XX, HTTPCode_Backend_3XX, HTTPCode_Backend_4XX, HTTPCode_Backend_5XX` | [HTTP Listener] Number of HTTP response codes generated by registered instances. This count does not include response codes generated by the load balancer. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Sum. Note that Minimum, Maximum, and Average are all 1. **Example**: Assume your load balancer has 2 instances each in us-west-2a and us-west-2b, and requests sent to 1 instance in us-west-2a result in an HTTP 500 response. The sum value for us-west-2a includes these error responses, while the sum value for us-west-2b does not. Therefore, the sum value for the load balancer equals the sum value for us-west-2a. |
| `HTTPCode_ELB_4XX`                                           | [HTTP Listener] Number of HTTP 4XX client error codes generated by the load balancer. Client errors are generated if the request format is incorrect or incomplete. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Sum. Note that Minimum, Maximum, and Average are all 1. **Example**: Assume your load balancer is enabled in us-west-2a and us-west-2b, and client requests contain malformed request URLs. This may lead to increased client errors in all availability zones. The sum value for the load balancer is the total of the values for each availability zone. |
| `HTTPCode_ELB_5XX`                                           | [HTTP Listener] Number of HTTP 5XX server error codes generated by the load balancer. This count does not include response codes generated by registered instances. This metric is reported if no healthy instances are registered with the load balancer or if the request rate exceeds the capacity of instances or the load balancer (overflow). **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Sum. Note that Minimum, Maximum, and Average are all 1. **Example**: Assume your load balancer is enabled in us-west-2a and us-west-2b, and instances in us-west-2a have high latency and respond slowly to requests. As a result, the surge queue in us-west-2a fills up, and clients receive 503 errors. If us-west-2b continues to respond normally, the sum value for the load balancer equals the sum value for us-west-2a. |
| `Latency`                                                    | [HTTP Listener] Total time (in seconds) taken for the load balancer to send a request to a registered instance until the instance starts sending response headers. [TCP Listener] Total time (in seconds) taken for the load balancer to successfully establish a connection with a registered instance. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Average. Maximum can be used to determine if certain requests take significantly longer than the average time. Note that Minimum is generally not useful. **Example**: Assume your load balancer has 2 instances each in us-west-2a and us-west-2b, and requests sent to 1 instance in us-west-2a have higher latency. The average value for us-west-2a will be higher than the average value for us-west-2b. |
| `RequestCount`                                               | Number of requests completed or connections issued in the specified time period (1 or 5 minutes). [HTTP Listener] Number of requests received and routed, including HTTP error responses from registered instances. [TCP Listener] Number of connections issued to registered instances. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Sum. Note that Minimum, Maximum, and Average all return 1. **Example**: Assume your load balancer has 2 instances each in us-west-2a and us-west-2b, and 100 requests are sent to the load balancer. 60 requests are sent to us-west-2a, with each instance receiving 30 requests, and 40 requests are sent to us-west-2b, with each instance receiving 20 requests. For the AvailabilityZone dimension, us-west-2a totals 60 requests, and us-west-2b totals 40 requests. For the LoadBalancerName dimension, the total is 100 requests. |
| `SpilloverCount`                                             | Total number of requests rejected due to the surge queue filling up. [HTTP Listener] The load balancer returns an HTTP 503 error code. [TCP Listener] The load balancer closes connections. **Reporting Standard**: Non-zero value. **Statistics**: The most useful statistic is Sum. Note that Average, Minimum, and Maximum report per load balancer node and are generally not useful. **Example**: Assume your load balancer is enabled in us-west-2a and us-west-2b, and instances in us-west-2a have high latency and respond slowly to requests. As a result, the surge queue in us-west-2a fills up, leading to overflow. If us-west-2b continues to respond normally, the sum value for the load balancer equals the sum value for us-west-2a. |
| `SurgeQueueLength`                                           | Total number of requests (HTTP listener) or connections (TCP listener) waiting to be routed to healthy instances. The maximum queue size is 1024. Once the queue is full, additional requests or connections are rejected. For more information, see SpilloverCount. **Reporting Standard**: Non-zero value. **Statistics**: The most valuable statistic is Maximum, as it represents the peak number of queued requests. Combining Average with Minimum and Maximum can determine the range of queued requests. Note that Sum is not useful. **Example**: Assume your load balancer is enabled in us-west-2a and us-west-2b, and instances in us-west-2a have high latency and respond slowly to requests. This results in the surge queue in us-west-2a filling up, likely increasing client response times. If this situation persists, the load balancer may overflow (see SpilloverCount metric). If us-west-2b continues to respond normally, the max value for the load balancer equals the max value for us-west-2a. |
| `UnHealthyHostCount`                                         | Number of unhealthy instances registered with the load balancer. An instance is considered unhealthy if it exceeds the unhealthy threshold configured for health checks. Unhealthy instances are re-marked as healthy once they meet the healthy threshold configured for health checks. **Reporting Standard**: Registered instances exist. **Statistics**: The most useful statistics are Average and Minimum. These statistics are determined by load balancer nodes. Note that some load balancer nodes may temporarily consider an instance unhealthy while others consider it healthy. **Example**: Refer to HealthyHostCount. |

### Load Balancer Metric Dimensions

To filter metrics for Application / Network / Gateway Load Balancers, use the following dimensions.

| Dimension               | Description                                                         |
| :----------------- | :----------------------------------------------------------- |
| `AvailabilityZone` | Filter metric data by availability zone.                                       |
| `LoadBalancer`     | Filter metric data by load balancer. Specify the load balancer as follows: `app/load-balancer-name/1234567890123456` (the ending part of the load balancer ARN). |
| `TargetGroup`      | Filter metric data by target group. Specify the target group as follows: `targetgroup/target-group-name/1234567890123456` (the ending part of the target group ARN). |

To filter metrics for Classic Load Balancers, use the following dimensions.

| Dimension               | Description                                                        |
| :----------------- | :--------------------------------------------------------- |
| `AvailabilityZone` | Filter metric data by availability zone.                                       |
| `LoadBalancerName` | Filter metric data by the specified load balancer.                              |

## Objects {#object}

Collected AWS ELB object data structure, which can be viewed under "Infrastructure - Custom