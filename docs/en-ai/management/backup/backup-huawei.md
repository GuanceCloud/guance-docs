# Data Forwarding to Huawei Cloud OBS
---

## Start Configuration

1. Select **Huawei Cloud OBS** as the archive type, which means that the matched log data will be saved to this object storage;   
2. Choose [Access Type](#type);
3. Click confirm to create successfully.

**Note**: If the archive type information changes, ensure that the associated platform configuration is updated accordingly to avoid data write failures due to configuration changes. New configuration rules will take effect within 5 minutes.

## Access Type {#type}

### Account Authorization

![](../img/back-8.png)

1. Use the exclusive Huawei Cloud account ID provided by Guance, and [add a cross-account access authorization policy](../obs-config.md);
2. Select the region;
3. Enter your bucket name in Huawei Cloud;

4. Enter the [storage path](#standard) for easier differentiation and location of forwarded data;
5. Click confirm to create successfully.

### Access Keys {#ak}

![](../img/back-9.png)

1. Configure the RAM policy for Guance in Huawei Cloud first [here](../obs-ak.md);
2. Enter the Access Key;
3. Enter the corresponding Secret Key;
4. Select the region;
5. Enter the bucket name;
6. Enter the [storage path](#standard) for easier differentiation and location of forwarded data;
7. Click confirm to create successfully.

**Regarding Overseas Sites**: The account IDs for overseas sites differ from those in China:

| Site | ID    |
| ---------- | ------------- |
| Hong Kong | 25507c35fe7e40aeba77f7309e94dd77    |
| Oregon | 25507c35fe7e40aeba77f7309e94dd77    |
| Singapore | 25507c35fe7e40aeba77f7309e94dd77    |
| Frankfurt | 25507c35fe7e40aeba77f7309e94dd77    |

#### Directory Path (Folder) Naming Convention {#standard}

1. Create a single folder or multiple levels of folders using slashes (/) to indicate nested directories.
2. Folder names cannot start or end with a slash (/).
3. Do not include more than two consecutive slashes (/).

**Note**:
    
- If the specified folder does not exist, Guance will create it directly, and data will still be stored under this path.
- Be cautious when changing the storage path. Due to a delay of about 5 minutes in updating configurations, some data may still be forwarded to the original directory after changes.

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Add an Account Access Authorization Policy in Guance</font>](../obs-config.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; What is a Bucket Policy?</font>](https://support.huaweicloud.com/perms-cfg-obs/obs_40_0004.html)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; How to Grant Read/Write Permissions to Other Accounts in Huawei Cloud?</font>](https://support.huaweicloud.com/perms-cfg-obs/obs_40_0025.html)


</div>

</font>