# Amazon EKS Integration
---

[Amazon Elastic Kubernetes Service (Amazon EKS)](https://aws.amazon.com/eks/){:target="_blank"} is a managed container service for running and scaling Kubernetes applications in the AWS cloud.
DataKit provides observability for Amazon EKS clusters at different dimensions such as namespaces, clusters, and Pods. Customers can use existing AWS support agreements to obtain support.


## Architecture Overview {#architecture-overview}

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-eks-architecture-overview.png){ width="800" }
  <figcaption>Architecture Diagram</figcaption>
</figure>

## Deploy DataKit {#add-on-install}

Use the Amazon EKS addon to deploy DataKit on an Amazon EKS cluster.

### Prerequisites {#prerequisites-addon-install}

- Subscribe to [Guance Container Agent](https://aws.amazon.com/marketplace/pp/prodview-tdwkw3qcsimso?sr=0-2&ref_=beagle&applicationId=AWSMPContessa){:target="_blank"} on the AWS Marketplace.
- You have access to an [Amazon EKS cluster](https://aws.amazon.com/eks/){:target="_blank"}.
- You need to obtain `DK_DATAWAY` in advance. You can also follow the instructions below:
    - Go to the [Guance](https://en.guance.com/){:target="_blank"} website, refer to the [registration](https://docs.guance.com/en/billing/commercial-register/){:target="_blank"} guide to become a Guance user.
    - Click on the "Integration" menu, then select the "DataKit" tab, and copy the `DK_DATAWAY` parameter as shown in the image:

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-eks-zh-get-datawayurl.png){ width="800" }
  <figcaption></figcaption>
</figure>  

<!-- markdownlint-disable MD046 -->  
=== "Enable DataKit Add-on from AWS Console"

    - Search for the add-on
    
      First, in the Amazon EKS console, go to your EKS cluster and under the "Add-ons" tab, select "Get more add-ons". In the cluster settings of your existing EKS cluster, look for new third-party EKS add-ons and search for `datakit`, select "Guance Container Agent", and proceed to the next step.
    
    <figure markdown>
      ![](https://static.guance.com/images/datakit/eks-install/get-more-addon.png){ width="800" }
      <figcaption></figcaption>
    </figure>
    
    <figure markdown>
      ![](https://static.guance.com/images/datakit/eks-install/search-datakit-addon.png){ width="800" }
      <figcaption></figcaption>
    </figure>

    - Confirm installation
      Choose the latest version to install.
    
    <figure markdown>
      ![](https://static.guance.com/images/datakit/eks-install/select-install-addon.png){ width="800" }
      <figcaption></figcaption>
    </figure>    
        
    <figure markdown>
      ![](https://static.guance.com/images/datakit/eks-install/install-datakit-addon.png){ width="800" }
      <figcaption></figcaption>
    </figure>    

=== "Enable DataKit Add-on using AWS CLI"

    ???+ tip
        You need to replace `$YOUR_CLUSTER_NAME` and `$AWS_REGION` with your actual Amazon EKS cluster name and AWS region.
        
    Installation:
    
    ```shell
    aws eks create-addon --addon-name guance_datakit --cluster-name $YOUR_CLUSTER_NAME --region $AWS_REGION
    ```
    
    Verification:
    
    ```shell
    aws eks describe-addon --addon-name guance_datakit --cluster-name $YOUR_CLUSTER_NAME --region $AWS_REGION
    ```
<!-- markdownlint-enable -->


### Configure DataKit {#config-addon-datakit}


Set the `token` environment variable:

```shell
token="https://us1-openway.guance.com?token=<YOUR-WORKSPACE-TOKEN>"
```

Add the token to the `env-dataway` secrets:

```shell
envDataway=$(echo -n "$token" | base64)
kubectl patch secret env-dataway -p "{\"data\": {\"datawayUrl\": \"$envDataway\"}}" -n datakit
```

Restart DataKit:

```shell
kubectl rollout restart ds datakit -n datakit
```

### Verify Deployment {#verify-addon-install}

- Get deployment status

```shell
helm ls -n datakit
```

Expected output:

```txt
datakit  datakit  1  2024-01-12 14:50:07.880846 +0800 CST  deployed  datakit-1.20.0  1.20.0
```

- Verify on the Guance platform

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-eks-zh-verify.png){ width="800" }
  <figcaption>Verification</figcaption>
</figure>

## Deploy DataKit on Amazon EKS Cluster Using Helm {#helm-install}

### Prerequisites {#prerequisites-helm-install}

- Install the following tools: [Helm 3.7.1](https://github.com/helm/helm/releases/tag/v3.7.1){:target="_blank"}, [kubectl](https://kubernetes.io/docs/tasks/tools/){:target="_blank}, and [AWS CLI](https://aws.amazon.com/cli/){:target="_blank"}.
- You have access to an [Amazon EKS cluster](https://aws.amazon.com/eks/){:target="_blank"}.
- You need to obtain `DK_DATAWAY` in advance. You can also follow the instructions below:
    - Go to the [Guance](https://en.guance.com/){:target="_blank"} website, refer to the [registration](https://docs.guance.com/en/billing/commercial-register/){:target="_blank"} guide to become a Guance user.
    - Click on the "Integration" menu, then select the "DataKit" tab, and copy the `DK_DATAWAY` parameter as shown in the image:

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-eks-zh-get-datawayurl.png){ width="800" }
  <figcaption>Copy URL</figcaption>
</figure>
  

### Log in to ECR Repository {#login-ecr}

```shell
export HELM_EXPERIMENTAL_OCI=1

aws ecr get-login-password \
    --region us-east-1 | helm registry login \
    --username AWS \
    --password-stdin 709825985650.dkr.ecr.us-east-1.amazonaws.com
```

### Helm Install (Upgrade) DataKit {#helm-install}

<!-- markdownlint-disable MD046 -->
???+ attention "Important Notes"

    The Helm version must be 3.7.1.
    `datakit.datawayUrl` must be modified.

<!-- markdownlint-enable -->

```shell
helm upgrade -i datakit oci://709825985650.dkr.ecr.us-east-1.amazonaws.com/guance/datakit-charts --version 1.23.5 \
     --create-namespace -n datakit
```

Expected output:

```shell
Release "datakit" does not exist. Installing it now.
Warning: chart media type application/tar+gzip is deprecated
Pulled: 709825985650.dkr.ecr.us-east-1.amazonaws.com/guance/datakit-charts:1.23.5
Digest: sha256:04ce9e0419d8f19898a5a18cda6c35f0ff82cf63e0d95c8693ef0a37ce9d8348
NAME: datakit
LAST DEPLOYED: Fri Jan 12 14:50:07 2024
NAMESPACE: datakit
STATUS: deployed
REVISION: 1
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace datakit -l "app.kubernetes.io/name=datakit,app.kubernetes.io/instance=datakit" -o jsonpath="{.items[0].metadata.name}")
  export CONTAINER_PORT=$(kubectl get pod --namespace datakit $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
  echo "Visit http://127.0.0.1:9527 to use your application"
  kubectl --namespace datakit port-forward $POD_NAME 9527:$CONTAINER_PORT
```

### Configure DataKit {#config-datakit}

Set the `token` environment variable:

```shell
token="https://us1-openway.guance.com?token=<YOUR-WORKSPACE-TOKEN>"
```

Add the token to the `env-dataway` secrets:

```shell
envDataway=$(echo -n "$token" | base64)
kubectl patch secret env-dataway -p "{\"data\": {\"datawayUrl\": \"$envDataway\"}}" -n datakit
```

Restart DataKit:

```shell
kubectl rollout restart ds datakit -n datakit
```

### Verify Deployment {#verify-install}

- Get deployment status

```shell
helm ls -n datakit
```

Expected output:

```txt
datakit  datakit  1  2024-01-12 14:50:07.880846 +0800 CST  deployed  datakit-1.20.0  1.20.0
```

- Verify on the Guance platform

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-eks-zh-verify.png){ width="800" }
  <figcaption>Verification</figcaption>
</figure>

## Further Reading {#more-reading}

[K8s Installation](datakit-daemonset-deploy.md)