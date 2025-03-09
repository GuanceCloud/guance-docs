# Switch Domain

???+ warning "Note"
     If HTTPS was previously enabled, you need to prepare the **certificate** for the new domain in advance. This domain replacement assumes `dataflux.cn` is being replaced with `guance.com`.

## Introduction

This document will guide you through how to replace the domain of <<< custom_key.brand_name >>>. The main steps are as follows:

1. Modify the domain in Launcher
2. Update all domains in configmaps
3. Add certificate Secret (optional)
4. Update all ingress domains
5. Restart services

## Impact Scope

<<< custom_key.brand_name >>> Studio will be unavailable for approximately 15-30 minutes.

## Operation Steps

### Step One: Modify Domain and Certificate Name in Launcher

- Open the settings in the top-right corner of Launcher.
- Click on Domain.
- Update the domain and save.

![](img/faq-ingress-2.png)

![](img/faq-ingress-1.png)

### Step Two: Update All Domains in Configmaps

- You can execute the following script to back up:

```shell
NAMESPACE="forethought-core forethought-kodo forethought-webclient func2 middleware utils launcher"

for i in $NAMESPACE;
do
  for o in $(kubectl get cm  -n $i --no-headers 2>/dev/null |awk {'print $1'});
  do
  filename=cm-$i-$o.yaml
  kubectl get cm $o -n $i -o yaml > $filename
  echo $i $o
  done
done
```

- Execute the following script to update the addresses:

???+ warning "Note"
      You need to replace the `OLD_VALUE` and `NEW_VALUE` variables.

```shell
# Set the key-value pairs to be replaced
OLD_VALUE="dataflux.cn"
NEW_VALUE="guance.com"
NAMESPACE="forethought-core forethought-kodo forethought-webclient func2 middleware utils launcher"

for i in $NAMESPACE;
do
  for configmap in $(kubectl get configmaps -o name -n $i 2>/dev/null |awk {'print $1'});
  do
  #echo $configmap
  # kubectl get $configmap -n $i -o yaml |grep $OLD_VALUE
  if [[ `kubectl get $configmap -n $i -o yaml |grep $OLD_VALUE` ]]; then
     echo "$i $configmap has $(kubectl get configmaps -n $i -o yaml |grep -c $OLD_VALUE) occurrences"
     kubectl get $configmap -n $i -o yaml | \
       sed "s/${OLD_VALUE}/${NEW_VALUE}/g" | \
       kubectl apply -f -
  fi
  done
done
```

### Step Three: Add Certificate Secret (Optional)

- Open the settings in the top-right corner of Launcher.
- Click on "Update Domain TLS Certificate".
- Update the TLS certificate and save.

![](img/faq-ssl-1.png)

![](img/faq-ssl-2.png)

### Step Four: Update All Ingress Domains
???+ warning "Note"
     If DataWay is installed using host mode, you need to modify the `remote_host` parameter of DataWay.

You can execute the following script to back up:

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

Execute the following script to update the addresses:

```shell
OLD_VALUE="dataflux.cn"
NEW_VALUE="guance.com"
NAMESPACE="forethought-core forethought-kodo forethought-webclient func2 middleware utils launcher"

for i in $NAMESPACE;
do
  for ing in $(kubectl get ing -n $i -o jsonpath='{.items[*].metadata.name}');
  do
  if [[ `kubectl get ing $ing -n $i -o yaml |grep $OLD_VALUE` ]]; then
     echo "$i $ing has $(kubectl get ing $ing -n $i -o yaml |grep -c $OLD_VALUE) occurrences"
     kubectl get ing $ing -n $i -o yaml | \
       sed "s/${OLD_VALUE}/${NEW_VALUE}/g" | \
       kubectl apply -f -
  fi
  done
done
```

### Step Five: Restart Services

```shell
kubectl delete pods --all -n forethought-core 
kubectl delete pods --all -n forethought-webclient  
kubectl delete pods --all -n func2
```