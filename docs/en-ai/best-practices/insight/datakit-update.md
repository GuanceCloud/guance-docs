# Best Practices for Datakit Version Updates

---

## One: Manual Update (Total 2 Steps)

### Step 1: Execute `datakit --version` First

(The purpose is to facilitate version comparison before and after the update.) The result is as follows:

![image.png](../images/datakit-update-1.png)

### Step 2: Execute Command (Please Choose the Corresponding Command)

**【Install on Linux】**

| Architecture | Command |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| X86 amd64    | `sudo -- sh -c 'curl https://<<< custom_key.static_domain >>>/datakit/installer-linux-amd64 -o dk-installer && chmod +x ./dk-installer && ./dk-installer -upgrade && rm -rf ./dk-installer'` |
| X86 i386     | `sudo -- sh -c 'curl https://<<< custom_key.static_domain >>>/datakit/installer-linux-386 -o dk-installer && chmod +x ./dk-installer && ./dk-installer -upgrade && rm -rf ./dk-installer'`   |
| arm          | `sudo -- sh -c 'curl https://<<< custom_key.static_domain >>>/datakit/installer-linux-arm -o dk-installer && chmod +x ./dk-installer && ./dk-installer -upgrade && rm -rf ./dk-installer'`   |
| arm64        | `sudo -- sh -c 'https://<<< custom_key.static_domain >>>/datakit/installer-linux-arm64 -o dk-installer && chmod +x ./dk-installer && ./dk-installer -upgrade && rm -rf ./dk-installer'`      |


**【Install on Windows】**

| Architecture | Command |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 64-bit       | `Import-Module bitstransfer; start-bitstransfer -source [https://<<< custom_key.static_domain >>>/datakit/installer-windows-amd64.exe](https://<<< custom_key.static_domain >>>/datakit/installer-windows-amd64.exe) -destination .dk-installer.exe; .dk-installer.exe -upgrade; rm .dk-installer.exe` |
| 32-bit       | `Import-Module bitstransfer; start-bitstransfer -source [https://<<< custom_key.static_domain >>>/datakit/installer-windows-386.exe](https://<<< custom_key.static_domain >>>/datakit/installer-windows-amd64.exe) -destination .dk-installer.exe; .dk-installer.exe -upgrade; rm .dk-installer.exe`   |

**【Install on MacOS】**

| Architecture | Command |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| all          | `sudo -- sh -c "curl [https://<<< custom_key.static_domain >>>/datakit/installer-darwin-amd64](https://<<< custom_key.static_domain >>>/datakit/installer-darwin-amd64) -o dk-installer && chmod +x ./dk-installer && ./dk-installer -upgrade && rm -rf ./dk-installer"` |

## Two: Automatic Update (Currently Automatic Update Only Supports Linux)

### Step 1: Prepare the Update Script

Copy the following script content to the installation directory of the machine where DataKit is located, save it as `datakit-update.sh` (the name can be arbitrary, as long as you know it).

```bash
#!/bin/bash
# Update DataKit if a new version is available

otalog=/usr/local/datakit/ota-update.log
installer=https://<<< custom_key.static_domain >>>/datakit/installer-linux-amd64

# Note: If you do not want to update RC versions of DataKit, remove `--accept-rc-version`
/usr/local/datakit/datakit --check-update --accept-rc-version --update-log $otalog

if [[ $? == 42 ]]; then
 echo "updating now..."
 sudo -- sh -c "curl ${installer}  -o dk-installer &&
	 chmod +x ./dk-installer &&
	 ./dk-installer --upgrade --ota --install-log "${otalog}" &&
	 rm -rf ./dk-installer"
fi
```

### Step 2: Add crontab Task

Execute the following command to enter the crontab rule addition interface:

```shell
crontab -u root -e
```

Add the following rule:

```shell
# This means trying to update to a new version at midnight every day
0 0 * * * bash /path/to/datakit-update.sh
```

Tip: Basic crontab syntax is as follows

```
*   *   *   *   *     <command to be executed>
^   ^   ^   ^   ^
|   |   |   |   |
|   |   |   |   +----- day of week (0 - 6) (Sunday=0)
|   |   |   +--------- month (1 - 12)   
|   |   +------------- day of month (1 - 31)
|   +----------------- hour (0 - 23)   
+--------------------- minute (0 - 59)
```

Run the following command to ensure crontab is installed successfully:

```shell
crontab -u root -l
```

Ensure that the crontab service is running:

```shell
service cron restart
```

If the installation is successful and an update attempt has been made, you will see logs similar to the following in the `update_log`:

```
2021-05-10T09:49:06.083+0800 DEBUG	ota-update datakit/main.go:201	get online version...
2021-05-10T09:49:07.728+0800 DEBUG	ota-update datakit/main.go:216	online version: datakit 1.1.6-rc0/9bc4b960, local version: datakit 1.1.6-rc0-62-g7a1d0956/7a1d0956
2021-05-10T09:49:07.728+0800 INFO	ota-update datakit/main.go:224	Up to date(1.1.6-rc0-62-g7a1d0956)
```

If an update actually occurs, you will see logs similar to the following:

```
2021-05-10T09:52:18.352+0800 DEBUG ota-update datakit/main.go:201 get online version...
2021-05-10T09:52:18.391+0800 DEBUG ota-update datakit/main.go:216 online version: datakit 1.1.6-rc0/9bc4b960, local version: datakit 1.0.1/7a1d0956
2021-05-10T09:52:18.391+0800 INFO  ota-update datakit/main.go:219 New online version available: 1.1.6-rc0, commit 9bc4b960 (released at 2021-04-30 14:31:27)
...
```

---