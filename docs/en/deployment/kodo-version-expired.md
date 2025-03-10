# Deployment Plan kodo Version Expiration
---

## Explanation
After version 1.93.173 of <<< custom_key.brand_name >>>, when the page reports an expired kodo service version, you can continue using <<< custom_key.brand_name >>> by adding parameters to the service. **However, a significantly outdated service version means new features cannot be used, and upgrading to a newer version later will be complicated and prone to errors due to skipping multiple versions. Therefore, it is recommended that private deployment projects maintain an upgrade frequency similar to SaaS iterations or ensure that they do not lag more than three iterations behind the latest version.**

## Problem Description
In a private deployment environment, if the kodo service version lags behind the current SaaS version by more than 180 days, the frontend page will throw an error **kodo version older than 60 days, expired, please update**, causing some functionalities of <<< custom_key.brand_name >>> to become unavailable.
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