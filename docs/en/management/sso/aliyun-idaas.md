# Alibaba Cloud IDaaS SSO
---


## Use Case


IDaaS (Alibaba Cloud IDentity as a Service) is a provider of identification and access management solutions. Guance supports federated authentication based on SAML 2.0 (Security Assertion Markup Language 2.0), an open standard used by many identity authentication providers (IdP). You can integrate IDaaS with Guance through SAML 2.0-based federation authentication, so that IDaaS account automatically logs in to the Guance platform to access the corresponding workspace resources, without having to create a separate Guance account for the enterprise/team.

## Setup

**Note**: Before creating the application, you need to register your account and create your organization at [IDaaS](https://yundun.console.aliyun.com/).

:material-numeric-1-circle: Create Applications


#### 1) Enter the IDaaS console > Add Applications-Standard Protocol" and select Create SSO Applications for SAML 2.0. (Take the guance application as an example here)

![](../img/06_aliyun_01.png)<br />![](../img/06_aliyun_02.png)

#### 2) After creating the application, click "Management" to enter the application configuration interface. Before configuring single sign-on, you can match the application account and authorization first.

① Add application account<br />![](../img/06_aliyun_03.png)<br />![](../img/06_aliyun_04.png)<br />② This example is authorized to be accessed by all employees by default. If you need special authorization, you can click "Authorization" to change the permission configuration.<br />![](../img/06_aliyun_05.png)



#### 3) After configuring the application account and authorization, click to enter the "SSO" page, navigate to the "Application Configuration Information" module, and click "Download" to obtain the IdP metadata file.

![](../img/06_aliyun_06.png)

### 2. Enable SSO in Guance and update the configuration on the IDaaS platform


#### 1）To enable sso single sign-on in Guance workspace, refer to the doc [new SSO](../../management/sso/index.md).

Note: For account security reasons, only one SSO is configured in Guance support workspace. If you have previously configured SAML 2.0, we will regard your last updated SAML 2.0 configuration as the final single sign-on authentication entry by default.<br />![](../img/06_aliyun_07.png)

#### 2）View SSO single sign-on details and download the service provider's Metadata data (you can access the link information through the browser and right-click to save)

Note: When configuring SSO login, it is necessary to add "mailbox domain name" for mailbox domain name mapping between Guance and identity provider (user mailbox domain name should be consistent with mailbox domain name added in Guance) to realize single sign-on.<br />![](../img/06_aliyun_08.png)


#### 3) Update the SSO configuration of the IDaaS side application

① Import the Metadata file of the service provider (SP) obtained in step <br />② Import Metadata and click "parse" to import the ACS URL and Entity ID parameters below<br />③ Change the configuration at "application account" to "IDaaS account/mailbox"<br />④ Click to expand [advanced configuration]. (Note: Assertion signing will be turned on by default in SaaS environment, and this parameter will be turned off by default in PaaS environment. After configuring application information, this parameter needs to be turned on manually.)<br />⑤ Add "Assertion Attribute", Key = "Email", Value = "user.email"<br />⑥ Click Save Configuration<br />![](../img/06_aliyun_09.png)<br />![](../img/06_aliyun_10.png)

### 3. Get the single sign-on address


#### 1) Access Guance through[【SSO】](https://auth.guance.com/login/sso), and enter the email address to get the login link. As shown in the following figure:

![](../img/06_aliyun_11.png)<br />![](../img/06_aliyun_12.png)

#### 2) Click to access the "login address" provided on the SSO login configuration details page. As shown in the following figure:

![](../img/06_aliyun_13.png)


### 4. Click "Link" to jump to IDaaS and enter the user name and password. After verification, you can log in to Guance. After logging in, as shown in the following figure:


#### 1) IDaaS platform enter user name and password to log in.

![](../img/06_aliyun_14.png)

#### 2）After logging in successfully, Guance page is displayed.

Note: If multiple workspaces are configured with the same identity provider SSO single sign-on at the same time, users can click the workspace option in the upper left corner of Guance to switch different workspaces to view data after signing on to the workspace through SSO single sign-on. <br />![](../img/06_aliyun_15.png)



---

