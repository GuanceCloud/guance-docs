# Self-built Node Management
---

## Introduction

Guance Cloud platform supports building new dial-up nodes around the world, that is, you can quickly build quality of service monitoring points distributed around the world through "self-built node management".

## New node

You can register a new dial test node by clicking "New Node" in "Cloud Dial Test"-"Self-built Node Management".

- Country: Select the geographical location of the self-built node, including country, province or city
- Operator: select the operator
- Node Code: Code Code used to obtain node information. Node Code does not support duplication in current space
- Node name: User-defined node name. Duplicate node name is not supported in current space

![](img/4.dailtesting_1.png)

## Node Management

On the Self-built Node Management page, you can view and manage existing self-built nodes in a unified way.

- When hovering over the node name, click Edit button to edit the node name again
- Click "Get Configuration" to get the configuration information of this node, which can be used to complete the installation of the dial-up node in DataKit
- Click "Delete" to delete the node. **Note: Once a node is deleted, the dialing task corresponding to the node will also be deleted**

![](img/image_1.png)

## Dialing Test Service Architecture Diagram

![](img/image_2.png)

## Install Dial Test Node

After "New Node", you need to complete the installation in DataKit before you can start the use of the node. The steps for installing the dial test node are as follows:

**Step 1:** After creating a self-built node, you need to get the configuration information of the specified node through "Self-built Node Management"-"Get Configuration

![](img/image_3.png)

**Step 2**: Install the dialing test node in DataKit and ensure that the server deploying the dialing test node detects the target node (country, region, operator). For details, refer to [network dialing test](../integrations/network/dialtesting.md).

After completing the installation of the dial test node, you can select the "Self-built" node when configuring the "Cloud Dial Test".
