# 0048-libusrbin-add-/usr/bin Directory Has New Files Added
---

## Rule ID

- 0048-libusrbin-add


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- Monitor the /usr/bin directory for new files being added.



## Scan Frequency
- disable

## Theoretical Basis


- The /usr/bin directory contains essential executable files for system commands. If new files are added, it is necessary to determine whether they are legitimate system commands.



## Risk Items


- Functionality may become unavailable



## Audit Method
- None



## Remediation
- If files in the /usr/bin directory are deleted, verify if they were legitimate system commands.



## Impact


- None




## Default Value


- None




## References


- None



## CIS Control


- None


</input_content>
</target_language>
</input_content>
</target_language>
</input>
</instruction>
<input>
<input_content>
# 0048-libusrbin-add-/usr/bin 目录被添加文件
---

## 规则ID

- 0048-libusrbin-add


## 类别

- system


## 级别

- warn


## 兼容版本


- Linux




## 说明


- 监控主机目录/usr/bin下有新文件被添加



## 扫描频率
- disable

## 理论基础


- /usr/bin目录放置的是系统基本的关键命令的可执行文件，如果有新文件添加，需要判断是否为正常的系统命令。






## 风险项


- 功能不可用



## 审计方法
- 无



## 补救
- 如果检测到/usr/bin目录下文件被删除，请检查是否为正常的系统命令。



## 影响


- 无




## 默认值


- 无




## 参考文献


- 无



## CIS 控制


- 无


</input_content>
<target_language>英语</target_language>
</input>

# 0048-libusrbin-add-/usr/bin Directory Has New Files Added
---

## Rule ID

- 0048-libusrbin-add


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- Monitoring detects new files being added to the host's /usr/bin directory.



## Scan Frequency
- disable

## Theoretical Basis


- The /usr/bin directory contains essential executable files for critical system commands. If new files are added, it is necessary to determine whether they are legitimate system commands.



## Risk Items


- Functionality may become unavailable



## Audit Method
- None



## Remediation
- If files in the /usr/bin directory are detected as being deleted, check if they were legitimate system commands.



## Impact


- None




## Default Value


- None




## References


- None



## CIS Control


- None