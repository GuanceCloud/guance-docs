# OIDC Single Sign-On Custom Domain Replacement Procedure (Deployment Plan URL Address Replacement Solution)
---

## Introduction

The <<< custom_key.brand_name >>> Deployment Plan supports replacing custom domain addresses based on the OIDC protocol to achieve single sign-on. This is used to solve the issue of accessing OIDC login via a workspace's custom domain. This document explains the specific configuration implementation method.

## Concepts

| Term        | Explanation                                                                 |
| ------------- | ----------------------------------------------------------------------------- |
| loginUrl    | <<< custom_key.brand_name >>> OIDC login entry address, typically formatted as `http://domain/oidc/login`, or with some query parameters in the URL. |
| authUrl     | Account authentication address.                                               |
| callbackURL | After successful account authentication, the callback address to <<< custom_key.brand_name >>>, typically formatted as `http://domain/oidc/callback`. |
| redirect_uri | The parameter name for the callback address carried in the authUrl.           |

## Steps {#steps}

### 1. Basic OIDC Configuration
1) In the <<< custom_key.brand_name >>> Launcher **namespace: forethought-core > core**, add a sub-configuration `requestSet` to the `OIDCClientSet` configuration item.

```yaml
# OIDC client configuration (when wellKnowURL is configured, the KeyCloakPassSet configuration item automatically becomes invalid)
OIDCClientSet:
  # OIDC Endpoints configuration address, i.e., the complete `https://xxx.xxx.com/xx/.well-known/openid-configuration` address.
  wellKnowURL: https://xxx.xxx.com/xx/.well-known/openid-configuration
  # Client ID provided by the authentication service
  clientId: xxx
  # Client Secret key
  clientSecret: xxxx

  # The following are custom configurations (used to customize various addresses in the OIDC process) which can be directly copied.
  requestSet:
    login:
      redirectUriFormatRequest:
        # Enable this switch
        isOpen: true
        url: "function request address in func (corresponding to the redirect_uri_format function external link below)"
        
      urlFormatRequest:
        # Switch, default off
        isOpen: true
        url: "function request address in func (corresponding to the login_auth_url_format function external link below)"

    callback:
      redirectUriFormatRequest:
        # Switch, default off
        isOpen: true
        description: "Same configuration description as redirectUriFormatRequest under login"
        url: "function request address in func (corresponding to the redirect_uri_format function external link below)"
      urlFormatRequest:
        # Switch, default off
        isOpen: true
        url: "function request address in func (corresponding to the callback_url_format function external link below)"
```

#### 1. Description of the `redirect_uri_format` Function

If there are non-standard changes to `redirect_uri` during the entire OIDC process, these should be formatted in an external function. Ensure that the `redirect_uri` in the OIDC client is consistent during login and callback requests; otherwise, verification of state and code on the client side will fail.

```python
# Request method: post
# Request body content:
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
# Response content:
{
    "redirect_uri": "modified redirect_uri",
}
```

#### 2. Description of the `login_auth_url_format` Function

Redirect the jump address of `oidc/login` to an external function for re-packaging before performing the address redirection.

```python
# Request method: post
# Request body content:
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
# Response content:
{
    "url": "formatted auth_url",
}
```

#### 3. Description of the `callback_url_format` Function

Redirect the jump address of `oidc/callback` to an external function for re-packaging before performing the address redirection.

```python
# Request method: post
# Request body content:
{
    "type": "callback", # This is the login type, indicating a request from the callback process
    "url": "original generated jump address",
    "args": {
        # Query parameters received by the oidc/login request
    },
    "headers": {
        # Header data received by the oidc/login request
    }
}
# Response content:
{
    "url": "formatted url",
}
```

### 2. Adding Scripts in Built-in Func

**Note:** You can directly copy this script.

```python
import json
import copy
import requests
from urllib.parse import urlparse, parse_qs, urlencode, urlunparse
from collections import OrderedDict

def parse_url(url):
    '''
    Parse the URL and return a unified URL parsing object and a dictionary of query parameters.

    '''
    # Parse URL information
    parsed_url = urlparse(url)
    # Place domain transmission in URL parameters
    query_params = parse_qs(parsed_url.query)
    # Use OrderedDict to maintain the original order of parameters
    ordered_params = OrderedDict(query_params)
    return parsed_url, ordered_params

def __make_redirect_uri(url, headers):
    '''
    Extract the source address from the request header, which is extracted from the X-Forwarded-Host header.

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


@DFF.API('Corresponds to redirectUriFormatRequest function - formats the redirect_uri information in the OIDC client')
def redirect_uri_format(**kwargs):
    '''
    When integrating with the <<< custom_key.brand_name >>> OIDC process, if there are non-standard processes causing changes in the `redirect_uri` parameter name or value, they need to be processed through this function.

    Parameters:
      type {str} Current operation type in the OIDC process, login indicates address changes from oidc/login requests; callback indicates requests from the oidc/callback process
      redirect_uri {str} Original redirect_uri address
      args {json} Query parameters from the corresponding request in the process
      headers {json} Information from the request headers in the process

    return {"redirect_uri": "modified redirect_uri address"}
    '''
    print("kwargs--->>>", json.dumps(kwargs))
    # Extract the original redirect_uri address and request header information
    redirect_uri = kwargs.get("redirect_uri", "")
    headers = kwargs.get("headers", {})
    # Generate new redirect_uri address
    new_url = __make_redirect_uri(redirect_uri, headers)

    result = {
        # This address provides the original login authentication code retrieval address
        "redirect_uri": new_url,
    }
    print("result-->>", result)
    return result


@DFF.API('Corresponds to urlFormatRequest function - formats the jump address information in login')
def login_auth_url_format(**kwargs):
    '''
    When integrating with the <<< custom_key.brand_name >>> OIDC process, if there are non-standard processes causing changes in parameters in the login address, they can be handled in this function.

    Parameters:
      type {str} Current operation type in the OIDC process, login indicates address changes from oidc/login requests; callback indicates requests from the oidc/callback process
      url {str} Original URL address
      args {json} Query parameters from the corresponding request in the process
      headers {json} Information from the request headers in the process

    return {"url": "modified URL address"}
    '''
    print("kwargs--->>>", json.dumps(kwargs))
    url = kwargs.get("url")
    new_url = None
    args = kwargs.get("args")
    headers = kwargs.get("headers")
    new_host = headers.get("X-From")
    if new_host:
        # Parse URL information
        parsed_url = urlparse(url)
        parsed_url = parsed_url._replace(netloc=new_host)
        new_url = urlunparse(parsed_url)

    result = {
        # This address provides the original login authentication code retrieval address
        "url": new_url or url
    }
    print("result-->>", result)
    return result


@DFF.API('Corresponds to urlFormatRequest function - formats the jump address information in callback')
def callback_url_format(**kwargs):
    '''
    When integrating with the <<< custom_key.brand_name >>> OIDC process, if there are non-standard processes causing changes in parameters in the callback URL after logging into the <<< custom_key.brand_name >>> space, they can be handled in this function.

    Parameters:
      type {str} Current operation type in the OIDC process, login indicates address changes from oidc/login requests; callback indicates requests from the oidc/callback process
      url {str} Original URL address
      args {json} Query parameters from the corresponding request in the process
      headers {json} Information from the request headers in the process

    return {"url": "modified URL address"}
    '''
    print("kwargs--->>>", json.dumps(kwargs))
    type = kwargs.get("type")
    url = kwargs.get("url")
    args = kwargs.get("args") or {}
    headers = kwargs.get("headers") or {}
    new_url = None
    from_v = args.get("from")
    if from_v:
        # Parse URL
        parsed_url, ordered_params = parse_url(url)
        ordered_params["from"] = from_v
        # Rebuild the query string, maintaining the original order
        new_query_string = urlencode(ordered_params, doseq=True)
        parsed_url = parsed_url._replace(query=new_query_string)
        new_url = urlunparse(parsed_url)

    result = {
        # This address provides the URL adjustment after successfully logging in to the frontend
        "url": new_url or url,
    }
    return result
```

Note that authorization links must be [enabled](https://<<< custom_key.func_domain >>>/doc/script-market-guance-issue-feishu-integration/#funcapi) for the `redirect_uri_format`, `login_auth_url_format`, and `callback_url_format` functions.