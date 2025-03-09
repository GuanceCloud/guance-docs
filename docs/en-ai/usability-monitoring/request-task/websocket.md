# Create a WEBSOCKET Test Task
---

WebSocket testing allows the client to initiate an HTTP request to the server, establish a WebSocket connection, thereby verifying requests and judging conditions (such as request headers, response times, etc.).


## Start Creating

Click **Create > Synthetic Tests**, and select **WEBSOCKET Protocol**.

![API Test WebSocket](../../img/api_test_websocket.png)


### :material-numeric-1-circle: Define Request Format

1. URL: Supports entering URLs for both WS and WSS protocols.
2. Advanced Settings: Supports custom request settings and authentication.
3. Content: Enter the message content to be sent to the server.
4. Name: Customize the name of the WebSocket test task; duplication is not allowed within the current workspace.


### :material-numeric-2-circle: Define Conditions {#test}

This involves adding conditions to match data. Multiple conditions can be combined using "All" or "Any" to achieve AND or OR logical relationships.

After defining the request format and adding conditions, click the "Test" button to the right of the URL to verify whether the test configuration is successful.

**Note**: The test result is independent of the selected node.

### :material-numeric-3-circle: Select Test Nodes

Currently <<< custom_key.brand_name >>> covers 14 global test nodes. You can choose one or more nodes from either China or overseas regions (available only to Commercial Plan users and above) to quickly start monitoring site service quality.



### :material-numeric-4-circle: Select Test Frequency

Choose the execution frequency of the test task. The following options are supported:

- 1 minute (Commercial Plan users and above only)
- 5 minutes (Commercial Plan users and above only)
- 15 minutes (Commercial Plan users and above only)
- 30 minutes
- 1 hour
- 6 hours
- 12 hours
- 24 hours