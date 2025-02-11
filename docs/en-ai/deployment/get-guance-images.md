# Application Image Acquisition

## Online Deployment Method {#online-image}

Online deployment refers to a Kubernetes environment that can access the public network, allowing Kubernetes to automatically download images from the official Guance public image repository during deployment.

To obtain the public address of the Guance image, visit the [Guance Version History](changelog.md).

## Offline Deployment Method {#offline-image}

### Downloading and Importing Guance Offline Image Packages

???+ warning "Note"
     If Kubernetes node hosts can access the public network, there is no need to import images via the offline method described above; the installation program will automatically download the images.

=== "amd64"

    For installations in an offline network environment, you must manually download the latest Guance Docker image package first. Afterward, use the `docker load` command to import all images onto each Kubernetes worker node before proceeding with subsequent guided installations.

    Latest Guance Docker image package download link: [https://static.guance.com/dataflux/package/guance-amd64-latest.tar.gz](https://static.guance.com/dataflux/package/guance-amd64-latest.tar.gz)

    1. Use the following command to download the Docker image package to your local machine:
    ```shell
    $ wget https://static.guance.com/dataflux/package/guance-amd64-latest.tar.gz
    ```

    2. After downloading, upload the Docker image package to each Kubernetes node host and execute the following commands to import the Docker images:
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

    For installations in an offline network environment, you must manually download the latest Guance Docker image package first. Afterward, use the `docker load` command to import all images onto each Kubernetes worker node before proceeding with subsequent guided installations.

    Latest Guance Docker image package download link: [https://static.guance.com/dataflux/package/guance-arm64-latest.tar.gz](https://static.guance.com/dataflux/package/guance-arm64-latest.tar.gz)

    1. Use the following command to download the Docker image package to your local machine:
    ```shell
    $ wget https://static.guance.com/dataflux/package/guance-arm64-latest.tar.gz
    ```

    2. After downloading, upload the Docker image package to each Kubernetes node host and execute the following commands to import the Docker images:
    - **Docker Environment Image Import Command:**
    ```shell
    $ gunzip -c guance-arm64-latest.tar.gz | docker load
    ```

    - **Containerd Environment Image Import Command:**
    ```shell
    $ gunzip guance-arm64-latest.tar.gz
    $ ctr -n=k8s.io images import guance-arm64-latest.tar
    ```

### Configuration for Self-hosted Image Repository {#registry-key-change}

???+ warning "Note"
     If the downloaded offline image package is imported into a self-hosted image repository for use, perform the following configuration.

     This operation must be done before deploying the launcher.

=== "helm"
    
    When installing the launcher, add the `imageSecrets.url`, `imageSecrets.username`, and `imageSecrets.password` parameters.

    ```shell hl_lines='4'
    helm install launcher launcher --repo https://pubrepo.guance.com/chartrepo/launcher -n launcher \
    --create-namespace \
    --set ingress.hostName=<Hostname>,storageClassName=<Stroageclass> \
    --set imageSecrets.url=<warehouseaddress>,imageSecrets.username=<warehouse username>,imageSecrets.password=<warehouse passwd>
    ```

=== "yaml"

    - Generate Secret

      ```shell
      kubectl create secret docker-registry dataflux-test --docker-server='<Repo Server>' --docker-username='<Repo Username>' --docker-password='<Repo Password>'
      ```
      > Replace the values of `docker-server`, `docker-username`, and `docker-password` with your image repository address, account, and password.

    - Retrieve Secret
    
      ```shell
      kubectl get secrets dataflux-test -o jsonpath='{.data.\.dockerconfigjson}'
      ```

      Execution result:
      ```shell
      eyJhdXRocyI6eyJwdWJyZXBvLmd1YW5jZxxxxxxxxxiJkZXBsb3kiLCJwYXNzd29yZCI6IlFXRVIiLCJhdXRoIjoiWkdWd2JHOTVPbEZYUlZJPSJ9fX0=
      ```

    - Installation

      Download Launcher YAML: [https://static.guance.com/launcher/launcher.yaml](https://static.guance.com/launcher/launcher.yaml)
      
      Save the above YAML content as a **launcher.yaml** file on the **operation machine**, then replace the variable parts within the document:
    
      - Replace `{{ launcher_image }}` with the latest Launcher application image address, which can be found in the [Deployment Image](changelog.md) documentation.
      - Replace `{{ domain }}` with the main domain, such as `dataflux.cn`.
      - Replace `{{ storageClassName }}` with the storage class name, such as `alicloud-nas`.

      Replace the `.dockerconfigjson` content with the secret.

      ![](img/registry-key.png)

      Execute installation:

      ```shell
      kubectl apply -f launcher.yaml
      ```