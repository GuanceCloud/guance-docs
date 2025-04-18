# 接口签名认证

---


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
#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import time
import hmac
import traceback
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

    def get_auth_header(self, method, full_path, body, filepath):
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
        if filepath:
            # 注意，文件上传都是通过 form 表单上传，因此此处不指定 Content-Type, 而是由内部生成请求时产生
            auth_headers.pop("Content-Type", "")
            # = "multipart/form-data"
        return auth_headers

    def run(self, method, path, query=None, body=None, headers=None, filepath=None, **kwargs):
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
        new_headers = self.get_auth_header(method, path, body, filepath)
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
        files = None
        if filepath:
            files = {'file': open(filepath, 'rb')}
        try:
            resp = requests.__getattribute__(method.lower())(
                url,
                data=body.encode(encoding='utf-8'),
                headers=new_headers,
                files=files
            )
        except Exception as e:
            print(traceback.format_exc())
            raise e
        finally:
            if files:
                files["file"].close()

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

    def upload_logo_image(self, workspace_uuid, filename, filepath, **kwargs):
        path = f"/api/v1/workspace/{workspace_uuid}/upload_logo_image"
        query = {
            "filename": filename,
            "language": "zh",
        }

        return self.post(path, query=query, filepath=filepath)

    def get_logo_url(self, workspace_uuid, filename, **kwargs):
        path = f"/api/v1/workspace/{workspace_uuid}/get_logo_url"
        query = {
            "filename": filename,
            "language": "zh",
        }
        return self.post(path, query=query)

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

def test_upload_logo_image(server, access_key, secret_key):
    dfapi = DFExternalAPI(server, access_key, secret_key, True)
    workspace_uuid = "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    filename = "logo.png"
    filepath = "/Users/luwenchang/Downloads/logo/鹦鹉1.jpeg"
    filename = "favicon.ico"
    filepath = "/Users/luwenchang/Downloads/logo/兔子4.jpeg"
    status_code, resp = dfapi.upload_logo_image(workspace_uuid, filename, filepath)
    print(f"======={__name__}====")
    print(f"status_code: {status_code}")
    print(f"resp: {resp}")

def test_get_logo_url(server, access_key, secret_key):
    dfapi = DFExternalAPI(server, access_key, secret_key, True)
    workspace_uuid = "wksp_4b57c7bab38e4a2d9630f675dc20015d"
    filename = "logo.png"
    status_code, resp = dfapi.get_logo_url(workspace_uuid, filename)
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
    # test_get(server, access_key, secret_key)
    # test_post(server, access_key, secret_key)
    test_upload_logo_image(server, access_key, secret_key)
    # test_get_logo_url(server, access_key, secret_key)


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


