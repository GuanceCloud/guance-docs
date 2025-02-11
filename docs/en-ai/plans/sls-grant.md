# How to Authorize SLS Credentials to a RAM Account

---

## Background

This guide covers the process of creating a RAM account and authorizing it from scratch. If you have already performed these steps before, you can skip them.

## Steps

1. During the registration process for the Guance Exclusive Plan, download the SLS authorization file. Open it and copy the JSON content for backup purposes; this will be used later.

> For details on the registration process, refer to the documentation [Alibaba Cloud Market - Activate Guance Exclusive Plan](../commercial-aliyun-sls.md);

![](../img/1.sls_6.jpeg)

2. Log in to Alibaba Cloud using your main account and complete real-name verification (if no prompt appears, it means verification has already been completed);

3. Click on the avatar in the top-right corner and select **AccessKey Management**;

![](../img/1.RAM.png)

4. Start using the sub-user AccessKey;

![](../img/2.RAM.png)

5. Create an AccessKey;

**Note**: Since the AccessKey Secret can only be viewed once, it is recommended to copy and back it up after creation.

![](../img/3.RAM.png)

6. In **RAM Access Control > Users**, create a RAM user and click to add permissions;

![](../img/4.RAM.png)

7. Click to create a new permission policy;

![](../img/5.RAM.png)

8. Click on script editing and paste the JSON copied in step 1 here;

![](../img/6.RAM.png)

9. Attach this permission policy to the authorization;

![](../img/7.RAM.png)

10. Enable log service for the Alibaba Cloud account;

![](../img/8.RAM.png)