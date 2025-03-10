# API Signature Authentication

---

## Authentication Method

The API uses API KEY for authentication. For each request, the value of *DF-API-KEY* in the request header is used to validate the request. Additionally, the workspace limitation for this request is determined by the workspace associated with this DF-API-KEY.

All interfaces currently displayed in the Open API only require providing the API KEY (Header: DF-API-KEY) as credentials. If the credentials exist and are valid, the authentication is considered successful.

For details on obtaining the API KEY, see [API Key Management](../management/api-key/index.md)