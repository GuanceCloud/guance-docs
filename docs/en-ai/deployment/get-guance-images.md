# Application Image Acquisition


## Online Deployment Method {#online-image}

Online deployment refers to a Kubernetes environment that can access the public network, allowing Kubernetes to automatically download images from the official <<< custom_key.brand_name >>> public image repository during deployment.

To obtain the public address of <<< custom_key.brand_name >>> images, visit the [<<< custom_key.brand_name >>> version history](changelog.md).


## Offline Deployment Method {#offline-image}

### Downloading and Importing <<< custom_key.brand_name >>> Offline Image Packages

???+ warning "Note"
     If Kubernetes node hosts can access the public network, there is no need to import images using the above offline method; the installation program will automatically download the images.

=== "amd64"

    For installations in an offline network environment, you need to manually download the latest <<< custom_key.brand_name >>> image package first. After importing all images into each Kubernetes worker node using the `docker load` command, proceed with subsequent guided installation.

    Latest <<< custom_key.brand_name >>> Docker image package download URL: [https://<<< custom_key.static_domain >>>/dataflux/package/guance-amd64-latest.tar.gz](https://<<< custom_key.static_domain >>>/dataflux/package/guance-amd64-latest.tar.gz)

    1. Use the following command to download the Docker image package to your local machine:
    ```shell
    $ wget https://<<< custom_key.static_domain >>>/dataflux/package/guance-amd64-latest.tar.gz
    ```

    2. After downloading, upload the Docker image package to each Kubernetes node host and execute the following commands to import the Docker image:
    - **Docker Environment Image Import Command:**
    ```shell
    $ gunzip -c guance-amd64-latest.tar.gz | docker load
    ```

    - **Containerd Environment Image Import Command:**
    ```shell
    $ gunzip guance-amd64-latest.tar.gz
    $ ctr -n=k8s.io images import guance-amd64-latest.tar
    ```
=== "arm64"

    For installations in an offline network environment, you need to manually download the latest <<< custom_key.brand_name >>> image package first. After importing all images into each Kubernetes worker node using the `docker load` command, proceed with subsequent guided installation.

    Latest <<< custom_key.brand_name >>> Docker image package download URL: [https://<<< custom_key.static_domain >>>/dataflux/package/guance-arm64-latest.tar.gz](https://<<< custom_key.static_domain >>>/dataflux/package/guance-arm64-latest.tar.gz)

    1. Use the following command to download the Docker image package to your local machine:
    ```shell
    $ wget https://<<< custom_key.static_domain >>>/dataflux/package/guance-arm64-latest.tar.gz
    ```

    2. After downloading, upload the Docker image package to each Kubernetes node host and execute the following commands to import the Docker image:
    - **Docker Environment Image Import Command:**
    ```shell
    $ gunzip -c guance-arm64-latest.tar.gz | docker load
    ```

    - **Containerd Environment Image Import Command:**
    ```shell
    $ gunzip guance-arm64-latest.tar.gz
    $ ctr -n=k8s.io images import guance-arm64-latest.tar
    ```


### Configuration of Self-built Image Repository for Launcher {#registry-key-change}

???+ warning "Note"
     If the downloaded offline image packages are imported into a self-built image repository, please configure as follows.

     This operation must be performed before deploying launcher.

=== "helm"
    
    When installing launcher, add the `imageSecrets.url`, `imageSecrets.username`, and `imageSecrets.password` parameters.

    ```shell hl_lines='4'
    helm install launcher launcher --repo https://pubrepo.guance.com/chartrepo/launcher -n launcher \
    --create-namespace  \
    --set ingress.hostName=<Hostname>,storageClassName=<Stroageclass> \
    --set imageSecrets.url=<warehouseaddress>,imageSecrets.username=<warehouse username>,imageSecrets.password=<warehouse passwd>
    ```


=== "yaml"

    - Generate a secret

      ```shell
      kubectl create secret docker-registry dataflux-test --docker-server='<Repo Server>' --docker-username='<Repo Username>' --docker-password='<Repo Password>'
      ```
      > Replace the values of `docker-server`, `docker-username`, and `docker-password` with your image repository address, account, and password.

    - Retrieve the secret
    
      ```shell
      kubectl get secrets dataflux-test -o jsonpath='{.data.\.dockerconfigjson}'
      ```

      Execution result:
      ```shell
      eyJhdXRocyI6eyJwdWJyZXBvLmd1YW5jZxxxxxxxxxiJkZXBsb3kiLCJwYXNzd29yZCI6IlFXRVIiLCJhdXRoIjoiWkdWd2JHOTVPbEZYUlZJPSJ9fX0=
      ```

    - Installation

      Download Launcher YAML from: [https://<<< custom_key.static_domain >>>/launcher/launcher.yaml](https://<<< custom_key.static_domain >>>/launcher/launcher.yaml)
      
      Save the above YAML content as a **launcher.yaml** file on your **operations machine**, then replace the variable parts in the document:
    
      - Replace `{{ launcher_image }}` with the latest Launcher application image address, which can be obtained from the [deployment image](changelog.md) documentation.
      - Replace `{{ domain }}` with the main domain, such as dataflux.cn.
      - Replace `{{ storageClassName }}` with the storage class name, such as alicloud-nas.

      Replace the `.dockerconfigjson` content with the secret.

      ![](img/registry-key.png)

      Execute the installation:

      ```shell
      kubectl apply -f launcher.yaml
      ```