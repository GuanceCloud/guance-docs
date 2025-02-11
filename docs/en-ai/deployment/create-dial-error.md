## New Dial Testing Node Creation Error SSL: WRONG_VERSION_NUMBER] wrong version number (_ssl.c:1131)
An error occurs when creating a new dial testing node.
![](img/create-dial-error-1.png)
Checking the logs of the forethought-backend service under the forethought-core namespace reveals the following error:
![](img/create-dial-error-2.png)
Solution:
In the launcher, go to the 【Modify Application Configuration】menu, edit the dialtesting configuration, and change the protocol of the address configured at internal_server from https to http.
![](img/create-dial-error-3.png)