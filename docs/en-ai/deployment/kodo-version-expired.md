# Deployment Plan kodo Version Expiration
---

## Description
After version 1.93.173 of Guance, when the page reports that the kodo service version has expired, you can continue using Guance by adding parameters to the service. **However, being many versions behind means new features cannot be utilized, and upgrading to a newer version later will be cumbersome and prone to errors due to skipping too many versions. Therefore, it is recommended that private deployment projects upgrade at the same frequency as SaaS iterations or ensure that they do not fall more than three iterations behind the latest version.**

## Problem Description
In a private deployment environment, if the kodo service version is more than 180 days behind the current SaaS version, the frontend page will throw an error **"kodo version older than 60 days, expired, please update"**, causing some functionalities of Guance to become unavailable.
![](img/kodo-version-expired-1.png)

## Problem Resolution
Add parameters to the service and restart it.
```shell
kubectl -n forethought-kodo edit deploy kodo
kubectl -n forethought-kodo edit deploy kodo-inner
```
Add the following parameters:
```yaml
          ...
          env:
            # Add the following content
            - name: KODO_DISABLE_EXPIRED_VESION_CHECKING
              value: "true"
```
After editing, observe whether the kodo and kodo-inner pods have restarted.