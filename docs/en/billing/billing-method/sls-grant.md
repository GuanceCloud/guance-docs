# How to Use SLS Authorization File to Authorize RAM Account

---

## Previously

The content of this article is to create a RAM account from 0 and authorize it. If you have done relevant operations before, you can skip it.

## Operating Instructions

1.Download the SLS authorization file in the registration process of opening the SLS Exclusive Plan with one click in Guance, and copy the JSON backup after opening, which will be used later. For the launch process, please refer to the doc [Opening Guance Exclusive Plan in the Alibaba Cloud market](../commercial-aliyun-sls.md).

![](../img/1.sls_6.jpeg)

2.Log in to Alibaba Cloud through your main account and perform real-name authentication (if there is no prompt, it means that it has been authenticated).

3.Drop down the avatar in the upper right corner and click AccessKey to manage.

![](../img/1.RAM.png)

4.Start using child user AccessKey

![](../img/2.RAM.png)

5.Create AccessKey

Note: Since AccessKey Secret can only be viewed once, it is recommended to copy it for backup after creation.

![](../img/3.RAM.png)

6.In **RAM Access Control > Users**, create a RAM user and click Add Permissions.

![](../img/4.RAM.png)

7.Click new permission policy.

![](../img/5.RAM.png)

8.Click Script Edit and paste the JSON copied in the first step here.

![](../img/6.RAM.png)

9.Add this permission policy to authorization.

![](../img/7.RAM.png)

10.Open log service for Alibaba Cloud account.

![](../img/8.RAM.png)
