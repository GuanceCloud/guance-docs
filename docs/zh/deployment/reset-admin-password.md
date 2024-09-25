# 部署版kodo版本过期
---

## 问题描述
部署完成后首次登录到后台管理界面，需要重置 admin 密码，重置后如果没有记录密码，很久之后忘记密码将无法登录到后台管理中，可通过下述两种方式处理。
## 问题解决
### 方案一：通过其他管理员重置密码
如果存在多个管理员，可以通过**其他管理员用户**登录到后台管理，重置遗忘密码的管理员用户的密码。

### 方案二：修改数据库数据
进入到 pod 里，执行 python 命令生成加密后的字符串后，修改数据库字段值。
```shell
kubectl -n forethought-core get po |grep front-backend
kubectl -n forethought-core exec -it pod_name bash
```
执行下列命令获取密码加密值
```shell
python
from werkzeug.security import generate_password_hash
generate_password_hash('admin')
```
通过 mysql client 连接到MySQL 数据库，执行 sql
```sql
-- passwd 值是上一步骤中生成的值
update df_core.main_manage_account set password = 'passwd' where username= 'admin';
```