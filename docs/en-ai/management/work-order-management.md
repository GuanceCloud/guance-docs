# Ticket Management
---

For issues encountered within Guance, you can submit a ticket for consultation and suggestions. For example, if you encounter difficult problems during usage, have questions related to purchasing or fees, or wish to propose needs and suggestions to Guance, the official team will promptly handle and respond to your tickets.

The ticket system is **based on workspace level**, so submitted tickets will not disappear due to the addition or removal of members. In the ticket list, you can view all tickets within the current workspace and understand previously encountered issues and feedback.

Guance provides users with 5*8 hours of ticket service time. Customer service personnel will process your ticket as soon as possible after receiving it.

> For more details, see [Support Plans](https://www.guance.com/support).

Click **Help > Ticket Management** in the lower-left corner to access the ticket management entry:

![Ticket Entry](../img/ticket-entry.png)

## Submitting a Ticket

On the ticket management page, you can directly click **Submit Ticket**, select the ticket type, enter the title and description of the ticket, and create it. Attachments are supported.

![](img/1.work_order_1.png)

### Ticket Types

Ticket types include **Unbind MFA**, **Change Owner Account**, **Purchase Inquiry**, **Documentation Help**, **Feature Request**, **Bug Report**, **Usage Issues**, and **Others**. You can choose the appropriate type based on the issue to facilitate faster allocation and handling.

![Ticket Types](../img/ticket-type.png)

**Note**:

- When the ticket type is **Change Owner Account**, you need to download the application form, fill out the required information and affix the company seal before uploading the attachment. If the application information is incomplete, it will not be processed.

![Application Form](../img/1.work_order_3.png)

- When the ticket type is **Unbind MFA**, email verification is required.

![MFA Unbinding](../img/1.work_order_2.png)

### Ticket Status {#state}

| Ticket Status | Description |
| ------------- | ----------- |
| Waiting for Assignment | The status of a ticket after submission by the user. |
| Waiting for Feedback | The status of a ticket after acceptance by the handler. |
| Feedback Provided | The status of a ticket after the handler sends a message, excluding fixed automatic replies. The ticket will revert to "Waiting for Feedback" when the user provides further feedback. |
| Closed | The status of a ticket that has been in the "Feedback Provided" state for over 7 days. The ticket submitter can manually close the ticket at any time. |
| Revoked | A ticket can be revoked while in the "Waiting for Assignment" state. |

### Attachments

You can upload attachments as needed for ticket issues. Supported formats include `.png`, `.gif`, `.jpg`, `.jpeg`, `.bmp`, `.doc`, `.docx`, `.pdf`, `.xlsx`, `xls`, `.txt`, `.zip`, `.rar`. Individual attachments cannot exceed 8MB, and up to 5 attachments can be uploaded at once.

## Ticket List

All tickets submitted by members within the current workspace will be displayed in the **All Tickets** list, where you can clearly see the status of each ticket.

![](img/ticketforall.png)

In the **My Tickets** list, you can view a summary of tickets submitted by you **across all workspaces**.

**Note**: If a user exits Workspace A or Workspace A is dissolved, tickets from Workspace A will not be shown in **My Tickets**.

![](img/ticketformine.png)

### Related Operations

- Filter tickets by type or status; in the search box, you can input the ticket number or title to quickly locate a specific ticket:

![](img/ticketformine-op.png)

- Tickets support batch export:

![](img/ticketexport.png)

- After closing a ticket, you can rate and review the ticket:

![](img/ticket-rate.png)

## Ticket Details

Clicking any ticket allows you to view detailed information such as its status, type, submitter, and associated workspace. On the details page, you can communicate with Guance and upload attachments during the conversation.

- For tickets in the "Waiting for Assignment" state, users can revoke the ticket. If needed, they can choose to restart the ticket after revocation;

![Revoke Ticket](../img/1.work_order_7.png)

![Restart Ticket](../img/1.work_order_7_1.png)

- For tickets in the "Feedback Provided" state, users can close the ticket. If there is no customer feedback within 7 days, the ticket will automatically close. Once closed, the ticket cannot be reopened or replied to.

**Note**: [Account Cancellation](./index.md#cancel) will automatically close any open tickets under the account.

![Close Ticket](../img/1.work_order_8.png)

<!-- 

## Ticket Management Backend (Internal Use Only)

### Ticket List

In the **Ticket List**, you can see all tickets submitted across the platform. Tickets submitted to Guance will be automatically forwarded to an admin account (referred to as Account A), who will then choose to handle the ticket directly or forward it to another handler. (The following image shows a ticket list submitted by the billing center for reference only. Tickets submitted to Guance have only four statuses: [Pending], [Processing], [Completed], [Cancelled])

![](img/1.work_order_mng_1.png)

### My Tickets

In **My Tickets**, you can view the list of tickets assigned to you.

- Pending: Supports [Handle], [Mark Complete], and [Forward] actions. Clicking Handle changes the ticket to "Processing"; forwarding to others removes the ticket from **My Tickets**.
- Processing: Supports replying to users and sending attachments.
- Completed/Canceled: Supports viewing ticket details and communication records but does not allow further replies.

![](img/1.work_order_mng_2.png)

### Ticket Handlers

In the **Ticket Handler List**, you can view the current available handlers, created by administrators, and assign "Roles" to them.

-->