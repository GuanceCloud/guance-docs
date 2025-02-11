# Scheck Installation

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

This document introduces the basic installation of Scheck.

## Installation {#install}

<!-- markdownlint-disable MD046 -->
=== "Linux"

    ```Shell
    sudo -- bash -c "$(curl -L https://static.guance.com/security-checker/install.sh)"
    ```

=== "Windows"

    ```powershell
    Set-ExecutionPolicy Bypass -scope Process -Force; Import-Module bitstransfer; start-bitstransfer -source https://static.guance.com/security-checker/install.ps1 -destination .install.ps1; powershell .install.ps1;
    ```
<!-- markdownlint-enable MD046 -->

## Upgrade {#upgrade}

<!-- markdownlint-disable MD046 -->
=== "Linux"

    ```Shell
    SC_UPGRADE=1 bash -c "$(curl -L https://static.guance.com/security-checker/install.sh)"
    ```

=== "Windows"

    ```powershell
    $env:SC_UPGRADE;Set-ExecutionPolicy Bypass -scope Process -Force; Import-Module bitstransfer; start-bitstransfer -source https://static.guance.com/security-checker/install.ps1 -destination .install.ps1; powershell .install.ps1;
    ```
<!-- markdownlint-enable MD046 -->

After installation, Scheck runs as a service named `scheck`. Use service management tools to control the program's startup/shutdown:

```shell
systemctl start/stop/restart scheck
# Or
service scheck start/stop/restart
```

Other related links:

- For basic usage of Scheck, refer to [Getting Started with Scheck](scheck-how-to.md)