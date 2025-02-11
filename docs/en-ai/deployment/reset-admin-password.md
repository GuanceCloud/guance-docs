# Deployment Plan kodo Version Expiration
---

## Problem Description
After the first login to the backend management interface following deployment, you need to reset the admin password. If the new password is not recorded and forgotten after a long time, you will be unable to log in to the backend management. This issue can be resolved through the following two methods.

## Problem Resolution
### Solution One: Reset Password via Another Administrator
If multiple administrators exist, you can log in to the backend management using **another administrator user** to reset the forgotten password of the administrator user.

### Solution Two: Modify Database Data
Enter the pod and execute the Python command to generate an encrypted string, then modify the database field value.
```shell
kubectl -n forethought-core get po | grep front-backend
kubectl -n forethought-core exec -it pod_name bash
```
Execute the following commands to obtain the encrypted password value:
```shell
python
from werkzeug.security import generate_password_hash
generate_password_hash('admin')
```
Connect to the MySQL database using the MySQL client and execute the SQL command:
```sql
-- The passwd value is generated from the previous step
update df_core.main_manage_account set password = 'passwd' where username= 'admin';
```