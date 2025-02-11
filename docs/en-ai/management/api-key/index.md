# API Key Management
---

Guance supports obtaining and updating workspace data through calling Open API interfaces. Before calling the API interface, you need to create an API Key as the authentication method.

> For more information about APIs, refer to [OpenAPI](../../management/api-key/open-api.md).


## Create a New API Key

In the Guance workspace **Management > API Key Management**, click **Create Key** in the top-right corner, enter the Key name, and click OK.

**Note**: API Key management is editable by administrators and above.

<img src="../img/3_apikey_1.png" width="80%" >

After clicking **OK**, you will receive the API Key ID and secret key for API calls.

![](../img/3_apikey_2.png)

Alternatively, you can obtain the API Key ID and secret key by clicking the view icon on the right side of the API Key management list. If it is no longer needed or there is a risk of leakage, you can delete and recreate it.

![](../img/3.apikey_3.png)

Creating or deleting an API Key will generate operation audit events, which can be viewed under **Management > Basic Settings** in the Guance workspace.

![](../img/3.apikey_4.png)