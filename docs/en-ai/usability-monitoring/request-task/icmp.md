# Create ICMP Test Task
---

ICMP testing can be used to monitor the network communication status of a host. By sending one or more ICMP requests (Ping), you can check packet connectivity, packet loss rate, and round-trip time (RTT). If route tracing (Traceroute) or network hops are configured, the system will return route tracing results, showing the number of network hops required to connect to the target host and detailed information for each hop.

## Start Creating

Click **Create > Synthetic Tests**, and select **ICMP Protocol**.

![API Test ICMP](../../img/api_test_icmp.png)


### 1. Define Request Format

1. Host: Enter the host address, supporting domain format (e.g., `www.example.com`) or directly enter an IP address (e.g., `192.186.0.1`);
2. Route Tracing: When enabled, it will start a route tracing probe (`traceroute`) to discover all gateways on the path to the target host;
3. Pings per Test: Choose to send 1 to 10 ICMP packets;
4. Name: Customize the name of the ICMP test task; duplicate names are not allowed within the current workspace.

### 2. Availability Judgment {#test}

You can add judgment conditions based on filtering criteria to match data. When multiple judgment conditions are selected, you can define AND or OR logical relationships using "All" or "Any".

After defining the request format and adding judgment conditions, click the "Test" button to the right of the URL to verify if the test connection configuration is successful. The test will return the number of sent/received packets based on the Pings sent during each test. If route tracing or network hops are configured, it will also return route tracing results.

**Note**:

- If "Network Hops" is chosen as a judgment condition, the system will return route tracing data similar to the Traceroute function;
- If the test task fails to successfully Ping the target, the round-trip time will display as 0, indicating no valid round-trip time;
- Test results are independent of the selected nodes.


### 3. Select Test Nodes

Currently <<< custom_key.brand_name >>> covers 14 global test nodes. You can choose one or more nodes from China or overseas regions (for Commercial Plan users and above) to quickly start site service quality monitoring.


### 4. Select Test Frequency

Choose the execution frequency for the test task, with the following options available:

- 1 minute (Commercial Plan users and above)
- 5 minutes (Commercial Plan users and above)
- 15 minutes (Commercial Plan users and above)
- 30 minutes
- 1 hour
- 6 hours
- 12 hours
- 24 hours