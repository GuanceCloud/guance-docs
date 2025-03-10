# RUM Headless


RUM is used to collect user access monitoring data reported by web pages or mobile terminals. Guance provides RUM one-click service. After opening, it can be automatically installed and deployed in the cloud host of Guance, and automatically complete a series of operations such as DataKit installation and RUM collector deployment.


## One-click Opening {#steps}

In **Integrations > RUM Headless**, or **Integrations > Extension > RUM Headless**, click to enter the opening process:

![](img/headless-1.png)

???+ warning "Permission and Charge"

    - Only one RUM Headless can be opened on one workspace, and only **Owner** has installation and configuration permission;
    - RUM Headless <u>charges monthly</u>, deducting one month's fee once it is successfully opened, and automatically deducting the next month's fee one day before the expiration date (for example, if it is opened on 04/13, it will be deducted on 04/12, 05/12 and so on...).


I. Click **Open**, fill in **HTTP Service Address**, and select **Specification** required for application;

- **HTTP Service Address**: That is, the HTTP service address of DataKit, through which external data is received, and it is necessary to fill in when accessing the application:

![](img/headless-5.png)

II. After filling in the relevant information, click **Open**;

III. The automated deployment process takes 10-15 minutes in advance. After opening, click **Confirm**. You can go directly to the studio in **Integrations > Extension**. Click **Configuration > Overview** to view information about RUM Headless.



## Related Operations

When RUM Headless is enabled, if you need to modify the configuration information, please refer to the following:

![](img/headless-2.png)

### Modify Service Address

Click **Modify** to complete authentication and modify the current **HTTP Service Address**.

![](img/automata-4.png)

### Modify Specification

Click **Modify** to complete authentication and modify the current **Specification**.

<font color=coral>**Note:**</font> The revised specification will take effect immediately on the same day, and the fees will be deducted according to the new specifications. The old specifications will be discarded directly and no refund will be made.

### Sourcemap Configuration

Sourcemap (source code mapping) is used to map the compressed code in the production environment back to the original source code.

![](img/headless-3.png)

When uploading files, select the application type, [configure and pack Sourcemap](../datakit/rum.md#sourcemap), and then drag or click Upload.

Under the 🔍 column, you can view the uploaded file name and application type, and you can enter the file name to search; Click :fontawesome-regular-trash-can: to delete the current file.

???+ warning "Instructions for Uploading"

    - The file size cannot exceed 500M and the file format must be zip;
    - The file name format is < app_id >-< env >-< version >, where `app_id` is required; Make sure that the unzipped file path of the zipped package matches the path of the URL in `error_stack`;
    - Multiple files cannot be uploaded at the same time;
    - Uploading files with the same name will give you an overwrite prompt, please note.

### State Correlation

On the RUM Headless configuration page, you can view the current application status.

???+ info "Your current application may have five states"

    | Status      | Description            |
    | ----------- | ------------- |
    | Starting      | Indicate that you are in a one-click RUM Headless process.             |
    | Running      | Indicate that the one-click RUM Headless process has been completed.             |
    | PlanChanging      | Indicate that the service address is being modified or the specification is being modified.              |
    | VersionUpgrading      | Indicate that the current application service is being upgraded.               |
    | Error      | Indicate that there is an operational problem in the opening process. You can check the **Error Feedback** or [contact us directly](https://en.guance.com/).           |

### Application Expiration

If you have opened RUM Headless before, after the application expires, we will keep all the data for you for <u>7 days</u> and release it when it expires. Within these 7 days, if you need to open the application again, you can choose to restore all the data or not:

- Restore Data: backup the previously reserved data to the newly opened RUM;  
- Do not recover data: Discard all previous data and [reopen the application](#steps).


### Disable APP

If you need to disable the current application service, click **Disable App** to complete **Identity Verification**, and then you can open the confirmation page and view the application expiration date.

RUM Headless is charged monthly, so you can still use RUM service before the fee expires, and you can resume RUM Headless on demand.
    


