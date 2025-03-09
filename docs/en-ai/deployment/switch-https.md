# Switch to HTTPS Access

## Introduction

This document only describes how to modify the already deployed <<< custom_key.brand_name >>> from HTTP access to support HTTPS.

## Prerequisites

- Verify the validity of the SSL certificate and Ingress plugin support for HTTPS before proceeding.
- <<< custom_key.brand_name >>> has been successfully deployed and is accessible.
- Cluster permissions for <<< custom_key.brand_name >>>.
- <<< custom_key.brand_name >>> Launcher page.

## Impact Scope

<<< custom_key.brand_name >>> Studio will experience brief periods of inaccessibility.

## Procedure

### Step One: Modify Domain Name and Certificate Name in Launcher

- Open the settings in the top-right corner of Launcher.
- Click on "External Domain TLS Certificate Update".
- Add certificate information and update the TLS certificate.

![](img/launcher-ssl-config.png)

![](img/add-ssl-pem.png)

- Verification

For example, using `dataflux.cn`:

```shell
kubectl get secret -A  | grep dataflux.cn

forethought-core              dataflux.cn                                            kubernetes.io/tls                     2      8d
forethought-kodo              dataflux.cn                                            kubernetes.io/tls                     2      8d
forethought-webclient         dataflux.cn                                            kubernetes.io/tls                     2      8d
func2                         dataflux.cn                                            kubernetes.io/tls                     2      8d
middleware                    dataflux.cn                                            kubernetes.io/tls                     2      8d
utils                         dataflux.cn                                            kubernetes.io/tls                     2      8d
```

### Step Two: Add TLS to Ingress

- You can execute the following script to back up commands:

```shell
NAMESPACE="forethought-core forethought-kodo forethought-webclient func2 middleware utils launcher"

for i in $NAMESPACE;
do
  for ing in $(kubectl get ing -n $i -o jsonpath='{.items[*].metadata.name}');
  do
  filename=ing-$i-$ing.yaml
  kubectl get ing $ing -n $i -o yaml > $filename
  done
done
```

- Execute the following script to modify the address:

???+ warning "Note"
      Replace the `SecretName` variable with your domain's secret name.

```shell
SecretName="dataflux.cn"

NAMESPACE="forethought-core forethought-kodo forethought-webclient func2 middleware utils launcher"

for i in $NAMESPACE; do
  for ing in $(kubectl get ing -n $i -o jsonpath='{.items[*].metadata.name}'); do
    # Check if Ingress already has TLS configured
    TLS_EXISTS=$(kubectl get ing "$ing" -n "$i" -o jsonpath='{.spec.tls}')

    if [ -z "$TLS_EXISTS" ]; then
      # Extract current Ingress hosts
      HOSTS=$(kubectl get ing "$ing" -n "$i" -o jsonpath='{.spec.rules[*].host}')

      # Use kubectl patch command to update each Ingress
      kubectl patch ingress "$ing" -n "$i" --type='json' -p="[
        {
          \"op\": \"add\",
          \"path\": \"/spec/tls\",
          \"value\": [
            {
              \"hosts\": [$HOSTS],
              \"secretName\": \"$SecretName\"
            }
          ]
        }
      ]"
      echo "Updated Ingress $ing in namespace $i to use HTTPS."
    else
      echo "Ingress $ing in namespace $i already has HTTPS configured. Skipping."
    fi
  done
done
```

### Step Three: Modify <<< custom_key.brand_name >>> Frontend Configuration

- Open the settings in the top-right corner of Launcher.
- Click on "Modify Application Configuration".
- Modify the namespaces `forethought-webclient` for `frontWeb (User Frontend)` and `managementWeb (Management Platform Frontend)`, changing http to https.

![](img/frontweb-ssl.png)

![](img/management-ssl.png)

![](img/confirm-modification.png)

## Rollback Method

- Revert the frontend configuration changes.
- Apply the backed-up Ingress YAML files.

```shell
ls ing*.yaml | xargs -n 1 kubectl apply -f
```