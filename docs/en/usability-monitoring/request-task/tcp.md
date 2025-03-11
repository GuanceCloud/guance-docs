# Create a TCP Test Task
---

TCP testing is used to monitor TCP connections on host ports, ensuring the availability of critical services such as SSH (22), SMTP (25), DNS (53), and HTTPS-based VPNs (443), as well as other custom ports. Through response time data, you can track the performance of network applications and discover all gateways along the path to the target host using traceroute functionality.


## Getting Started

Click **Create > Synthetic Tests**, and select **TCP Protocol**.

![API Test TCP](../../img/api_test_tcp.png)


### 1. Define Request Format

1. Host: Supports entering a host address and port. The host address can be a domain name (e.g., `www.example.com`) or an IP address (e.g., `192.168.0.1`), with the default port being `443`.  
2. Name: Customize the name for the TCP test task; duplication is not allowed within the current workspace.  
3. Traceroute: When enabled, it starts a traceroute probe (`traceroute`) to discover all gateways along the path to the target host.

### 2. Availability Conditions {#test}

You can add conditions to filter data based on specific criteria. When multiple conditions are selected, you can define the logical relationship as `AND` or `OR` using "All" or "Any".


After defining the request format and adding conditions, click the **Test** button to the right of the URL to verify if the test connection configuration is successful and return traceroute results (if relevant conditions are configured).


**Note**:

- If "Network Hops" is chosen as a condition, the system will return traceroute data, similar to enabling the Traceroute function.
- Test results are independent of the selected test node.

### 3. Select Test Nodes

Currently <<< custom_key.brand_name >>> covers 14 global test nodes. You can choose one or more nodes from China or overseas regions (for Commercial Plan users and above) to quickly start monitoring site service quality.


### 4. Select Test Frequency

Choose the execution frequency for the test task. The following options are supported:

- 1 minute (Commercial Plan users and above only)
- 5 minutes (Commercial Plan users and above only)
- 15 minutes (Commercial Plan users and above only)
- 30 minutes
- 1 hour
- 6 hours
- 12 hours
- 24 hours