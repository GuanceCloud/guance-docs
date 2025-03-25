# Switch Domain

???+ warning "Note"
     If HTTPS was previously enabled, you need to prepare the **certificate** for the new domain in advance. This domain replacement assumes `dataflux.cn` is replaced with `<<< custom_key.brand_main_domain >>>`.

## Introduction

This article will explain how to replace the domain of <<< custom_key.brand_name >>>. The main steps are as follows:

1. Modify the domain in Launcher
2. Update all domains in configmap
3. Add certificate Secret (optional)
4. Modify all ingress domains
5. Restart services

## Scope of Impact

<<< custom_key.brand_name >>> Studio will be unavailable, approximately 15-30 minutes.

## Operation Steps

### Step One: Modify the domain and certificate name in Launcher

- Open the settings in the top-right corner of Launcher
- Click on the domain
- Modify the domain and save.

![](img/faq-ingress-2.png)

![](img/faq-ingress-1.png)

### Step Two: Modify all domains in configmap

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

- Execute the following script to modify the address:

???+ warning "Note"
      You need to replace the variables `OLD_VALUE` and `NEW_VALUE`.

```shell
# Set the key-value pairs to be replaced
OLD_VALUE="dataflux.cn"
NEW_VALUE="<<< custom_key.brand_main_domain >>>"
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

### Step Three: Add certificate Secret (optional)

- Open the settings in the top-right corner of Launcher
- Click on "Update TLS Certificate for Domain"
- Modify the TLS certificate and save.

![](img/faq-ssl-1.png)

![](img/faq-ssl-2.png)

### Step Four: Modify all Ingress domains
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

Execute the following script to modify the address:

```shell
OLD_VALUE="dataflux.cn"
NEW_VALUE="<<< custom_key.brand_main_domain >>>"
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

### Step Five: Restart services

```shell
kubectl delete pods --all -n forethought-core 
kubectl delete pods --all -n forethought-webclient  
kubectl delete pods --all -n func2
```