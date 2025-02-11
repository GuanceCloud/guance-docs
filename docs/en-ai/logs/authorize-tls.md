# How to Use TLS Authorization Files for IAM Account Authorization
---

## Background

This guide walks you through creating an IAM account and granting authorization from scratch. If you have already performed these steps previously, you can skip them.

## Steps

1. On the [Guance TLS External Index Binding](./multi-index/tls.md) page, click to download the authorization file. After opening it, copy the JSON content for backup; you will need it later.

2. Log in to your main account on the Volcano Engine platform and complete real-name verification.

**Note**: If no prompt appears, it means that you have already completed the verification.

3. Click the dropdown menu next to your avatar in the top-right corner and select API Access Key.

![API Access](../img/api.png)

4. Click Create New Key to create a sub-user.

![](img/new-user.png)

5. Create a user either by using the current username or inviting another account.

*The following image shows creation via username:*

![](img/via-name.png)

6. After entering the necessary information for the sub-user, click Next.

**Note**: In the login settings, make sure to check "Programmatic Access."

![](img/next.png)

7. In the permission settings, do not select any permission policies; choose "Global" for the scope of effect.

![](img/all.png)

8. After reviewing and verifying your phone number, you can view and download the AK (Access Key) and SK (Secret Key) information.

![](img/download.png)

9. Click Policy Management and create a custom policy.

![](img/strategy.png)

10. Click JSON Editor, enter the policy name, and paste the JSON content copied in step 1 here, then click Submit.

![](img/json-tls.png)

11. After successful submission, click Add Authorization to assign this permission policy to the requested sub-user.

12. Enable the log service for the Volcano Engine account.

![](img/open.png)