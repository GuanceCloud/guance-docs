# 切换域名

???+ warning "注意"
     如果之前启用了HTTPS，您需要提前准备新域名的**证书**。此次更换域名假定为`dataflux.cn` 替换为 `guance.com`

## 简介

本文将介绍如何替换观测云的域名，以下为主要步骤：

1. Launcher 修改域名
2. 修改 configmap里所有域名
3. 添加证书 Secret（可选）
4. 修改所有 ingress 的域名
5. 重启服务

## 影响范围

观测云 Studio 无法使用，时间大概15～30分钟无法访问。

## 操作步骤

### 步骤一：Launcher 修改域名和证书名称

- 打开 Launcher 右上角的设置
- 点击域名
- 修改域名，保存。

![](img/faq-ingress-2.png)

![](img/faq-ingress-1.png)

### 步骤二：修改 configmap 里所有域名

- 可以执行以下脚本备份：

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

- 执行以下脚本修改地址：

???+ warning "注意"
      需要替换`OLD_VALUE` 和 `NEW_VALUE` 的变量。

```shell
# 设置要替换的键值对
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
     echo "$i $configmap 有$(kubectl get configmaps -n $i -o yaml |grep -c $OLD_VALUE) 处"
     kubectl get $configmap -n $i -o yaml | \
       sed "s/${OLD_VALUE}/${NEW_VALUE}/g" | \
       kubectl apply -f -
  fi
  done
done
```

### 步骤三：添加证书 Secret （可选）

- 打开 Launcher 右上角的设置
- 点击「域名 TLS 证书更新」
- 修改 TLS 证书，保存。

![](img/faq-ssl-1.png)

![](img/faq-ssl-2.png)

### 步骤四：修改所有 Ingress 的域名
???+ warning "注意"
     如果使用主机模式安装的 DataWay，需要修改 DataWay 的 `remote_host ` 参数。

可以执行以下脚本备份：

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

执行以下脚本修改地址：

```shell
OLD_VALUE="dataflux.cn"
NEW_VALUE="guance.com"
NAMESPACE="forethought-core forethought-kodo forethought-webclient func2 middleware utils launcher"

for i in $NAMESPACE;
do
  for ing in $(kubectl get ing -n $i -o jsonpath='{.items[*].metadata.name}');
  do
  if [[ `kubectl get ing $ing -n $i -o yaml |grep $OLD_VALUE` ]]; then
     echo "$i $ing 有$(kubectl get ing $ing -n $i -o yaml |grep -c $OLD_VALUE) 处"
     kubectl get ing $ing -n $i -o yaml | \
       sed "s/${OLD_VALUE}/${NEW_VALUE}/g" | \
       kubectl apply -f -
  fi
  done
done
```

### 步骤五：重启服务

```shell
kubectl delete pods --all -n forethought-core 
kubectl delete pods --all -n forethought-webclient  
kubectl delete pods --all -n func2
```

