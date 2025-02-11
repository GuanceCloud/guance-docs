# Huawei Cloud Virtual Internet Access

## Introduction {#introduction}

Currently, the available service region for **Huawei Cloud** is **cn-south-1** (Guangzhou), with other regions to be launched soon. The architecture is as follows:

| Access Site         | Your Server's Region | Name ID of the Endpoint Service                                  |
| ------------------- | -------------------- | ---------------------------------------------------------------- |
| China Region 4 (Guangzhou) | `cn-south-1`            | `cn-south-1.openway.af005322-387a-47cb-a21f-758b1c6c7ee7` |

## VPC Endpoint Connection Service {#hw-connect}

### Step One: Account ID Authorization {#Account-authorization}

Log in to the management console.

Click on "My Credentials" under your account.

![img](https://static.guance.com/images/datakit/vpcep_01.png)

On the "My Credentials" page, you can view the "Account ID" of your tenant, as shown below.

![img](https://static.guance.com/images/datakit/vpcep_02.png)

Copy this "Account ID" and inform our Guance customer manager to add it to our whitelist.

### Step Two: Purchase Endpoint {#Purchase-nodes}

Log in to the management console.

In the top-left corner of the management console, select the **Guangzhou** region and project.

Click on "Service List > Network > VPC Endpoint" to enter the "Endpoint" page.

On the "Endpoint" page, click "Purchase Endpoint."

![img](https://static.guance.com/images/datakit/vpcep_03.png)

Follow the interface prompts to configure parameters. (**Service Name** will use the **Name ID of the Endpoint Service** from the table above.)

After configuring the parameters, click "Buy Now" to confirm the specifications.

- If the specifications are correct, click "Submit," and the task will be submitted successfully.
- If there are errors in the parameter configuration, click "Previous Step" to modify the parameters, then click "Submit."

Request Connection

- In the endpoint list, check if the endpoint status is "Pending Acceptance." **At this point, please inform our customer manager** to verify the connection request.

- After notifying that the connection has been accepted, return to the endpoint list and check if the endpoint status changes to "Accepted," indicating that the endpoint has successfully connected to the endpoint service.

Click on the endpoint ID to view detailed information about the endpoint.

- After successful creation of the endpoint, a "Node IP" (private IP) and an "Internal Domain Name" (if you selected "Create Internal Domain Name" during endpoint creation) will be generated.

![img](https://static.guance.com/images/datakit/vpcep_04.png)

- You can use the node IP or internal domain name to access the endpoint service for cross-VPC resource communication.

## DNS Resolution of Internal Domain Names {#dns-resolution}

### Add Internal Domain Name Resolution {#add-dns-resolution}

In the navigation bar, click "DNS Service"

Select internal domain name

Click the "Create Domain" button in the top-right corner, and fill in the required data according to the prompts. Use `guance.com` as the main domain name.

Enter the VPC where the endpoint resides, as shown in the figure below:

![img](https://static.guance.com/images/datakit/vpcep_05.png)

After successful creation, click Manage Resolution

Next, click the "Add Record Set" button in the top-right corner.

- Fill in the host record with the service name (`cn4-openway`).

- Enter the IP address of the endpoint.

Then click Confirm. As shown in the figure below:

![img](https://static.guance.com/images/datakit/vpcep_06.png)

Log in to any machine within the VPC intranet and use the following command to verify:

```shell
curl https://cn4-openway.guance.com
```