# RUM Headless

RUM is used to collect user access monitoring (RUM) data reported from web or mobile ends. Guance provides a one-click activation service for RUM. After activation, it automatically installs and deploys on Guance's cloud hosts, completing a series of operations such as automatic DataKit installation and RUM collector deployment.

**Note**: The prerequisite for activating the autometa func platform is to contact the billing center to enable the whitelist channel. You need to contact your account manager and provide information such as the site and ID of the workspace.

## One-Click Activation {#steps}

In **Integration > RUM Headless**, or **Integration > Extensions > RUM Headless**, click to enter the activation process:

![](img/headless-1.png)

???+ warning "Permissions and Billing"

    - Only one instance can be activated per workspace, and only the **Owner** has the permission to activate and configure;
    - RUM Headless is **billed monthly**. The fee for one month is deducted once after successful activation, and the next month’s fee is automatically deducted one day before expiration (e.g., if activated on 04/13, fees will be deducted on 04/12 and 05/12, and so on).

1. Click **Activate**;
2. Enter the HTTP service address;
3. Select the required application specifications;
4. Click **Activate Now**;

**Note**: HTTP service address: This is the HTTP service address of DataKit, which receives external data. It needs to be filled in when integrating applications:

<img src="../img/headless-5.png" width="60%" >

The automated deployment process takes approximately 10-15 minutes. After successful activation, you can directly access the console via **Integration > Func > Extensions**. Click **Configuration > Summary** to view the relevant information for RUM Headless.

## Related Configuration

After RUM Headless is activated, if you need to modify configuration details, refer to the following content:

<!--

![](img/headless-2.png)
-->

### Modify Service Address

1. Click **Modify**;
2. Obtain and enter the email verification code;
3. Click confirm to complete **identity verification**, then modify the current HTTP service address.

**Note**: You can modify the service address up to 3 times per day.

### Modify Specifications

1. Click **Modify**;
2. Obtain and enter the email verification code;
3. Click confirm to complete identity verification, then modify the current specifications.

**Note**: Changes to specifications take effect immediately on the same day and are billed according to the new specifications. The old specifications will be discarded immediately with no refund.

### Sourcemap Configuration

Sourcemap (source code mapping) is used to map compressed production environment code back to the original source code.

![](img/headless-3.png)

When uploading files, select the application type, [configure the Sourcemap after packaging](../integrations/rum.md#sourcemap), and drag or click to upload.

Below the 🔍 bar, you can view the names of uploaded files and their application types. You can search by entering the file name; click :fontawesome-regular-trash-can: to delete the current file.

???+ warning "Upload Guidelines"

    - File size must not exceed 500M;
    - File format must be `.zip`;
    - File naming format should be `<app_id>-<env>-<version>`, where `app_id` is mandatory. Incorrect formats will not take effect. Ensure that the file paths after decompression match the URLs in the `error_stack`;
    - Multiple files cannot be uploaded simultaneously;
    - Uploading files with the same name will result in an overwrite prompt, please be cautious.

### Status Information

On the RUM Headless configuration page, you can view the current application status.

Your application may have five statuses:

| Status      | Description            |
| ----------- | ------------- |
| Activating      | Indicates that the one-click activation process for RUM Headless is ongoing.             |
| Activated      | Indicates that the one-click activation process for RUM Headless is completed.             |
| Changing Plan      | Indicates that the service address or specifications are being modified.              |
| Upgrading      | Indicates that the current application service is being upgraded.               |
| Operation Failed      | Indicates issues during the activation process. You can **view error feedback** or directly [contact us](https://www.guance.com/aboutUs/introduce#contact).           |

### Application Expiration

If you previously activated RUM Headless, all data will be retained for 7 days after expiration. Within these 7 days, if you need to reactivate the application, you can choose to **restore all data** or **not restore data**:

- Restore Data: Back up previously retained data to the newly activated RUM;
- Do Not Restore Data: Abandon all previous data and [reactivate the application](#steps).

### Deactivate Application

If you need to deactivate the current application service, click **Deactivate Application**, complete **identity verification**, and open the confirmation page to view the application expiration date.

RUM Headless uses a monthly billing model. Before the fees expire, you can still use the RUM service and can choose to **reactivate** RUM Headless as needed.