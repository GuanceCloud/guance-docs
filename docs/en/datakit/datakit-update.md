# DataKit Update
---

DataKit supports both manual and automatic update methods.

## Additional Supported Environment Variables {#extra-envs}

Currently, the upgrade command also supports environment variables consistent with the installation command [environment variables supported by the installation command](datakit-install.md#extra-envs), starting from version [1.62.1](changelog.md#cl-1.62.1).

## Prerequisites {#req}

- Remote updates require DataKit version >= 1.5.9
- Automatic updates require DataKit version >= 1.1.6-rc1
- Manual updates have no version requirements

## Manual Update {#manual}

Run the following commands to check the current DataKit version. If a newer version is available online, it will prompt the corresponding update command, for example:

> - If [DataKit < 1.2.7](changelog.md#cl-1.2.7), use `datakit --version` here.
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

If the current DataKit is in proxy mode, the automatic update prompt command will automatically include proxy settings:

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

> Note: The service does not support Datakit installed in k8s.

During the Datakit installation process, a remote update service is installed by default, specifically for upgrading the Datakit version. For older versions of Datakit, you can specify additional parameters in the Datakit upgrade command to install this service:

<!-- markdownlint-disable MD046 -->

=== "Public Network Installation"

    ```shell hl_lines="2"
    DK_UPGRADE=1 \
      DK_UPGRADE_MANAGER=1 \
      bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

=== "Offline Update"

    [:octicons-tag-24: Version-1.38.0](changelog.md#cl-1.38.0)

    If you have [offline synchronized the Datakit installation package](datakit-offline-install.md#offline-advanced), assuming the offline package URL is `http://my.static.com/datakit`, then the upgrade command here is:

    ```shell hl_lines="3"
    DK_UPGRADE=1 \
      DK_UPGRADE_MANAGER=1 \
      DK_INSTALLER_BASE_URL="http://my.static.com/datakit" \
      bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

???+ attention

    By default, the service binds to address `0.0.0.0:9542`. If this address is occupied, you can specify an alternative:

    ```shell hl_lines="3"
    DK_UPGRADE=1 \
      DK_UPGRADE_MANAGER=1 \
      DK_UPGRADE_LISTEN=0.0.0.0:19542 \
      bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

---

Since the service provides an HTTP API, it has the following optional parameters ([:octicons-tag-24: Version-1.38.0](changelog.md#cl-1.38.0)):

- **`version`**: Upgrade or downgrade Datakit to the specified version (for offline installations, ensure the specified version has been synchronized).
- **`force`**: If the current Datakit has not started or behaves abnormally, we can force its upgrade and restart the service using this parameter.

We can manually call its interface to perform a remote update, or achieve remote updates through DCA.

=== "Manual Call"

    ```shell
    # Upgrade to the latest Datakit version
    curl -XPOST "http://<datakit-ip>:9542/v1/datakit/upgrade"

    {"msg":"success"}

    # Upgrade to a specific Datakit version
    curl -XPOST "http://<datakit-ip>:9542/v1/datakit/upgrade?version=3.4.5"

    # Force upgrade a Datakit version
    curl -XPOST "http://<datakit-ip>:9542/v1/datakit/upgrade?force=1"
    ```

=== "DCA"

    Refer to the [DCA documentation](../dca/index.md).

---

???+ info

    - The upgrade process may take longer depending on network bandwidth (basically equivalent to manually calling the Datakit upgrade command). Please wait patiently for the API response. If interrupted midway, **the behavior is undefined**.
    - During the upgrade process, if the specified version does not exist, the request will return an error (e.g., version `3.4.5` does not exist):

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

Refer to the relevant sections in [Offline Installation](datakit-offline-install.md).

## FAQ {#faq}

### Differences Between Update and Install {#upgrade-vs-install}

To upgrade to a newer version of Datakit, you can choose to:

- Reinstall
- [Execute the upgrade command](datakit-update.md#manual)

On hosts where Datakit is already installed, it is recommended to upgrade to a newer version via the upgrade command rather than reinstalling. If you reinstall, all configurations inside [*datakit.conf*](datakit-conf.md#maincfg-example) will be reset to default settings, such as global tag configurations, port settings, etc. This may not be what you expect.

However, regardless of whether you reinstall or execute the upgrade command, all collection-related configurations will not change.

### Handling Version Check Failures {#version-check-failed}

During DataKit installation/upgrade, the installer checks the current running DataKit version to ensure it matches the upgraded version.

However, in some cases, the old version of the DataKit service may not have uninstalled successfully, causing the detected version to still be the old one:

```shell
2022-09-22T21:20:35.967+0800    ERROR   installer  installer/main.go:374  checkIsNewVersion: current version: 1.4.13, expect 1.4.16
```

In this case, you can forcefully stop the old version of DataKit and restart it:

``` shell
datakit service -T # Stop the service
datakit service -S # Start the new service

# If that doesn't work, uninstall and reinstall the DataKit service
datakit service -U # Uninstall the service
datakit service -I # Reinstall the service

# After completing the above operations, confirm that the DataKit version is the latest

datakit version # Ensure the currently running DataKit is the latest version

       Version: 1.4.16
        Commit: 1357544bd6
        Branch: master
 Build At(UTC): 2022-09-20 11:43:20
Golang Version: go version go1.18.3 linux/amd64
      Uploader: zy-infra-gitlab-prod-runner/root/xxx
ReleasedInputs: checked
```

### Updating to a Specific Version {#downgrade}

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

The `<version>` in the above commands can be found on the [DataKit release history](changelog.md) page.

To roll back the DataKit version, only versions after [1.2.0](changelog.md#cl-1.2.0) are supported; earlier rc versions are not recommended for rollback.
