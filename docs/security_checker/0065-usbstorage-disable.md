# 0065-usbstorage-disable-禁用USB存储
---

## 规则ID

- 0065-usbstorage-disable


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- USB存储设备提供了一种传输和存储文件的方法。但是有黑客通过USB向服务器安装恶意软件，已成为网络渗透的一种简单而通用的手段，并且是在网络环境中建立持久威胁的通用方式。



## 扫描频率
- 0 */30 * * *

## 理论基础


- 限制系统上的USB访问将减少设备的物理层面的攻击，并减少引入恶意软件的可能性






## 风险项


- 生产服务器尽量减少对外的接口，usb是一种简单又高效的植入恶意软件的方式。



## 审计方法
- 运行以下命令并验证输出是否如所示：

``` bash
# modprobe -n -v usb-storage
install /bin/true
# lsmod | grep usb-storage
<No output>
```



## 补救
- 在/etc/modprobe.d/目录中以.conf结尾的文件中编辑或创建文件。
  示例：vim /etc/modprobe.d/usb_storage.conf添加以下行：

``` bash
install usb-storage /bin/true
```
运行以下命令以卸载usb-storage模块：

``` bash
# rmmod usb-storage
```



## 影响


- 卸载以后，不发份子将无法通过usb接口植入恶意软件。系统安全性也得到了提升




## 默认值


- 默认没有安装usb模块




## 参考文献


- 无



## CIS 控制


- Version 7
    >   8.4 Configure Anti-Malware Scanning of Removable Devices



- Configure devices so that they automatically conduct an anti-malware scan of removable media when inserted or connected.
    >   8.5 Configure Devices Not To Auto-run Content



- Configure devices to not auto-run content from removable media.


