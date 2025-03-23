---
icon: zy/external-api
---
# Overview

---

<<< custom_key.brand_name >>> External API is a simplified HTTP REST API.

* Only GET / POST requests
* Use resource-oriented URLs to call APIs
* Use status codes to indicate request success or failure
* All requests return JSON structures
* External API programmatically maintains the <<< custom_key.brand_name >>> platform

## Supported Endpoints

| Deployment Type | Node Name | Endpoint                                                  |
|----------------|-----------|-----------------------------------------------------------|
| Private Deployment Plan | Private Deployment Plan | Refer to the actual deployed Endpoint, usually `https://external-api.dataflux.cn` |

## API Documentation Configuration

1. The API documentation address is fixed at: \<Endpoint>/v1/doc <br/>
For example: https://external-api.dataflux.cn/v1/doc

3. The API documentation switch configuration is located in the core (namespace: forethought-core) configuration within launcher. Specific configuration as follows:
```yaml
# API Doc
apiDocPageSwitch:
  # Switch for external api interface documentation page, true: indicates enabled; false: indicates disabled. Default `false`
  external: true

```

## Service Configuration Items

Optional configuration items are located in the core (namespace: forethought-core) configuration within launcher. Specific optional configurations are as follows:
```yaml
# Configuration items for the external-api service
external:
  # Validity period of each request signature, in seconds, default 60 seconds
  timeliness: 60
  # Visitor identifier, corresponds to the `X-Df-Access-Key` value in the interface request header; non-empty string
  accessKey: ""
  # Secret key used to calculate the signature
  secretKey: ""

```