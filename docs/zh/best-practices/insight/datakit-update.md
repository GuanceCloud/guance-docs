# Datakit版本更新最佳实践

---

## 一：手动更新（总共2步）

### 步骤1:先执行 datakit--version

（目的为：方便更新前后版本对比）效果如下

![image.png](../images/datakit-update-1.png)

### 步骤2:执行命令（注意选择对应的命令）

**【在 Linux 上安装】**

| X86 amd64 | `sudo -- sh -c 'curl https://{{{ custom_key.static_domain }}}/datakit/installer-linux-amd64 -o dk-installer && chmod +x ./dk-installer && ./dk-installer -upgrade && rm -rf ./dk-installer'` |
| --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| X86 i386  | `sudo -- sh -c 'curl https://{{{ custom_key.static_domain }}}/datakit/installer-linux-386 -o dk-installer && chmod +x ./dk-installer && ./dk-installer -upgrade && rm -rf ./dk-installer'`   |
| arm       | `sudo -- sh -c 'curl https://{{{ custom_key.static_domain }}}/datakit/installer-linux-arm -o dk-installer && chmod +x ./dk-installer && ./dk-installer -upgrade && rm -rf ./dk-installer'`   |
| arm64     | `sudo -- sh -c 'https://{{{ custom_key.static_domain }}}/datakit/installer-linux-arm64 -o dk-installer && chmod +x ./dk-installer && ./dk-installer -upgrade && rm -rf ./dk-installer'`      |



**【在 Windows 上安装】**

| 64位 | `Import-Module bitstransfer; start-bitstransfer -source [https://{{{ custom_key.static_domain }}}/datakit/installer-windows-amd64.exe](https://{{{ custom_key.static_domain }}}/datakit/installer-windows-amd64.exe) -destination .dk-installer.exe; .dk-installer.exe -upgrade; rm .dk-installer.exe` |
| ---- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 32位 | `Import-Module bitstransfer; start-bitstransfer -source [https://{{{ custom_key.static_domain }}}/datakit/installer-windows-386.exe](https://{{{ custom_key.static_domain }}}/datakit/installer-windows-amd64.exe) -destination .dk-installer.exe; .dk-installer.exe -upgrade; rm .dk-installer.exe`   |

**【在 MacOS 上安装 上安装】**

| all | `sudo -- sh -c "curl [https://{{{ custom_key.static_domain }}}/datakit/installer-darwin-amd64](https://{{{ custom_key.static_domain }}}/datakit/installer-darwin-amd64) -o dk-installer && chmod +x ./dk-installer && ./dk-installer -upgrade && rm -rf ./dk-installer"` |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |

## 二：自动更新（目前自动更新只支持 Linux）

### 步骤1:准备更新脚本

将如下脚本内容复制到 DataKit 所在机器的安装目录下，保存 `datakit-update.sh`（名称随意，自己知道就行）

```bash
#!/bin/bash
# Update DataKit if new version available

otalog=/usr/local/datakit/ota-update.log
installer=https://{{{ custom_key.static_domain }}}/datakit/installer-linux-amd64

# 注意：如果不希望更新 RC 版本的 DataKit，可移除 `--accept-rc-version`
/usr/local/datakit/datakit --check-update --accept-rc-version --update-log $otalog

if [[ $? == 42 ]]; then
 echo "update now..."
 sudo -- sh -c "curl ${installer}  -o dk-installer &&
	 chmod +x ./dk-installer &&
	 ./dk-installer --upgrade --ota --install-log "${otalog}" &&
	 rm -rf ./dk-installer"
fi
```

### 步骤2:添加 crontab 任务

执行如下命令，进入 crontab 规则添加界面：

```shell
crontab -u root -e
```

添加如下规则：

```shell
# 意即每天凌晨尝试一下新版本更新
0 0 * * * bash /path/to/datakit-update.sh
```

Tips: crontab 基本语法如下

```
*   *   *   *   *     <command to be execute>
^   ^   ^   ^   ^
|   |   |   |   |
|   |   |   |   +----- day of week(0 - 6) (Sunday=0)
|   |   |   +--------- month (1 - 12)   
|   |   +------------- day of month (1 - 31)
|   +----------------- hour (0 - 23)   
+--------------------- minute (0 - 59)
```

执行如下命令确保 crontab 安装成功：

```shell
crontab -u root -l
```

确保 crontab 服务启动：

```shell
service cron restart
```

如果安装成功且有尝试更新，则在 `update_log` 中能看到类似如下日志：

```
2021-05-10T09:49:06.083+0800 DEBUG	ota-update datakit/main.go:201	get online version...
2021-05-10T09:49:07.728+0800 DEBUG	ota-update datakit/main.go:216	online version: datakit 1.1.6-rc0/9bc4b960, local version: datakit 1.1.6-rc0-62-g7a1d0956/7a1d0956
2021-05-10T09:49:07.728+0800 INFO	ota-update datakit/main.go:224	Up to date(1.1.6-rc0-62-g7a1d0956)
```

如果确实发生了更新，会看到类似如下的更新日志：

```
2021-05-10T09:52:18.352+0800 DEBUG ota-update datakit/main.go:201 get online version...
2021-05-10T09:52:18.391+0800 DEBUG ota-update datakit/main.go:216 online version: datakit 1.1.6-rc0/9bc4b960, local version: datakit 1.0.1/7a1d0956
2021-05-10T09:52:18.391+0800 INFO  ota-update datakit/main.go:219 New online version available: 1.1.6-rc0, commit 9bc4b960 (release at 2021-04-30 14:31:27)
...
```

---

