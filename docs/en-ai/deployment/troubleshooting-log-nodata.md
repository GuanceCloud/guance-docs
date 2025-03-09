# Data Discontinuity Troubleshooting

## Introduction

This article will introduce how to troubleshoot log, trace, and metrics data discontinuity issues in <<< custom_key.brand_name >>>.

## Architecture Diagram

The <<< custom_key.brand_name >>> data flow is as follows:

1. DataKit pushes metric logs to the <<< custom_key.brand_name >>> DataWay cluster.
2. DataWay pushes the data to the kodo service for processing.
3. kodo pushes the processed data to the nsqd message queue service.
4. kodo-x requests data consumption from the nsqd message queue service.
5. kodo-x pushes the consumed data to the corresponding storage engine.

![](img/faq-log-1.png)

## Data Discontinuity Troubleshooting Steps

### Step One: Check Host Time

Please confirm the following information:

- The host time of the <<< custom_key.brand_name >>> cluster matches the current time.
- The DataKit collector host time matches the current time.

You can check this by running the command:
```shell
date
```

If the host time does not match the current time, please correct it using the following methods:

=== "Online Environment"
    ```shell
    # Install ntpdate
    yum install ntpdate -y

    # Synchronize local time
    ntpdate time.windows.com

    # Synchronize with network source
    ntpdate cn.pool.ntp.org
    ```

=== "Offline Environment"
    ```shell
    sudo date -s "2022-01-01 10:30:00"
    ```
    > Note: Modify the time accordingly

### Step Two: Collector Troubleshooting

Refer to [DataKit Data Discontinuity Troubleshooting](../datakit/why-no-data.md)

### Step Three: View DataWay Service Logs

Please follow these steps:

```shell
# Login to the container
kubectl exec -ti -n <Namespace> <dataway pod name> bash
# View logs
cd /usr/local/cloudcare/dataflux/dataway
# Search for error logs
grep -Ei error log
```


### Step Four: Check the Running Status of Each Service

- Check if the cluster node status is normal

  ```shell
  kubectl get node
  ```

- Check if all services under `forethought-kodo` are running normally

  ```shell
  kubectl get pods -n forethought-kodo
  ```

- Check if the nsqd service status is normal

  ```shell
  kubectl get pods -n middleware | grep nsqd
  ```

- Check if the storage engine is functioning normally

  ```shell
  kubectl get pods -n middleware
  ```


### Step Five: View kodo Service Logs

???+ warning "Note"
     Viewing the kodo service logs can help determine whether <<< custom_key.brand_name >>> successfully pushed data to the consumption queue.

- Namespace: forethought-kodo

- Deployment: kodo

- Log path: /logdata/log

  

=== "kodo Service Normal"
    If the kodo service is normal, please execute the following commands:

    ```shell
    # Login to the container
    kubectl exec -ti -n forethought-kodo <kodo pod name> bash
    # View logs
    cd /logdata
    # Search for error logs
    grep -Ei error log
    ```

=== "kodo Service Abnormal"

    If the kodo service is abnormal, you will be unable to log into the container. You can first adjust the kodo log output mode and then view the container logs.

    - Modify kodo log output mode

      ```shell
      kubectl get configmap kodo -n forethought-kodo -o yaml | \
             sed "s/\/logdata\/log/stdout/g" | \
             kubectl apply -f -
      ```

    - Restart the kodo container

      ```shell
      kubectl rollout restart -n forethought-kodo deploy kodo 
      ```

    - View kodo container logs

      ```shell
      kubectl logs -f -n forethought-kodo <kodo pod name>
      ```

### Step Six: View kodo-x Service Logs

???+ warning "Note"
     Viewing the kodo-x service logs can help determine whether <<< custom_key.brand_name >>> successfully wrote data, and whether there are issues such as log throttling or slow log writing.

- Namespace: forethought-kodo
- Deployment: kodo-x
- Log path: /logdata/log

=== "kodo-x Service Normal"
   
    If the kodo-x service is normal, please execute the following commands:

    ```shell
    # Login to the container
    kubectl exec -ti -n forethought-kodo <kodo-x pod name> bash
    # View logs
    cd /logdata
    # Search for error logs
    grep -Ei error log
    ```

=== "kodo-x Service Abnormal"

    If the kodo-x service is abnormal, you will be unable to log into the container. You can first adjust the kodo-x log output mode and then view the container logs.

    - Modify kodo-x log output mode

      ```shell
      kubectl get configmap kodo-x -n forethought-kodo -o yaml | \
             sed "s/\/logdata\/log/stdout/g" | \
             kubectl apply -f -
      ```

    - Restart the kodo-x container

      ```shell
      kubectl rollout restart -n forethought-kodo deploy kodo-x
      ```

    - View kodo-x container logs

      ```shell
      kubectl logs -f -n forethought-kodo <kodo-x pod name>
      ```