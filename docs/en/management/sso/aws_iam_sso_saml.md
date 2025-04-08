# Example of Single Sign-On through AWS IAM Identity Center (SAML)
---

AWS IAM Identity Center (formerly AWS SSO) is a centralized identity management service provided by AWS, supporting **Single Sign-On (SSO)** for unified control of user access to multiple AWS accounts, cloud applications (such as Salesforce, GitHub), and hybrid cloud resources.

???+ warning "Note"

    The SAML 2.0 single sign-on feature of AWS IAM Identity Center is only available for use on the AWS **international site**.

## 1. Enable IAM Identity Center {#get_started}

In this example, assume that the user account logging into the AWS platform has **never used** the IAM Identity Center service before, and this is its first use.

1. Log in to the AWS console;
2. In the search bar, type IAM Identity Center;
3. Click "Enable".

<img src="../../img/aws_iam_sso-1.png" width="70%" >

<img src="../../img/aws_iam_sso-2.png" width="70%" >

???+ warning "Note"

    - When enabling IAM Identity Center, pay attention to the **region selection** in the top navigation bar of the console. Once the service is enabled, it cannot be directly switched regions; you will need to re-enable and reconfigure all settings in the new region.
    - If your organization already has an AWS main management region (such as us-east-1 or ap-northeast-1), it is recommended to keep it consistent for easier unified management.

## 2. Create a Custom SAML 2.0 Application

On the application management page, select "Customer-managed," and click "Add Application."

???- abstract "Why choose 'Customer-managed (Custom)'"

    | Option      | Applicable Scenario                |
    | ----------- | ------------------ |
    | AWS-managed      | Third-party SaaS applications pre-integrated by AWS (such as Salesforce, Slack, Zoom). AWS automatically provides metadata and configuration templates.                |
    | Customer-managed      | Third-party platforms requiring manual SAML configuration (non-AWS pre-integrated applications, such as the example object '<<< custom_key.brand_name >>>' platform in this article), where you must provide SAML metadata or ACS URL.                |


1. Select the application type as "I want to set up my own application";
2. Continue selecting SAML 2.0, and proceed to the next step.

<img src="../../img/aws_iam_sso-3.png" width="70%" >

<img src="../../img/aws_iam_sso-4.png" width="70%" >

### Configure the Application {#config}

1. Define the display name of the application, such as `guance`;
2. Enter a description as needed;
3. Under "IAM Identity Center Metadata," click to download the IAM Identity Center SAML metadata file and certificate;
4. In the application metadata, select "Upload application SMAL metadata file," choosing the [metadata file](#for_idp_file) downloaded from <<< custom_key.brand_name >>>;
5. Submit the current configuration;
6. The page will prompt that the application has been successfully added.

<img src="../../img/aws_iam_sso-5.png" width="70%" >

<img src="../../img/aws_iam_sso-6.png" width="70%" >


## 3. Edit Attribute Mapping

Attribute mapping is the core configuration of SAML integration, used to pass AWS user attributes to <<< custom_key.brand_name >>>.

After returning to the application details page, click **Actions > Edit Attribute Mapping** in the upper right corner of the page to map the AWS user login identity to the role identity of <<< custom_key.brand_name >>>.

1. The system defaults to providing the field `Subject` (user unique identifier), which is mapped to `${user:email}`;
2. After completing the configuration, click Save Changes.

<img src="../../img/aws_iam_sso-18.png" width="70%" >

### Additional Role Attributes

1. Define the user or group attributes to be mapped to roles, here selecting the `email` and `familyName` fields;
2. Define the attributes to be mapped to these string values, respectively `$(user:email}` and `$(user:familyName}`;
3. Save the current changes.
4. Subsequently, configure the [role mapping](./role_mapping.md) on <<< custom_key.brand_name >>>.

<img src="../../img/aws_iam_sso-19.png" width="70%" >

## 4. Assign User and Group Access Permissions {#assign_permisson}

Users and groups created in your Identity Center directory are only available in IAM Identity Center. You can subsequently assign permissions to them. In this example, by default, **no users or groups have been added to the current directory**.


### Step 1: Add Users {#add_user}

1. Go to the console > Users page;
2. Click "Add User";
3. Define the username, select how the user will receive their password, and input email, first name, last name, and display name;
4. Proceed to the next step.


<img src="../../img/aws_iam_sso-7.png" width="70%" >

<img src="../../img/aws_iam_sso-8.png" width="70%" >

**Note**: The username, password, and email here are required configurations for subsequent single sign-on for this user.

### Step 2: Add Users to Groups

1. If there are no groups in the current directory, go to the creation entry on the right side;
2. Define the group name;
3. Click the "Create" button in the lower right corner;
4. Return to the add user page, select this group, and proceed to the next step;
5. Confirm adding this user. A status message will notify you that you have successfully added the user.

<img src="../../img/aws_iam_sso-9.png" width="70%" >

<img src="../../img/aws_iam_sso-10.png" width="70%" >


### Step 3: Assign Users and Groups to Applications

1. Go to the application, select the configured program (in this example, the previously configured `guance`), and assign users and groups to it;
2. Search and check all users and groups that need to be assigned permissions;
3. Review and confirm to create the assignment successfully.


<img src="../../img/aws_iam_sso-11.png" width="70%" >

<img src="../../img/aws_iam_sso-12.png" width="70%" >


## 5. Create a User SSO Identity Provider in <<< custom_key.brand_name >>> {#for_idp_file}

1. Log in to <<< custom_key.brand_name >>> workspace > Manage > Member Management > User SSO;
2. Select SAML;
3. Click Add Identity Provider and start the configuration;
4. Define the identity provider name as `aws_sso`;
5. Upload the [metadata document](#config) downloaded during application configuration;
6. Define the access restriction as `<<< custom_key.brand_main_domain >>>`;
7. Select roles and session duration;
8. Click Confirm.


<img src="../../img/aws_iam_sso-13.png" width="70%" >

> For more configuration details, refer to [SSO Management](./index.md#corporate).

## 6. Login Verification

1. Log in to the <<< custom_key.brand_name >>> single sign-on page: https://<<< custom_key.studio_main_site_auth >>>/login/sso;
2. Select the application created on the AWS side from the list;
3. Login address;
4. Input [username, password](#add_user);
5. You can log in successfully.


<img src="../../img/aws_iam_sso-14.png" width="70%" >

<img src="../../img/aws_iam_sso-15.png" width="70%" >