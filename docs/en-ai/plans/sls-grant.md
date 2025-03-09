# How to Use SLS Authorization Files to Authorize RAM Accounts

---

## Background

This content covers creating a RAM account and authorizing it from scratch. If you have previously performed these operations, you can skip this section.

## Steps

1. During the registration process for the <<< custom_key.brand_name >>> Exclusive Plan SLS, download the SLS authorization file. Open it and copy the JSON content for backup purposes; you will need it later.

> For more details on the registration process, refer to the documentation [Alibaba Cloud Market Activation of <<< custom_key.brand_name >>> Exclusive Plan](../commercial-aliyun-sls.md);

![](../img/1.sls_6.jpeg)

2. Log in to Alibaba Cloud with your main account and complete real-name verification (if there is no prompt, it means verification has already been completed);

3. Click the dropdown menu next to the profile icon in the top-right corner and select **AccessKey Management**;

![](../img/1.RAM.png)

4. Start using the sub-user AccessKey;

![](../img/2.RAM.png)

5. Create an AccessKey;

**Note**: Since the AccessKey Secret can only be viewed once, it is recommended to copy and back it up after creation.

![](../img/3.RAM.png)

6. Under **RAM Access Control > Users**, create a RAM user and click **Add Permissions**;

![](../img/4.RAM.png)

7. Click **Create Permission Policy**;

![](../img/5.RAM.png)

8. Click **Script Editor** and paste the JSON copied in step one here;

![](../img/6.RAM.png)

9. Add this permission policy to the authorization;

![](../img/7.RAM.png)

10. Enable Log Service for the Alibaba Cloud account;

![](../img/8.RAM.png)