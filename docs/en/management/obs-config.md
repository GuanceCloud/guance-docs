# Huawei Cloud OBS Bucket Authorization

## Specific Operations

1. [Log in to the Huawei Cloud console](https://auth.huaweicloud.com/authui/login.html?service=https://console.huaweicloud.com/console/#/login).

2. On the **Service List** page, find **Object Storage Service**, enter the **Parallel File System** page, which is the bucket:

![](img/obs.png)

3. Select the target file system, go to **Access Control > ACL**:

![](img/obs-1.png)

4. Click **Add**, enter the **New Account Authorization** page.

4.1 Enter the authorized Huawei Cloud account ID, check the bucket access permissions and ACL access permissions, and click OK:

**Note**: The account ID here is the exclusive Huawei Cloud account ID provided by <<< custom_key.brand_name >>>: `f000ee4d7327428da2f53a081e7109bd`

![](img/obs-2.png)

5. If download permission is not available, check the **Object Read Permission**, and click **OK**.

![](img/obs-3.png)

## Further Reading

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; What is a Bucket Policy?</font>](https://support.huaweicloud.com/perms-cfg-obs/obs_40_0004.html)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; How to Grant Read and Write Permissions for Other Accounts on a Bucket in Huawei Cloud?</font>](https://support.huaweicloud.com/perms-cfg-obs/obs_40_0025.html)

</div>