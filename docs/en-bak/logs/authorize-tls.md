# How to use TLS authorization file to authorize lAM account
---

## Background

This guide is for setting up a lAM account from scratch and granting permissions. If you've already done this, you can skip these steps.

## Steps

I. On the Guance page for [binding Volcengine TLS external indices](./multi-index/tls.md), download the authorization file, open it, and copy the JSON backup for later use.

II. Log in to your Volcengine master account and complete real-name verification.

**Note**: If no prompt appears, it means you've already verified.

III. Click on API Access Key under your profile picture in the top right corner.

<img src="../img/api.png" width="60%" >

IV. Click "Create New Key" to create a sub-user.

![](img/new-user.png)

V. Create a user, either by using the current username or by inviting another account.

*Below is an example of creating via username:*

![](img/via-name.png)

VI. Enter the necessary information for the sub-user and click "Next."

**Note:** In the login settings, check "Programmatic Access."

![](img/next.png)

VII. In the permissions settings, do not check any policy; select "Global" for the scope.

![](img/all.png)

VIII. After reviewing and verifying your phone number, you can view the AK and AKS information and download them.

![](img/download.png)

IX. Click on "Policy Management" and create a new custom policy.

![](img/strategy.png)

X. Click the JSON editor, enter the policy name, paste the JSON copied in step I here, and click submit.

![](img/json-tls.png)

XI. After successful submission, click "Add Authorization" to grant this policy to the applied sub-user.

XII. Enable the Log Service for your Volcengine account.

![](img/open.png)
