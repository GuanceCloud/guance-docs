# Reliability Verification
---

This article verifies the reliability of the central deployment through a complete data pipeline:

- Collecting large amounts of data using specific collectors in Datakit
- Uploading data to Kodo via Dataway
- Writing the data into log storage according to established procedures

## Environment Preparation {#prepare}

- A basic Linux machine with Datakit installed and the [logstreaming collector](../integrations/logstreaming.md) enabled
- Prepare a test script to push data to the logstreaming collector in Datakit
- Enable an unlimited workspace to handle a large volume of log data

## Implementation {#go}

- Download the test data, which contains 10,000 log entries, each 1KB in size:

```bash
wget https://static.<<< custom_key.brand_main_domain >>>/testing-data/10000-1kb.log
```

- Modify the following script by entering the prepared Datakit IP, and save the script as *curl-log-streaming.sh*:

```bash
#!/bin/bash

# Check if parameters are provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <number_of_iterations>"
    exit 1
fi

# Read command-line arguments for loop iterations
num_iterations=$1
file=$2

# Execute the specified number of iterations using a for loop
for ((i=1; i<=num_iterations; i++)); do
		curl -v http://<YOUR-DATAKIT-IP>:9529/v1/write/logstreaming?source=drop-testing --data-binary "@$2"
        sleep 2.5 # Sleep for 2.5s
done
```

- Run the above script, which will send 40,000 requests to Datakit, lasting approximately 28 hours:

```bash
bash curl-log-streaming.sh 40000 10000-1kb.log
```

## Result Review {#show}

After completing the steps above, you can see the `logstreaming/drop-testing` collection in Datakit's monitor:

```bash
datakit monitor -MI
```

You can check the request latency of Datakit reporting to Dataway using the following command:

```bash
datakit monitor -MW
```

In the <<< custom_key.brand_name >>> log Explorer, select the log source (`source`) as `drop-testing`. The height of each bar (with a 1-minute interval) in the status distribution chart should be around 220,000 to 240,000 (`60s/2.5s*10000`). Normally, the data is evenly distributed without sudden increases or drops (since data writing occurs at a fixed frequency).

During this process, you can search for "dataway" in the built-in views to check the metrics of Dataway itself. Additionally, you need to review the Explorers for components like NSQ/GuanceDB/Kodo/Kodo-X to ensure their successful deployment.