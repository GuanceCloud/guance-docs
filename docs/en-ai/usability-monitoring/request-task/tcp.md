# Create a TCP Test Task
---

TCP tests are used to monitor TCP connections on host ports, ensuring the availability of critical services such as SSH (22), SMTP (25), DNS (53), and VPN over HTTPS (443), as well as other custom ports. Through response time data, you can track the performance of network applications and discover all gateways along the path to the target host using traceroute functionality.


## Getting Started

Click **Create > Synthetic Tests**, and select **TCP Protocol**.

<img src="../../img/api_test_tcp.png" width="70%" >


### :material-numeric-1-circle: Define Request Format

1. Host: Supports entering host addresses and ports. The host address can be a domain name (e.g., `www.example.com`) or an IP address (e.g., `192.168.0.1`), with the default port being `443`.  
2. Name: Customize the name for your TCP test task; it must be unique within the current workspace.  
3. Traceroute: When enabled, this will start a traceroute probe (`traceroute`) to discover all gateways along the path to the target host.

### :material-numeric-2-circle: Availability Criteria {#test}

You can add criteria to filter data based on conditions. When multiple criteria are selected, you can define logical relationships using "All" or "Any" to represent `AND` or `OR` logic.


After defining the request format and adding criteria, click the **Test** button to the right of the URL to verify whether the test configuration is successful and return traceroute results (if configured).


**Note**:

- If "Network Hops" is chosen as a criterion, the system will return traceroute data, similar to enabling the Traceroute feature.
- Test results are independent of the selected test node.

### :material-numeric-3-circle: Select Test Nodes

Currently, <<< custom_key.brand_name >>> covers 14 global test nodes. You can choose one or more nodes from China or overseas regions (available only for Commercial Plan users and above) to quickly initiate site service quality monitoring.


### :material-numeric-4-circle: Select Test Frequency

Choose the execution frequency for the test task. The following options are supported:

- 1 minute (Commercial Plan users and above only)
- 5 minutes (Commercial Plan users and above only)
- 15 minutes (Commercial Plan users and above only)
- 30 minutes
- 1 hour
- 6 hours
- 12 hours
- 24 hours