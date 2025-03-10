# 0021-profile-exist-Check if Global Environment Variable File Exists
---

## Rule ID

- 0021-profile-exist


## Category

- System


## Level

- Critical


## Compatible Versions

- Linux


## Description

- Monitor whether `/etc/profile` exists on the host.


## Scan Frequency

- 1 */5 * * *


## Theoretical Basis



## Risk Items

- Service Unavailable


## Audit Method

- Verify the existence of `/etc/profile` on the host. You can run the following command to verify:

```bash
ls /etc/profile
```


## Remediation

- If `/etc/profile` has been deleted, please execute the following commands:
> ```bash
>    export PATH=/usr/bin:/usr/sbin:/bin:/sbin:/usr/X11R6/bin
> ```
> Create a new `profile` file using `vim /etc/profile`, copy the following content into it, and then use `source /etc/profile` to make the changes take effect immediately.
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


## Impact

- None


## Default Value

- None


## References

- [Emergency Response Thoughts and Procedures for Hacker Intrusions (Unofficial)](https://www.sohu.com/a/236820450_99899618)

- [Real Case Analysis of a Mining Malware Intrusion (Unofficial)](https://www.cnblogs.com/zsl-find/articles/11688640.html)


## CIS Controls

- None