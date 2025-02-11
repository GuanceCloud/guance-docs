# API Signature Authentication

---

## Authentication Method

The API uses an API KEY for authentication. For each request, the value of *DF-API-KEY* in the request Header is used to validate its legitimacy. Additionally, the workspace scope for this request is determined by the workspace associated with this DF-API-KEY.

All interfaces currently displayed by the Open API only require providing the API KEY (Header: DF-API-KEY) as credentials. If the credential exists and is valid, it is considered authenticated.

For details on obtaining the API KEY, see [API Key Management](../management/api-key/index.md)