# DataKit Update
---

DataKit supports both manual and automatic update methods.

## Extra Supported Environment Variables {#extra-envs}

Currently, the upgrade command also supports environment variables consistent with the installation command [environment variables supported by the installation command](datakit-install.md#extra-envs), starting from version [1.62.1](changelog.md#cl-1.62.1).

## Prerequisites {#req}

- Remote updates require Datakit version >= 1.5.9
- Automatic updates require DataKit version >= 1.1.6-rc1
- Manual updates have no specific version requirements

## Manual Update {#manual}

Run the following command directly to check the current DataKit version. If there is a newer version online, it will prompt you with the corresponding update command, for example:

> - If [DataKit < 1.2.7](changelog.md#cl-1.2.7), here only `datakit --version` can be used
> - If DataKit < 1.2.0, please [use the update command directly](changelog.md#cl-1.2.0-break-changes)

<!-- markdownlint-disable MD046 -->

=== "Linux/macOS"

    ``` shell
    $ datakit version
    
           Version: 1.2.8
            Commit: e9ccdfbae4
            Branch: testing
     Build At(UTC): 2022-03-11 11:07:06
    Golang Version: go version go1.18.3 linux/amd64
          Uploader: xxxxxxxxxxxxx/xxxxxxx/xxxxxxx
    ReleasedInputs: all
    ---------------------------------------------------
    
    Online version available: 1.2.9, commit 9f5ac898be (release at 2022-03-10 12:03:12)
    
    Upgrade:
    DK_UPGRADE=1 bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

=== "Windows"

    ``` powershell
    $ datakit.exe version
    
           Version: 1.2.8
            Commit: e9ccdfbae4
            Branch: testing
     Build At(UTC): 2022-03-11 11:07:36
    Golang Version: go version go1.18.3 linux/amd64
          Uploader: xxxxxxxxxxxxx/xxxxxxx/xxxxxxx
    ReleasedInputs: all
    ---------------------------------------------------
    
    Online version available: 1.2.9, commit 9f5ac898be (release at 2022-03-10 12:03:12)
    
    Upgrade:
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_UPGRADE="1";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.guance.com/datakit/install.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```
<!-- markdownlint-enable -->

---

If the current DataKit is in proxy mode, the auto-update prompt command will automatically include proxy settings:

<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    ```shell
    HTTPS_PROXY=http://10.100.64.198:9530 DK_UPGRADE=1 ...
    ```

=== "Windows"

    ``` powershell
    $env:HTTPS_PROXY="http://10.100.64.198:9530"; $env:DK_UPGRADE="1" ...
    ```
<!-- markdownlint-enable -->

## Remote Update Service {#auto}

[:octicons-tag-24: Version-1.5.9](changelog.md#cl-1.5.9) · [:octicons-beaker-24: Experimental](index.md#experimental)

> Note: The service does not support Datakit installed within k8s.

During the Datakit installation process, a remote update service is installed by default, specifically for upgrading the Datakit version. For older versions of Datakit, an additional parameter can be specified in the Datakit upgrade command to install this service:

<!-- markdownlint-disable MD046 -->

=== "Public Network Installation"

    ```shell hl_lines="2"
    DK_UPGRADE=1 \
      DK_UPGRADE_MANAGER=1 \
      bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

=== "Offline Update"

    [:octicons-tag-24: Version-1.38.0](changelog.md#cl-1.38.0)

    If you have already [synchronized the Datakit installation package offline](datakit-offline-install.md#offline-advanced), assuming the offline installation package address is `http://my.static.com/datakit`, then the upgrade command here is

    ```shell hl_lines="3"
    DK_UPGRADE=1 \
      DK_UPGRADE_MANAGER=1 \
      DK_INSTALLER_BASE_URL="http://my.static.com/datakit" \
      bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

???+ attention

    The service binds to `0.0.0.0:9542` by default. If this address is occupied, you can specify an alternative:

    ```shell hl_lines="3"
    DK_UPGRADE=1 \
      DK_UPGRADE_MANAGER=1 \
      DK_UPGRADE_LISTEN=0.0.0.0:19542 \
      bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

---

Since the service provides an HTTP API, it has the following optional parameters ([:octicons-tag-24: Version-1.38.0](changelog.md#cl-1.38.0)):

- **`version`**: Upgrade or downgrade Datakit to a specified version number (if it's an offline installation, ensure that the specified version has been synchronized)
- **`force`**: If the current Datakit has not started or is behaving abnormally, we can force upgrade it and bring up the service via this parameter

We can manually invoke its interface to perform a remote update, or achieve a remote update through DCA.

=== "Manual Invocation"

    ```shell
    # Update to the latest Datakit version
    curl -XPOST "http://<datakit-ip>:9542/v1/datakit/upgrade"

    {"msg":"success"}

    # Update to a specified Datakit version
    curl -XPOST "http://<datakit-ip>:9542/v1/datakit/upgrade?version=3.4.5"

    # Forcefully upgrade a Datakit version
    curl -XPOST "http://<datakit-ip>:9542/v1/datakit/upgrade?force=1"
    ```

=== "DCA"

    Refer to the [DCA documentation](../dca/index.md).

---

???+ info

    - The upgrade process may take longer depending on network bandwidth conditions (basically equivalent to manually invoking the Datakit upgrade command), so please wait patiently for the API response. If interrupted during the process, **the behavior is undefined**.
    - During the upgrade process, if the specified version does not exist, the request will return an error (`3.4.5` this version does not exist):

    ```json
    {
      "error_code": "datakit.upgradeFailed",
      "message": "unable to download script file http://my.static.com/datakit/install-3.4.5.sh: resonse status: 404 Not Found"
    }
    ```

    - If the current Datakit is not running, it will return an error:

    ```json
    {
      "error_code": "datakit.upgradeFailed",
      "message": "get datakit version failed: unable to query current Datakit version: Get \"http://localhost:9529/v1/ping\": dial tcp localhost:9529 connect: connection refused)"
    }
    ```
<!-- markdownlint-enable -->

## Offline Update {#offline-upgrade}

Refer to the [Offline Installation](datakit-offline-install.md) related sections.

## FAQ {#faq}

### Differences Between Update and Installation {#upgrade-vs-install}

To upgrade to a newer version of Datakit, you can use:

- Reinstallation
- [Execute the upgrade command](datakit-update.md#manual)

On hosts where Datakit is already installed, it is recommended to upgrade to a newer version using the upgrade command rather than reinstalling. If you reinstall, all configurations inside [*datakit.conf*](datakit-conf.md#maincfg-example) will be reset to their default settings, such as global tag configurations, port settings, etc., which might not be what we expect.

However, regardless of whether you reinstall or execute the upgrade command, all collection-related configurations will remain unchanged.

### Handling Failed Version Checks {#version-check-failed}

During the DataKit installation/upgrade process, the installer checks the currently running DataKit version to ensure that the running DataKit version matches the upgraded version.

In some cases, the old version of the DataKit service may not have uninstalled successfully, causing the detected running DataKit version to still be the old version:

```shell
2022-09-22T21:20:35.967+0800    ERROR   installer  installer/main.go:374  checkIsNewVersion: current version: 1.4.13, expect 1.4.16
```

At this point, we can forcibly stop the old version of DataKit and restart DataKit:

``` shell
datakit service -T # Stop the service
datakit service -S # Start the new service

# If this doesn't work, you can first uninstall the DataKit service and reinstall it
datakit service -U # Uninstall the service
datakit service -I # Reinstall the service

# After completing the above operations, confirm that the DataKit version is the latest version

datakit version # Ensure the currently running DataKit is the latest version

       Version: 1.4.16
        Commit: 1357544bd6
        Branch: master
 Build At(UTC): 2022-09-20 11:43:20
Golang Version: go version go1.18.3 linux/amd64
      Uploader: zy-infra-gitlab-prod-runner/root/xxx
ReleasedInputs: checked
```

### Upgrading to a Specific Version {#downgrade}

If you need to upgrade or roll back to a specific version, you can do so using the following commands:

<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    ```shell
    DK_UPGRADE=1 bash -c "$(curl -L https://static.guance.com/datakit/install-3.4.5.sh)"
    ```
=== "Windows"

    ```powershell
    Remove-Item -ErrorAction SilentlyContinue Env:DK_*;
    $env:DK_UPGRADE="1";
    Set-ExecutionPolicy Bypass -scope Process -Force;
    Import-Module bitstransfer;
    start-bitstransfer  -source https://static.guance.com/datakit/install-3.4.5.ps1 -destination .install.ps1;
    powershell ./.install.ps1;
    ```
<!-- markdownlint-enable -->

The `<version number>` in the above command can be found on the [DataKit Release History](changelog-2025.md) page.

If you want to roll back the DataKit version, currently only versions after [1.2.0](changelog.md#cl-1.2.0) are supported; rolling back to earlier rc versions is not recommended.