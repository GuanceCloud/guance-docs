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

Run the following command to check the current DataKit version. If there is a newer version available online, it will prompt the corresponding update command, such as:

> - If [DataKit < 1.2.7](changelog.md#cl-1.2.7), use `datakit --version` here
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
    
    Online version available: 1.2.9, commit 9f5ac898be (released at 2022-03-10 12:03:12)
    
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
    
    Online version available: 1.2.9, commit 9f5ac898be (released at 2022-03-10 12:03:12)
    
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

> Note: The service does not support DataKit installed in k8s.

During the DataKit installation process, a remote update service is installed by default, specifically for upgrading the DataKit version. For older DataKit versions, you can specify additional parameters in the DataKit upgrade command to install this service:

<!-- markdownlint-disable MD046 -->

=== "Public Network Installation"

    ```shell hl_lines="2"
    DK_UPGRADE=1 \
      DK_UPGRADE_MANAGER=1 \
      bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

=== "Offline Update"

    [:octicons-tag-24: Version-1.38.0](changelog.md#cl-1.38.0)

    If you have [synchronized the DataKit installation package offline](datakit-offline-install.md#offline-advanced), assuming the offline installation package address is `http://my.static.com/datakit`, then the upgrade command here is

    ```shell hl_lines="3"
    DK_UPGRADE=1 \
      DK_UPGRADE_MANAGER=1 \
      DK_INSTALLER_BASE_URL="http://my.static.com/datakit" \
      bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

???+ attention

    The service defaults to binding on `0.0.0.0:9542`. If this address is occupied, you can specify an alternative:

    ```shell hl_lines="3"
    DK_UPGRADE=1 \
      DK_UPGRADE_MANAGER=1 \
      DK_UPGRADE_LISTEN=0.0.0.0:19542 \
      bash -c "$(curl -L https://static.guance.com/datakit/install.sh)"
    ```

---

Since the service provides an HTTP API, it has the following optional parameters ([:octicons-tag-24: Version-1.38.0](changelog.md#cl-1.38.0)):

- **`version`**: Upgrade or downgrade DataKit to a specified version number (if it's an offline installation, ensure the specified version has been synchronized)
- **`force`**: If the current DataKit has not started or behaves abnormally, we can force an upgrade using this parameter and bring up the service

We can manually call its interface to achieve remote updates or use DCA to perform remote updates.

=== "Manual Call"

    ```shell
    # Upgrade to the latest DataKit version
    curl -XPOST "http://<datakit-ip>:9542/v1/datakit/upgrade"

    {"msg":"success"}

    # Upgrade to a specific DataKit version
    curl -XPOST "http://<datakit-ip>:9542/v1/datakit/upgrade?version=3.4.5"

    # Force upgrade a DataKit version
    curl -XPOST "http://<datakit-ip>:9542/v1/datakit/upgrade?force=1"
    ```

=== "DCA"

    Refer to the [DCA documentation](../dca/index.md).

---

???+ info

    - The upgrade process may take longer depending on network bandwidth (basically equivalent to manually invoking the DataKit upgrade command), please wait patiently for the API response. If interrupted midway, **the behavior is undefined**.
    - During the upgrade process, if the specified version does not exist, the request will return an error (version `3.4.5` does not exist):

    ```json
    {
      "error_code": "datakit.upgradeFailed",
      "message": "unable to download script file http://my.static.com/datakit/install-3.4.5.sh: resonse status: 404 Not Found"
    }
    ```

    - If the current DataKit is not running, it will return an error:

    ```json
    {
      "error_code": "datakit.upgradeFailed",
      "message": "get datakit version failed: unable to query current Datakit version: Get \"http://localhost:9529/v1/ping\": dial tcp localhost:9529 connect: connection refused)"
    }
    ```
<!-- markdownlint-enable -->

## Offline Update {#offline-upgrade}

Refer to the relevant sections of the [Offline Installation](datakit-offline-install.md).

## FAQ {#faq}

### Differences Between Update and Installation {#upgrade-vs-install}

To upgrade to a newer version of DataKit, you can choose:

- Reinstallation
- [Execute the upgrade command](datakit-update.md#manual)

On hosts where DataKit is already installed, it is recommended to upgrade to a newer version using the upgrade command rather than reinstalling. If you reinstall, all configurations inside [*datakit.conf*](datakit-conf.md#maincfg-example) will be reset to default settings, such as global tag configurations, port settings, etc., which may not be what you expect.

However, regardless of whether you reinstall or execute the upgrade command, all collection-related configurations will remain unchanged.

### Handling Version Check Failures {#version-check-failed}

During the installation/upgrade process of DataKit, the installer checks the current running DataKit version to ensure that the running DataKit version matches the upgraded version.

However, in some cases, the old version of the DataKit service has not been successfully uninstalled, causing the detected version during the check to still be the old version:

```shell
2022-09-22T21:20:35.967+0800    ERROR   installer  installer/main.go:374  checkIsNewVersion: current version: 1.4.13, expect 1.4.16
```

At this point, you can forcefully stop the old version of DataKit and restart the DataKit service:

``` shell
datakit service -T # Stop the service
datakit service -S # Start the new service

# If not successful, uninstall the DataKit service first and then reinstall it
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

### Upgrading or Downgrading to a Specific Version {#downgrade}

To upgrade or downgrade to a specific version, you can use the following commands:

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

The `<version>` in the above command can be found on the [DataKit release history](changelog.md) page.

To downgrade the DataKit version, only versions after [1.2.0](changelog.md#cl-1.2.0) are supported; downgrading to rc versions before this is not recommended.