# SSO Management
---

Guance supports SSO management based on SAML protocol, and supports enterprises to manage employee information in local IdP (Identity Provider). Without user synchronization between Guance and enterprise IdP, enterprise employees can log in and access Guance through designated roles. <br />![](../img/SSO.png)

## New SSO

Guance supports users to open SSO based on the workspace. When logging in, users can obtain the corresponding SSO login by entering the company mailbox and realize the corresponding authentication login. In Guance workspace "Admin"-"SSO Admin"-"Enable", you can set SSO for employees.

Note:

- For account security reasons, only one SSO is configured in Guance support workspace. If you have configured SAML 2.0 before, we will regard your last updated SAML 2.0 configuration as the final single sign-on authentication entry by default.
- If multiple workspaces are configured with the same identity provider SSO at the same time, users can click on the workspace option in the upper left corner of Guance to switch different workspaces to view data after signing on to the workspace through SSO.

![](../img/06_sso_1.png)

- Metadata document: XML document provided by IdP (identity provider).
- Mailbox domain name: required. This configuration is used to verify whether the mailbox suffix entered at single sign-on matches, and the matching mailbox can get the login link of SSO online.
- Access role: the system permission role of Guance. At present, only [read-only-member] and [standard-member]are supported here, and the permission is promoted to [administrator]. For details, please refer to the doc [permission management](../../management/access-management.md).
- Remarks: Users can customize the description information added for identity providers.

![](../img/06_sso_2.png)

After completing the above information, click "Confirm" to obtain "Entity ID" and "Assertion Address", and after the corresponding SAML configuration is completed according to the requirements of identity provider IdP.

- Login address: The login address of Guance SSO generated based on metadata documents uploaded by users. One login address has and can only access one workspace.
- Metadata: Metadata document of Guance SSO generated based on Metadata document uploaded by user.
- Entity ID: Response Entity ID of Guance SSO login generated based on metadata document uploaded by user, which is used to identify service provider (SP), such as Guance, at identity provider.
- Assertion address: The response destination address of Guance SSO login generated based on the metadata document uploaded by the user, which is used for single sign-on at the identity provider call.

![](../img/06_sso_3.png)

After obtaining "Entity ID" and "Assertion Address", click "Confirm" to update the configuration, click "Cancel" to return to SSO management, support updating/deleting SSO, and support clicking "Number" of "Member" to view the specific list of authorized single sign-on members.<br />![](../img/06_sso_4.png)

## SSO

After SSO configuration is completed, log in through [Guance official website](https://www.dataflux.cn/) or [Guance studio](https://auth.dataflux.cn/loginpsw), and select "Single Sign-on" on the login page.<br />![](../img/06_sso_5.png)<br />Enter the email address where the SSO is being created and click "Get login address".<br />![](../img/06_sso_6.png)<br />Click the link to open the corporate account login page.<br />![](../img/06_sso_7.png)<br />Enter the enterprise common mailbox and password to log in directly to the workspace corresponding to Guance.<br />Note: If multiple workspaces are configured with the same identity provider SSO at the same time, users can click the workspace option in the upper left corner of Guance to switch different workspaces to view data.<br />![](../img/06_sso_8.png)

## Mail Notification

Enable, configure, and remove SSO, and the owner and administrator of the corresponding workspace will be notified by email.<br />![](../img/06_sso_9.png)

## Audit Events

Enabling, configuring, and deleting SSO will generate audit events.<br />![](../img/06_sso_10.png)<br />In Guance workspace, click "Administration"-"Basic Settings"-"Security-Operational Audit", and click "View" to view all audit events in the current workspace.<br />![](../img/06_sso_11.png)


---
