## Common Cause Analysis

- The Dataway service did not run properly after being deployed to the server.
- The Dataway service configuration file is incorrect, such as not configuring the correct listening settings or workspace token information.
- The Dataway service runtime configuration is incorrect. This can be identified by checking the Dataway logs.
- The server where Dataway is deployed cannot communicate with the kodo service (including that the dataway server has not added the correct df-kodo service resolution in the hosts).
- The kodo service is malfunctioning. This can be confirmed by checking the kodo service logs.
- The df-kodo ingress service is not correctly configured. This is specifically manifested as an inability to access `http|https://df-kodo.<xxxx>:<port>`.