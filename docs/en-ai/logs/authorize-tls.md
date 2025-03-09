# How to Authorize TLS Credentials to an IAM Account
---

## Background

This guide walks you through creating an IAM account and authorizing it from scratch. If you have already performed these steps before, you can skip them.

## Steps

1. On the <<< custom_key.brand_name >>> [Bind Volcengine TLS External Index](./multi-index/tls.md) page, click to download the authorization file. Open it and copy the JSON content for backup; you will need it later.

2. Log in to your main Volcengine account and complete real-name verification.

**Note**: If no prompt appears, it means you have already completed the verification.

3. Click on the avatar in the top-right corner, then select API Access Key.

![API](../img/api.png)

4. Click Create Key to create a sub-user.

![New User](img/new-user.png)

5. Create a user either by using the current username or inviting other accounts to create one.

*The following image shows creation via username:*

![Via Name](img/via-name.png)

6. After entering the required information for the sub-user, click Next.

**Note**: In the login settings, check "Programmatic Access".

![Next](img/next.png)

7. In the permission settings, do not select any permission policies; choose "Global" for the scope of effect.

![All](img/all.png)

8. After reviewing and verifying your phone number, you can view and download the AK (Access Key ID) and SK (Secret Access Key) information.

![Download](img/download.png)

9. Click Policy Management and create a custom policy.

![Strategy](img/strategy.png)

10. Click JSON Editor, enter the policy name, paste the JSON copied in step 1 here, and click Submit.

![JSON TLS](img/json-tls.png)

11. After successful submission, click Add Authorization to assign this permission policy to the requested sub-user.

12. Enable log service for the Volcengine account.

![Open](img/open.png)