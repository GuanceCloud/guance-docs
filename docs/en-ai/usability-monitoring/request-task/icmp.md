# Create ICMP Test Task
---

ICMP tests can be used to monitor the network communication status of a host. By sending one or more ICMP requests (Ping), you can check packet connectivity, packet loss rate, and round-trip time (RTT). If route tracing (Traceroute) or network hops are configured, the system will return route tracing results, showing the number of network hops required to connect to the target host and detailed information for each hop.

## Start Creating

Click **Create > Synthetic Tests**, and select **ICMP Protocol**.

![API Test ICMP](../../img/api_test_icmp.png)

### :material-numeric-1-circle: Define Request Format

1. Host: Enter the host address, supporting domain name format (e.g., `www.example.com`) or directly input an IP address (e.g., `192.186.0.1`);
2. Route Tracing: When enabled, it starts the route tracing probe (`traceroute`) to discover all gateways on the path to the target host;
3. Pings per Test: You can choose to send 1 to 10 ICMP packets;
4. Name: Customize the name of the ICMP test task; duplicate names are not allowed within the current workspace.

### :material-numeric-2-circle: Availability Judgment {#test}

You can add judgment conditions based on filtering criteria to match data. When multiple judgment conditions are selected, you can define AND or OR logical relationships using "All" or "Any."

After defining the request format and adding judgment conditions, click the "Test" button to the right of the URL to verify if the test connection configuration is successful. The test will return the number of sent/received packets based on the Pings sent during each test. If route tracing or network hops are configured, it will also return route tracing results.

**Note**:

- If "Network Hops" is chosen as a judgment condition, the system will return route tracing data, similar to the Traceroute function;
- If the test task fails to successfully Ping the target, the round-trip time will display as 0, indicating no valid round-trip time;
- Test results are independent of the selected nodes.

### :material-numeric-3-circle: Select Test Nodes

Currently, <<< custom_key.brand_name >>> covers 14 global test nodes. You can choose one or more nodes from China or overseas regions (for Commercial Plan users and above) to quickly start monitoring site service quality.

### :material-numeric-4-circle: Select Test Frequency

Choose the execution frequency of the test task, with the following options supported:

- 1 minute (Commercial Plan users and above only)
- 5 minutes (Commercial Plan users and above only)
- 15 minutes (Commercial Plan users and above only)
- 30 minutes
- 1 hour
- 6 hours
- 12 hours
- 24 hours