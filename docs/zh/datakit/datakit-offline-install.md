
# 离线部署
---

某些时候，目标机器没有公网访问出口，按照如下方式可离线安装 DataKit。

## 代理安装 {#install-via-proxy}

如果内网有可以通外网的机器，可以在该节点部署一个 proxy，将内网机器的访问流量通过该机器代理出来。

当前 DataKit 自己内置了一个 proxy 采集器；也能通过 Nginx 正向代理功能来实现同一目的。基本网络结构如下：

<figure markdown>
  ![](https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/images/datakit/dk-nginx-proxy.png){ width="700"}
</figure>

### 前置条件 {#requrements}

- 通过[正常安装方式](datakit-install.md)，在有公网出口的机器上安装一个 DataKit，开通该 DataKit 上的 [proxy](proxy.md) 采集器，假定 proxy 采集器所在 Datakit IP 为 1.2.3.4，有如下配置：

```toml
[[inputs.proxy]]
  ## default bind ip address
  bind = "0.0.0.0" 
  ## default bind port
  port = 9530
```

- 或者准备配置好正向代理的 Nginx

=== "Linux/Mac"

    - 使用 datakit 代理
    
    增加环境变量 `HTTPS_PROXY="1.2.3.4:9530"`，安装命令如下：
    
    ```shell
    export HTTPS_PROXY=http://1.2.3.4:9530; DK_DATAWAY=https://openway.guance.com?token=<TOKEN> bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```
    
    - 使用 Nginx 代理
    
    增加环境变量 `DK_PROXY_TYPE="nginx"; DK_NGINX_IP="1.2.3.4";`，安装命令如下：
    
    ```shell
    export DK_PROXY_TYPE="nginx"; DK_NGINX_IP="1.2.3.4"; DK_DATAWAY=https://openway.guance.com?token=<TOKEN> bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

=== "Windows"

    - 使用 datakit 代理
    
    增加环境变量 `$env:HTTPS_PROXY="1.2.3.4:9530"`，安装命令如下：
    
    ```powershell
    $env:HTTPS_PROXY="1.2.3.4:9530"; $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>"; Set-ExecutionPolicy Bypass -scope Process -Force; Import-Module bitstransfer; start-bitstransfer -ProxyUsage Override -ProxyList $env:HTTPS_PROXY -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1; powershell .install.ps1;
    ```

    - 使用 Nginx 代理
    
    增加环境变量 `$env:DK_PROXY_TYPE="nginx"; $env:DK_NGINX_IP="1.2.3.4";`，安装命令如下：
    
    ```powershell
    $env:DK_PROXY_TYPE="nginx"; $env:DK_NGINX_IP="1.2.3.4"; $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>"; Set-ExecutionPolicy Bypass -scope Process -Force; Import-Module bitstransfer; start-bitstransfer -ProxyUsage Override -ProxyList $env:HTTPS_PROXY -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1; powershell .install.ps1;
    ```
    
    > 注意：其它安装参数设置，跟[正常安装](datakit-install.md) 无异。

---


## 全离线安装 {#offline}

当环境完全没有外网的情况下，只能通过移动硬盘（U 盘）等方式将安装包从公网下载到内网。

全离线安装有两张策略可以选择：

- 简单模式：直接将 U 盘内的文件拷贝到每一台主机上，安装 DataKit。但简单模式目前**不支持**安装阶段通过[环境变量来做一些设置](datakit-install.md#extra-envs)。
- 高级模式：在内网部署一个 Nginx，通过 Nginx 构建一个文件服务器，以替代 static.guance.com

### 简单模式 {#offline-simple}

以下文件的地址，可通过 wget 等下载工具，也可以直接在浏览器中输入对应的 URL 下载。

???+ Attention

    Safari 浏览器下载时，后缀名可能不同（如将 `.tar.gz` 文件下载成 `.tar`），会导致安装失败。建议用 Chrome 浏览器下载。

- 先下载数据包 [data.tar.gz](https://static.guance.com/datakit/data.tar.gz)，每个平台都一样。

- 然后再下载俩个安装程序：

=== "Windows 32 位"

    - [Installer](https://static.guance.com/datakit/installer-windows-386.exe){:target="_blank"}
    - [DataKit](https://static.guance.com/datakit/datakit-windows-386-1.5.5.tar.gz){:target="_blank"}

=== "Windows 64 位"

    - [Installer](https://static.guance.com/datakit/installer-windows-amd64.exe){:target="_blank"}
    - [DataKit](https://static.guance.com/datakit/datakit-windows-amd64-1.5.5.tar.gz){:target="_blank"}

=== "Linux X86 32 位"

    - [Installer](https://static.guance.com/datakit/installer-linux-386){:target="_blank"}
    - [DataKit](https://static.guance.com/datakit/datakit-linux-386-1.5.5.tar.gz){:target="_blank"}

=== "Linux X86 64 位"

    - [Installer](https://static.guance.com/datakit/installer-linux-amd64){:target="_blank"}
    - [DataKit](https://static.guance.com/datakit/datakit-linux-amd64-1.5.5.tar.gz){:target="_blank"}

=== "Linux Arm 32 位"

    - [Installer](https://static.guance.com/datakit/installer-linux-arm){:target="_blank"}
    - [DataKit](https://static.guance.com/datakit/datakit-linux-arm-1.5.5.tar.gz){:target="_blank"}

=== "Linux Arm 64 位"

    - [Installer](https://static.guance.com/datakit/installer-linux-arm64){:target="_blank"}
    - [DataKit](https://static.guance.com/datakit/datakit-linux-arm64-1.5.5.tar.gz){:target="_blank"}

下载完后，应该有三个文件（此处 `<OS-ARCH>` 指特定平台的安装包）：

- `datakit-<OS-ARCH>.tar.gz`
- `installer-<OS-ARCH>` 或 `installer-<OS-ARCH>.exe`
- `data.tar.gz`

将这些文件拷贝到对应机器上（通过 U 盘或 scp 等命令）。

### 安装 {#install}

=== "Windows"

    需以 administrator 权限运行 Powershell 执行：

    ```powershell
    .\installer-windows-amd64.exe --offline --dataway "https://openway.guance.com?token=<YOUR-TOKEN>" --srcs .\datakit-windows-amd64-1.5.5.tar.gz,.\data.tar.gz
    ```

=== "Linux"

    需以 root 权限运行：

    ```shell
    chmod +x installer-linux-amd64
    ./installer-linux-amd64 --offline --dataway "https://openway.guance.com?token=<YOUR-TOKEN>" --srcs datakit-linux-amd64-1.5.5.tar.gz,data.tar.gz
    ```

### 高级模式 {#offline-advanced}

DataKit 目前的安装地址是公网地址，所有二进制数据以及安装脚本都是从 static.guance.com 站点下载。对于不能访问该站点的机器，可以通过在内网部署一个文件服务器，以替代 static.guance.com 站点。

高级模式的网络流量拓扑如下：

<figure markdown>
  ![](https://zhuyun-static-files-production.oss-cn-hangzhou.aliyuncs.com/images/datakit/nginx-file-server.png){ width="700"}
</figure>


先准备一台内网均可访问的机器，在该机器上安装 Nginx， 将 DataKit 安装所需的文件下载（或通过 U 盘拷贝）到 Nginx 服务器上，这样其它机器可以从 Nginx 文件服务器上下载安装文件来完成安装。

- 设置 Nginx 文件服务器 {#nginx-config}

在 nginx.conf 中添加配置：

```
server {
    listen 8080;
    server_name _;
    ## 映射到跟目录下
    location / {
        root /;
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
        charset utf-8,gbk;
    }
}
```

重启 Nginx：

```shell
nginx -t        # 测试配置
nginx -s reload # reload配置
```

- 将文件下载到 Nginx 服务器所在的 */datakit* 目录下，这里以 wget 下载 Linux AMD64 平台的安装包为例：

```shell
#!/bin/bash

mkdir -p /datakit
wget -P /datakit https://static.guance.com/datakit/install.sh
wget -P /datakit https://static.guance.com/datakit/version
wget -P /datakit https://static.guance.com/datakit/data.tar.gz
wget -P /datakit https://static.guance.com/datakit/installer-linux-amd64-1.5.5
wget -P /datakit https://static.guance.com/datakit/datakit-linux-amd64-1.5.5.tar.gz

# 下载其它工具包：sources 是开启 RUM sourcemap 功能使用的安装包，如果未开启此功能，可选择不下载
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
  "/datakit/sourcemap/libs/libdwarf-code-20200114.tar.gz"
  "/datakit/sourcemap/libs/binutils-2.24.tar.gz"
  "/datakit/sourcemap/atosl/atosl-20220804-x64-linux.tar.gz"
)

mkdir -p /datakit/sourcemap/jdk \
  /datakit/sourcemap/R8       \
  /datakit/sourcemap/proguard \
  /datakit/sourcemap/ndk      \
  /datakit/sourcemap/libs     \
  /datakit/sourcemap/atosl

for((i=0;i<${#sources[@]};i++)); do
  wget https://static.guance.com${sources[$i]} -O ${sources[$i]}
done
```

- 准备安装

在内网机器上，通过设置 `DK_INSTALLER_BASE_URL`，将其指向 Nginx 文件服务器：

=== "Linux/Mac"
    
    ```shell
    HTTPS_PROXY=http://1.2.3.4:9530 \
    DK_INSTALLER_BASE_URL="http://<nginxServer>:8080/datakit" \
    DK_DATAWAY="https://dataway?token=<TOKEN>" \
    bash -c "$(curl -L ${DK_INSTALLER_BASE_URL}/install.sh)"
    ```

=== "Windows"

    ```powershel
    $env:HTTPS_PROXY="1.2.3.4:9530";
    $env:DK_DATAWAY="https://openway.guance.com?token=<TOKEN>";
    $env:DK_INSTALLER_BASE_URL="http://<nginxServer>:8080/datakit";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer -source ${DK_INSTALLER_BASE_URL}/install.ps1 -destination .install.ps1;
    powershell .install.ps1;
    ```

到此为止，离线安装完成。注意，此处还额外设置了 HTTPS_PROXY。

---

- 更新 DataKit

如果有新的 DataKit 版本，可以将其安装上面的方式下载下来，执行如下命令来升级：

=== "Linux/Mac"

    ```shell
    DK_INSTALLER_BASE_URL="http://<nginxServer>:8080/datakit" \
    DK_UPGRADE=1 \
		bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

=== "Windows"

    ```powershell
    $env:DK_INSTALLER_BASE_URL="http://<nginxServer>:8080/datakit";
    $env:DK_UPGRADE="1";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
    powershell .install.ps1;
    ```
