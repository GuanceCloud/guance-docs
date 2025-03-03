# Scheck 安装

- 版本：1.0.7-7-g251eead
- 发布日期：2023-04-06 11:17:57
- 操作系统支持：windows/amd64,windows/386,linux/arm,linux/arm64,linux/386,linux/amd64


本文介绍 Scheck 的基本安装。

## 安装 {#install}

<!-- markdownlint-disable MD046 -->
=== "Linux"

    ```Shell
    sudo -- bash -c "$(curl -L https://{{{ custom_key.static_domain }}}/security-checker/install.sh)"
    ```

=== "Windows"

    ```powershell
    Set-ExecutionPolicy Bypass -scope Process -Force; Import-Module bitstransfer; start-bitstransfer -source https://{{{ custom_key.static_domain }}}/security-checker/install.ps1 -destination .install.ps1; powershell .install.ps1;
    ```
<!-- markdownlint-enable MD046 -->

## 更新 {#upgrade}

<!-- markdownlint-disable MD046 -->
=== Linux

    ```Shell
    SC_UPGRADE=1 bash -c "$(curl -L https://{{{ custom_key.static_domain }}}/security-checker/install.sh)"
    ```

=== Windows

    ```powershell
    $env:SC_UPGRADE;Set-ExecutionPolicy Bypass -scope Process -Force; Import-Module bitstransfer; start-bitstransfer -source https://{{{ custom_key.static_domain }}}/security-checker/install.ps1 -destination .install.ps1; powershell .install.ps1;
    ```
<!-- markdownlint-enable MD046 -->

安装完成后即以服务的方式运行，服务名为`scheck`，使用服务管理工具来控制程序的启动/停止：  

```shell
systemctl start/stop/restart scheck
# Or
service scheck start/stop/restart
```

其它相关链接：

- 关于 Scheck 的基本 使用，参考 [Scheck 使用入门](scheck-how-to.md)
