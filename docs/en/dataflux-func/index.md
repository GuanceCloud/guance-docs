---
icon: zy/dataflux-func
---

# DataFlux Func
---

DataFlux Func is a Python-based script development, management and execution platform.

Formerly a function calculation component under [Guance](https://en.guance.com/), it has become an independent system.

It is mainly divided into two parts:

- Server: Built with Node.js + Express, it mainly provides Web UI service and external API interface.
- Worker: Built using Python 3 + Celery, it mainly provides the execution environment of Python scripts (including Beat module).

## DataFlux Func (Automata) {#steps}

Guance supports the one-click opening service of DataFlux Func (Automata). After the opening is completed, Func can be automatically deployed in the cloud host, and you can quickly log in to the corresponding Func platform through **Integrations** in the workspace.

![](img/automata-1.png)

### One-click Opening

click to enter the opening process:

???+ warning "Permission and Charge"

    - Only one Automata can be opened on one workspace, and only **Owner** has installation and configuration permission;
    - Automata <u>charges monthly</u>, deducting one month's fee once it is successfully opened, and automatically deducting the next month's fee one day before the expiration date (for example, if it is opened on 04/13, it will be deducted on 04/12, 05/12 and so on...).

![](img/automata.png)

1. Click **Open**, fill in **Domain**, and select **Specification** required for application;
2. After filling in the relevant information, click **Open**;       
3. In the pop-up agreement window, click **Confirm**, and the managed version of DataFlux Func can be successfully opened. In the prompt page, you can view your initial account password and send it to your mailbox synchronously. Please pay attention to checking and saving;     
4. The automated deployment process takes 5 minutes in advance. After opening, click **Confirm**. You can go directly to the studio in **Integrations > Extension**. Click **Configuration > Overview** to view information about Automata.


### Related Operations

When Automata is enabled, if you need to modify the configuration information, please refer to the following:

![](img/automata-3.png)

#### Modify Domain

Click **Modify** to complete authentication and modify the current **Domain**.

![](img/automata-4.png)

#### Modify Specification

Click **Modify** to complete authentication and modify the current **Specification**.

<font color=coral>**Note:**</font> The revised specification will take effect immediately on the same day, and the fees will be deducted according to the new specifications. The old specifications will be discarded directly and no refund will be made.


#### State Correlation

On the Automata configuration page, you can view the current application status.

???+ info "Your current application may have five states"

    | Status      | Description            |
    | ----------- | ------------- |
    | Starting      | Indicate that you are in a one-click Automata process.             |
    | Running      | Indicate that the one-click Automata process has been completed.             |
    | PlanChanging      | Indicate that the service address is being modified or the specification is being modified.              |
    | VersionUpgrading      | Indicate that the current application service is being upgraded.               |
    | Error      | Indicate that there is an operational problem in the opening process. You can check the **Error Feedback** or [contact us directly](https://en.guance.com/).           |


#### Reset Password

Click **Reset Password** to complete **Identity Verification** to reset the password. You will receive a new password for DataFlux Func Automata in your mailbox. Please check it carefully.


#### Disable APP

If you need to disable the current application service, click **Disable App** to complete **Identity Verification**, and then you can open the confirmation page and view the application expiration date.

![](img/automata-5.png)

Automata is charged monthly, so you can still use RUM service before the fee expires, and you can resume Automata on demand.

![](img/automata-6.png)


#### Application Expiration

If you have opened Automata before, after the application expires, we will keep all the data for you for <u>7 days</u> and release it when it expires. Within these 7 days, if you need to open the application again, you can choose to restore all the data or not:

- Restore Data: backup the previously reserved data to the newly opened RUM;  
- Not recover data: Discard all previous data and [reopen the application](#steps).

![](img/automata-7.png)

## DataFlux Func (Private-deployment)

> See:

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; __DataFlux Func (Private-deployment)__ </font>](https://func.guance.com/doc/maintenance-guide-requirement/)

<br/>

</div>


> For details of DataFlux Func deployment and maintenance manual, script development manual, script market, etc., please refer to:

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; __DataFlux Func Documentation Library__ </font>](https://func.guance.com/doc/)

<br/>

</div>

## RUM Headless

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; __Open RUM Headless with One-click__ </font>](./headless.md)

<br/>

</div>