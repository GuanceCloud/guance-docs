# 0081-gdm-config-GDM has not been deleted or configured for login
---

## Rule ID

- 0081-gdm-config


## Category

- system


## Level

- warn


## Compatible Versions


- Linux




## Description


- GDM (GNOME Display Manager) is used to handle graphical logins for GNOME-based systems.



## Scan Frequency
- 1 */5 * * *

## Theoretical Basis


- If graphical login is not required, it should be removed to reduce the attack surface of the system. If graphical login is necessary, displaying the last logged-in user should be disabled and a warning banner should be configured.
Displaying the last logged-in user can eliminate half of the equation needed for unauthorized users to log in, such as the user ID/password.
The warning message informs users attempting to log in about the legal status of the system and must include the name of the organization that owns the system and any implemented monitoring policies.
Note:
Other options and sections may appear in the /etc/dconf/db/gdm.d/01-banner-message file.
If another GUI login service is being used and is required on the system, refer to its documentation to disable the display of the last logged-in user and apply an equivalent banner.



## Risk Items


- Cybersecurity



## Audit Method
- Run the following command to verify that gdm is not installed on the system:
```bash
 # rpm -q gdm
package gdm is not installed
```
Or
If GDM is required:
Verify that /etc/dconf/profile/gdm exists and includes the following content:
```bash
user-db:user
system-db:gdm file-db:/usr/share/gdm/greeter-dconf-defaults
```
Verify that files exist in /etc/dconf/db/gdm.d/ and contain the following content: (this is usually /etc/dconf/db/gdm.d/01-banner-message)
```bash
[org/gnome/login-screen]
banner-message-enable=true
banner-message-text='<banner message>'
```
Verify that files exist in /etc/dconf/db/gdm.d/ and contain the following content: (this is usually /etc/dconf/db/gdm.d/00-login-screen)
```bash
[org/gnome/login-screen]
disable-user-list=true
```



## Remediation
- Run the following command to remove gdm
```bash
# yum remove gdm
```
Or
If GDM is required:
Edit or create the file /etc/dconf/profile/gdm and add the following content:
```bash
user-db:user
system-db:gdm
file-db:/usr/share/gdm/greeter-dconf-defaults
```
Edit or create the file /etc/dconf/db/gdm.d/, and add the following content: (this is usually /etc/dconf/db/gdm.d/01-banner-message)
```bash
 [org/gnome/login-screen]
banner-message-enable=true
banner-message-text='<banner message>'
```
Example banner text: "Authorized use only."
Edit or create the file /etc/dconf/db/gdm.d/, and add the following content: (this is usually /etc/dconf/db/gdm.d/00-login-screen)
```bash
[org/gnome/login-screen]
# Do not show the user list
disable-user-list=true
```
Run the following command to update the system database:
```bash
# dconf update
```



## Impact


- None




## Default Value



## References


- None



## CIS Control


- Version 7
5.1 Establish Secure Configurations
Maintain documented secure configuration standards for all authorized operating systems and software.