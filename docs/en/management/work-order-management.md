# Ticket Management
---

For issues encountered in <<< custom_key.brand_name >>>, you can submit a ticket for inquiries and suggestions. For example, if you encounter difficult-to-resolve problems during use, questions related to purchasing and fees, or wish to provide requirements and suggestions to <<< custom_key.brand_name >>>, the official team will promptly process and respond to your tickets after submission.

The ticket system is **workspace-based**, so already submitted tickets will not disappear due to a member joining or leaving. In the ticket list, you can view all tickets within the current workspace and understand previously encountered issues and feedback.

<<< custom_key.brand_name >>> provides users with 5*8 hours of ticket service time. Customer service personnel will handle ticket issues as soon as they are received.

> For more details, see [Support Plans](https://<<< custom_key.brand_main_domain >>>/support).

Click on the bottom-left **Help > Ticket Management** to access the ticket management entry:

<img src="../img/ticket-entry.png" width="50%" >

## Submitting a Ticket

On the ticket management page, you can directly click **Submit Ticket**, choose the type of ticket, input the title and description of the ticket, and then create it. Uploading attachments is supported.

![](img/1.work_order_1.png)

### Ticket Types

Ticket types include **Unbinding MFA**, **Changing Owner Account**, **Purchase Consultation**, **Help Documentation**, **Requirement Suggestions**, **BUG Feedback**, **Usage Issues**, **Others**. You can select the corresponding type based on the ticket issue to facilitate faster allocation and processing.

<img src="../img/ticket-type.png" width="50%" >

**Note**:

- When the ticket type is changing the owner account, you need to first download the application form, fill out the information according to the requirements, and upload the attachment with the company seal. If the application information is incomplete, it will not be processed.

<img src="../img/1.work_order_3.png" width="50%" >

- When the ticket type is unbinding MFA, email verification is required.

<img src="../img/1.work_order_2.png" width="50%" >

### Ticket Status {#state}


| Ticket Status      | Description                          |
| ----------- | ------------------------------------ |
| Waiting for Assignment       | The status of a ticket after user submission. |
| Waiting for Feedback       | The status of a ticket after acceptance by the handler. |
| Feedback Provided    | The status of a ticket after the handler sends a message. This does not include fixed automatic replies. When the user provides further feedback, the ticket will revert to waiting for feedback. |
| Closed      | The status of a ticket that has been in the feedback provided state for over 7 days. The ticket submitter can manually close the ticket at any time.                          |
| Canceled      | A ticket in the waiting for assignment status can be canceled.                          |


### Attachments

You can upload attachments as needed for ticket issues. Supported formats are `.png`, `.gif`, `.jpg`, `.jpeg`, `.bmp`, `.doc`, `.docx`, `.pdf`, `.xlsx`, `xls`, `.txt`, `.zip`, `.rar`. Each attachment cannot exceed 8M, and up to 5 attachments can be uploaded at once.

## Ticket List

All tickets submitted by all members within the current workspace will appear in the **All Tickets** list, where each ticket's status can be clearly seen.

![](img/ticketforall.png)

In the **My Tickets** list, you can view a summary of tickets submitted by yourself **across all workspaces**.


**Note**: If a user exits Workspace A or Workspace A has been dissolved, tickets from Workspace A will not be displayed in **My Tickets**.

![](img/ticketformine.png)

### Related Actions

- Filter tickets by ticket type or ticket status; input the ticket number or title in the search box to quickly locate:

![](img/ticketformine-op.png)

- Tickets support batch export:

![](img/ticketexport.png)

- After closing a ticket, you can rate and review the current ticket:

![](img/ticket-rate.png)

## Ticket Details

Clicking any ticket allows you to view detailed information such as the ticket’s status, type, submitter, and associated workspace. On the details page, you and <<< custom_key.brand_name >>> can communicate with each other, and uploading attachments is supported during communication.

- For tickets awaiting assignment, users can cancel the ticket. If necessary later, you can choose to restart the ticket;

<img src="../img/1.work_order_7.png" width="70%" >

<img src="../img/1.work_order_7_1.png" width="70%" >

- For tickets that have been responded to, users can close the ticket. If there is no customer feedback within 7 days, the ticket will automatically close. Once closed, tickets cannot be reopened or replied to again.

**Note**: After [account cancellation](./index.md#cancel), any unclosed tickets submitted under this account will be automatically closed.

<img src="../img/1.work_order_8.png" width="70%" >



<!-- 

## Ticket Management Backend (Internal Use Only)

### Ticket List

In the 【Ticket List】, you can see all tickets submitted across the platform. Tickets submitted by <<< custom_key.brand_name >>> will be automatically forwarded to an administrator account (referred to as: Account A). Account A can then choose to handle the ticket directly or forward it to another handler. (The following image shows the ticket list submitted by the billing center for reference only. Tickets submitted by <<< custom_key.brand_name >>> have only four statuses: 【Pending Acceptance】【In Progress】【Completed】【Cancelled】)

![](img/1.work_order_mng_1.png)

### My Tickets

In 【My Tickets】, you can view tickets assigned to yourself.

- Pending Acceptance: Supports 【Handle】【Mark Complete】【Forward】 three actions. Clicking Handle automatically changes the ticket to “In Progress”; after forwarding to someone else, the ticket will disappear from 【My Tickets】.
- In Progress: Supports replying to user messages and sending attachments.
- Completed/Cancelled: Supports viewing ticket details and communication records but does not allow further replies.

![](img/1.work_order_mng_2.png)

### Ticket Handlers

In the 【Ticket Handler List】, you can view the current available handlers, all created by the administrator, who can assign a “Role” to each handler.

-->