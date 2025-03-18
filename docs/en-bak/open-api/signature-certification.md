# Interface Signature Authentication

---

## Authentication Method

The interface is authenticated by API KEY, and the value of *DF-API-KEY* in the Header of the request body is used as validity check for each request. And the workspace qualification basis of this request (take the workspace to which this DF-API-KEY belongs).

All interfaces currently displayed by the Open API need to provide only API KEY (Header: DF-API-KEY) as credentials.
If the credentials exist and are valid, the authentication is considered passed.

See [API Key management](../management/api-key/open-api.md).


