# 0065-usbstorage-disable - Disable USB Storage
---

## Rule ID

- 0065-usbstorage-disable


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- USB storage devices provide a method for transferring and storing files. However, hackers have been using USB devices to install malware on servers, which has become a simple and common method for network penetration and establishing persistent threats in network environments.



## Scan Frequency
- 0 */30 * * *

## Theoretical Basis


- Restricting USB access on the system will reduce physical attacks on the device and decrease the likelihood of introducing malware






## Risk Items


- Production servers should minimize external interfaces; USB is a simple and efficient way to implant malware.



## Audit Method
- Run the following commands and verify that the output matches the expected results:

``` bash
# modprobe -n -v usb-storage
install /bin/true
# lsmod | grep usb-storage
<No output>
```



## Remediation
- Edit or create a file with a .conf extension in the /etc/modprobe.d/ directory.
  Example: Add the following line in vim /etc/modprobe.d/usb_storage.conf:

``` bash
install usb-storage /bin/true
```
Run the following command to unload the usb-storage module:

``` bash
# rmmod usb-storage
```



## Impact


- After unloading, the system will not be able to implant malware through the USB interface, enhancing system security.




## Default Value


- By default, the USB module is not installed.




## References


- None



## CIS Controls


- Version 7
    >   8.4 Configure Anti-Malware Scanning of Removable Devices



- Configure devices so that they automatically conduct an anti-malware scan of removable media when inserted or connected.
    >   8.5 Configure Devices Not To Auto-run Content



- Configure devices to not auto-run content from removable media.