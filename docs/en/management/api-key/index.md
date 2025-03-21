# API Key Management
---

<<< custom_key.brand_name >>> supports obtaining and updating <<< custom_key.brand_name >>> workspace data through calling Open API interfaces. Before calling the API interface, you need to create an API Key as the authentication method.

> For API introduction, refer to [OpenAPI](../../management/api-key/open-api.md).


## Create API Key

In <<< custom_key.brand_name >>> workspace **Management > API Key Management**, click **Create Key** in the top-right corner, enter the Key name, and click Confirm.

**Note**: API Key management supports editing by administrators and above.

<img src="../img/3_apikey_1.png" width="80%" >

After clicking **Confirm**, you can obtain the API Key ID and secret key for use.

![](../img/3_apikey_2.png)

Alternatively, you can obtain the API Key ID and secret key by clicking the view icon on the right side of the API Key management list. If it is no longer needed or there is a risk of leakage, you can delete it and recreate it.

![](../img/3.apikey_3.png)

Creating or deleting an API Key will generate an audit event, which can be viewed under **Management > Basic Settings** in <<< custom_key.brand_name >>> workspace's operation audit.

![](../img/3.apikey_4.png)