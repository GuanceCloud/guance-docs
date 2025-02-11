---
icon: zy/external-api
---
# Overview

---

The Guance External API is a simplified HTTP REST API.

* Only GET / POST requests
* Use resource-oriented URLs to call the API
* Use status codes to indicate request success or failure
* All requests return JSON structures
* The External API programmatically maintains the Guance platform

## Supported Endpoints

| Deployment Type | Node Name | Endpoint                |
|-----------------|-----------|-------------------------|
| Private Deployment Plan | Private Deployment Plan | Follow the actual deployed Endpoint, usually `http://external-api.dataflux.cn` |

## API Documentation Configuration

1. The API documentation address is fixed at: \<Endpoint>/v1/doc <br/>
For example: http://external-api.dataflux.cn/v1/doc

3. The API documentation switch configuration is located in the core configuration of launcher (namespace: forethought-core). The specific configuration is as follows:
```yaml
# API Doc
apiDocPageSwitch:
  # Switch for external API documentation page, true: indicates enabled; false: indicates disabled. Default is `false`
  external: true

```

## Service Configuration Items

Optional configuration items are located in the core configuration of launcher (namespace: forethought-core). The specific optional configurations are as follows:
```yaml
# Configuration items for the external-api service
external:
  # Valid period for each request signature, in seconds, default is 60 seconds
  timeliness: 60
  # Visitor identifier, corresponding to the `X-Df-Access-Key` value in the request header; non-empty string
  accessKey: ""
  # Secret key used to calculate the signature
  secretKey: ""

```