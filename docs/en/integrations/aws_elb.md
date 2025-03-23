---
title: 'AWS ELB'
tags: 
  - AWS
summary: 'Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>.'
__int_icon: 'icon/aws_elb'

dashboard:
  - desc: 'AWS Application ELB built-in view'
    path: 'dashboard/en/aws_application_elb'
  - desc: 'AWS Network ELB built-in view'
    path: 'dashboard/en/aws_network_elb'

monitor:
  - desc: 'AWS Application ELB monitor'
    path: 'monitor/en/aws_application_elb'
  - desc: 'AWS Network ELB monitor'
    path: 'monitor/en/aws_network_elb'

---


<!-- markdownlint-disable MD025 -->
# AWS ELB
<!-- markdownlint-enable -->

Use the "<<< custom_key.brand_name >>> Cloud Sync" series script packages in the script market to synchronize cloud monitoring and cloud asset data to <<< custom_key.brand_name >>>.


## Configuration {#config}

### Install Func

It is recommended to enable <<< custom_key.brand_name >>> integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with script installation.

If you deploy Func yourself, refer to [Self-deploy Func](https://<<< custom_key.func_domain >>>/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Amazon Web Services AK that meets the requirements in advance (for simplicity, you can directly grant CloudWatch read-only access `CloudWatchReadOnlyAccess`)

To synchronize ECS cloud resource monitoring data, we install the corresponding collection script:

For AWS Application Load Balancer (AWS Application ELB), select "<<< custom_key.brand_name >>> Integration (AWS-ApplicationELB Collection)" (ID: `guance_aws_applicationelb`)

For AWS Network Load Balancer (AWS Network ELB), select "<<< custom_key.brand_name >>> Integration (AWS-NetworkELB Collection)" (ID: `guance_aws_networkelb`)

For AWS Gateway Load Balancer (AWS Gateway ELB), select "<<< custom_key.brand_name >>> Integration (AWS-GatewayELB Collection)" (ID: `guance_aws_gatewayelb`)

For AWS Classic Load Balancer, select "<<< custom_key.brand_name >>> Integration (AWS-ELB Collection)" (ID: `guance_aws_elb`)

After clicking 【Install】, enter the corresponding parameters: Amazon Web Services AK, Amazon Web Services account name.

Click 【Deploy Startup Script】, and the system will automatically create a `Startup` script set and automatically configure the corresponding startup script. In the startup script, ensure that 'regions' match the actual regions where the ELBs are located.

After enabling, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration." Click 【Execute】 to immediately execute it once without waiting for the scheduled time. After a short wait, you can view the execution task records and corresponding logs.

> If you want to collect the corresponding logs, you also need to enable the corresponding log collection script. If you want to collect bills, you need to enable the cloud bill collection script.


By default, we collect some configurations, for more details see the metrics section [Configure Custom Cloud Object Metrics](https://<<< custom_key.func_domain >>>/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. In "Manage / Automatic Trigger Configuration," confirm whether the corresponding tasks have the corresponding automatic trigger configuration, and check the corresponding task records and logs for any abnormalities.
2. On the <<< custom_key.brand_name >>> platform, under "Infrastructure / Custom," check if there is asset information.
3. On the <<< custom_key.brand_name >>> platform, under "Metrics," check if there is corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon Web Services - Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration:

[Amazon Web Services Cloud Monitoring Application Load Balancer Metric Details](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html){:target="_blank"}

[Amazon Web Services Cloud Monitoring Network Load Balancer Metric Details](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-cloudwatch-metrics.html){:target="_blank"}

[Amazon Web Services Cloud Monitoring Gateway Load Balancer Metric Details](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/cloudwatch-metrics.html){:target="_blank"}

[Amazon Web Services Cloud Monitoring Classic Load Balancer Metric Details](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-cloudwatch-metrics.html){:target="_blank"}

### Application Load Balancer Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :------------------------------------------------------------------ |
| `ActiveConnectionCount`                           | The total number of concurrent active TCP connections from clients to the load balancer and from the load balancer to targets. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ClientTLSNegotiationErrorCount`                  | The number of TLS connections initiated by clients that failed to establish sessions with the load balancer due to TLS errors. Possible causes include cipher or protocol mismatches or clients closing connections because they could not validate the server certificate. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ConsumedLCUs`                                    | The number of load balancer capacity units (LCUs) used by the load balancer. You pay for the number of LCUs used per hour. For more information, see [Elastic Load Balancing Pricing](http://aws.amazon.com/elasticloadbalancing/pricing/){:target="_blank"}. **Reporting Standard**: Always reported. **Statistics**: All dimensions `LoadBalancer` |
| `DesyncMitigationMode_NonCompliant_Request_Count` | The number of requests that do not comply with RFC 7230 standards. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `DroppedInvalidHeaderRequestCount`                | The number of HTTP headers deleted by the load balancer before routing requests due to invalid header fields. The load balancer only deletes these headers when the `routing.http.drop_invalid_header_fields.enabled` attribute is set to `true`. **Reporting Standard**: Non-zero values reported. **Statistics**: All dimensions `AvailabilityZone`, `LoadBalancer` |
| `ForwardedInvalidHeaderRequestCount`              | The number of HTTP headers with invalid HTTP header fields routed by the load balancer. The load balancer forwards requests with these headers only when the `routing.http.drop_invalid_header_fields.enabled` attribute is set to `false`. **Reporting Standard**: Always reported. **Statistics**: All dimensions `AvailabilityZone`, `LoadBalancer` |
| `GrpcRequestCount`                                | The number of gRPC requests handled via IPv4 and IPv6. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistics are `Sum`. `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTP_Fixed_Response_Count`                       | The number of successful fixed response operations. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTP_Redirect_Count`                             | The number of successful redirection operations. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTP_Redirect_Url_Limit_Exceeded_Count`          | The number of redirection operations that could not be completed due to the URL in the response location header being greater than 8K. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_3XX_Count`                          | The number of HTTP 3XX redirection codes originating from the load balancer. This count does not include response codes generated by the target. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_4XX_Count`                          | The number of HTTP 4XX client error codes originating from the load balancer. This count does not include response codes generated by the target. Client errors are generated if the request format is incorrect or incomplete. Except in cases where the load balancer returns [HTTP 460 Error Code](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-troubleshooting.html#http-460-issues){:target="_blank"}, the target does not receive these requests. This count does not include any response codes generated by the target. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistics are `Sum`. `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_5XX_Count`                          | The number of HTTP 5XX server error codes originating from the load balancer. This count does not include any response codes generated by the target. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistics are `Sum`. `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_500_Count`                          | The number of HTTP 500 error codes originating from the load balancer. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_502_Count`                          | The number of HTTP 502 error codes originating from the load balancer. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_503_Count`                          | The number of HTTP 503 error codes originating from the load balancer. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_504_Count`                          | The number of HTTP 504 error codes originating from the load balancer. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `IPv6ProcessedBytes`                              | The total number of bytes processed by the load balancer via IPv6. This count is included in `ProcessedBytes`. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `IPv6RequestCount`                                | The number of IPv6 requests received by the load balancer. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistics are `Sum`. `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `NewConnectionCount`                              | The total number of new TCP connections established from clients to the load balancer and from the load balancer to targets. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `NonStickyRequestCount`                           | The number of requests chosen by the load balancer for a new target because it cannot use existing sticky sessions. For example, the request is the first request from a new client and does not provide a sticky cookie, provides a sticky cookie but does not specify a registered target in this target group, the sticky cookie is malformed or expired, or an internal error occurs causing the load balancer to fail to read the sticky cookie. **Reporting Standard**: Sticky enabled on the target group. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ProcessedBytes`                                  | The total number of bytes processed by the load balancer via IPv4 and IPv6 (HTTP headers and HTTP payloads). This count includes traffic to and from clients and Lambda functions, as well as traffic from identity providers (IdP) if user authentication is enabled. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `RejectedConnectionCount`                         | The number of connections rejected due to the load balancer reaching its connection limit. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `RequestCount`                                    | The number of requests handled via IPv4 and IPv6. This metric increments only for requests where the load balancer node can choose a target. Requests rejected before selecting a target are not reflected in this metric. **Reporting Standard**: Always reported. **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `TargetGroup`, `LoadBalancer` |
| `RuleEvaluations`                                 | The number of rules processed by the load balancer given an average request rate over 1 hour. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer` |



The `AWS/ApplicationELB` namespace includes the following metrics for targets.

| Metric                                                         | Description                                                         |
| :----------------------------------------------------------- | :------------------------------------------------------------------ |
| `HealthyHostCount`                                           | The number of targets considered healthy. **Reporting Standard**: Reported when health checks are enabled. **Statistics**: Most useful statistics are `Average`, `Minimum`, and `Maximum`. Dimensions `TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer``AvailabilityZone`, `TargetGroup`, `LoadBalancer` |
| `HTTPCode_Target_2XX_Count`, `HTTPCode_Target_3XX_Count`, `HTTPCode_Target_4XX_Count`, `HTTPCode_Target_5XX_Count` | The number of HTTP response codes generated by the target. It does not include any response codes generated by the load balancer. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistics are `Sum`. `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer``TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `RequestCountPerTarget`                                      | The average number of requests received by each target in the target group. You must specify the target group using the `TargetGroup` dimension. If the target is a Lambda function, this metric does not apply. **Reporting Standard**: Always reported. **Statistic**: Only valid statistic is `Sum`. This represents the average, not the sum. Dimensions `TargetGroup``AvailabilityZone`, `TargetGroup`, `LoadBalancer` |
| `TargetConnectionErrorCount`                                 | The number of times connections between the load balancer and the target failed to establish successfully. If the target is a Lambda function, this metric does not apply. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer``TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `TargetResponseTime`                                         | The time taken for a request to leave the load balancer until a response is received from the target (in seconds). This is equivalent to the `target_processing_time` field in the access logs. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistics are `Average` and `pNN.NN` (percentiles). Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer``TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `TargetTLSNegotiationErrorCount`                             | The number of TLS connections initiated by the load balancer that failed to establish sessions with the target. Possible causes include cipher or protocol mismatches. If the target is a Lambda function, this metric does not apply. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer``TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `UnHealthyHostCount`                                         | The number of targets considered unhealthy. **Reporting Standard**: Reported when health checks are enabled. **Statistics**: Most useful statistics are `Average`, `Minimum`, and `Maximum`. Dimensions `TargetGroup`, `LoadBalancer``TargetGroup`, `AvailabilityZone`, `LoadBalancer``AvailabilityZone`, `TargetGroup`, `LoadBalancer` |



The `AWS/ApplicationELB` namespace includes the following metrics for target group health. For more information, see [Target Group Health](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/target-group-health.html){:target="_blank"}.

| Metric                           | Description                                                         |
| :----------------------------- | :------------------------------------------------------------------ |
| `HealthyStateDNS`              | The number of zones that meet DNS health good state requirements. **Statistics**: Most useful statistic is `Min`. Dimensions `LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `HealthyStateRouting`          | The number of zones that meet routing health good state requirements. **Statistics**: Most useful statistic is `Min`. Dimensions `LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `UnhealthyRoutingRequestCount` | The number of requests routed using the routing failure transfer operation (open when failed). **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `UnhealthyStateDNS`            | The number of zones that do not meet DNS health good state requirements and are therefore marked as unhealthy in DNS. **Statistics**: Most useful statistic is `Min`. Dimensions `LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `UnhealthyStateRouting`        | The number of zones that do not meet routing health good state requirements and therefore the load balancer distributes traffic to all targets in the zone (including unhealthy targets). **Statistics**: Most useful statistic is `Min`. Dimensions `LoadBalancer`, `TargetGroup``AvailabilityZone`, `LoadBalancer`, `TargetGroup` |



The `AWS/ApplicationELB` namespace includes the following metrics for Lambda functions registered as targets.

| Metric                         | Description                                                         |
| :--------------------------- | :------------------------------------------------------------------ |
| `LambdaInternalError`        | The number of failed requests to the Lambda function due to issues within the load balancer or AWS Lambda. To get the error reason code, check the error_reason field in the access logs. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `TargetGroup``TargetGroup`, `LoadBalancer` |
| `LambdaTargetProcessedBytes` | The total number of bytes processed by the load balancer for requests targeting the Lambda function and responses from that function. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer` |
| `LambdaUserError`            | The number of failed requests to the Lambda function due to issues with the Lambda function. For example, the load balancer does not have permission to invoke the function, the load balancer receives malformed JSON or JSON missing required fields from the function, or the size of the request body or response exceeds the maximum size of 1 MB. To get the error reason code, check the error_reason field in the access logs. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `TargetGroup``TargetGroup`, `LoadBalancer` |

The `AWS/ApplicationELB` namespace includes the following metrics for user authentication.

| Metric                            | Description                                                         |
| :------------------------------ | :------------------------------------------------------------------ |
| `ELBAuthError`                  | The number of times user authentication fails due to misconfigured authentication actions, the load balancer's inability to establish a connection with the IdP, or the load balancer's inability to complete the authentication process due to internal errors. To get the error reason code, check the error_reason field in the access logs. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthFailure`                | The number of times user authentication fails due to the IdP rejecting user access or the multiple use of authorization codes. To get the error reason code, check the error_reason field in the access logs. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthLatency`                | The time taken (in milliseconds) to query ID tokens and user information from the IdP. If one or more of these operations fail, this indicates the failure time. **Reporting Standard**: Non-zero values reported. **Statistics**: All statistics are meaningful. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthRefreshTokenSuccess`    | The number of times the load balancer successfully refreshes user claims using the refresh token provided by the IdP. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthSuccess`                | The number of successful authentication operations. This metric increments when the load balancer retrieves user identity claims from the IdP and completes the verification workflow. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ELBAuthUserClaimsSizeExceeded` | The number of times the configured IdP returns user claims exceeding 11K bytes. **Reporting Standard**: Non-zero values reported. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer``AvailabilityZone`, `LoadBalancer` |

### Network Load Balancer Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :------------------------------------------------------------------ |
| `ActiveFlowCount`                           | The total number of concurrent flows (or connections) from clients to targets. This metric includes connections in the SYN_SENT and ESTABLISHED states. TCP connections are not terminated on the load balancer, so a client with an open TCP connection to a target is counted as one flow. **Reporting Standard**: Always reported. **Statistics**: Most useful statistics are Average, Maximum, and Minimum. **Dimensions**: `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ActiveFlowCount_TCP`                           | The total number of concurrent TCP flows (or connections) from clients to targets. This metric includes connections in the SYN_SENT and ESTABLISHED states. TCP connections are not terminated on the load balancer, so a client with an open TCP connection to a target is counted as one flow. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistics are Average, Maximum, and Minimum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ConsumedLCUs`                           | The number of load balancer capacity units (LCUs) used by the load balancer. You pay for the number of LCUs used per hour. **Reporting Standard**: Always reported. **Statistics**: All. **Dimensions**: `LoadBalancer` |
| `ConsumedLCUs_TCP`                           | The number of load balancer capacity units (LCUs) used by the load balancer for TCP. You pay for the number of LCUs used per hour. **Reporting Standard**: Non-zero values reported. **Statistics**: All. **Dimensions**: `LoadBalancer` |
| `NewFlowCount`                           | The total number of new flows (or connections) established from clients to targets during the period. **Reporting Standard**: Always reported. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `NewFlowCount_TCP`                           | The total number of new TCP flows (or connections) established from clients to targets during the period. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `PeakPacketsPerSecond`                           | The highest average packet rate (packets processed per second) calculated every 10 seconds during the sampling window. This metric includes health check traffic. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Maximum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ProcessedBytes`                           | The total number of bytes processed by the load balancer, including TCP/IP headers. This count includes traffic to and from targets, minus health check traffic. **Reporting Standard**: Always reported. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ProcessedBytes_TCP`                           | The total number of bytes processed by the TCP listener. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `ProcessedPackets`                           | The total number of packets processed by the load balancer. This count includes traffic to and from targets, as well as health check traffic. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `TCP_Client_Reset_Count`                           | The total number of reset (RST) packets sent from clients to targets. These resets are generated by clients and then forwarded by the load balancer. **Reporting Standard**: Always reported. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `TCP_ELB_Reset_Count`                           | The total number of reset (RST) packets generated by the load balancer. **Reporting Standard**: Always reported. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `TCP_Target_Reset_Count`                           | The total number of reset (RST) packets sent from targets to clients. These resets are generated by targets and then forwarded by the load balancer. **Reporting Standard**: Always reported. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |
| `UnhealthyRoutingFlowCount`                           | The number of flows (or connections) routed using the routing failure transfer operation (open when failed). **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`,`AvailabilityZone` `LoadBalancer` |

### Gateway Load Balancer Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :------------------------------------------------------------------ |
| `ActiveFlowCount`                           | The total number of concurrent flows (or connections) from clients to targets. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistics are Average, Maximum, and Minimum. **Dimensions**: `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ConsumedLCUs`                           | The number of load balancer capacity units (LCUs) used by the load balancer. You pay for the number of LCUs used per hour. **Reporting Standard**: Always reported. **Statistics**: All. **Dimensions**: `LoadBalancer` |
| `HealthyHostCount`                           | The number of targets considered healthy. **Reporting Standard**: Reported when health checks are enabled. **Statistics**: Most useful statistics are Maximum and Minimum. **Dimensions**: `LoadBalancer``TargetGroup`,`AvailabilityZone``LoadBalancer``TargetGroup` |
| `NewFlowCount`                           | The total number of new flows (or connections) established from clients to targets during the period. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `ProcessedBytes`                           | The total number of bytes processed by the load balancer. This count includes traffic to and from targets, excluding health check traffic. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `UnHealthyHostCount`                           | The number of targets considered unhealthy. **Reporting Standard**: Reported when health checks are enabled. **Statistics**: Most useful statistics are Maximum and Minimum. **Dimensions**: `LoadBalancer``TargetGroup`,`AvailabilityZone``LoadBalancer``TargetGroup` |

### Classic Load Balancer Metrics

| Metric                                                         | Description                                                         |
| :----------------------------------------------------------- | :------------------------------------------------------------------ |
| `BackendConnectionErrors`                                    | The number of times connections between the load balancer and registered instances fail to establish successfully. Since the load balancer retries connections when errors occur, this count may exceed the request rate. Note that this count also includes all connection errors related to health checks. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Sum. Note that Average, Minimum, and Maximum are reported for each load balancer node and generally are not useful. However, the difference between the minimum and maximum (or peak to average, average to valley) can be used to determine if there are anomalies in the load balancer nodes. **Example**: Assume your load balancer has 2 instances each in us-west-2a and us-west-2b, and connection attempts to 1 instance in us-west-2a result in backend connection errors. The sum value for us-west-2a includes these connection errors, while the sum value for us-west-2b does not. Therefore, the sum value for the load balancer equals the sum value for us-west-2a. |
| `DesyncMitigationMode_NonCompliant_Request_Count`            | [HTTP Listener] The number of requests that do not comply with RFC 7230 standards. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer``AvailabilityZone`, `LoadBalancer` |
| `HealthyHostCount`                                           | The number of healthy instances registered with the load balancer. Newly registered instances are considered healthy after passing the first health check. If cross-AZ load balancing is enabled, the number of healthy instances is calculated across all AZs for the LoadBalancerName dimension. Otherwise, it is calculated for each AZ. **Reporting Standard**: Registered instances. **Statistics**: Most useful statistics are Average and Maximum. These statistics are determined by the load balancer nodes. Note that some load balancer nodes may temporarily consider an instance unhealthy while others consider it healthy. **Example**: Assume your load balancer has 2 instances each in us-west-2a and us-west-2b, and 1 instance in us-west-2a is unhealthy, while us-west-2b has no unhealthy instances. For the AvailabilityZone dimension, us-west-2a averages 1 healthy and 1 unhealthy instance, and us-west-2b averages 2 healthy and 0 unhealthy instances. |
| `HTTPCode_Backend_2XX, HTTPCode_Backend_3XX, HTTPCode_Backend_4XX, HTTPCode_Backend_5XX` | [HTTP Listener] The number of HTTP response codes generated by registered instances. This count does not include any response codes generated by the load balancer. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Sum. Note that Minimum, Maximum, and Average are all 1. **Example**: Assume your load balancer has 2 instances each in us-west-2a and us-west-2b, and requests sent to 1 instance in us-west-2a result in an HTTP 500 response. The sum value for us-west-2a includes these error responses, while the sum value for us-west-2b does not. Therefore, the sum value for the load balancer equals the sum value for us-west-2a. |
| `HTTPCode_ELB_4XX`                                           | [HTTP Listener] The number of HTTP 4XX client error codes generated by the load balancer. Client errors are generated if the request format is incorrect or incomplete. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Sum. Note that Minimum, Maximum, and Average are all 1. **Example**: Assume your load balancer is enabled in us-west-2a and us-west-2b, and client requests contain malformed request URLs. This may result in increased client errors in all AZs. The sum value for the load balancer is the sum of the values for each AZ. |
| `HTTPCode_ELB_5XX`                                           | [HTTP Listener] The number of HTTP 5XX server error codes generated by the load balancer. This count does not include any response codes generated by registered instances. This metric is reported if there are no healthy instances registered with the load balancer, or if the request rate exceeds the capacity of the instances or the load balancer (overflow). **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Sum. Note that Minimum, Maximum, and Average are all 1. **Example**: Assume your load balancer is enabled in us-west-2a and us-west-2b, and instances in us-west-2a have high latency and respond slowly to requests. As a result, the surge queue for us-west-2a fills up, and clients receive 503 errors. If us-west-2b continues to respond normally, the sum value for the load balancer will equal the sum value for us-west-2a. |
| `Latency`                                                    | [HTTP Listener] The total time (in seconds) taken from the load balancer sending a request to a registered instance to the instance starting to send response headers. [TCP Listener] The total time (in seconds) taken by the load balancer to successfully establish a connection with a registered instance. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Average. Maximum can be used to determine if certain requests take much longer than the average time. Note that Minimum is generally not useful. **Example**: Assume your load balancer has 2 instances each in us-west-2a and us-west-2b, and requests sent to 1 instance in us-west-2a have high latency. The average value for us-west-2a will be higher than the average value for us-west-2b. |
| `RequestCount`                                               | The number of requests completed or connections issued during the specified time period (1 or 5 minutes). [HTTP Listener] The number of requests received and routed, including HTTP error responses from registered instances. [TCP Listener] The number of connections issued to registered instances. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Sum. Note that Minimum, Maximum, and Average all return 1. **Example**: Assume your load balancer has 2 instances each in us-west-2a and us-west-2b, and 100 requests are sent to the load balancer. 60 requests are sent to us-west-2a, with each instance receiving 30 requests, and 40 requests are sent to us-west-2b, with each instance receiving 20 requests. For the AvailabilityZone dimension, us-west-2a has a total of 60 requests, and us-west-2b has a total of 40 requests. For the LoadBalancerName dimension, there is a total of 100 requests. |
| `SpilloverCount`                                             | The total number of requests rejected due to the surge queue filling up. [HTTP Listener] The load balancer returns an HTTP 503 error code. [TCP Listener] The load balancer closes the connection. **Reporting Standard**: Non-zero values reported. **Statistics**: Most useful statistic is Sum. Note that Average, Minimum, and Maximum are reported for each load balancer node and generally are not useful. **Example**: Assume your load balancer is enabled in us-west-2a and us-west-2b, and instances in us-west-2a have high latency and respond slowly to requests. As a result, the surge queue for us-west-2a fills up, leading to overflow. If us-west-2b continues to respond normally, the sum value for the load balancer will be the same as the sum value for us-west-2a. |
| `SurgeQueueLength`                                           | The total number of requests (HTTP Listener) or connections (TCP Listener) waiting to be routed to healthy instances. The maximum queue size is 1024. After the queue fills up, additional requests or connections will be rejected. For more information, see SpilloverCount. **Reporting Standard**: Non-zero values reported. **Statistics**: The most valuable statistic is Maximum, as it represents the peak of queued requests. Using Average statistics along with Minimum and Maximum can determine the range of queued requests. Note that Sum is not useful. **Example**: Assume your load balancer is enabled in us-west-2a and us-west-2b, and instances in us-west-2a have high latency and respond slowly to requests. As a result, the surge queue for us-west-2a fills up, likely increasing the client response time. If this situation persists, the load balancer may overflow (see SpilloverCount metric). If us-west-2b continues to respond normally, the max for the load balancer will be the same as the max for us-west-2a. |
| `UnHealthyHostCount`                                         | The number of unhealthy instances registered with the load balancer. An instance is considered unhealthy if it exceeds the unhealthy threshold configured for health checks. Unhealthy instances are reclassified as healthy after meeting the good threshold configured for health checks. **Reporting Standard**: Registered instances. **Statistics**: Most useful statistics are Average and Minimum. These statistics are determined by the load balancer nodes. Note that some load balancer nodes may temporarily consider an instance unhealthy while others consider it healthy. **Example**: See HealthyHostCount. |

### Load Balancer Metric Dimensions

To filter metrics for Application / Network / Gateway load balancers, use the following dimensions.

| Dimension               | Description                                                         |
|| :----------------- | :------------------------------------------------------------------ |
| `AvailabilityZone` | Filter metric data by availability zone.                                       |
| `LoadBalancer`     | Filter metric data by load balancer. Specify the load balancer as follows: `app/load-balancer-name/1234567890123456` (the ending part of the load balancer ARN). |
| `TargetGroup`      | Filter metric data by target group. Specify the target group as follows: `targetgroup/target-group-name/1234567890123456` (the ending part of the target group ARN). |

To filter metrics for Classic load balancers, use the following dimensions.

| Dimension               | Description                                                        |
| :----------------- | :------------------------------------------------------------------ |
| `AvailabilityZone` | Filter metric data by availability zone.                                       |
| `LoadBalancerName` | Filter metric data by specified load balancer.                              |

## Objects {#object}

The collected AWS ELB object data structure can be viewed in "Infrastructure - Custom."

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

> *Note: Fields in `tags` and `fields` may change with subsequent updates.*
>
> > Tip 1: AWS ELB Metrics are divided into four types based on the type of load balancer:
> >
> > 1. Application ELB corresponds to the metric set `aws_aelb`
> > 2. Network ELB corresponds to the metric set `aws_nelb`
> > 3. Gateway ELB corresponds to the metric set `aws_gelb`
> > 4. Classic ELB corresponds to the metric set `aws_elb`
> >
> > Tip 2: The value of `tags.name` is determined in two ways:
> >
> > 1. For Classic Load Balancers, take the `LoadBalancerName` field.
> > 2. For Application, Network, and Gateway Load Balancers, extract the ending part of the load balancer ARN (`LoadBalancerArn`).
> >
> > Example for Network Load Balancer:
> >
> > ```txt
> > `LoadBalancerArn` is `arn:awS-cn:elasticloadbalancing:cn-northwest-1:xxxx1335135:loadbalancer/net/k8s-forethou-kodongin-xxxxa46f01/xxxxe75ae81d08c2`
> > ```
> >
> > Corresponding `tags.name` is `net/k8s-forethou-kodongin-xxxxa46f01/xxxxe75ae81d08c2`
> >
> > Tip 3:
> >
> > - `fields.message`, `tags.AvailabilityZones` are serialized JSON characters
> > - The `tags.state` field indicates the state of the Load Balancers, values: `active`, `provisioning`, `active_impaired`, `failed` ("classic" type load balancer instances do not have this field)
> > - The `tags.Type` field indicates the type of Load Balancers, values: `application`, `network`, `gateway`, `classic`
> > - The `tags.Scheme` field indicates the scheme of Load Balancers, values: `internet-facing`, `internal`
> > - The `fields.ListenerDescriptions` field represents the listener list for the load balancer
> > - The `fields.AvailabilityZones` field represents the associated Amazon Route 53 availability zone information for the load balancer