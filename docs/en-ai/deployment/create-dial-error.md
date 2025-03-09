## 1 Error Creating Dial Testing Node: SSL: WRONG_VERSION_NUMBER] wrong version number (_ssl.c:1131)

When creating a dial testing node, an error occurs:
![](img/create-dial-error-1.png)
Check the logs of the forethought-backend service under the forethought-core namespace, which show the following error:
![](img/create-dial-error-2.png)
Solution:
In the launcher, use the 【Modify Application Configuration】menu to change the dialtesting configuration. Change the protocol of the address configured at internal_server from https to http.
![](img/create-dial-error-3.png)

## 2 Error Adding New Node for Dial Testing

Problem Description: The 【Add New Node】function for dial testing reports an error: Failed to call the dial testing service interface.

Resolution:

Check the kodo logs and find the error message: `get ak error: Ak not found or disabled, ak: xxxx`

Log in to the database and run the following SQL queries:

```sql
-- Query the following SQL in df_core
select value from main_config where keyCode="DialingServerSet"

-- Query the following AK list in dialtesting
select * from aksk where parent_ak = -1 order by id asc;
```

Compare the values obtained from the SQL query with the value displayed in the "Other" option under the top-right menu button in the Launcher interface for `dialServiceAK`. Use the ak/sk information from `dialServiceAK` to overwrite the corresponding records in the database (update the data in the database using an UPDATE statement).