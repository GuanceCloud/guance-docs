# RUM Headless


RUM is used to collect user access monitoring data reported from web pages or mobile terminals. <<< custom_key.brand_name >>> provides a one-click activation service for RUM. After activation, it can be automatically installed and deployed on <<< custom_key.brand_name >>> cloud hosts, automatically completing the installation of DataKit, deployment of RUM collectors, and a series of other operations.

**Note**: The prerequisite for activating the autometa func platform is to contact the billing center to enable the whitelist channel. You need to contact your account manager and provide information such as the site and ID where the workspace is located.

## One-Click Activation {#steps}

In **Integration > RUM Headless**, or **Integration > Expansion > RUM Headless**, click to enter the activation process:

![](img/headless-1.png)

???+ warning "Permissions and Billing"

    - Only one instance can be activated per workspace, and only the **Owner** has the activation and configuration permissions;
    - RUM Headless is **billed monthly**, with one month's fee deducted upon successful activation. The next month’s fee will be automatically deducted one day before expiration (e.g., activation on 04/13 means billing on 04/12 and 05/12, and so on...).


1. Click **Activate**;
2. Fill in the HTTP service address;
3. Select the required specifications for the application;
4. Click **Activate Now**;


**Note**: HTTP service address: This is the HTTP service address of DataKit, which receives external data. This address needs to be filled when integrating applications:

<img src="../img/headless-5.png" width="60%" >

The automated deployment process is expected to take 10-15 minutes. After activation is completed, you can directly access the console under **Integration > Func > Expansion**. Click **Configuration > Overview** to view relevant information about RUM Headless.



## Related Configuration

After RUM Headless is activated, if you need to modify the configuration information, refer to the following content:



### Modify Service Address

1. Click **Modify**;
2. Obtain and fill in the email verification code;
3. Click confirm to complete **identity verification**, allowing modification of the current HTTP service address.

**Note**: The service address can be modified up to three times daily.


### Modify Specifications

1. Click **Modify**;
2. Obtain and fill in the email verification code;
3. Click confirm to complete identity verification, allowing modification of the current specifications.

**Note:** Changes to specifications take effect immediately on the same day and are billed according to the new specifications. The old specifications will be discarded directly without refund.

### Sourcemap Configuration

Sourcemap (source code mapping) is used to map compressed code in the production environment back to the original source code.

![](img/headless-3.png)

When uploading files, select the application type and [configure the completed Sourcemap](../integrations/rum.md#sourcemap), then drag or click to upload.

Below the 🔍 bar, you can view the names of uploaded files and their application types, and you can search by entering the file name; clicking :fontawesome-regular-trash-can: deletes the current file.

???+ warning "Upload Notes"

    - File size cannot exceed 500MB;
    - File format must be `.zip`;
    - File naming format should be `<app_id>-<env>-<version>`, where `app_id` is mandatory. Incorrect formatting will not take effect. Ensure that the file path after decompressing the package matches the URL path in `error_stack`;
    - Multiple files cannot be uploaded simultaneously;
    - Uploading files with the same name will prompt for overwriting, please pay attention.

### Status Related

On the RUM Headless configuration page, you can view the current application status.

There may be five possible statuses for your current application:

| Status      | Description            |
| ----------- | ------------- |
| Activating      | Indicates that the one-click activation process for RUM Headless is ongoing.             |
| Activated      | Indicates that the one-click activation process for RUM Headless has been completed.             |
| Changing Plan      | Indicates that modifications are being made to the service address or specifications.              |
| Upgrading      | Indicates that the current application service is being upgraded.               |
| Operation Failed      | Indicates an operational issue during the activation process. You can **view error feedback** or directly [contact us](https://<<< custom_key.brand_main_domain >>>/aboutUs/introduce#contact).           |

### Application Expiration

If you have previously activated RUM Headless, all data will be retained for 7 days after expiration, and will be released upon expiration. Within these 7 days, if you need to activate the application again, you can choose to **restore all data** or **not restore data**:

- Restore Data: Back up the previously retained data to the newly activated RUM;
- Do Not Restore Data: Abandon all previous data and [reactivate the application](#steps).


### Disable Application

If you need to disable the current application service, click **Disable Application**, complete **identity verification**, and open the confirmation page where you can view the application expiration date.

RUM Headless adopts a monthly billing model. Before the fees expire, you can still use the RUM service and can **restore activation** for RUM Headless as needed.