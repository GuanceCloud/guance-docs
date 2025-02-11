# User-defined Node Management
---

In addition to the 14 built-in nodes in the Guance system, you can also set up new dial testing nodes globally. Based on different geographic locations and different ISPs, user-defined nodes allow for availability monitoring from multiple regions, providing a comprehensive understanding of site availability.

![](img/image_2.png)

## Create a New Node

Go to **Synthetic Tests > User-defined Node Management**, and click **Create a New Node**.

1. Select the country/region and province or city;
2. Choose the ISP;
3. The node code will be automatically filled in; node codes must be unique within the current workspace;
4. Enter the node name; node names must be unique within the current workspace;
5. Click Confirm.

## Node Management

In the node list, you can view and manage all user-defined nodes in the current workspace through the following operations:

1. Hover over the node name and click the edit button to modify the node name;
2. Click Get Configuration to copy the configuration information directly from the pop-up window;
3. Click Delete to remove the current node. If the user-defined node is associated with a dial testing task, after deletion, this node will no longer report data for that task, but already reported data remains unaffected.

<img src="../img/node-delete.png" width="60%" >

## Install the Node

After creating a new node, you need to complete the installation in DataKit to enable its use.

1. After creating a user-defined node, you need to obtain the configuration information for the specified node via **User-defined Node Management > Get Configuration**;
2. Complete the [installation](../integrations/dialtesting.md) of the dial testing node in DataKit, ensuring that the server where the dial testing node is deployed can detect the target node (country, region, ISP).