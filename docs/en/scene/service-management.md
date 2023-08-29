# Service Management

**Service Management** as a centralized management portal, accesses and views key information under all services in the current workspace from a global perspective; at the same time, it connects business attributes with business data, and through associated warehouses and documents, quickly identify code locations and problem solutions for urgent problems.

Into **Scenes > Service Management** Page:

You can view information such as the status of all services, associated repositories, and documents.

<img src="..img/service-manage-1.png" width="60%" >


## Add Service List

<img src="../img/service-manage-2.png" width="60%" >

| Field      | Description         |
| ----------- | ------------------- |
| Name      |  Required field. This is the service name.        |
| Type      | Required field. The type selection range includes:`app`, `framework`, `cache`, `message_queue`, `custom`, `db`, `web`. |
| Team      | The team to which the current service belongs. |
| Emergency Contact      | The email address of the contact; if multiple selections are required, they must be separated by commas, semicolons, and spaces.         |
| Repository Config      | Fill in the display name, provider name and warehouse code URL.        |
| Help Document      | Fill in the display name, provider name, and other associated document URLs.        |

After entering the relevant information, Click **Confirm** to create successfully.

## Service List

After the creation is complete, you can view all the services in the list:

**Note**: **Status** of the service includes OK, Critical, Important, and No Data. The status of the last unrecovered event within 60 days of the service is taken, and 【OK】 is displayed if there is none.

![](img/service-manage-3.png)

You can manage lists by:

- Batch operation: click :material-square-rounded-outline:, next to the service, you can delete specific services in batches.
- In the search bar, you can enter keywords to search for the service name.
- On **Related**，Hover to the corresponding icon, click to automatically jump to the associated warehouse or document.

<img src="../img/service-manage-4.png" width="70%" >

- On **Operate**，Hover to the avatar icon to view the creator, creation time, updater and update time of the service.
- Click :octicons-star-24: button，to bookmark the current service.
- Click :material-dots-vertical: button，to edit or delete the current service；
- USe **Favorites**、**Creations** and **Frequently read** to quickly filter and find the corresponding services.

## List Details

Click on a service to enter the details page.

The overview page opens by default:

![](img/service-manage-5.png)

Click the tab at the top of the page to enter the logs, trace, error tracking, event explorer, and query all relevant information under the associated service.

|                   <font color=coral size=3>:fontawesome-regular-circle-down: &nbsp;**Form more information about Explorer, click here:**</font>                         |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | 
| [Log Explorer](../logs/explorer.md){ .md-button .md-button--primary } | [Trace Explorer](../application-performance-monitoring/explorer.md){ .md-button .md-button--primary } |
|  [Error Tracking Explorer](../application-performance-monitoring/error.md){ .md-button .md-button--primary } | [Event Explorer](../events/unrecovered-events.md){ .md-button .md-button--primary } |