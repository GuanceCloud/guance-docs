# Application Image Acquisition


## Online Deployment Method {#online-image}

Online deployment refers to a Kubernetes environment that can access the public network, so during deployment, Kubernetes can automatically download images from <<< custom_key.brand_name >>>'s official public image repository.

To obtain the public address of the <<< custom_key.brand_name >>> image, you can visit [<<< custom_key.brand_name >>> Version History](changelog.md).


## Offline Deployment Method {#offline-image}

### Download and Import of <<< custom_key.brand_name >>> Offline Image Packages

???+ warning "Note"
     If the Kubernetes node host can access the public network, there is no need to import images via the above offline method; the installation program will automatically download the images.

=== "amd64"

    If installing in an offline network environment, you need to manually download the latest <<< custom_key.brand_name >>> image package first. Afterward, use the `docker load` command to import all images onto each Kubernetes worker node before proceeding with subsequent guided installations.

    Latest <<< custom_key.brand_name >>> Docker image package download link: [https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-latest.tar.gz](https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-latest.tar.gz)

    1. Use the following command to download the Docker image package locally:
    ```shell
    $ wget https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-amd64-latest.tar.gz
    ```

    2. After downloading, upload the Docker image package to each Kubernetes node host and execute the following commands to import the Docker image:
    - **Docker Environment Image Import Command:**
    ```shell
    $ gunzip -c guance-amd64-latest.tar.gz | docker load
    ```

    - **Containterd Environment Image Import Command:**
    ```shell
    $ gunzip guance-amd64-latest.tar.gz
    $ ctr -n=k8s.io images import guance-amd64-latest.tar
    ```
=== "arm64"

    If installing in an offline network environment, you need to manually download the latest <<< custom_key.brand_name >>> image package first. Afterward, use the `docker load` command to import all images onto each Kubernetes worker node before proceeding with subsequent guided installations.

    Latest <<< custom_key.brand_name >>> Docker image package download link: [https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-latest.tar.gz](https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-latest.tar.gz)

    1. Use the following command to download the Docker image package locally:
    ```shell
    $ wget https://static.<<< custom_key.brand_main_domain >>>/dataflux/package/guance-arm64-latest.tar.gz
    ```

    2. After downloading, upload the Docker image package to each Kubernetes node host and execute the following commands to import the Docker image:
    - **Docker Environment Image Import Command:**
    ```shell
    $ gunzip -c guance-arm64-latest.tar.gz | docker load
    ```

    - **Containterd Environment Image Import Command:**
    ```shell
    $ gunzip guance-arm64-latest.tar.gz
    $ ctr -n=k8s.io images import guance-arm64-latest.tar
    ```


### Configuration of Self-built Image Repository for Launcher {#registry-key-change}

???+ warning "Note"
     If the downloaded offline image package is imported into your self-built image repository for use, please make the following configurations.

     This operation must be performed before deploying luancher.

=== "helm"
    
    When installing launcher, add the `imageSecrets.url`, `imageSecrets.username`, and `imageSecrets.password` parameters.

    ```shell hl_lines='4'
    helm install launcher launcher  --repo https://pubrepo.<<< custom_key.brand_main_domain >>>/chartrepo/launcher -n launcher \
    --create-namespace  \
    --set ingress.hostName=<Hostname>,storageClassName=<Stroageclass> \
    --set imageSecrets.url=<warehouseaddress>,imageSecrets.username=<warehouse username>,imageSecrets.password=<warehouse passwd>
    ```


=== "yaml"

    - Generate Secret

      ```shell
      kubectl create secret docker-registry dataflux-test --docker-server='<Repo Server>' --docker-username='<Repo Username>' --docker-password='<Repo Password>'
      ```
      > Note: Replace the values of the `docker-server`, `docker-username`, and `docker-password` parameters with your image repository address, account, and password.

    - Retrieve Secret
    
      ```shell
      kubectl get secrets dataflux-test -o jsonpath='{.data.\.dockerconfigjson}'
      ```

      Execution result:
      ```shell
      eyJhdXRocyI6eyJwdWJyZXBvLmd1YW5jZxxxxxxxxxiJkZXBsb3kiLCJwYXNzd29yZCI6IlFXRVIiLCJhdXRoIjoiWkdWd2JHOTVPbEZYUlZJPSJ9fX0=
      ```

    - Installation

      Download Launcher YAML: [https://static.<<< custom_key.brand_main_domain >>>/launcher/launcher.yaml](https://static.<<< custom_key.brand_main_domain >>>/launcher/launcher.yaml)
      
      Save the content of the above YAML as the **launcher.yaml** file on the **operations machine**, then replace the variable parts within the document:
    
      - Replace {{ launcher_image }} with the latest version of the Launcher application image address, which can be obtained from the [Deployment Image](changelog.md) documentation.
      - Replace {{ domain }} with the main domain, such as using dataflux.cn.
      - Replace {{ storageClassName }} with the storage class name, such as alicloud-nas.

      Replace the .dockerconfigjson content with the secret.

      ![](img/registry-key.png)

      Execute the installation:

      ```shell
      kubectl apply -f launcher.yaml
      ```