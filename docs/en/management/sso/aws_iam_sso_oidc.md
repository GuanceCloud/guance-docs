# Example of Single Sign-On via AWS IAM Identity Center (OIDC)
---

OIDC is a protocol based on OAuth 2.0 that allows users to log in directly to Guance using their AWS account without re-entering passwords. After AWS verifies the user, it generates an ID Token, which Guance validates and uses for automatic login. Compared to traditional protocols, OIDC is more lightweight and simplifies the cross-platform authentication process, making it suitable for cloud-native applications.

???+ warning "Note"

    The OAuth 2.0 single sign-on feature of AWS IAM Identity Center is only available for AWS **International sites**.

## 1. Enable IAM Identity Center

> For more details, refer to [Enable Service](./aws_iam_sso_saml.md#get_started).

## 2. Add an Application

1. On the application management page, select "Customer-managed" and click "Add application";
2. Choose the application type as "I want to set up my own application";
3. Continue by selecting OAuth 2.0 and proceed to the next step.

<img src="../../img/aws_iam_oidc.png" width="70%" >

### Configure the Application {#config}

1. Define the display name for this application, such as `guance_oidc`;
2. Enter a description if needed;
3. Select "Requires assignment";
4. Input the URL where users can access the application: https://<<< custom_key.studio_main_site_auth >>>/login/sso;
5. Choose to make this application "Visible" in the AWS Access Portal;
6. Proceed to the next step.

<img src="../../img/aws_iam_oidc_1.png" width="70%" >


## 3. Specify Authentication Settings

To add a customer-managed application that supports OAuth 2.0 to IAM Identity Center, you need to specify a trusted token issuer. This is the OAuth 2.0 authorization server that creates signed tokens. These tokens are used to authorize requests from client applications to access AWS-managed applications (receiving applications).

If there is no trusted token issuer configured within your application yet, you will need to create one first.

1. Enter the Issuer URL: https://<<< custom_key.studio_main_site_auth >>>/login/sso;
2. Define the trusted token issuer name, such as `GUANCE`;
3. Select the identity provider attribute `Email (email)` mapping to `Email`;
4. Click Create;
5. After successful creation, you will automatically enter the authentication page, where you can modify relevant settings as needed;
6. Return to the "Specify Authentication Settings" page, refresh, and select the trusted token issuer;
7. Enter the Aud claim;
8. Proceed to the next step.

**<img src="../../img/aws_iam_oidc_2.png" width="70%" >**// Not available yet

> For more details, refer to [Using Applications with Trusted Token Issuers](https://docs.aws.amazon.com/zh_cn/singlesignon/latest/userguide/using-apps-with-trusted-token-issuer.html?icmpid=docs_sso_console).

## 4. Specify Application Credentials

IAM roles are identities with specific permissions that you create, and their credentials are valid for a short period.

1. Select "Enter one or more IAM roles";
2. Select "View IAM roles", go to the new page, and click into the role page;
3. Copy its ARN;
4. Enter the ARN of this role;
5. Proceed to the next step.

<img src="../../img/aws_iam_oidc_3.png" width="70%" >

<img src="../../img/aws_iam_oidc_4.png" width="70%" >

<img src="../../img/aws_iam_oidc_5.png" width="70%" >

## 5. Review and Configure

After confirming that the configuration is correct, submit. A prompt will appear indicating that the application was successfully added.

## 6. Assign User and Group Access Permissions

> For more details, refer to [Assign Users and Groups](./aws_iam_sso_saml.md#assign_permisson).

## 7. Login Verification

1. Log in to the <<< custom_key.brand_name >>> single sign-on page: https://<<< custom_key.studio_main_site_auth >>>/login/sso;
2. Select the application created on the AWS side from the list;
3. Login address;
4. Enter [username, password](./aws_iam_sso_saml.md#add_user);
5. You will then log in successfully.


<img src="../../img/aws_iam_sso-14.png" width="70%" >

<img src="../../img/aws_iam_sso-15.png" width="70%" >