# User-defined Node Management
---


In addition to the 14 built-in nodes of <<< custom_key.brand_name >>>, you can create new dial testing nodes globally. By setting up nodes based on different geographical locations and different ISPs, you can perform Synthetic Tests from multiple regions to fully understand the availability of your site.

![](img/image_2.png)

## Create a Node

Go to **Synthetic Tests > User-defined Node Management**, and click **Create**.

<img src="../img/create_self_node.png" width="60%" >

1. Select the country/region and province or city;
2. Choose the ISP;
3. The node code will be automatically filled in; duplicate node codes are not supported within the current workspace;  
4. Enter the node name; duplicate node names are not supported within the current workspace;
5. Click Confirm.


## Manage Nodes

In the node list, you can uniformly view and manage all user-defined nodes in the current workspace:

- Click "Get Configuration" to directly copy the configuration information in the pop-up window;
- Click "Audit Logs" to view the operation records related to this node;
- Click "Delete" to delete the current node. If the user-defined node is associated with a Test task, after deletion, this node will no longer report data for that task, but already reported data remains unaffected.

<img src="../img/node-delete.png" width="60%" >


## Install Nodes

After creating a node, you need to complete the installation in DataKit to enable its use.

1. After creating a user-defined node, you need to obtain the configuration information of the specified node through **User-defined Node Management > Get Configuration**;  

2. Complete the [installation](../integrations/dialtesting.md) of the dial testing node in DataKit, ensuring that the server where the dial testing node is deployed can detect the target node (country, region, ISP).