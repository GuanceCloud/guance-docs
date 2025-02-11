# Alibaba Cloud EventBridge Best Practices

---

This article introduces how to integrate the content of Alibaba Cloud EventBridge into the Guance platform, leveraging Guance's powerful unified aggregation capabilities to easily obtain Alibaba Cloud events and track real-time data information.

## Background Information 

EventBridge is a serverless event bus service provided by Alibaba Cloud. It supports Alibaba Cloud services, custom applications, and SaaS applications to connect in a standardized and centralized manner, routing events between these applications using the standardized CloudEvents 1.0 protocol. This helps you easily build loosely coupled, distributed event-driven architectures. However, for multi-cloud environments or traditional IDC + cloud service combinations, customers often hope to unify and comprehensively manage cloud events, Metrics, logs, traces, etc., for integrated scheduling. The Guance platform provides such capabilities.

## Prerequisites

You have completed the following operations:

- Installed DataKit; for detailed steps, refer to [Host Installation of DataKit](../../datakit/datakit-install.md)
- Enabled Alibaba Cloud EventBridge (currently free during the public beta period)
- Allowed port 9529 in the server security group

## Applicable Scenarios

By using the built-in HTTP service of the event bus, push event information to Guance.

#### Step One: Modify DataKit Listening Port

1. Edit the main configuration file of the server DataKit `/usr/local/datakit/conf.d/datakit.conf`

```shell
[http_api]
  listen = "0.0.0.0:9529"
```

2. Restart DataKit
```shell
systemctl restart datakit
```

#### Step Two: Create an EventBridge Rule

1. Log in to the [Alibaba Cloud EventBridge Console](https://eventbridge.console.aliyun.com/overview)

2. Select **EventBus** - **default** - **Event Rules**

![image.png](../images/aliyun-eventbridge-1.png)

3. Create a rule, configure basic information, enter a name and description, then click **Next**

![image.png](../images/aliyun-eventbridge-2.png)

4. Configure the event pattern, select **Alibaba Cloud Official Event Source**, choose the desired **Event Source** and **Event Type**

![image.png](../images/aliyun-eventbridge-3.png)

5. After selection, you can test the event pattern through debugging, then click **Next**

![image.png](../images/aliyun-eventbridge-4.png)

6. Configure the event target, set **Service Type** to `HTTP`, **URL** to `DataKit Logging API Address`, and **Body** to `Template`

![image.png](../images/aliyun-eventbridge-5.png)

7. When **Body** is set to `Template`, define the variables and custom template as per [Alibaba Cloud Template Documentation](https://help.aliyun.com/document_detail/181429.html#section-tdd-mia-lol)

- Variables: Extract parameters from the original cloud event data using JSONPath with "$."
- Templates: Reference variables using "${}", which must conform to the [DataKit API Specification](../../datakit/apis.md#api-logging-example)

![image.png](../images/aliyun-eventbridge-6.png)

8. Set **Network Type** to `Public`, then click **Confirm**

![image.png](../images/aliyun-eventbridge-7.png)

9. Log in to Guance, go to the **Logs** module to view the generated events

- measurement: data source
- message: log content
- fields: extended fields

![image.png](../images/aliyun-eventbridge-8.png)

#### Data Validation

- Event Tracking > Event Details, check the original cloud event data

![image.png](../images/aliyun-eventbridge-9.png)

![image.png](../images/aliyun-eventbridge-10.png)

- Event Tracking > Event Trace, verify if the event was delivered successfully

![image.png](../images/aliyun-eventbridge-11.png)

![image.png](../images/aliyun-eventbridge-12.png)

- Check the data reception status on the server at `/var/log/datakit/gin.log`

![image.png](../images/aliyun-eventbridge-13.png)

## Related Documents

[Alibaba Cloud EventBridge Product Overview](https://help.aliyun.com/document_detail/163239.html)

[Guance DataKit API Development Documentation](../../datakit/apis.md)