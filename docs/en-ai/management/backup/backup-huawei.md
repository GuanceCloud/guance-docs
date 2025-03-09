# Data Forwarding to Huawei Cloud OBS
---

## Start Configuration

1. Choose **Huawei Cloud OBS** as the archive type, which means that the matched log data will be saved to this object storage;   
2. Select [Access Type](#type);
3. Click confirm to create successfully.

**Note**: If the archive type information changes, ensure that the configuration of the associated platform has been synchronized to avoid data write failures due to configuration changes. New configuration rules will take effect within 5 minutes.


## Access Type {#type}

### Account Authorization

![](../img/back-8.png)

1. You must use the exclusive Huawei Cloud account ID provided by <<< custom_key.brand_name >>> and [add cross-account access authorization policies](../obs-config.md);
2. Select region;
3. Enter your bucket name on Huawei Cloud;

4. Enter the [storage path](#standard) to facilitate further differentiation and location of forwarded data;
5. Click confirm to create successfully.

### Access Keys {#ak}

![](../img/back-9.png)

1. First configure the <<< custom_key.brand_name >>> RAM policy in Huawei Cloud [here](../obs-ak.md);
2. Enter Access Key;
3. Enter the corresponding Secret Key;
4. Select region;
5. Enter the bucket name;
6. Enter the [storage path](#standard) to facilitate further differentiation and location of forwarded data;
7. Click confirm to create successfully.

**Regarding overseas sites**: The account IDs for overseas sites differ from those in China:

| Site | ID    |
| ---------- | ------------- |
| Hong Kong | 25507c35fe7e40aeba77f7309e94dd77    |
| Oregon | 25507c35fe7e40aeba77f7309e94dd77    |
| Singapore | 25507c35fe7e40aeba77f7309e94dd77    |
| Frankfurt | 25507c35fe7e40aeba77f7309e94dd77    |

#### Directory Path (Folder) Naming Conventions {#standard}

1. Create a single folder or multiple levels of folders, with slashes (/) indicating the creation of multi-level folders.  
2. Folder names cannot start or end with a slash (/).  
3. They cannot contain two or more consecutive slashes (/). 

**Note**:
    
- If the entered folder does not exist, <<< custom_key.brand_name >>> will create it directly, and data will still be stored under this path.
- Be cautious when changing the storage path, as updating configurations may have a delay of about 5 minutes, and some data might still be forwarded to the original directory after changes.

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Add an account access authorization policy in <<< custom_key.brand_name >>></font>](../obs-config.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; What is a bucket policy?</font>](https://support.huaweicloud.com/perms-cfg-obs/obs_40_0004.html)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; How to grant read/write permissions to other accounts in Huawei Cloud?</font>](https://support.huaweicloud.com/perms-cfg-obs/obs_40_0025.html)


</div>

</font>