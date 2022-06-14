# 0021-profile-exist-全局环境变量文件是否存在
---

## 规则ID

- 0021-profile-exist


## 类别

- system


## 级别

- critical


## 兼容版本


- Linux




## 说明


- 监控主机/etc/profile 是否存在



## 扫描频率
- 1 */5 * * *

## 理论基础





## 风险项


- 服务不可用



## 审计方法
- 验证主机/etc/profile。可以执行以下命令验证：

```bash
ls /etc/profile
```



## 补救
- 如果/etc/profile被删除后，请执行以下命令：
> ```bash
>    export PATH=/usr/bin:/usr/sbin:/bin:/sbin:/usr/X11R6/bin
> ```
> 通过vim /etc/profile新建立profile文件，把如下命令拷贝进去，再使用source /etc/profile是文件立即生效
```bash
# /etc/profile

 # System wide environment and startup programs, for login setup
 # Functions and aliases go in /etc/bashrc

 # It"s NOT a good idea to change this file unless you know what you
 # are doing. It"s much better to create a custom.sh shell script in
 # /etc/profile.d/ to make custom changes to your environment, as this
 # will prevent the need for merging in future updates.

 pathmunge () {
     case ":${PATH}:" in
         *:"$1":*)
             ;;
         *)
             if [ "$2" = "after" ] ; then
                 PATH=$PATH:$1
             else
                 PATH=$1:$PATH
             fi
     esac
 }


 if [ -x /usr/bin/id ]; then
     if [ -z "$EUID" ]; then
         # ksh workaround
         EUID=`id -u`
         UID=`id -ru`
     fi
     USER="`id -un`"
     LOGNAME=$USER
     MAIL="/var/spool/mail/$USER"
 fi

 # Path manipulation
 if [ "$EUID" = "0" ]; then
     pathmunge /usr/sbin
     pathmunge /usr/local/sbin
 else
     pathmunge /usr/local/sbin after
     pathmunge /usr/sbin after
 fi

 HOSTNAME=`/usr/bin/hostname 2>/dev/null`
 HISTSIZE=1000
 if [ "$HISTCONTROL" = "ignorespace" ] ; then
     export HISTCONTROL=ignoreboth
 else
     export HISTCONTROL=ignoredups
 fi

 export PATH USER LOGNAME MAIL HOSTNAME HISTSIZE HISTCONTROL

 # By default, we want umask to get set. This sets it for login shell
 # Current threshold for system reserved uid/gids is 200
 # You could check uidgid reservation validity in
 # /usr/share/doc/setup-*/uidgid file
 if [ $UID -gt 199 ] && [ "`id -gn`" = "`id -un`" ]; then
     umask 002
 else
     umask 022
 fi

 for i in /etc/profile.d/*.sh ; do
     if [ -r "$i" ]; then
         if [ "${-#*i}" != "$-" ]; then
             . "$i"
         else
             . "$i" >/dev/null
         fi
     fi
 done

 unset i
 unset -f pathmunge
 #ulimit -SHn 1024000
```



## 影响


- 无




## 默认值


- 无




## 参考文献


- [黑客入侵应急排查思路&&流程（非官方）](https://www.sohu.com/a/236820450_99899618)



- [记录一次真实的挖矿 入侵排查分析（非官方）](https://www.cnblogs.com/zsl-find/articles/11688640.html)



## CIS 控制


- 无


