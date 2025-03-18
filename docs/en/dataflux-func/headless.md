# RUM Headless

RUM is used to collect user access monitoring data reported from web or mobile ends. <<< custom_key.brand_name >>> provides a one-click activation service for RUM. After activation, it automatically installs and deploys on <<< custom_key.brand_name >>> cloud servers, automatically completing DataKit installation, RUM collector deployment, and other operations.

**Note**: To activate the autometa func platform, you need to contact the billing center to open a whitelist channel. Contact your account manager and provide information such as the site and ID of your workspace.

## One-Click Activation {#steps}

In **Integration > RUM Headless**, or **Integration > Extensions > RUM Headless**, click to enter the activation process:

![](img/headless-1.png)

???+ warning "Permissions and Billing"

    - Only one instance can be activated per workspace, and only the **Owner** has the permission to activate and configure;
    - RUM Headless is **billed monthly**. The cost for one month is deducted upon successful activation, and the next month's fee is automatically deducted one day before expiration (for example, if activated on 04/13, fees will be deducted on 04/12 and 05/12, and so on).

1. Click **Activate**;
2. Enter the HTTP service address;
3. Select the required specifications for the application;
4. Click **Activate Now**;

**Note**: HTTP service address: This is the HTTP service address of DataKit, which receives external data. You need to fill this in when integrating applications:

<img src="../img/headless-5.png" width="60%" >

The automated deployment process takes approximately 10-15 minutes. After successful activation, you can directly access the console via **Integration > Func > Extensions**. Click **Configuration > Overview** to view RUM Headless related information.

## Configuration

After activating RUM Headless, if you need to modify configuration information, refer to the following content:

<!--

![](img/headless-2.png)
-->

### Modify Service Address

1. Click **Modify**;
2. Obtain and enter the email verification code;
3. Click confirm to complete **identity verification** and modify the current HTTP service address.

**Note**: You can modify the service address up to 3 times per day.

### Modify Specifications

1. Click **Modify**;
2. Obtain and enter the email verification code;
3. Click confirm to complete identity verification and modify the current specifications.

**Note:** Specification changes take effect immediately on the same day and are billed according to the new specifications. The old specifications will be discontinued with no refunds.

### Sourcemap Configuration

Sourcemap (source mapping) is used to map compressed code in the production environment back to the original source code.

![](img/headless-3.png)

When uploading files, select the application type and [configure the Sourcemap after packaging](../integrations/rum.md#sourcemap), then drag or click to upload.

Below the 🔍 bar, you can view the names and application types of uploaded files. You can search by file name; clicking :fontawesome-regular-trash-can: deletes the current file.

???+ warning "Upload Requirements"

    - File size must not exceed 500M;
    - File format must be `.zip`;
    - File naming format should be `<app_id>-<env>-<version>`, where `app_id` is mandatory. Incorrect formats will not take effect. Ensure that the file paths after decompression match the URLs in the `error_stack`;
    - Multiple files cannot be uploaded simultaneously;
    - Uploading files with the same name will result in an overwrite prompt. Please note.

### Status Information

On the RUM Headless configuration page, you can view the current application status.

Your application may have five statuses:

| Status      | Description            |
| ----------- | ------------- |
| Activating      | Indicates that the RUM Headless one-click activation process is ongoing.             |
| Activated      | Indicates that the RUM Headless one-click activation process is completed.             |
| Changing Plan      | Indicates that the service address or specifications are being modified.              |
| Upgrading      | Indicates that the current application service is being upgraded.               |
| Operation Failed      | Indicates that there was an issue during the activation process. You can **view error feedback** or [contact us](https://<<< custom_key.brand_main_domain >>>/aboutUs/introduce#contact).           |

### Application Expiration

If you previously activated RUM Headless, all data will be retained for 7 days after expiration. Within these 7 days, if you need to reactivate the application, you can choose to **restore all data** or **not restore data**:

- Restore Data: Back up previously retained data to the newly activated RUM;
- Do Not Restore Data: Abandon all previous data and [reactivate the application](#steps).

### Deactivate Application

If you need to deactivate the current application service, click **Deactivate Application**, complete **identity verification**, and you will be directed to a confirmation page where you can view the application expiration date.

RUM Headless uses a monthly billing model. Before the fees expire, you can still use RUM services and can **reactivate** RUM Headless as needed.