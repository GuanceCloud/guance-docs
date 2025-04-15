# RUM Headless


RUM is used to collect user access monitoring data reported from web pages or mobile ends. <<< custom_key.brand_name >>> provides a one-click activation service for RUM. After activation, it can be automatically installed and deployed in <<< custom_key.brand_name >>> cloud hosts, automatically completing DataKit installation, RUM collector deployment, and a series of other operations.

???+ warning "Note"

    The prerequisite for activating the RUM Headless platform is to contact the billing center to enable the whitelist channel. You need to contact your account manager and provide information such as the site and ID of the workspace.


## One-Click Activation {#steps}

In **Integrations > RUM Headless**, or **Integrations > Extensions > RUM Headless**, click to enter the activation process:

![](img/headless-1.png)

???+ warning "Permissions and Billing"

    - Only one can be activated per workspace, only **Owner** has activation and configuration permissions;
    - RUM Headless is **billed monthly**, after successful activation, one month's fee will be deducted at once, and the next month's fee will be automatically deducted one day before expiration (for example: activation on 04/13, then fees will be deducted on 04/12, 05/12, and so on...).


1. Click **Activate**;
2. Fill in the HTTP service address;
3. Select the required specifications for the application;
4. Activate immediately.


???+ warning "Note"

    HTTP service address: That is, the HTTP service address of DataKit, which receives external data through this address. This address needs to be filled out when integrating applications:

<img src="../img/headless-5.png" width="60%" >

The automated deployment process is expected to take 10-15 minutes. After activation is completed, you can directly enter the console in **Integrations > Func > Extensions**. Click **Configure > Overview** to view the relevant information about RUM Headless.



## Related Configurations

After the RUM Headless activation is complete, if you need to modify configuration information, refer to the following content.


### Modify Service Address

1. Click **Modify**;
2. Obtain and enter the email verification code;
3. Confirm, complete **identity verification**, and you can modify the current HTTP service address.

???+ warning "Note"

    The service address can be modified up to 3 times daily.


### Modify Specifications

1. Click **Modify**;
2. Obtain and enter the email verification code;
3. Confirm, complete identity verification, and you can modify the current specifications.

???+ warning "Note"

    After modifying the specifications, they take effect immediately on the same day, and billing starts according to the new specifications. The old specifications will be directly abandoned, and no refunds will be issued.

### Sourcemap Configuration

Sourcemap (source code mapping) is used to map compressed code in the production environment back to the original source code.

![](img/headless-3.png)

When uploading files, select the application type, [configure the completed Sourcemap packaging](../integrations/rum.md#sourcemap), drag or click to upload.

Below the 🔍 bar, you can view the names of uploaded files and their application types; you can search by entering the file name; clicking :fontawesome-regular-trash-can: deletes the current file.

???+ warning "Upload Notes"

    - File size cannot exceed 500M;
    - File format must be `.zip`;
    - File naming format should be `<app_id>-<env>-<version>`, where `app_id` is mandatory. Incorrect formats will not take effect; ensure that the file paths after decompressing the package match the paths in the `error_stack` URL;
    - Multiple files cannot be uploaded simultaneously;
    - Uploading files with the same name will prompt an overwrite notice, please be cautious.

### Status Related

On the RUM Headless configuration page, you can view the current application status.

Your current application may have five possible statuses:

| Status      | Description            |
| ----------- | ------------- |
| Activating      | Indicates being in the one-click activation process for RUM Headless.             |
| Activated      | Indicates the one-click activation process for RUM Headless has been completed.             |
| Plan Changing      | Indicates currently modifying the service address or specifications.              |
| Upgrading      | Indicates upgrading the current application service.               |
| Operation Failed      | Indicates there are operational issues during the activation process. You can **view error feedback** or directly [contact us](https://<<< custom_key.brand_main_domain >>>/aboutUs/introduce#contact).           |

### Application Expiration

Three days before the application renewal charge date, the system will check if the balance is sufficient for renewal. If the balance is insufficient, the system will send email and system notifications to remind the workspace Owner.

If you have used RUM Headless before and reactivate the application before its expiration, all application data can be restored. If overdue without renewal, data will be permanently deleted. The system retains data for the last 7 days. Within these 7 days, if you choose to reactivate the application, you can opt to restore all data or not restore any data.

- Restore data: Back up previously retained data to the newly activated RUM;
- Do not restore data: Abandon all previous data, [reactivate the application](#steps).


### Disable Application

If you need to disable the current application service, click **Disable Application**, complete **identity verification**, and you can open the confirmation page to view the application expiration date.

RUM Headless uses a monthly billing model. Before the fee expires, you can still use the RUM service and can **restore activation** for RUM Headless as needed.