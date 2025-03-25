# Steps for Replacing Custom Domain Names with OIDC Single Sign-On (Replacement Scheme for Deployment Plan URL)
---

## Introduction

The <<< custom_key.brand_name >>> Deployment Plan supports replacing custom domain addresses based on the OIDC protocol to achieve single sign-on. This is used to solve the problem of accessing OIDC login via a workspace's custom domain name. This article explains the specific configuration implementation process.



## Concepts

| Term         | Explanation                          |
| -------------- | ------------------------------------ |
| loginUrl     | <<< custom_key.brand_name >>> OIDC login entry address, usually in the format `http://domain/oidc/login`, or with some query parameters in the address  |
| authUrl      | Account authentication address        |
| callbackURL  | After successful account authentication, the callback address to <<< custom_key.brand_name >>>, usually in the format `http://domain/oidc/callback` |
| redirect_uri | Parameter name for the callback address carried in authUrl                        |



## Procedures {#steps}

### 1. Basic OIDC Configuration
1) In the <<< custom_key.brand_name >>> Launcher **namespace: forethought-core > core**, add a sub-configuration item `requestSet` to the `OIDCClientSet` configuration.


```yaml
# OIDC client configuration (when this item is configured with wellKnowURL, the KeyCloakPassSet configuration item automatically becomes invalid)
OIDCClientSet:
  # OIDC Endpoints configuration address, i.e., the complete `https://xxx.xxx.com/xx/.well-known/openid-configuration` address.
  wellKnowURL: https://xxx.xxx.com/xx/.well-known/openid-configuration
  # Client ID provided by the authentication service
  clientId: xxx
  # Client's Secret key
  clientSecret: xxxx

  # The following is the custom configuration section (used for customizing various addresses in the oidc flow), which can be directly copied
  requestSet:
    login:
      redirectUriFormatRequest:
        # Enable this switch
        isOpen: true
        url: "function request address in func (corresponding to the external link of the redirect_uri_format function below)"
        
      urlFormatRequest:
        # Switch, default is off
        isOpen: true
        url: "function request address in func (corresponding to the external link of the login_auth_url_format function below)"

    callback:
      redirectUriFormatRequest:
        # Switch, default is off
        isOpen: true
        description: "Same as the configuration explanation of redirectUriFormatRequest under login"
        url: "function request address in func (corresponding to the external link of the redirect_uri_format function below)"
      urlFormatRequest:
        # Switch, default is off
        isOpen: true
        url: "function request address in func (corresponding to the external link of the callback_url_format function below)"

```


#### 1. Description of the `redirect_uri_format` Function

If there is a non-standard change in the `redirect_uri` during the entire OIDC process, it should be formatted in an external function. Ensure that the `redirect_uri` in the oidc client is consistent when making login and callback requests; otherwise, the verification of state and code on the client side will fail.

```python
# Request method: post
# Request body content as follows:
{
    "type": "login", # Indicates whether the change corresponds to the login or callback process
    "redirect_uri": "original redirect_uri address",
    "args": {
      # Query parameters received by the oidc/login request
    },
    "headers": {
      # Header data received by the oidc/login request
    }
}
# Response content as follows:
{
    "redirect_uri": "modified redirect_uri",
}
```

#### 2. Description of the `login_auth_url_format` Function

Redirect the jump address of oidc/login to an external function for re-packaging before performing the address redirection.

```python
# Request method: post
# Request body content as follows:
{
    "type": "login", # This is the login type, login indicates from login, callback indicates from callback request
    "url": "original OIDC login address",
    "args": {
      # Query parameters received by the oidc/login request
    },
    "headers": {
      # Header data received by the oidc/login request
    }
}
# Response content as follows:
{
    "url": "formatted auth_url",
}
```

#### 3. Description of the `callback_url_format` Function

Redirect the jump address of oidc/callback to an external function for re-packaging before performing the address redirection.

```python
# Request method: post
# Request body content as follows:
{
    "type": "callback", # This is the login type, indicating a request from the callback process
    "url": "originally generated jump address",
    "args": {
      # Query parameters received by the oidc/login request
    },
    "headers": {
      # Header data received by the oidc/login request
    }
}
# Response content as follows:
{
    "url": "formatted url",
}
```


### 2. Add Script in Built-in Func.

**Note:** You can directly copy this script.

```python
import json
import copy
import requests
from urllib.parse import urlparse, parse_qs, urlencode, urlunparse
from collections import OrderedDict

def parse_url(url):
    '''
    Parse the url and return a unified url parsing object and dictionary of query parameters.

    '''
    # Parse url information
    parsed_url = urlparse(url)
    # Hostname is placed in the url parameter
    query_params = parse_qs(parsed_url.query)
    # Use OrderedDict to maintain the original order of parameters
    ordered_params = OrderedDict(query_params)
    return parsed_url, ordered_params

def __make_redirect_uri(url, headers):
    '''
    Extract the request source address from the request header, this address is extracted from the X-Forwarded-Host header.

    '''
    # Parse redirect_uri
    parsed_url, ordered_params = parse_url(url)
    x_host = headers.get("X-Forwarded-Host")
    x_port = headers.get("X-Forwarded-Port")
    x_scheme = headers.get("X-Forwarded-Scheme", "").lower()
    if not x_scheme:
        x_scheme = copy.deepcopy(parsed_url.scheme)

    netloc = copy.deepcopy(parsed_url.netloc)
    if x_host:
        if (x_scheme == "http" and x_port == "80") or (x_scheme == "https" and x_port == "443"):
            netloc = x_host
        else:
            netloc = f"{x_host}:{x_port}" if x_port else x_host

    parsed_url = parsed_url._replace(scheme=x_scheme, netloc=netloc)
    new_url = urlunparse(parsed_url)
    return new_url


@DFF.API('Function corresponding to redirectUriFormatRequest - formatting the redirect_uri information in the oidc client')
def redirect_uri_format(**kwargs):
    '''
    When connecting to the <<< custom_key.brand_name >>> OIDC process, if there are non-standard processes causing changes in the name or value of the redirect_uri parameter, it needs to be handled through the current function.

    Parameters:
      type {str} Current operation type in the oidc process, login represents the address change caused by the oidc/login request; callback represents the request generated by the oidc/callback process
      redirect_uri {str} Original redirect_uri address
      args {json} Query parameters in the corresponding request of the process
      headers {json} Information in the request headers of the corresponding process

    return {"redirect_uri": "modified redirect_uri address"}
    '''
    print("kwargs--->>>", json.dumps(kwargs))
    # Extract the original redirect_uri address and request header information
    redirect_uri = kwargs.get("redirect_uri", "")
    headers = kwargs.get("headers", {})
    # Generate a new redirect_uri address
    new_url = __make_redirect_uri(redirect_uri, headers)

    result = {
        # This address provides the original login authentication code acquisition address
        "redirect_uri": new_url,
    }
    print("result-->>", result)
    return result


@DFF.API('Function corresponding to urlFormatRequest - formatting the jump address information in login')
def login_auth_url_format(**kwargs):
    '''
    When connecting to the <<< custom_key.brand_name >>> OIDC process, if there are non-standard processes causing changes in the parameters of the login address, they can be processed in the current function.

    Parameters:
      type {str} Current operation type in the oidc process, login represents the address change caused by the oidc/login request; callback represents the request generated by the oidc/callback process
      url {str} Original url address
      args {json} Query parameters in the corresponding request of the process
      headers {json} Information in the request headers of the corresponding process

    return {"url": "modified url address"}
    '''
    print("kwargs--->>>", json.dumps(kwargs))
    url = kwargs.get("url")
    new_url = None
    args = kwargs.get("args")
    headers = kwargs.get("headers")
    new_host = headers.get("X-From")
    if new_host:
        # Parse url information
        parsed_url = urlparse(url)
        parsed_url = parsed_url._replace(netloc=new_host)
        new_url = urlunparse(parsed_url)

    result = {
        # This address provides the original login authentication code acquisition address
        "url": new_url or url
    }
    print("result-->>", result)
    return result


@DFF.API('Function corresponding to urlFormatRequest - formatting the jump address information in callback')
def callback_url_format(**kwargs):
    '''
    When connecting to the <<< custom_key.brand_name >>> OIDC process, if there are non-standard processes causing changes in the parameters of the address after callback and logging into the <<< custom_key.brand_name >>> space, they can be processed in the current function.

    Parameters:
      type {str} Current operation type in the oidc process, login represents the address change caused by the oidc/login request; callback represents the request generated by the oidc/callback process
      url {str} Original url address
      args {json} Query parameters in the corresponding request of the process
      headers {json} Information in the request headers of the corresponding process

    return {"url": "modified url address"}
    '''
    print("kwargs--->>>", json.dumps(kwargs))
    type = kwargs.get("type")
    url = kwargs.get("url")
    args = kwargs.get("args") or {}
    headers = kwargs.get("headers") or {}
    new_url = None
    from_v = args.get("from")
    if from_v:
        # Parse url
        parsed_url, ordered_params = parse_url(url)
        ordered_params["from"] = from_v
        # Reconstruct the query string, maintaining the original order
        new_query_string = urlencode(ordered_params, doseq=True)
        parsed_url = parsed_url._replace(query=new_query_string)
        new_url = urlunparse(parsed_url)

    result = {
        # This address provides the adjustment after successfully logging into the front-end after callback
        "url": new_url or url,
    }
    return result


```

Note: Authorization links need to be enabled for the `redirect_uri_format`, `login_auth_url_format`, and `callback_url_format` functions [Enable Authorization Links](https://<<< custom_key.func_domain >>>/doc/script-market-guance-issue-feishu-integration/#funcapi).