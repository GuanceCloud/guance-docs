# OIDC 单点登录自定义域名替换操作步骤（部署版 url 地址替换方案）
---

## 简介

{{{ custom_key.brand_name }}}部署版支持基于 OIDC 协议进行自定义域名地址替换实现单点登录。用以解决工作空间自定义域名方式接入OIDC登录。本文对具体配置实现方式进行讲解。



## 概念先解

| 名词      | 解释                          |
| ----------- | ------------------------------------ |
| loginUrl  | {{{ custom_key.brand_name }}} OIDC 登录入口地址，一般格式 `http://域名/oidc/login`，或者地址上带些查询参数  |
| authUrl       | 账号认证地址 |
| callbackURL    | 账号认证成功之后, 回调到{{{ custom_key.brand_name }}}的地址，一般格式 `http://域名/oidc/callback` |
| redirect_uri      | authUrl 中携带的参数回调地址参数名                          |



## 操作步骤 {#steps}

### 1、OIDC 基本配置
1）在{{{ custom_key.brand_name }}} Launcher **命名空间：forethought-core > core** 中为`OIDCClientSet`配置项添加子配置项`requestSet` 。


```yaml
# OIDC 客户端配置(当该项配置中配置了 wellKnowURL 时, KeyCloakPassSet 配置项自动失效)
OIDCClientSet:
  # OIDC Endpoints 配置地址,即完整的 `https://xxx.xxx.com/xx/.well-known/openid-configuration` 地址.
  wellKnowURL: https://xxx.xxx.com/xx/.well-known/openid-configuration
  # 由认证服务提供的 客户端ID
  clientId: xxx
  # 客户端的 Secret key
  clientSecret: xxxx

  # 以下为自定义配置部分(用于对 oidc 流程中的各种地址进行自定义配置) 可以直接复制
  requestSet:
    login:
      redirectUriFormatRequest:
        # 打开此处开关
        isOpen: true
        url: "func中的函数请求地址(对应下文中的 redirect_uri_format 函数外链)"
        
      urlFormatRequest:
        # 开关, 默认关闭
        isOpen: true
        url: "func中的函数请求地址（对应下文中的 login_auth_url_format 函数外链）"

    callback:
      redirectUriFormatRequest:
        # 开关, 默认关闭
        isOpen: true
        description: "与 login 下的 redirectUriFormatRequest 配置说明一致"
        url: "func中的函数请求地址(对应下文中的 redirect_uri_format 函数外链)"
      urlFormatRequest:
        # 开关, 默认关闭
        isOpen: true
        url: "func中的函数请求地址（对应下文中的 callback_url_format 函数外链）"

```


#### 1、redirect_uri_format 函数说明

  如果在整个 OIDC 流程中存在非标的 redirect_uri 变更，则应在外部函数中进行格式化。 确保 login 和 callback 请求时， oidc client 中的 redirect_uri 是一致的，否则在客户端验证 state 和 code 将失败。

  ```python
  # 请求方法: post
  # 请求体内容如下:
  {
    "type": "login", # 表示变更对应的时 login 还是 callback 流程
    "redirect_uri": "原始的 redirect_uri 地址",
    "args": {
      # oidc/login 请求接收到的 查询参数
    },
    "headers": {
      # oidc/login 请求接收到的 请求头数据
    }
  }
  # 响应内容如下:
  {
    "redirect_uri": "变更后的 redirect_uri",
  }
```

#### 2、 login_auth_url_format 函数说明

  将 oidc/login 的跳转地址转发给 外部函数重新包装后再进行 地址跳转

  ```python
  # 请求方法: post
  # 请求体内容如下:
  {
    "type": "login", # 这是登录类型, login 表示来自登录, callback 表示来自回调的请求
    "url": "原始的 OIDC 登录地址",
    "args": {
      # oidc/login 请求接收到的 查询参数
    },
    "headers": {
      # oidc/login 请求接收到的 请求头数据
    }
  }
  # 响应内容如下:
  {
    "url": "格式化之后的 auth_url",
  }
```

#### 3、 callback_url_format 函数说明

   将 oidc/callback 的跳转地址转发给 外部函数重新包装后再进行 地址跳转

  ```python
  # 请求方法: post
  # 请求体内容如下:
  {
    "type": "callback", # 这是登录类型，表示来自 callback 的流程请求
    "url": "原始生成的 跳转地址",
    "args": {
      # oidc/login 请求接收到的 查询参数
    },
    "headers": {
      # oidc/login 请求接收到的 请求头数据
    }
  }
  # 响应内容如下:
  {
    "url": "格式化之后的 url",
  }
```


### 2、在内置 Func 中添加脚本。

**注意：** 可以直接复制这个脚本

```python
import json
import copy
import requests
from urllib.parse import urlparse, parse_qs, urlencode, urlunparse
from collections import OrderedDict

def parse_url(url):
    '''
    解析 url 并返回统一的 url 解析对象和 查询参数字典数据

    '''
    # 解析 url 信息
    parsed_url = urlparse(url)
    # 域名传递放置于 url 参数中
    query_params = parse_qs(parsed_url.query)
    # 使用OrderedDict以保持参数的原始顺序
    ordered_params = OrderedDict(query_params)
    return parsed_url, ordered_params

def __make_redirect_uri(url, headers):
    '''
    从请求头中提取请求来源地址, 该地址从 X-Forwarded-Host 头中提取

    '''
    # 解析 redirect_uri
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


@DFF.API('对应 redirectUriFormatRequest 函数-格式化 oidc client 中的 redirect_uri 信息')
def redirect_uri_format(**kwargs):
    '''
    当对接{{{ custom_key.brand_name }}} OIDC 流程时，如果存在非标流程导致 redirect_uri 参数名或参数值发生改变时，需要通过当前函数进行处理。

    Parameters:
      type {str} 当前操作对应 oidc 流程中的类型， login 表示 oidc/login 请求产生的地址变更；callback 表示 oidc/callback 流程产生的请求
      redirect_uri {str} 原始的 redirect_uri 地址
      args {json} 流程对应的请求中的查询参数
      headers {json} 流程对应的请求头中的信息

    return {"redirect_uri": "变更后的 redirect_uri 地址"}
    '''
    print("kwargs--->>>", json.dumps(kwargs))
    # 提取原本的 redirect_uri 地址和请求头信息
    redirect_uri = kwargs.get("redirect_uri", "")
    headers = kwargs.get("headers", {})
    # 生成新的 redirect_uri 地址
    new_url = __make_redirect_uri(redirect_uri, headers)

    result = {
        # 这个地址提供原始的 获取登录认证 code 地址
        "redirect_uri": new_url,
    }
    print("result-->>", result)
    return result


@DFF.API('对应 urlFormatRequest 函数-格式化 login 中的 跳转地址信息')
def login_auth_url_format(**kwargs):
    '''
    当对接{{{ custom_key.brand_name }}} OIDC 流程时，如果存在非标流程导致 login 地址中的参数需要变更时，可以在当前函数中进行处理。

    Parameters:
      type {str} 当前操作对应 oidc 流程中的类型， login 表示 oidc/login 请求产生的地址变更；callback 表示 oidc/callback 流程产生的请求
      url {str} 原始的 url 地址
      args {json} 流程对应的请求中的查询参数
      headers {json} 流程对应的请求头中的信息

    return {"url": "变更后的 url 地址"}
    '''
    print("kwargs--->>>", json.dumps(kwargs))
    url = kwargs.get("url")
    new_url = None
    args = kwargs.get("args")
    headers = kwargs.get("headers")
    new_host = headers.get("X-From")
    if new_host:
        # 解析 url 信息
        parsed_url = urlparse(url)
        parsed_url = parsed_url._replace(netloc=new_host)
        new_url = urlunparse(parsed_url)

    result = {
        # 这个地址提供原始的 获取登录认证 code 地址
        "url": new_url or url
    }
    print("result-->>", result)
    return result


@DFF.API('对应 urlFormatRequest 函数-格式化 callback 中的 跳转地址信息')
def callback_url_format(**kwargs):
    '''
    当对接{{{ custom_key.brand_name }}} OIDC 流程时，如果存在非标流程导致 callback 后登录{{{ custom_key.brand_name }}}空间的地址中的参数需要变更时，可以在当前函数中进行处理。

    Parameters:
      type {str} 当前操作对应 oidc 流程中的类型， login 表示 oidc/login 请求产生的地址变更；callback 表示 oidc/callback 流程产生的请求
      url {str} 原始的 url 地址
      args {json} 流程对应的请求中的查询参数
      headers {json} 流程对应的请求头中的信息

    return {"url": "变更后的 url 地址"}
    '''
    print("kwargs--->>>", json.dumps(kwargs))
    type = kwargs.get("type")
    url = kwargs.get("url")
    args = kwargs.get("args") or {}
    headers = kwargs.get("headers") or {}
    new_url = None
    from_v = args.get("from")
    if from_v:
        # 解析 url
        parsed_url, ordered_params = parse_url(url)
        ordered_params["from"] = from_v
        # 重新构建查询字符串，保持原始顺序
        new_query_string = urlencode(ordered_params, doseq=True)
        parsed_url = parsed_url._replace(query=new_query_string)
        new_url = urlunparse(parsed_url)

    result = {
        # 这个地址提供 callback 成功之后，登录到前端的地址调整
        "url": new_url or url,
    }
    return result


```

注意，需要为 `redirect_uri_format`、`login_auth_url_format`、`callback_url_format` 三个函数[开启授权链接](https://func.guance.com/doc/script-market-guance-issue-feishu-integration/#funcapi)



