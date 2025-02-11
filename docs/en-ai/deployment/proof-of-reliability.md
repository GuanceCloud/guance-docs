# Reliability Verification
---

This article verifies the reliability of the central deployment through a complete data pipeline:

- Collecting large amounts of data using Datakit's specific collectors
- Uploading data to Kodo via Dataway
- Kodo writes the data into log storage according to established procedures


## Environment Preparation {#prepare}

- A basic Linux machine with Datakit installed and the [logstreaming collector](../integrations/logstreaming.md) enabled
- Prepare a test script to push data to Datakit's logstreaming collector
- Enable an unlimited workspace so that it can handle a large volume of log data

## Implementation {#go}

- Download the test data, which contains 10,000 log entries, each 1KB in length:

```bash
wget https://static.guance.com/testing-data/10000-1kb.log
```

- Modify the following script by filling in the prepared Datakit IP address, and save the script as *curl-log-streaming.sh*:

```bash
#!/bin/bash

# Check if parameters are provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <number_of_iterations>"
    exit 1
fi

# Read command-line arguments as loop iterations
num_iterations=$1
file=$2

# Execute specified iterations using a for loop
for ((i=1; i<=num_iterations; i++)); do
		curl -v http://<YOUR-DATAKIT-IP>:9529/v1/write/logstreaming?source=drop-testing --data-binary "@$2"
        sleep 2.5 # Sleep for 2.5 seconds
done
```

- Execute the above script, which will send 40,000 requests to Datakit over approximately 28 hours:

```bash
bash curl-log-streaming.sh 40000 10000-1kb.log
```

## Result Review {#show}

After completing the above steps, you should see `logstreaming/drop-testing` collection in Datakit's monitor:

```bash
datakit monitor -MI
```

You can view the request latency from Datakit to Dataway using the following command:

```bash
datakit monitor -MW
```

In the Guance log Explorer, set the log source (`source`) to `drop-testing`. The height of each bar (with a 1-minute interval) should be around 220,000 to 240,000 (`60s/2.5s*10000`). Under normal circumstances, the data distribution is very uniform without sudden spikes or drops (since the data write frequency is fixed).

During this process, you can search for "dataway" in the built-in views to check the metrics of Dataway itself. Additionally, you should review the Explorers for NSQ, GuanceDB, Kodo, and Kodo-X to ensure their successful deployment.