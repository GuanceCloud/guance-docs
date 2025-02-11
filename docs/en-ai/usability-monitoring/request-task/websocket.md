# Create a WEBSOCKET Dial Testing Task
---

WEBSOCKET dial testing allows your client to initiate an HTTP request to the server, establish a WEBSOCKET connection, and verify the defined requests and judgment conditions, such as request headers, response times, etc.

## Create a Task

In the Guance workspace, click **New > Synthetic Tests**, and select **WEBSOCKET Protocol**.

![](../img/4.dailtesting_websocket_1.png)

You can add [labels](../../management/global-label.md) in the top-left corner for the current dial testing task, enabling data linkage within the current workspace through global labels. Added labels are saved and displayed directly in the list. You can quickly find the dial testing tasks under specific labels using the **Shortcut > Labels** on the left panel.

**Additional Label Logic**: Set the dial testing task node to `node_name:South China-Guangzhou-China Telecom`. If you add a label `node_name:User-defined Node` to the dial testing task, this custom label `node_name:User-defined Node` will not be written into the dial test result attributes.

### Define Request Format

<img src="../../img/4.dailtesting_websocket_2.png" width="70%" >

1. URL: Supports both WS and WSS protocol URLs;
2. Advanced Settings: Adjust advanced settings according to actual needs, including request settings and authentication;
3. Content: Input the message to send to the client;
4. Name: Customize the name of the WEBSOCKET dial testing task; duplicate names are not supported within the same space.

### Availability Judgment

You can add judgment conditions to match data based on filtering criteria. When multiple judgment conditions are selected, you can choose "All" or "Any" to determine the `AND` or `OR` relationship between conditions.

<img src="../../img/4.dailtesting_websocket_3.png" width="80%" >

After defining the request format and adding availability judgment conditions, you can click the **Test** button next to the URL to check if the dial test connection configuration is successful.

**Note**: Testing is independent of the selected node.

### Select Dial Testing Nodes

Guance currently covers 14 dial testing nodes globally. You can choose one or more nodes from China or overseas regions (only available for Commercial Plan users and above) to quickly start monitoring the service quality of your site.

<img src="../../img/4.dailtesting_http_4.png" width="80%" >

### Choose Dial Testing Frequency

Select the frequency at which cloud dial testing returns data. Options include 1 minute (only available for Commercial Plan users and above), 5 minutes (only available for Commercial Plan users and above), 15 minutes (only available for Commercial Plan users and above), 30 minutes, 1 hour, 6 hours, 12 hours, and 24 hours.

<img src="../../img/4.dailtesting_http_5.png" width="70%" >