# Create a WEBSOCKET Test Task
---

WebSocket testing allows clients to initiate HTTP requests to the server, establish WebSocket connections, thereby verifying requests and judgment conditions (such as request headers, response times, etc.).


## Start Creating

Click **Create > Synthetic Tests**, and select **WEBSOCKET Protocol**.

![API Test WebSocket](../../img/api_test_websocket.png)


### 1. Define Request Format

1. URL: Supports entering URLs for both WS and WSS protocols.  
2. Advanced Settings: Supports custom request settings and authentication.  
3. Content: Enter the message content to be sent to the server.  
4. Name: Customize the name of the WebSocket test task; duplication is not allowed within the current workspace.


### 2. Define Conditions {#test}

That is, match data by adding judgment conditions. Multiple conditions can be combined using "All" or "Any" to achieve AND or OR logical relationships.

After defining the request format and adding judgment conditions, click the "Test" button to the right of the URL to verify whether the test connection configuration is successful.

**Note**: The test result is independent of the selected node.

### 3. Select Test Nodes

Currently <<< custom_key.brand_name >>> covers 14 global test nodes. You can choose one or more nodes from within China or overseas regions (for Commercial Plan users and above) to quickly start monitoring site service quality.



### 4. Select Test Frequency

Choose the execution frequency for the test task. Supported options include:

- 1 minute (Commercial Plan users and above only)
- 5 minutes (Commercial Plan users and above only)
- 15 minutes (Commercial Plan users and above only)
- 30 minutes
- 1 hour
- 6 hours
- 12 hours
- 24 hours