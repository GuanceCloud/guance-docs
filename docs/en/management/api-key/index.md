# API Key Management
---

<<< custom_key.brand_name >>> supports obtaining and updating data in the workspace by calling Open API interfaces. Before calling the API interface, you need to create an API Key first, which is used for identity authentication.

> For more information about APIs, refer to [OpenAPI](../../management/api-key/open-api.md).


## Create

1. Define the Key name;
2. Select the role for this API Key;
3. Click confirm.

**Note**: If multiple roles are selected for this API Key, the final permissions will be the **union** of the selected role permissions.

<img src="../img/3_apikey_1.png" width="80%" >

After successfully creating, you will obtain the API Key ID and secret key used for calling.

![](../img/3.apikey_3.png)

![](../img/3_apikey_2.png)