The phenomenon is shown in the following figure:
![](img/not_see_dataway_1.jpg)

### Troubleshooting Ideas

**Assumption 1: The backend management interface does not display the version number. After installing DataWay, the version number must be displayed to indicate a successful connection.**

As shown in the figure:

![](img/not_see_dataway_2.jpg)

1. First, check if the configuration file of DataWay is correct, whether the correct listening port and workspace token information are configured.

2. Check if the DataWay service is running normally,

```shell
kubectl get pods -n launcher
```

3. Check for any errors when running normally

```shell
kubectl logs -f -n launcher <launcher_name>
```

4. Check if the deployed kodo service is abnormal, which can be confirmed by checking the kodo service logs

- First, enter the pod of the kodo service

```shell
kubectl exec -ti -n forethought-kodo <kodo_pod_name> -- /bin/bash
```

- Then go to the `/logdata` directory to view log files

```
cd /logdata
tail -f logs
```

5. Check if the DataWay service can communicate normally with the kodo service (including whether the `dataway` server has not added the correct resolution of the `df-kodo` service in the `hosts`).

6. Check in Studio integration whether the DataWay list is normal.

**Assumption 2: The backend management interface displays the version number, but in the Studio integration, the DataWay list under the DataKit module is empty**

1. If all the above situations have been resolved, an empty list problem appears.

2. If it was deployed once before, it may be due to Redis cache not being cleared. If there is no persistent storage, restarting the container will do.

```shell
kubectl delete pods -n middleware <redis_pod_name>
```

3. Another possibility is that formatting errors occurred during copy-paste, causing the system workspace token to not be found. You can copy the token again and use the vim command line with "/" to check for formatting issues.