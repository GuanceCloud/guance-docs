# Single Sign-On Example with AWS IAM Identity Center
---

AWS IAM Identity Center (formerly AWS SSO) is a centralized identity management service provided by AWS, supporting **Single Sign-On (SSO)** to manage unified access permissions for users across multiple AWS accounts, cloud applications (such as Salesforce, GitHub), and hybrid cloud resources.

**Note:**

## 1. Enable IAM Identity Center

In this example, it is assumed that the user account logging into the AWS platform has **never used** the IAM Identity Center service before, and this is its first use.

1. Log in to the AWS console;
2. In the search bar, enter IAM Identity Center;
3. Click "Enable".

<img src="../../img/aws_iam_sso-1.png" width="70%" >

<img src="../../img/aws_iam_sso-2.png" width="70%" >

**Note:**

- When enabling IAM Identity Center, pay attention to the **region selection** in the top navigation bar of the console. Once enabled, you cannot directly switch regions; you need to re-enable and reconfigure all settings in the new region.
- If your organization already has an AWS main management region (such as us-east-1 or ap-northeast-1), it is recommended to maintain consistency for easier unified management.

## 2. Create a Custom SAML 2.0 Application

On the application management page, select "Customer Managed" and click "Add Application".

???- abstract "Why choose 'Customer Managed (Custom)'"

    | Option      | Use Cases                |
    | ----------- | ------------------ |
    | AWS Managed | Pre-integrated third-party SaaS applications by AWS (such as Salesforce, Slack, Zoom). AWS automatically provides metadata and configuration templates.                |
    | Customer Managed | Third-party platforms that require manual SAML configuration (non-AWS pre-integrated applications, such as the <<< custom_key.brand_name >>> platform in this example), requiring you to provide SAML metadata or ACS URL.                |

1. Choose the application type as "I want to set up an application";
2. Continue to select SAML 2.0 and proceed to the next step.

<img src="../../img/aws_iam_sso-3.png" width="70%" >

<img src="../../img/aws_iam_sso-4.png" width="70%" >

### Configure the Application {#config}

1. Define the display name for this application, such as `Guance`;
2. Enter a description as needed;
3. Under "IAM Identity Center Metadata," click to download the IAM Identity Center SAML metadata file and certificate;
4. In the application metadata, fill in the fields "Application ACS URL" and "Application SAML Audience" with: https://auth.guance.com/login/sso;
5. Submit the current configuration;
6. The page will prompt that the application has been successfully added.

<img src="../../img/aws_iam_sso-5.png" width="70%" >

<img src="../../img/aws_iam_sso-6.png" width="70%" >

## 3. Edit Attribute Mapping

Attribute mapping is the core configuration for SAML integration, used to pass AWS user attributes to <<< custom_key.brand_name >>>.

After returning to the application details page, click **Actions > Edit Attribute Mapping** in the upper right corner to map AWS user login identities to <<< custom_key.brand_name >>> role identities.

1. The system defaults to providing the field `Subject` (user unique identifier), choose to map it to `${user:email}`;
2. After configuration, click save changes.

<img src="../../img/aws_iam_sso-18.png" width="70%" >

## 4. Assign User and Group Access Permissions

Users and groups created in the Identity Center directory are only available in IAM Identity Center. Subsequently, you can assign permissions to them. In this example, it is assumed that **no users or groups have been added to the current directory**.

### Step 1: Add Users {#add_user}

1. Go to the console > Users page;
2. Click "Add User";
3. Define the username, choose how the user will receive the password, and enter email, first name, last name, and display name;
4. Proceed to the next step.

<img src="../../img/aws_iam_sso-7.png" width="70%" >

<img src="../../img/aws_iam_sso-8.png" width="70%" >

**Note:** The username, password, and email here are required configurations for subsequent single sign-on by the user.

### Step 2: Add Users to Groups

1. If there are no groups in the current directory, go to the creation entry on the right side;
2. Define the group name;
3. Click the "Create" button at the bottom right;
4. Return to the add user page, select the group, and proceed to the next step;
5. Confirm adding the user. A status message will notify you that the user has been successfully added.

<img src="../../img/aws_iam_sso-9.png" width="70%" >

<img src="../../img/aws_iam_sso-10.png" width="70%" >

### Step 3: Assign Users and Groups to the Application

1. Go to the application, select the configured application (in this example, the previously configured `Guance`), and assign users and groups to it;
2. Search and check all users and groups that need permission assignment;
3. After review, the assignment will be successful.

<img src="../../img/aws_iam_sso-11.png" width="70%" >

<img src="../../img/aws_iam_sso-12.png" width="70%" >

## 5. Create a User SSO Identity Provider in <<< custom_key.brand_name >>>

1. Log in to <<< custom_key.brand_name >>> workspace > Manage > Member Management > User SSO;
2. Select SAML;
3. Click Add Identity Provider and start configuration;
4. Define the identity provider name as `aws_sso`;
5. Upload the [metadata document downloaded during application configuration](#config);
6. Define the access restriction as `guance.com`;
7. Choose roles and session duration;
8. Click confirm.

<img src="../../img/aws_iam_sso-13.png" width="70%" >

> For more configuration details, refer to [SSO Management](./index.md#corporate).

## 6. Login Verification

1. Log in to the <<< custom_key.brand_name >>> single sign-on page: https://auth.guance.com/login/sso;
2. Select the application created on the AWS side from the list;
3. Login URL;
4. Enter [username, password](#add_user);
5. Successful login.

<img src="../../img/aws_iam_sso-14.png" width="70%" >

<img src="../../img/aws_iam_sso-15.png" width="70%" >