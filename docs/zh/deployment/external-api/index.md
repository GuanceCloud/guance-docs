---
icon: zy/open-api
---

# 概述

---

观测云 External API 是一个简化的 HTTP REST API。

* 只有 GET / POST 请求
* 使用面向资源的 URL 调用 API
* 使用状态码指示请求成功或失败
* 所有请求返回 JSON 结构
* External API 以编程方式维护观测云平台

## 支持Endpoint

| 部署类型  | 节点名       | Endpoint                |
|-------|-----------|-------------------------|
| 私有部署版 | 私有部署版     | 以实际部署的 Endpoint 为准, 一般为`http://external-api.dataflux.cn` |

## API 文档配置

1. 接口文档地址固定为: \<Endpoint\>/v1/doc <br/>
例如: http://external-api.dataflux.cn/v1/doc

3. API 文档开关配置位于 launcher 中的 core (命名空间：forethought-core) 配置中。具体配置如下
```yaml
# API Doc
apiDocPageSwitch:
  # external api 接口文档页面开关, true: 表示开启; false: 表示关闭。默认`false`
  external: true

```

## 服务配置项

可选配置项位于 launcher 中的 core (命名空间：forethought-core) 配置中。具体可选配置如下
```yaml
# external-api 服务的配置项
external:
  # 每次请求签名的有效期, 单位秒, 默认 60秒
  timeliness: 60
  # 访问者标识, 对应接口请求头中的`X-Df-Access-Key`值; 非空字符串
  accessKey: ""
  # 用于计算签名的密钥
  secretKey: ""

```


## 公共请求头(Header)

| 参数名             | 必选     | 示例                 | 描述                                                                                          |
|:----------------|:-------|:-------------------|:--------------------------------------------------------------------------------------------|
| Content-Type    | 是      | application/json   | 请求内容类型, API 接口必须强制添加该请求头，且默认值为 application/json                                             |
| X-Df-Access-Key | 是      | e243xxxxxxxx       | 访问者标识。该值即为 「服务配置项」中描述的 `accessKey`  |
| X-Df-Timestamp | 是      | 1711701527         | 请求发起的时间点，秒级时间戳。允许的误差绝对值为「服务配置项」中描述的`timeliness`的值，超过这个时间范围将引发 `ft.MissingAuthHeaderInfo` 异常 |
| X-Df-SVersion | 是      | v20240417          | 签名算法版本, 固定为: `v20240417` |
| X-Df-Nonce | 是      | 5931f3059ba244dxxx | 每次请求生成的随机临值 |
| X-Df-Signature | 是      | 4SW5WlUkeNoFsh+KPdJob2SAdZ2hrp7l2txXjCAub2g= | 签名结果值 |


## 接口签名算法

### 参与签名计算的元素

| 参数名             | 描述                                                                                                                   |
|:----------------|:---------------------------------------------------------------------------------------------------------------------|
| method          | 接口请求方法, 目前支持的请求方法有`GET`、`POST`                                                                                       |
| nonce           | 随机数，对应请求头中的`X-Df-Nonce`                                                                                              |
| timestamp       | 请求发起的时间点对应的时间戳，秒级单位，对应请求头中的`X-Df-Timestamp`                                                                          |
| path            | 原始的请求路径（包含查询字符串）, 例如: <br/> `GET请求: /api/v1/account/list?pageIndex=1&pageSize=20` <br/> `POST请求: /api/v1/account/add`|
| body            | 请求中原始的 body 信息，无 body 时，body 默认为空字符串，并参与签名计算 |


### 签名计算逻辑

将 method(大写)、nonce(请求时生成的随机临时码) 、 path(原始请求路径和查询字符串)、 timestamp、body 使用 一个空格 拼接为签名原文字符串(`string_to_sign`). 当无 body 时， body 默认用空字符串代替。
即签名原文字符串 `string_to_sign = '{method} {nonce} {path} {timestamp} {body}'`.
用「服务配置项」描述中的 `secretKey` 作为密钥, 对`string_to_sign`进行加密(hmac sha256) 得到每次请求的认证签名，即请求头 X-Signature 的值.


### python 版签名和接口请求示例
```python
import json
import time
import hmac
import uuid
import hashlib
from urllib.parse import urlencode
import requests

class DFExternalAPI(object):

    def __init__(self, server, access_key, secret_key, debug=False):
        self.server = server
        self.access_key = access_key
        self.secret_key = secret_key
        self.debug = debug

    def get_sign(self, method, full_path, timestamp, nonce, body=None):
        """ 生成签名 """
        if body is None:
            # 无body时, 默认设置 body为空字符串
            body = ""
        # 原始签名字符串
        string_to_sign = " ".join([method, nonce, full_path, timestamp, body])
        # 对签名字符串进行 编码
        string_to_sign = string_to_sign.encode(encoding="utf-8")
        secret_key = self.secret_key.encode(encoding="utf-8")
        # 进行 hmac 加密
        h = hmac.new(secret_key, string_to_sign, hashlib.sha256)
        sign = h.hexdigest()
        return sign

    def get_auth_header(self, method, full_path, body):
        """ 生成请求头相关信息 """
        # 当前时间点的时间戳
        timestamp = str(int(time.time()))
        # 随机数
        nonce = uuid.uuid4().hex
        # 生成签名
        sign = self.get_sign(method, full_path, timestamp, nonce, body) if self.access_key else None
        # 生成完整请求头相关信息
        auth_headers = {
            'Content-Type': 'application/json',
            'X-Df-Access-Key': self.access_key,
            'X-Df-Timestamp': timestamp,
            'X-Df-Nonce': nonce,
            'X-Df-SVersion': "v20240417",
            'X-Df-Signature': sign,
        }
        return auth_headers

    def run(self, method, path, query=None, body=None, headers=None, **kwargs):
        """ 执行请求并提取响应信息 """
        # 格式化请求方法
        method = method.upper()
        # 生成完整的请求路径信息
        if query:
            path = path + '?' + urlencode(query, encoding='utf-8')
        # 对 body 主体需要进行 unicode 编码（key排序不是必须的, 只要确保最终 body 为 unicode 编码即可）
        if body:
            if isinstance(body, (tuple, list, dict)):
                body = json.dumps(body, sort_keys=True, separators=(',', ':'), ensure_ascii=False)
        else:
            body = ""
        # 合并 请求头信息
        headers = headers or {}
        new_headers = self.get_auth_header(method, path, body)
        new_headers.update(headers)
        # 完整的请求url
        url = self.server + path
        if self.debug:
            print("============请求详情==================")
            print("url: ", url)
            print("---- headers ----")
            print(json.dumps(headers, indent=4, ensure_ascii=False))
            print("---- body ----")
            print(json.dumps(body, indent=4, ensure_ascii=False))
            print("==============================")
        # 执行请求
        resp = requests.__getattribute__(method.lower())(
            url,
            data=body.encode(encoding='utf-8'),
            headers=new_headers
        )
        # 获取响应状态
        resp_status_code = resp.status_code
        # 响应内容
        resp_data = resp.text
        if resp_status_code != 200:
            raise Exception(resp_data)

        resp_content_type = resp.headers.get('Content-Type')
        if isinstance(resp_content_type, str):
            resp_content_type = resp_content_type.split(';')[0].strip()

        if resp_content_type == 'application/json':
            try:
                resp_data = json.loads(resp_data)
            except Exception as e:
                raise Exception('Cannot parse response body as json', resp_data)

        return resp_status_code, resp_data

    def get(self, path, query=None, headers=None):
        return self.run('GET', path, query, None, headers)

    def post(self, path, query=None, body=None, headers=None, **kwargs):
        return self.run('POST', path, query, body, headers, **kwargs)

    def account_list(self, search="", page_index=1, page_size=10, **kwargs):
        path = "/api/v1/account/list"
        query = {
            "search": search,
            "pageIndex": page_index,
            "pageSize": page_size
        }
        return self.get(path, query)

    def query_data(self, workspace_uuid, body, **kwargs):
        path = f"/api/v1/df/{workspace_uuid}/query_data"
        return self.post(path, body=body)

def test_get(server, access_key, secret_key):

    dfapi = DFExternalAPI(server, access_key, secret_key)
    status_code, resp = dfapi.account_list("测试")
    print(f"======={__name__}====")
    print(f"status_code: {status_code}")
    print(f"resp: {resp}")

def test_post(server, access_key, secret_key):
    dfapi = DFExternalAPI(server, access_key, secret_key, True)
    workspace_uuid = "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    body = {
        "queries": [
            {
                "qtype": "dql",
                "query": {
                    "q": "L::re(`.*`):(fill(count(__docid), 0) as `count`){ (`index` IN ['default']) AND (`message` = queryString(\"观测\")) } BY `status`",
                    "funcList": [],
                    "maxPointCount": 60,
                    "interval": 20,
                    "align_time": True,
                    "sorder_by": [{"column": "`#1`", "order": "DESC"}],
                    "slimit": 20,
                    "disable_sampling": False,
                    "timeRange": [1713440394537, 1713441294537],
                    "tz": "Asia/Shanghai"
                }
            }
        ]
    }
    status_code, resp = dfapi.query_data(workspace_uuid, body)
    print(f"======={__name__}====")
    print(f"status_code: {status_code}")
    print(f"resp: {resp}")


if __name__ == '__main__':
    # external api 服务域名地址
    server = "http://127.0.0.1:5000"
    # 配置的访问者 ak
    access_key = "abcd"
    # 配置的密钥 sk
    secret_key = "Admin123"
    test_get(server, access_key, secret_key)
    test_post(server, access_key, secret_key)
```

### go 版签名和接口请求示例

```golang
package main
 
import (
    "bytes"
    "crypto/hmac"
    "crypto/sha256"
    "encoding/json"
    "net/url"
 
    //"encoding/base64"
    "encoding/hex"
    "fmt"
    "github.com/google/uuid"
    "io/ioutil"
    "net/http"
    "strconv"
    "time"
)

type DFExternalAPI struct {
    server     string
    accessKey  string
    secretKey  string
    debug      bool
}

func Marshal(data interface{}) []byte {
    byteStr, err := json.Marshal(data)
    if err != nil {
        fmt.Println("JsonMarshal 错误:", err)
    }
 
    return byteStr
}
 
func NewDFExternalAPI(server, accessKey, secretKey string, debug bool) *DFExternalAPI {
    return &DFExternalAPI{
        server:    server,
        accessKey: accessKey,
        secretKey: secretKey,
        debug:     debug,
    }
}
 
func (api *DFExternalAPI) GetSign(method, fullPath string, timestamp, nonce string, body string) string {
    if body == "" {
        body = ""
    }
 
    stringToSign := fmt.Sprintf("%s %s %s %s %s", method, nonce, fullPath, timestamp, body)
    stringToSignBytes := []byte(stringToSign)
    //
    secretKeyBytes := []byte(api.secretKey)
 
    h := hmac.New(sha256.New, secretKeyBytes)
    h.Write(stringToSignBytes)
    sign := hex.EncodeToString(h.Sum(nil))
 
    //hmacGen := hmac.New(sha256.New, []byte(api.secretKey))
    //hmacGen.Write([]byte(stringToSign))
    //sign := base64.StdEncoding.EncodeToString(hmacGen.Sum(nil))
 
    return sign
}
 
func (api *DFExternalAPI) SetDFHeaders(req *http.Request, timestamp, nonce, sign string)  {
    // 设置请求头
    req.Header.Set("Content-Type", "application/json")
    req.Header.Set("X-Df-Access-Key", api.accessKey)
    req.Header.Set("X-Df-Timestamp", timestamp)
    req.Header.Set("X-Df-Nonce", nonce)
    req.Header.Set("X-Df-SVersion", "v20240417")
    req.Header.Set("X-Df-Signature", sign)
    return
}
 
func eTestGet(server, accessKey, secretKey string) {
    // 生成一个随机的 UUID,并将 UUID 格式化为字符串
    nonce := uuid.New().String()
    timestamp := strconv.FormatInt(time.Now().Unix(), 10)
    //fullPath := "/api/v1/account/list?search=中国&pageIndex=1&pageSize=10"
    v := url.Values{}
    v.Set("search", "中国")
    v.Set("pageIndex", "1")
    v.Set("pageSize", "10")
 
    fullPath := fmt.Sprintf("/api/v1/account/list?%s", v.Encode())
 
    api := NewDFExternalAPI(server, accessKey, secretKey, false)
    sign := api.GetSign("GET", fullPath, timestamp, nonce, "")
 
    url := api.server + fullPath
    // 创建一个 GET 请求
    req, err := http.NewRequest("GET", url, nil)
    if err != nil {
        fmt.Println("创建请求失败:", err)
        return
    }
    api.SetDFHeaders(req, timestamp, nonce, sign)
    // 发起请求
    client := &http.Client{}
    resp, err := client.Do(req)
    if err != nil {
        fmt.Println("请求失败:", err)
        return
    }
    defer resp.Body.Close()
 
    // 读取响应体
    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        fmt.Println("读取响应体失败:", err)
        return
    }
 
    // 打印响应体
    fmt.Println(string(body))
}
 
func eTestPost(server, accessKey, secretKey string) {
    method := "POST"
    // 生成一个随机的 UUID,并将 UUID 格式化为字符串
    nonce := uuid.New().String()
    timestamp := strconv.FormatInt(time.Now().Unix(), 10)
    workspaceUUID := "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    fullPath := fmt.Sprintf("/api/v1/df/%s/query_data", workspaceUUID)
 
    api := NewDFExternalAPI(server, accessKey, secretKey, false)
 
    body := map[string]interface{}{
        "queries": []map[string]interface{}{
            {
                "uuid": "15d0fb90-fd81-11ee-b9b6-d19f81405637",
                "qtype": "dql",
                "query": map[string]interface{}{
                    "q":             "L::re(`.*`):(fill(count(__docid), 0) as `count`){ (`index` IN ['default']) AND (`message` = queryString(\"观测\")) } BY `status`",
                    "_funcList":     []interface{}{},
                    "funcList":      []interface{}{},
                    "maxPointCount": 60,
                    "interval":      20,
                    "align_time":    true,
                    "sorder_by": []map[string]interface{}{
                        {
                            "column": "`#1`",
                            "order":  "DESC",
                        },
                    },
                    "slimit":            20,
                    "disable_sampling":  false,
                    "timeRange":         []int64{1713440394537, 1713441294537},
                    "tz":                "Asia/Shanghai",
                },
            },
        },
    }
    bodyStr := Marshal(body)
    sign := api.GetSign(method, fullPath, timestamp, nonce, string(bodyStr))
 
    url := api.server + fullPath
    // 创建一个 GET 请求
    req, err := http.NewRequest("POST", url, bytes.NewBuffer(bodyStr))
    if err != nil {
        fmt.Println("创建请求失败:", err)
        return
    }
    //// 设置请求头
    api.SetDFHeaders(req, timestamp, nonce, sign)
    // 发起请求
    client := &http.Client{}
    resp, err := client.Do(req)
    if err != nil {
        fmt.Println("请求失败:", err)
        return
    }
    defer resp.Body.Close()
    // 读取响应体
    content, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        fmt.Println("读取响应体失败:", err)
        return
    }
    // 打印响应体
    fmt.Println(string(content))
}
 
func main() {
    accessKey := "abcd"
    secretKey := "Admin123"
    server := "http://127.0.0.1:5000"
    eTestGet(server, accessKey, secretKey)
    eTestPost(server, accessKey, secretKey)
}
```

## 接口公共响应结构

### 公共响应结构字段说明
| 字段        | 类型      | 说明                          |
|-----------|-----------|-----------------------------|
| code      | Number    | 返回的状态码，与 HTTP 状态码保持相同，无错误时固定为 200 |
| content   | String、Number、Array、Boolean、JSON | 返回的数据，具体返回什么类型的数据与实际接口的业务有关 |
| pageInfo  | JSON | 所有列表接口响应的列表分页信息             |
| pageInfo.count | Number | 当前页数据量                      |
| pageInfo.pageIndex | Number | 分页页码                        |
| pageInfo.pageSize | Number | 每页大小                        |
| pageInfo.totalCount | Number | 符合条件的总数据量                   |
| errorCode | String | 返回的错误状态码，空表示无错误             |
| message   | String | 返回的错误码对应的具体说明信息             |
| success   | Boolean | 固定为 true，表示接口调用成功           |
| traceId   | Boolean | traceId，用于跟踪每一次的请求情况        |

### 响应结果示例

```bash
# 列表查询类接口响应结构
{
    "code":200,
    "content":[
        {Object}
    ],
    "errorCode":"",
    "message":"",
    "pageInfo":{
        "count":10,
        "pageIndex":1,
        "pageSize":10,
        "totalCount":836
    },
    "success":true,
    "traceId":"1749091119335873001"
}

# 修改类接口响应结构
{
    "code":200,
    "content":true,
    "errorCode":"",
    "message":"",
    "success":true,
    "traceId":"4250149955169518608"
}
```



