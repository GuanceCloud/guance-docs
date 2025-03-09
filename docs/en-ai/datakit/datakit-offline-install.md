# Offline Deployment
---

In some cases, the target machine does not have public network access. The following method can be used to install DataKit offline.

## Proxy Installation {#install-via-proxy}

If the internal network has a machine that can access the external network, you can deploy a proxy on this node to route the internal network machine's traffic through this machine.

Currently, DataKit has a built-in proxy collector; it can also achieve the same purpose using Nginx’s forward proxy feature. The basic network structure is as follows:

<figure markdown>
  ![](https://static.guance.com/images/datakit/dk-nginx-proxy.png){ width="700"}
</figure>

### Prerequisites {#requrements}

- Install a DataKit on a machine with public network access via [standard installation method](datakit-install.md), and enable the [proxy](../integrations/proxy.md) collector on this DataKit. Assume the IP of the DataKit where the proxy collector is located is 1.2.3.4, with the following configuration:

```toml
[[inputs.proxy]]
  ## default bind ip address
  bind = "0.0.0.0" 
  ## default bind port
  port = 9530
```

- Or prepare an Nginx configured for forward proxy.

<!-- markdownlint-disable MD046 MD034 -->
=== "Linux/Mac"

    - Using DataKit Proxy
    
    Add environment variable `HTTPS_PROXY="1.2.3.4:9530"`, the installation command is as follows:
    
    ```shell
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> HTTPS_PROXY=http://1.2.3.4:9530 bash -c 'eval "$(curl -L https://static.guance.com/datakit/install.sh)"'
    ```

    - Using Nginx Proxy
    
    Add environment variable `DK_PROXY_TYPE="nginx"; DK_NGINX_IP="1.2.3.4";`, the installation command is as follows:
    
    ```shell
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> DK_NGINX_IP=1.2.3.4 HTTPS_PROXY=http://1.2.3.4:9530 bash -c 'eval "$(curl -L https://static.guance.com/datakit/install.sh)"'
    ```

=== "Windows"

    - Using DataKit Proxy
    
    Add environment variable `$env:HTTPS_PROXY="1.2.3.4:9530"`, the installation command is as follows:
    
    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
    $env:HTTPS_PROXY="1.2.3.4:9530";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer -ProxyUsage Override -ProxyList $env:HTTPS_PROXY -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```

    - Using Nginx Proxy
    
    Add environment variable `$env:DK_PROXY_TYPE="nginx"; $env:DK_NGINX_IP="1.2.3.4";`, the installation command is as follows:
    
    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
    $env:DK_NGINX_IP="1.2.3.4";
    $env:DK_PROXY_TYPE="nginx";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer -ProxyUsage Override -ProxyList $env:DK_NGINX_IP -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```

    > Note: Other installation parameter settings are the same as [standard installation](datakit-install.md).
<!-- markdownlint-enable -->

---

## Fully Offline Installation {#offline}

When the environment has no Internet access at all, the installation package must be downloaded from the public network to the intranet via methods like USB drives.

There are two strategies for fully offline installation:

- Simple Mode: Directly copy files from the USB drive to each host and install DataKit. However, simple mode currently **does not support** setting configurations through [environment variables during installation](datakit-install.md#extra-envs).
- Advanced Mode: Deploy an Nginx server within the intranet to build a file server replacing static.guance.com

### Simple Mode {#offline-simple}

The URLs of the following files can be downloaded using wget or by entering the corresponding URL in a browser.

<!-- markdownlint-disable MD046 -->
???+ Attention

    Safari may change the file extension (e.g., downloading `.tar.gz` as `.tar`), leading to installation failure. It is recommended to use Chrome.
<!-- markdownlint-enable -->

- First, download the data package [data.tar.gz](https://static.guance.com/datakit/data.tar.gz), which is the same for all platforms.

- Then download other required installation programs:

<!-- markdownlint-disable MD046 -->
=== "Windows 32-bit"

    - [`Installer`](https://static.guance.com/datakit/installer-windows-386.exe){:target="_blank"}
    - [`Datakit`](https://static.guance.com/datakit/datakit-windows-386-1.68.1.tar.gz){:target="_blank"}
    - [`Datakit-Lite`](https://static.guance.com/datakit/datakit_lite-windows-386-1.68.1.tar.gz){:target="_blank"}
    - [`Upgrader`](https://static.guance.com/datakit/dk_upgrader-windows-386.tar.gz){:target="_blank"}

=== "Windows 64-bit"

    - [`Installer`](https://static.guance.com/datakit/installer-windows-amd64.exe){:target="_blank"}
    - [`Datakit`](https://static.guance.com/datakit/datakit-windows-amd64-1.68.1.tar.gz){:target="_blank"}
    - [`Datakit-Lite`](https://static.guance.com/datakit/datakit_lite-windows-amd64-1.68.1.tar.gz){:target="_blank"}
    - [`Upgrader`](https://static.guance.com/datakit/dk_upgrader-windows-amd64.tar.gz){:target="_blank"}

=== "Linux X86 32-bit"

    - [`Installer`](https://static.guance.com/datakit/installer-linux-386){:target="_blank"}
    - [`Datakit`](https://static.guance.com/datakit/datakit-linux-386-1.68.1.tar.gz){:target="_blank"}
    - [`Datakit-Lite`](https://static.guance.com/datakit/datakit_lite-linux-386-1.68.1.tar.gz){:target="_blank"}
    - [`Upgrader`](https://static.guance.com/datakit/dk_upgrader-linux-386.tar.gz){:target="_blank"}

=== "Linux X86 64-bit"

    - [`Installer`](https://static.guance.com/datakit/installer-linux-amd64){:target="_blank"}
    - [`Datakit`](https://static.guance.com/datakit/datakit-linux-amd64-1.68.1.tar.gz){:target="_blank"}
    - [`Datakit-Lite`](https://static.guance.com/datakit/datakit_lite-linux-amd64-1.68.1.tar.gz){:target="_blank"}
    - [`Upgrader`](https://static.guance.com/datakit/dk_upgrader-linux-amd64.tar.gz){:target="_blank"}
    - [`APM Auto Instrumentation`](https://static.guance.com/datakit/datakit-apm-inject-linux-amd64-1.68.1.tar.gz){:target="_blank"}

=== "Linux Arm 32-bit"

    - [`Installer`](https://static.guance.com/datakit/installer-linux-arm){:target="_blank"}
    - [`Datakit`](https://static.guance.com/datakit/datakit-linux-arm-1.68.1.tar.gz){:target="_blank"}
    - [`Datakit-Lite`](https://static.guance.com/datakit/datakit_lite-linux-arm-1.68.1.tar.gz){:target="_blank"}
    - [`Upgrader`](https://static.guance.com/datakit/dk_upgrader-linux-arm.tar.gz){:target="_blank"}

=== "Linux Arm 64-bit"

    - [`Installer`](https://static.guance.com/datakit/installer-linux-arm64){:target="_blank"}
    - [`Datakit`](https://static.guance.com/datakit/datakit-linux-arm64-1.68.1.tar.gz){:target="_blank"}
    - [`Datakit-Lite`](https://static.guance.com/datakit/datakit_lite-linux-arm64-1.68.1.tar.gz){:target="_blank"}
    - [`Upgrader`](https://static.guance.com/datakit/dk_upgrader-linux-arm64.tar.gz){:target="_blank"}
    - [`APM Auto Instrumentation`](https://static.guance.com/datakit/datakit-apm-inject-linux-arm64-1.68.1.tar.gz){:target="_blank"}
<!-- markdownlint-enable -->

After downloading, you should have the following files (where `<OS-ARCH>` refers to specific platform installation packages):

- `datakit-<OS-ARCH>.tar.gz`
- `dk_upgrader-<OS-ARCH>.tar.gz`
- `installer-<OS-ARCH>` or `installer-<OS-ARCH>.exe`
- `data.tar.gz`
- `datakit-apm-inject-linux-<ARCH>.tar.gz`

Copy these files to the corresponding machines (via USB drive or `scp` commands).

<!-- markdownlint-disable MD046 -->
???+ Attention

    Ensure all files are completely downloaded. They may not be reusable across different versions. For example, the installer program behaves differently between different versions of DataKit because it might adjust the default configuration of DataKit, and the configurations of different DataKit versions have varying degrees of changes. It is best to use the installer program corresponding to version 1.2.3 when installing or upgrading DataKit version 1.2.3.
<!-- markdownlint-enable -->

#### Installation {#simple-install}

> If installing the lite version of DataKit offline, specify the installation package with the `_lite` suffix, such as `datakit_lite-linux-amd64-1.68.1.tar.gz`.

<!-- markdownlint-disable MD046 -->
=== "Linux"

    Run with root privileges:

    ```shell
    chmod +x installer-linux-amd64
    ./installer-linux-amd64 --offline --dataway "https://openway.guance.com?token=<YOUR-TOKEN>" --srcs datakit-linux-amd64-1.68.1.tar.gz,dk_upgrader-linux-amd64.tar.gz,data.tar.gz
    ```

=== "Windows"

    Run PowerShell with administrator privileges:

    ```powershell
    .\installer-windows-amd64.exe --offline --dataway "https://openway.guance.com?token=<YOUR-TOKEN>" --srcs .\datakit-windows-amd64-1.68.1.tar.gz,.\dk_upgrader-windows-amd64.tar.gz,.\data.tar.gz
    ```
<!-- markdownlint-enable -->

#### Upgrade {#simple-upgrade}

> If upgrading the lite version of DataKit offline, specify the installation package with the `_lite` suffix, such as `datakit_lite-linux-amd64-1.68.1.tar.gz`.

<!-- markdownlint-disable MD046 -->
=== "Linux"

    Run with root privileges:

    ```shell
    chmod +x installer-linux-amd64
    ./installer-linux-amd64 --offline --upgrade --srcs datakit-linux-amd64-1.68.1.tar.gz,data.tar.gz
    ```

=== "Windows"

    Run PowerShell with administrator privileges:

    ```powershell
    .\installer-windows-amd64.exe --offline --upgrade --srcs .\datakit-windows-amd64-1.68.1.tar.gz,.\data.tar.gz
    ```
<!-- markdownlint-enable -->

<!-- markdownlint-disable MD046 -->
???+ tip "How to Specify More Configuration Parameters for Offline Installation"

    During non-offline installation, we can specify some default parameters using [environment variables `DK_XXX=YYY`](datakit-install.md#extra-envs). These default parameters are applied through *install.sh* (or *install.ps1* on Windows). However, these environment variables do not work for the installation program *installer-xxx*. We can only add these options using the command-line parameters of *installer-xxx*. To see the supported parameters, run:

    ```shell
    ./installer-linux-amd64 --help
    ```

    For example, specifying the Dataway address is done using `--dataway`. Additionally, these extra command-line parameters only take effect during installation mode and not during (offline) mode.
<!-- markdownlint-enable -->

### Advanced Mode {#offline-advanced}

Currently, DataKit installs from public addresses, with all binaries and installation scripts downloaded from the static.guance.com site. For machines that cannot access this site, you can deploy a file server within the intranet to replace static.guance.com.

The network topology for advanced mode is as follows:

<figure markdown>
  ![](https://static.guance.com/images/datakit/nginx-file-server.png){ width="700"}
</figure>

Prepare a machine accessible within the intranet, install Nginx on it, and download (or copy via USB) the necessary files for DataKit installation to the Nginx server so that other machines can download the installation files from the Nginx file server to complete the installation.

- Setting up the Nginx File Server {#nginx-config}

Add the following configuration in *nginx.conf*:

``` nginx
server {
    listen 8080;
    server_name _;
    ## Map to the root directory
    location / {
        root /;
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
        charset utf-8,gbk;
    }
}
```

Restart Nginx:

```shell
nginx -t        # Test configuration
nginx -s reload # Reload configuration
```

- Download files to the */datakit* directory on the Nginx server, here is an example using wget to download the installation package for the Linux AMD64 platform:

```shell
#!/bin/bash

mkdir -p /datakit
mkdir -p /datakit/apm_lib
wget -P /datakit https://static.guance.com/datakit/install.sh
wget -P /datakit https://static.guance.com/datakit/version
wget -P /datakit https://static.guance.com/datakit/data.tar.gz
wget -P /datakit https://static.guance.com/datakit/installer-linux-amd64-1.68.1
wget -P /datakit https://static.guance.com/datakit/datakit-linux-amd64-1.68.1.tar.gz
wget -P /datakit https://static.guance.com/datakit/datakit_lite-linux-amd64-1.68.1.tar.gz
wget -P /datakit https://static.guance.com/datakit/dk_upgrader-linux-amd64.tar.gz
wget -P /datakit https://static.guance.com/datakit/datakit-apm-inject-linux-amd64-1.68.1.tar.gz
wget -P /datakit/apm_lib https://static.guance.com/dd-image/dd-java-agent.jar

# Download other toolkits: sources are installation packages used for enabling RUM sourcemap functionality. If this feature is not enabled, you may choose not to download them.
sources=(
  "/datakit/sourcemap/jdk/OpenJDK11U-jdk_x64_mac_hotspot_11.0.16_8.tar.gz"
  "/datakit/sourcemap/jdk/OpenJDK11U-jdk_aarch64_mac_hotspot_11.0.15_10.tar.gz"
  "/datakit/sourcemap/jdk/OpenJDK11U-jdk_x64_linux_hotspot_11.0.16_8.tar.gz"
  "/datakit/sourcemap/jdk/OpenJDK11U-jdk_aarch64_linux_hotspot_11.0.16_8.tar.gz"
  "/datakit/sourcemap/R8/commandlinetools-mac-8512546_simplified.tar.gz"
  "/datakit/sourcemap/R8/commandlinetools-linux-8512546_simplified.tar.gz"
  "/datakit/sourcemap/proguard/proguard-7.2.2.tar.gz"
  "/datakit/sourcemap/ndk/android-ndk-r22b-x64-mac-simplified.tar.gz"
  "/datakit/sourcemap/ndk/android-ndk-r25-x64-linux-simplified.tar.gz"
  "/datakit/sourcemap/atosl/atosl-darwin-x64"
  "/datakit/sourcemap/atosl/atosl-darwin-arm64"
  "/datakit/sourcemap/atosl/atosl-linux-x64"
  "/datakit/sourcemap/atosl/atosl-linux-arm64"
)

mkdir -p /datakit/sourcemap/jdk \
  /datakit/sourcemap/R8       \
  /datakit/sourcemap/proguard \
  /datakit/sourcemap/ndk      \
  /datakit/sourcemap/atosl

for((i=0;i<${#sources[@]};i++)); do
  wget https://static.guance.com${sources[$i]} -O ${sources[$i]}
done
```

<!-- markdownlint-disable MD046 -->
???+ Attention

    The download link for the `Installer` program on Windows needs to include the **.exe** suffix, such as [*https://static.guance.com/datakit/installer-windows-386-1.68.1.exe*](https://static.guance.com/datakit/installer-windows-386-1.68.1.exe) and
    [*https://static.guance.com/datakit/installer-windows-amd64-1.68.1.exe*](https://static.guance.com/datakit/installer-windows-amd64-1.68.1.exe).
<!-- markdownlint-enable -->

#### Installation {#advance-install}

On intranet machines, set `DK_INSTALLER_BASE_URL` to point to the Nginx file server:

<!-- markdownlint-disable MD046 MD034 -->
=== "Linux/Mac"

    ```shell
    DK_DATAWAY=https://openway.guance.com?token=<TOKEN> DK_INSTALLER_BASE_URL=http://[Nginx-Server]:8080/datakit HTTPS_PROXY=http://1.2.3.4:9530 bash -c 'eval "$(curl -L ${DK_INSTALLER_BASE_URL}/install.sh)"'
    ```

=== "Windows"

    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
    $env:DK_INSTALLER_BASE_URL="http://[Nginx-Server]:8080/datakit";
    $env:HTTPS_PROXY="1.2.3.4:9530";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source ${DK_INSTALLER_BASE_URL}/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```
<!-- markdownlint-enable -->

At this point, the offline installation is complete. Note that `HTTPS_PROXY` is additionally set to support proxies.

---

#### Upgrade {#advance-upgrade}

If there is a new version of DataKit, download it in the same way and execute the following command to upgrade:

<!-- markdownlint-disable MD046 MD034 -->
=== "Linux/Mac"

    ```shell
    DK_INSTALLER_BASE_URL=http://[Nginx-Server]:8080/datakit DK_UPGRADE=1 bash -c "$(curl -L ${DK_INSTALLER_BASE_URL}/install.sh)"
    ```

=== "Windows"

    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_INSTALLER_BASE_URL="http://[Nginx-Server]:8080/datakit";
    $env:DK_UPGRADE="1";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source ${DK_INSTALLER_BASE_URL}/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```
<!-- markdownlint-enable -->

## Kubernetes Offline Deployment {#k8s-offline}

### Script-Assisted Installation {#Auxiliary-installation}

Here we provide a simple script to help complete passwordless login, file distribution, and image decompression tasks.

<!-- markdownlint-disable MD046 -->
???- note "*datakit_tools.sh* (click to expand)"

    ```shell
    #!/bin/bash
    # Please modify the IP of the hosts to be passwordless
    host_ip=(
      10.200.14.112
      10.200.14.113
      10.200.14.114
    )
    # Please modify the login password
    psd='123.com'

    menu() {
      echo -e "\e[33m------Please select the operation you need------\e[0m"
      echo -e "\e[33m1、Set SSH remote passwordless login\e[0m"
      echo -e "\e[33m2、Remote file transfer\e[0m"
      echo -e "\e[33m3、Remote image decompression\e[0m"
      read -p "Please enter the option number：" num
    }

    # Remote passwordless
    SSH-COPY(){
    yum install -y expect
    ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
    for i in ${host_ip[@]}
      do
        /usr/bin/expect<<EOF
        spawn ssh-copy-id ${i}
        expect {
              "(yes/no)" {send "yes\r";exp_continue}
              "password" {send "${psd}\r"}
    }
    expect eof
    EOF
    done
    }

    SCP(){
    read  -p "Please enter the filenames to transfer (multiple files can be entered)：" file_name
    for i in ${host_ip[@]}
      do
      for j in ${file_name[@]}
        do
          echo -e "\e[33m------${i}---${j}------\e[0m"
          scp ${j} root@${i}:/root/
      done
    done
    }

    SSH(){
    read -p "Please enter the filename to decompress：" file_name
    # Remote image decompression
    for i in ${host_ip[@]}
      do
        echo -e "\e[33m------${i}------\e[0m"
        # ssh root@${i} "docker load -i ${file_name}"
        ssh root@${i} " ctr -n=k8s.io image import ${file_name} "
    done
    }
    #menu
    CASE(){
    case ${num} in
    1)
    SSH-COPY
            echo -e "\e[33m------------------------------------------------------\e[0m"
    ;;
    2)
    SCP
            echo -e "\e[33m------------------------------------------------------\e[0m"
    ;;
    3)
    SSH
            echo -e "\e[33m------------------------------------------------------\e[0m"
      ;;
    *)
            
      echo -e "\e[31m Please enter a number {1|2|3}:\e[0m"
      echo -e "\e[31m Please enter a number {1|2|3}:\e[0m"
    esac
    }

    menu
    CASE
    read -p "Do you want to continue executing list operations? [y/n]：" a
    while [ "${a}" == "y" ]
      do
        menu 
        CASE
        read -p "Do you want to continue executing list operations? [y/n]：" a
        continue
    done
    ```
<!-- markdownlint-enable -->

```shell
# Modify the host IP and login password in the script, then follow the prompts to complete the operations.
chmod +x datakit_tools.sh
./datakit_tools.sh
```

### Proxy Installation {#k8s-install-via-proxy}

**If the internal network has a machine that can access the external network, you can deploy an NGINX server on this node to act as an image retrieval proxy.**

1. Download the *datakit.yaml* file

```shell
wget https://static.guance.com/datakit/datakit.yaml -P /home/guance/
```

2. Download and pack the Datakit image

```shell
# Pull and pack amd image
docker pull --platform amd64 pubrepo.guance.com/datakit/datakit:1.68.1
docker save -o datakit-amd64-1.68.1.tar pubrepo.guance.com/datakit/datakit:1.68.1
mv datakit-amd64-1.68.1.tar /home/guance

# Pull and pack arm image
docker pull --platform arm64 pubrepo.guance.com/datakit/datakit:1.68.1
docker save -o datakit-arm64-1.68.1.tar pubrepo.guance.com/datakit/datakit:1.68.1
mv datakit-arm64-1.68.1.tar /home/guance

# Check if the image architecture is correct
docker image inspect pubrepo.guance.com/datakit/datakit:1.68.1 |grep Architecture

```

3. Modify NGINX configuration for proxy

<!-- markdownlint-disable MD046 -->
???- note "/etc/nginx/nginx.conf (click to expand)"

    ```shell
    #user  nobody;
    worker_processes  1;

    #error_log  logs/error.log;
    #error_log  logs/error.log  notice;
    #error_log  logs/error.log  info;

    #pid        logs/nginx.pid;


    events {
        worker_connections  1024;
    }


    http {
        include       mime.types;
        default_type  application/octet-stream;

        #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
        #                  '$status $body_bytes_sent "$http_referer" '
        #                  '"$http_user_agent" "$http_x_forwarded_for"';

        #access_log  logs/access.log  main;

        sendfile        on;
        #tcp_nopush     on;

        #keepalive_timeout  0;
        keepalive_timeout  65;

        #gzip  on;

        server {
            listen       8080;
            server_name  localhost;
            root /home/guance;
            autoindex on;

            #charset koi8-r;

            #access_log  logs/host.access.log  main;


            #error_page  404              /404.html;

            # redirect server error pages to the static page /50x.html
            #

            # proxy the PHP scripts to Apache listening on 127.0.0.1:80
            #
            #location ~ \.php$ {
            #    proxy_pass   http://127.0.0.1;
            #}

            # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
            #
            #location ~ \.php$ {
            #    root           html;
            #    fastcgi_pass   127.0.0.1:9000;
            #    fastcgi_index  index.php;
            #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
            #    include        fastcgi_params;
            #}

            # deny access to .htaccess files, if Apache's document root
            # concurs with nginx's one
            #
            #location ~ /\.ht {
            #    deny  all;
            #}
        }


        # another virtual host using mix of IP-, name-, and port-based configuration
        #
        #server {
        #    listen       8000;
        #    listen       somename:8080;
        #    server_name  somename  alias  another.alias;

        #    location / {
        #        root   html;
        #        index  index.html index.htm;
        #    }
        #}


        # HTTPS server
        #
        #server {
        #    listen       443 ssl;
        #    server_name  localhost;

        #    ssl_certificate      cert.pem;
        #    ssl_certificate_key  cert.key;

        #    ssl_session_cache    shared:SSL:1m;
        #    ssl_session_timeout  5m;

        #    ssl_ciphers  HIGH:!aNULL:!MD5;
        #    ssl_prefer_server_ciphers  on;

        #    location / {
        #        root   html;
        #        index  index.html index.htm;
        #    }
        #}

    }
    ```
<!-- markdownlint-enable -->

4. Execute commands on other intranet machines.

```shell
wget http://<nginx-server-ip>:8080/datakit.yaml 
wget http://<nginx-server-ip>:8080/datakit-amd64-1.68.1.tar 
```

5. Command to decompress the image

```shell
# docker 
docker load -i /k8sdata/datakit/datakit-amd64-1.68.1.tar

# containerd
ctr -n=k8s.io image import /k8sdata/datakit/datakit-amd64-1.68.1.tar

```

6. Start the Datakit container

```shell
kubectl apply -f datakit.yaml
```

### Fully Offline Installation {#k8s-offilne-all}

When the environment has no Internet access at all, the installation package must be transferred from the public network to the intranet via methods like USB drives.

- Command to decompress the image

```shell
# docker 
docker load -i datakit-amd64-1.68.1.tar

# containerd
ctr -n=k8s.io image import datakit-amd64-1.68.1.tar

```

- Execute the startup command on the cluster control machine

``` shell
kubectl apply -f datakit.yaml
```

- Update command

```shell
# Need to decompress the image first
kubectl patch -n datakit daemonsets.apps datakit -p '{"spec": {"template": {"spec": {"containers": [{"image": "pubrepo.guance.com/datakit/datakit:<version>","name": "datakit"}]}}}}'
```