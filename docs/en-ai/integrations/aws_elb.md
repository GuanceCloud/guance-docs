---
title: 'AWS ELB'
tags: 
  - AWS
summary: 'Use the script packages in the Script Market of Guance Cloud Sync series to synchronize cloud monitoring and cloud asset data to Guance'
__int_icon: 'icon/aws_elb'

dashboard:
  - desc: 'Built-in View for AWS Application ELB'
    path: 'dashboard/en/aws_application_elb'
  - desc: 'Built-in View for AWS Network ELB'
    path: 'dashboard/en/aws_network_elb'

monitor:
  - desc: 'AWS Application ELB Monitor'
    path: 'monitor/en/aws_application_elb'
  - desc: 'AWS Network ELB Monitor'
    path: 'monitor/en/aws_network_elb'

---

<!-- markdownlint-disable MD025 -->
# AWS ELB
<!-- markdownlint-enable -->

Use the script packages in the Script Market of Guance Cloud Sync series to synchronize cloud monitoring and cloud asset data to Guance


## Configuration {#config}

### Install Func

It is recommended to enable the Guance integration - extension - DataFlux Func (Automata): all prerequisites are automatically installed, please continue with the script installation

If you deploy Func yourself, refer to [Self-deployed Func](https://func.guance.com/doc/script-market-guance-integration/){:target="_blank"}


### Install Script

> Note: Please prepare an Amazon Cloud AK that meets the requirements in advance (for simplicity, you can directly grant read-only permission for CloudWatch `CloudWatchReadOnlyAccess`)

To synchronize the monitoring data of ECS cloud resources, we install the corresponding collection scripts:

For AWS Application Load Balancer (AWS Application ELB), select "Guance Integration (AWS-ApplicationELB Collection)" (ID: `guance_aws_applicationelb`)

For AWS Network Load Balancer (AWS Network ELB), select "Guance Integration (AWS-NetworkELB Collection)" (ID: `guance_aws_networkelb`)

For AWS Gateway Load Balancer (AWS Gateway ELB), select "Guance Integration (AWS-GatewayELB Collection)" (ID: `guance_aws_gatewayelb`)

For AWS Classic Load Balancer, select "Guance Integration (AWS-ELB Collection)" (ID: `guance_aws_elb`)

After clicking 【Install】, enter the corresponding parameters: Amazon Cloud AK, Amazon Cloud account name.

Click 【Deploy Startup Script】. The system will automatically create a `Startup` script set and configure the corresponding startup script. In the startup script, ensure that 'regions' matches the actual regions where the ELB is located.

Once enabled, you can see the corresponding automatic trigger configuration in "Manage / Automatic Trigger Configuration". Click 【Execute】 to run it immediately without waiting for the scheduled time. After a short while, you can view the execution task records and corresponding logs.

> If you need to collect corresponding logs, you also need to enable the log collection script. If you need to collect billing information, you need to enable the cloud billing collection script.


We default to collecting some configurations, see [Custom Cloud Object Metrics Configuration](https://func.guance.com/doc/script-market-guance-aws-cloudwatch/){:target="_blank"}


### Verification

1. Confirm in "Manage / Automatic Trigger Configuration" whether the corresponding tasks have the corresponding automatic trigger configuration, and check the corresponding task records and logs for any abnormalities.
2. In the Guance platform, under "Infrastructure / Custom", check if there is any asset information.
3. In the Guance platform, under "Metrics", check if there is any corresponding monitoring data.

## Metrics {#metric}
After configuring Amazon Cloud Monitoring, the default metric sets are as follows. You can collect more metrics through configuration:

[Amazon Cloud Monitoring Application Load Balancer Metrics Details](https://docs.aws.amazon.com/en_us/elasticloadbalancing/latest/application/load-balancer-cloudwatch-metrics.html){:target="_blank"}

[Amazon Cloud Monitoring Network Load Balancer Metrics Details](https://docs.aws.amazon.com/en_us/elasticloadbalancing/latest/network/load-balancer-cloudwatch-metrics.html){:target="_blank"}

[Amazon Cloud Monitoring Gateway Load Balancer Metrics Details](https://docs.aws.amazon.com/en_us/elasticloadbalancing/latest/gateway/cloudwatch-metrics.html){:target="_blank"}

[Amazon Cloud Monitoring Classic Load Balancer Metrics Details](https://docs.aws.amazon.com/en_us/elasticloadbalancing/latest/classic/elb-cloudwatch-metrics.html){:target="_blank"}

### Application Load Balancer Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :-------------------------------------------------------------------|
| `ActiveConnectionCount`                           | Total number of concurrent active TCP connections from clients to the load balancer and from the load balancer to targets. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ClientTLSNegotiationErrorCount`                  | Number of TLS connections initiated by clients that failed to establish a session with the load balancer due to TLS errors. Possible causes include mismatched ciphers or protocols or the client closing the connection because it could not verify the server's certificate. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ConsumedLCUs`                                    | Number of load balancer capacity units (LCU) used by the load balancer. You pay for the number of LCUs used per hour. For more information, see [Elastic Load Balancing Pricing](http://aws.amazon.com/elasticloadbalancing/pricing/){:target="_blank"}. **Reporting Standard**: Always report **Statistics**: All dimensions `LoadBalancer` |
| `DesyncMitigationMode_NonCompliant_Request_Count` | Number of requests that do not comply with RFC 7230. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `DroppedInvalidHeaderRequestCount`                | Number of HTTP headers with invalid header fields that were removed by the load balancer before routing the request. The load balancer only removes these headers when the `routing.http.drop_invalid_header_fields.enabled` attribute is set to `true`. **Reporting Standard**: Report non-zero values **Statistics**: All dimensions `AvailabilityZone`, `LoadBalancer` |
| `ForwardedInvalidHeaderRequestCount`              | Number of HTTP headers with invalid HTTP header fields that were routed by the load balancer. The load balancer only forwards these headers when the `routing.http.drop_invalid_header_fields.enabled` attribute is set to `false`. **Reporting Standard**: Always report **Statistics**: All dimensions `AvailabilityZone`, `LoadBalancer` |
| `GrpcRequestCount`                                | Number of gRPC requests processed via IPv4 and IPv6. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistics are `Sum`. `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTP_Fixed_Response_Count`                       | Number of successful fixed response operations. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTP_Redirect_Count`                             | Number of successful redirect operations. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTP_Redirect_Url_Limit_Exceeded_Count`          | Number of redirect operations that could not be completed because the URL in the response location header was greater than 8K. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_3XX_Count`                          | Number of HTTP 3XX redirect codes generated by the load balancer. This count does not include response codes generated by targets. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_4XX_Count`                          | Number of HTTP 4XX client error codes generated by the load balancer. This count does not include response codes generated by targets. If the request format is incorrect or incomplete, client errors are generated. Except for situations where the load balancer returns an [HTTP 460 error code](https://docs.aws.amazon.com/en_us/elasticloadbalancing/latest/application/load-balancer-troubleshooting.html#http-460-issues){:target="_blank"}, targets do not receive these requests. This count does not include any response codes generated by targets. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistics are `Sum`. `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_5XX_Count`                          | Number of HTTP 5XX server error codes generated by the load balancer. This count does not include any response codes generated by targets. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistics are `Sum`. `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_500_Count`                          | Number of HTTP 500 error codes generated by the load balancer. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_502_Count`                          | Number of HTTP 502 error codes generated by the load balancer. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_503_Count`                          | Number of HTTP 503 error codes generated by the load balancer. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HTTPCode_ELB_504_Count`                          | Number of HTTP 504 error codes generated by the load balancer. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `IPv6ProcessedBytes`                              | Total number of bytes processed by the load balancer via IPv6. This count is included in `ProcessedBytes`. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `IPv6RequestCount`                                | Number of IPv6 requests received by the load balancer. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistics are `Sum`. `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `NewConnectionCount`                              | Total number of new TCP connections established from clients to the load balancer and from the load balancer to targets. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `NonStickyRequestCount`                           | Number of requests selected by the load balancer to choose a new target because it cannot use existing sticky sessions. For example, the request is the first request from a new client and no sticky cookie is provided, a sticky cookie is provided but does not specify a registered target in this target group, the sticky cookie is malformed or expired, or an internal error prevents the load balancer from reading the sticky cookie. **Reporting Standard**: Sticky is enabled on the target group. **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ProcessedBytes`                                  | Total number of bytes processed by the load balancer via IPv4 and IPv6 (HTTP headers and HTTP payloads). This count includes traffic to and from clients and Lambda functions, as well as traffic from identity providers (IdP) if user authentication is enabled. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `RejectedConnectionCount`                         | Number of connections rejected due to the load balancer reaching its connection limit. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `RequestCount`                                    | Number of requests processed via IPv4 and IPv6. This metric only increments for requests where the load balancer node can select a target. Requests rejected before selecting a target are not reflected in this metric. **Reporting Standard**: Always report **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `TargetGroup`, `LoadBalancer` |
| `RuleEvaluations`                                 | Number of rules processed by the load balancer given an average request rate over 1 hour. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer` |



The `AWS/ApplicationELB` namespace includes the following metrics for targets.

| Metric                                                         | Description                                                         |
| :----------------------------------------------------------- | :-------------------------------------------------------------------|
| `HealthyHostCount`                                           | Number of targets considered healthy. **Reporting Standard**: Reported when health checks are enabled **Statistics**: Most useful statistics are `Average`, `Minimum`, and `Maximum`. Dimensions `TargetGroup`, `LoadBalancer`, `TargetGroup`, `AvailabilityZone`, `LoadBalancer`, `AvailabilityZone`, `TargetGroup`, `LoadBalancer` |
| `HTTPCode_Target_2XX_Count`, `HTTPCode_Target_3XX_Count`, `HTTPCode_Target_4XX_Count`, `HTTPCode_Target_5XX_Count` | Number of HTTP response codes generated by targets. It does not include any response codes generated by the load balancer. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistic is `Sum`. `Minimum`, `Maximum`, and `Average` all return 1. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer`, `TargetGroup`, `LoadBalancer`, `TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `RequestCountPerTarget`                                      | Average number of requests received by each target in the target group. You must specify the target group using the `TargetGroup` dimension. If the target is a Lambda function, this metric does not apply. **Reporting Standard**: Always report **Statistics**: Only valid statistic is `Sum`. This represents the average, not the sum. Dimensions `TargetGroup`, `AvailabilityZone`, `TargetGroup`, `LoadBalancer` |
| `TargetConnectionErrorCount`                                 | Number of times the load balancer failed to establish a connection with the target. If the target is a Lambda function, this metric does not apply. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer`, `TargetGroup`, `LoadBalancer`, `TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `TargetResponseTime`                                         | Time taken for the request to leave the load balancer until a response is received from the target (in seconds). This is equivalent to the `target_processing_time` field in access logs. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistics are `Average` and `pNN.NN` (percentile). Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer`, `TargetGroup`, `LoadBalancer`, `TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `TargetTLSNegotiationErrorCount`                             | Number of TLS connections initiated by the load balancer that failed to establish a session with the target. Possible causes include mismatched ciphers or protocols. If the target is a Lambda function, this metric does not apply. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer`, `TargetGroup`, `LoadBalancer`, `TargetGroup`, `AvailabilityZone`, `LoadBalancer` |
| `UnHealthyHostCount`                                         | Number of targets considered unhealthy. **Reporting Standard**: Reported when health checks are enabled **Statistics**: Most useful statistics are `Average`, `Minimum`, and `Maximum`. Dimensions `TargetGroup`, `LoadBalancer`, `TargetGroup`, `AvailabilityZone`, `LoadBalancer`, `AvailabilityZone`, `TargetGroup`, `LoadBalancer` |



The `AWS/ApplicationELB` namespace includes the following metrics for target group health. For more information, see [Target Group Health](https://docs.aws.amazon.com/en_us/elasticloadbalancing/latest/application/target-group-health.html){:target="_blank"}.

| Metric                           | Description                                                         |
| :----------------------------- | :-------------------------------------------------------------------|
| `HealthyStateDNS`              | Number of zones that meet DNS health requirements. **Statistics**: Most useful statistic is `Min`. Dimensions `LoadBalancer`, `TargetGroup`, `AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `HealthyStateRouting`          | Number of zones that meet routing health requirements. **Statistics**: Most useful statistic is `Min`. Dimensions `LoadBalancer`, `TargetGroup`, `AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `UnhealthyRoutingRequestCount` | Number of requests routed using routing failure transfer operations (fail open). **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `TargetGroup`, `AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `UnhealthyStateDNS`            | Number of zones that do not meet DNS health requirements and are marked as unhealthy in DNS. **Statistics**: Most useful statistic is `Min`. Dimensions `LoadBalancer`, `TargetGroup`, `AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `UnhealthyStateRouting`        | Number of zones that do not meet routing health requirements and therefore the load balancer routes traffic to all targets in the zone (including unhealthy targets). **Statistics**: Most useful statistic is `Min`. Dimensions `LoadBalancer`, `TargetGroup`, `AvailabilityZone`, `LoadBalancer`, `TargetGroup` |



The `AWS/ApplicationELB` namespace includes the following metrics for Lambda functions registered as targets.

| Metric                         | Description                                                         |
| :--------------------------- | :-------------------------------------------------------------------|
| `LambdaInternalError`        | Number of failed requests to the Lambda function due to issues with the load balancer or AWS Lambda. To get the error reason code, see the error_reason field in the access logs. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `TargetGroup`, `TargetGroup`, `LoadBalancer` |
| `LambdaTargetProcessedBytes` | Total number of bytes processed by the load balancer for requests to and responses from the Lambda function. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer` |
| `LambdaUserError`            | Number of failed requests to the Lambda function due to issues with the Lambda function itself. For example, the load balancer does not have permission to invoke the function, the load balancer receives malformed JSON or missing required fields from the function, or the request body or response size exceeds the maximum size of 1 MB. To get the error reason code, see the error_reason field in the access logs. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `TargetGroup`, `TargetGroup`, `LoadBalancer` |

The `AWS/ApplicationELB` namespace includes the following metrics for user authentication.

| Metric                            | Description                                                         |
| :------------------------------ | :-------------------------------------------------------------------|
| `ELBAuthError`                  | Number of times user authentication could not be completed due to misconfiguration of authentication operations, inability of the load balancer to establish a connection with the IdP, or inability of the load balancer to complete the authentication process due to internal errors. To get the error reason code, see the error_reason field in the access logs. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ELBAuthFailure`                | Number of times user authentication could not be completed due to the IdP rejecting user access or multiple uses of the authorization code. To get the error reason code, see the error_reason field in the access logs. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ELBAuthLatency`                | Time (in milliseconds) taken to query the ID token and user information from the IdP. If any of these operations fail, this indicates the failure time. **Reporting Standard**: Report non-zero values **Statistics**: All statistics are meaningful. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ELBAuthRefreshTokenSuccess`    | Number of times the load balancer successfully refreshed user claims using the refresh token provided by the IdP. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ELBAuthSuccess`                | Number of successful authentication operations. This metric increments when the load balancer retrieves user claims from the IdP and completes the verification workflow. **Reporting Standard**: Report non-zero values **Statistics**: Most useful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ELBAuthUserClaimsSizeExceeded` | Number of times the configured IdP returns user claims larger than 11K bytes. **Reporting Standard**: Report non-zero values **Statistics**: Only meaningful statistic is `Sum`. Dimensions `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |

### Network Load Balancer Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :-------------------------------------------------------------------|
| `ActiveFlowCount`                           | Total number of concurrent flows (or connections) from clients to targets. This metric includes connections in SYN_SENT and ESTABLISHED states. TCP connections are not terminated at the load balancer, so a client with an open TCP connection to a target is counted as one flow. **Reporting Standard**: Always report. **Statistics**: Most useful statistics are Average, Maximum, and Minimum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ActiveFlowCount_TCP`                           | Total number of concurrent TCP flows (or connections) from clients to targets. This metric includes connections in SYN_SENT and ESTABLISHED states. TCP connections are not terminated at the load balancer, so a client with an open TCP connection to a target is counted as one flow. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistics are Average, Maximum, and Minimum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ConsumedLCUs`                           | Number of load balancer capacity units (LCU) used by the load balancer. You pay for the number of LCUs used per hour. **Reporting Standard**: Always report. **Statistics**: All. **Dimensions**: `LoadBalancer` |
| `ConsumedLCUs_TCP`                           | Number of load balancer capacity units (LCU) used by the load balancer for TCP. You pay for the number of LCUs used per hour. **Reporting Standard**: Report non-zero values. **Statistics**: All. **Dimensions**: `LoadBalancer` |
| `NewFlowCount`                           | Total number of new flows (or connections) established from clients to targets during the period. **Reporting Standard**: Always report. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `NewFlowCount_TCP`                           | Total number of new TCP flows (or connections) established from clients to targets during the period. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `PeakPacketsPerSecond`                           | Highest average packet rate (packets per second) processed during the sampling window calculated every 10 seconds. This metric includes health check traffic. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Maximum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ProcessedBytes`                           | Total number of bytes processed by the load balancer, including TCP/IP headers. This count includes traffic to and from targets, excluding health check traffic. **Reporting Standard**: Always report. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ProcessedBytes_TCP`                           | Total number of bytes processed by the TCP listener. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ProcessedPackets`                           | Total number of packets processed by the load balancer. This count includes traffic to and from targets and health check traffic. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `TCP_Client_Reset_Count`                           | Total number of reset (RST) packets sent from clients to targets. These resets are generated by clients and then forwarded by the load balancer. **Reporting Standard**: Always report. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `TCP_ELB_Reset_Count`                           | Total number of reset (RST) packets generated by the load balancer. **Reporting Standard**: Always report. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `TCP_Target_Reset_Count`                           | Total number of reset (RST) packets sent from targets to clients. These resets are generated by targets and then forwarded by the load balancer. **Reporting Standard**: Always report. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `UnhealthyRoutingFlowCount`                           | Number of flows (or connections) routed using routing failure transfer operations (fail open). **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |

### Gateway Load Balancer Metrics

| Metric                                              | Description                                                         |
| :------------------------------------------------ | :-------------------------------------------------------------------|
| `ActiveFlowCount`                           | Total number of concurrent flows (or connections) from clients to targets. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistics are Average, Maximum, and Minimum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ConsumedLCUs`                           | Number of load balancer capacity units (LCU) used by the load balancer. You pay for the number of LCUs used per hour. **Reporting Standard**: Always report. **Statistics**: All. **Dimensions**: `LoadBalancer` |
| `HealthyHostCount`                           | Number of targets considered healthy. **Reporting Standard**: Reported when health checks are enabled. **Statistics**: Most useful statistics are Maximum and Minimum. **Dimensions**: `LoadBalancer`, `TargetGroup`, `AvailabilityZone`, `LoadBalancer`, `TargetGroup` |
| `NewFlowCount`                           | Total number of new flows (or connections) established from clients to targets during the period. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `ProcessedBytes`                           | Total number of bytes processed by the load balancer. This count includes traffic to and from targets but excludes health check traffic. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `UnHealthyHostCount`                           | Number of targets considered unhealthy. **Reporting Standard**: Reported when health checks are enabled. **Statistics**: Most useful statistics are Maximum and Minimum. **Dimensions**: `LoadBalancer`, `TargetGroup`, `AvailabilityZone`, `LoadBalancer`, `TargetGroup` |

### Classic Load Balancer Metrics

| Metric                                                         | Description                                                         |
| :----------------------------------------------------------- | :-------------------------------------------------------------------|
| `BackendConnectionErrors`                                    | Number of times the load balancer failed to establish a connection with registered instances. Since the load balancer retries connections when errors occur, this count may exceed the request rate. Note that this count also includes all connection errors related to health checks. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Sum. Note that Average, Minimum, and Maximum are reported per load balancer node and are generally not useful. However, the difference between minimum and maximum (or peak-to-average, average-to-trough) can be used to determine if there are anomalies among load balancer nodes. **Example**: Suppose your load balancer has two instances in us-west-2a and two instances in us-west-2b, and connection attempts to one instance in us-west-2a result in backend connection errors. The sum value for us-west-2a includes these connection errors, while the sum value for us-west-2b does not. Therefore, the sum value for the load balancer equals the sum value for us-west-2a. |
| `DesyncMitigationMode_NonCompliant_Request_Count`            | [HTTP Listener] Number of requests that do not comply with RFC 7230. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Sum. **Dimensions**: `LoadBalancer`, `AvailabilityZone`, `LoadBalancer` |
| `HealthyHostCount`                                           | Number of healthy instances registered with the load balancer. New instances are considered healthy after passing their first health check. If cross-zone load balancing is enabled, the number of healthy instances is calculated across all availability zones for the LoadBalancerName dimension. Otherwise, it is calculated for each availability zone. **Reporting Standard**: Report when instances are registered. **Statistics**: Most useful statistics are Average and Maximum. These statistics are determined by load balancer nodes. Note that some load balancer nodes may temporarily consider an instance unhealthy while others consider it healthy. **Example**: Suppose your load balancer has two instances in us-west-2a and two instances in us-west-2b, and one instance in us-west-2a is unhealthy, while none in us-west-2b are unhealthy. For the AvailabilityZone dimension, us-west-2a averages 1 healthy and 1 unhealthy instance, while us-west-2b averages 2 healthy and 0 unhealthy instances. |
| `HTTPCode_Backend_2XX, HTTPCode_Backend_3XX, HTTPCode_Backend_4XX, HTTPCode_Backend_5XX` | [HTTP Listener] Number of HTTP response codes generated by registered instances. This count does not include any response codes generated by the load balancer. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Sum. Note that Minimum, Maximum, and Average are all 1. **Example**: Suppose your load balancer has two instances in us-west-2a and two instances in us-west-2b, and a request sent to one instance in us-west-2a results in an HTTP 500 response. The sum value for us-west-2a includes these error responses, while the sum value for us-west-2b does not. Therefore, the sum value for the load balancer equals the sum value for us-west-2a. |
| `HTTPCode_ELB_4XX`                                           | [HTTP Listener] Number of HTTP 4XX client error codes generated by the load balancer. Client errors are generated if the request format is incorrect or incomplete. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Sum. Note that Minimum, Maximum, and Average are all 1. **Example**: Suppose your load balancer is enabled in us-west-2a and us-west-2b, and a client request contains a malformed request URL. This may lead to an increase in client errors in all availability zones. The sum value for the load balancer is the total of the values from all availability zones. |
| `HTTPCode_ELB_5XX`                                           | [HTTP Listener] Number of HTTP 5XX server error codes generated by the load balancer. This count does not include any response codes generated by registered instances. If there are no healthy instances registered with the load balancer or the request rate exceeds the capacity of the instances or the load balancer (overflow), this metric is reported. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Sum. Note that Minimum, Maximum, and Average are all 1. **Example**: Suppose your load balancer is enabled in us-west-2a and us-west-2b, and instances in us-west-2a have high latency and respond slowly to requests. As a result, the surge queue of the load balancer nodes in us-west-2a fills up, and clients receive 503 errors. If us-west-2b continues to respond normally, the sum value for the load balancer equals the sum value for us-west-2a. |
| `Latency`                                                    | [HTTP Listener] Total time (in seconds) from when the load balancer sends a request to a registered instance until the instance starts sending response headers. [TCP Listener] Total time (in seconds) the load balancer takes to successfully establish a connection with a registered instance. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Average. Maximum can be used to determine if certain requests take significantly longer than the average. Note that Minimum is generally not useful. **Example**: Suppose your load balancer has two instances in us-west-2a and two instances in us-west-2b, and a request sent to one instance in us-west-2a has high latency. The average value for us-west-2a will be higher than the average value for us-west-2b. |
| `RequestCount`                                               | Number of requests completed or connections issued within a specified time period (1 or 5 minutes). [HTTP Listener] Number of requests received and routed, including HTTP error responses from registered instances. [TCP Listener] Number of connections issued to registered instances. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Sum. Note that Minimum, Maximum, and Average all return 1. **Example**: Suppose your load balancer has two instances in us-west-2a and two instances in us-west-2b, and 100 requests are sent to the load balancer. 60 requests are sent to us-west-2a, with each instance receiving 30 requests, and 40 requests are sent to us-west-2b, with each instance receiving 20 requests. For the AvailabilityZone dimension, us-west-2a has a total of 60 requests, and us-west-2b has a total of 40 requests. For the LoadBalancerName dimension, there is a total of 100 requests. |
| `SpilloverCount`                                             | Total number of requests rejected due to the surge queue filling up. [HTTP Listener] The load balancer returns an HTTP 503 error code. [TCP Listener] The load balancer closes connections. **Reporting Standard**: Report non-zero values. **Statistics**: Most useful statistic is Sum. Note that Average, Minimum, and Maximum are reported per load balancer node and are generally not useful. **Example**: Suppose your load balancer is enabled in us-west-2a and us-west-2b, and instances in us-west-2a have high latency and respond slowly to requests. As a result, the surge queue of the load balancer nodes in us-west-2a fills up, leading to overflow. If us-west-2b continues to respond normally, the sum value for the load balancer will be the same as the sum value for us-west-2a. |
| `SurgeQueueLength`                                           | Total number of requests (HTTP listener) or connections (TCP listener) waiting to be routed to healthy instances. The queue's maximum size is 1024. Once the queue is full, additional requests or connections are rejected. For more information, see SpilloverCount. **Reporting Standard**: Report non-zero values. **Statistics**: The most valuable statistic is Maximum, as it represents the peak number of queued requests. Using Average statistics along with Minimum and Maximum can help determine the range of queued requests. Note that Sum is not useful. **Example**: Suppose your load balancer is enabled in us-west-2a and us-west-2b, and instances in us-west-2a have high latency and respond slowly to requests. As a result, the surge queue of the load balancer nodes in us-west-2a fills up, likely increasing the response time for clients. If this condition persists, the load balancer may overflow (see the SpilloverCount metric). If us-west-2b continues to respond normally, the max value for the load balancer will be the same as the max value for us-west-2a. |
| `UnHealthyHostCount`                                         | Number of unhealthy instances registered with the load balancer. If an instance exceeds the unhealthy threshold configured in the health check, it is considered unhealthy. Unhealthy instances are reclassified as healthy once they meet the good threshold configured in the health check. **Reporting Standard**: Report when instances are registered. **Statistics**: Most useful statistics are Average and Minimum. These statistics are determined by load balancer nodes. Note that some load balancer nodes may temporarily consider an instance unhealthy while others consider it healthy. **Example**: See HealthyHostCount. |

### Load Balancer Metric Dimensions

To filter metrics for Application / Network / Gateway load balancers, use the following dimensions.

| Dimension               | Description                                                         |
| :----------------- | :-------------------------------------------------------------------|
| `AvailabilityZone` | Filter metric data by availability zone.                                       |
| `LoadBalancer`     | Filter metric data by load balancer. Specify the load balancer as follows: `app/load-balancer-name/1234567890123456` (the ending part of the load balbalancer ARN).
| `TargetGroup`      | Filter metric data by target group. Specify the target group as follows: `targetgroup/target-group-name/1234567890123456` (the ending part of the target group ARN). |

To filter metrics for Classic load balancers, use the following dimensions.

| Dimension               | Description                                                         |
| :----------------- | :-------------------------------------------------------------------|
| `AvailabilityZone` | Filter metric data by availability zone.                                       |
| `LoadBalancerName` | Filter metric data by the specified load balancer.                              |

## Objects {#object}

The structure of collected AWS ELB object data can be viewed under "Infrastructure - Custom" in Guance.

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

> *Note: The fields in `tags` and `fields` may change with subsequent updates.*
>
> > Tip 1: AWS ELB metric sets differ based on the type of load balancer:
> >
> > 1. Application ELB corresponds to the metric set `aws_aelb`
> > 2. Network ELB corresponds to the metric set `aws_nelb`
> > 3. Gateway ELB corresponds to the metric set `aws_gelb`
> > 4. Classic ELB corresponds to the metric set `aws_elb`
> >
> > Tip 2: The value of `tags.name` is determined in two ways:
> >
> > 1. For Classic Load Balancers, it takes the `LoadBalancerName` field.
> > 2. For Application, Network, and Gateway Load Balancers, it extracts the ending part of the load balancer ARN (`LoadBalancerArn`).
> >
> > Example for a Network Load Balancer:
> >
> > ```txt
> > `LoadBalancerArn` is `arn:awS-cn:elasticloadbalancing:cn-northwest-1:xxxx1335135:loadbalancer/net/k8s-forethou-kodongin-xxxxa46f01/xxxxe75ae81d08c2`
> > ```
> >
> > Corresponding `tags.name` is `net/k8s-forethou-kodongin-xxxxa46f01/xxxxe75ae81d08c2`
> >
> > Tip 3:
> >
> > - `fields.message` and `tags.AvailabilityZones` are JSON serialized strings.
> > - The `tags.state` field indicates the state of the Load Balancers, with possible values: `active`, `provisioning`, `active_impaired`, `failed` (Classic load balancers do not have this field).
> > - The `tags.Type` field indicates the type of Load Balancers, with possible values: `application`, `network`, `gateway`, `classic`.
> > - The `tags.Scheme` field indicates the scheme of Load Balancers, with possible values: `internet-facing`, `internal`.
> > - The `fields.ListenerDescriptions` field contains the list of listeners for the load balancer.
> > - The `fields.AvailabilityZones` field represents Amazon Route 53 availability zone information associated with the load balancer.