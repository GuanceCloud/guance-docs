## Common Cause Analysis

- The Dataway service did not run properly after being deployed to the server.
- The Dataway service configuration file is incorrect, without proper listener or workspace token information configured.
- The Dataway service runtime configuration is incorrect; this can be identified by checking the Dataway logs.
- The server where Dataway is deployed cannot communicate with the kodo service (including that the df-kodo service's correct resolution has not been added to the hosts on the Dataway server).
- The kodo service is malfunctioning; this can be confirmed by checking the kodo service logs.
- The df-kodo ingress service is not correctly configured. This is specifically manifested as an inability to access `http|https://df-kodo.<xxxx>:<port>`.