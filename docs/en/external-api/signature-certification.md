# Interface Signature Authentication

---

## Interface Signature Algorithm

### Elements Involved in Signature Calculation

| Parameter Name | Description                                                                                                                   |
|:---------------|:---------------------------------------------------------------------------------------------------------------------|
| method         | Interface request method, currently supported request methods are `GET`, `POST`                                                                                       |
| nonce          | Random number, corresponding to the request header `X-Df-Nonce`                                                                                              |
| timestamp      | Timestamp corresponding to the time point when the request is initiated, in seconds, corresponding to the request header `X-Df-Timestamp`                                                                          |
| path           | Original request path (including query string), for example: <br/> `GET request: /api/v1/account/list?pageIndex=1&pageSize=20` <br/> `POST request: /api/v1/account/add`|
| body           | Original body information in the request, if there is no body, the body defaults to an empty string and participates in the signature calculation |

### Signature Calculation Logic

Concatenate `method` (uppercase), `nonce` (random temporary code generated during the request), `path` (original request path and query string), `timestamp`, and `body` with a single space to form the signature raw string (`string_to_sign`). When there is no body, the body defaults to an empty string.
That is, the signature raw string `string_to_sign = '{method} {nonce} {path} {timestamp} {body}'`.
Use the `secretKey` described in the "service configuration item" as the key to encrypt `string_to_sign` using HMAC SHA256 to get the authentication signature for each request, which is the value of the request header `X-Signature`.

### Python Version of Signature and Interface Request Example
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
        """ Generate signature """
        if body is None:
            # If no body, set body to an empty string by default
            body = ""
        # Original signature string
        string_to_sign = " ".join([method, nonce, full_path, timestamp, body])
        # Encode the signature string
        string_to_sign = string_to_sign.encode(encoding="utf-8")
        secret_key = self.secret_key.encode(encoding="utf-8")
        # Perform HMAC encryption
        h = hmac.new(secret_key, string_to_sign, hashlib.sha256)
        sign = h.hexdigest()
        return sign

    def get_auth_header(self, method, full_path, body, filepath):
        """ Generate request header information """
        # Current timestamp
        timestamp = str(int(time.time()))
        # Random number
        nonce = uuid.uuid4().hex
        # Generate signature
        sign = self.get_sign(method, full_path, timestamp, nonce, body) if self.access_key else None
        # Generate complete request header information
        auth_headers = {
            'Content-Type': 'application/json',
            'X-Df-Access-Key': self.access_key,
            'X-Df-Timestamp': timestamp,
            'X-Df-Nonce': nonce,
            'X-Df-SVersion': "v20240417",
            'X-Df-Signature': sign,
        }
        if filepath:
            # Note that file uploads are done via form data, so do not specify Content-Type here; it will be generated internally when creating the request
            auth_headers.pop("Content-Type", "")
        return auth_headers

    def run(self, method, path, query=None, body=None, headers=None, filepath=None, **kwargs):
        """ Execute request and extract response information """
        # Format request method
        method = method.upper()
        # Generate complete request path information
        if query:
            path = path + '?' + urlencode(query, encoding='utf-8')
        # Ensure body is unicode encoded (key sorting is not necessary, just ensure the final body is unicode encoded)
        if body:
            if isinstance(body, (tuple, list, dict)):
                body = json.dumps(body, sort_keys=True, separators=(',', ':'), ensure_ascii=False)
        else:
            body = ""
        # Merge request header information
        headers = headers or {}
        new_headers = self.get_auth_header(method, path, body, filepath)
        new_headers.update(headers)
        # Complete request URL
        url = self.server + path
        if self.debug:
            print("============Request Details==================")
            print("url: ", url)
            print("---- headers ----")
            print(json.dumps(headers, indent=4, ensure_ascii=False))
            print("---- body ----")
            print(json.dumps(body, indent=4, ensure_ascii=False))
            print("==============================")
        # Execute request
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

        # Get response status
        resp_status_code = resp.status_code
        # Response content
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
                raise Exception('Cannot parse response body as JSON', resp_data)

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
            "language": "en",
        }

        return self.post(path, query=query, filepath=filepath)

    def get_logo_url(self, workspace_uuid, filename, **kwargs):
        path = f"/api/v1/workspace/{workspace_uuid}/get_logo_url"
        query = {
            "filename": filename,
            "language": "en",
        }
        return self.post(path, query=query)

def test_get(server, access_key, secret_key):

    dfapi = DFExternalAPI(server, access_key, secret_key)
    status_code, resp = dfapi.account_list("test")
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
                    "q": "L::re(`.*`):(fill(count(__docid), 0) as `count`){ (`index` IN ['default']) AND (`message` = queryString(\"Guance\")) } BY `status`",
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
    filepath = "/Users/luwenchang/Downloads/logo/parrot.jpeg"
    filename = "favicon.ico"
    filepath = "/Users/luwenchang/Downloads/logo/rabbit.jpeg"
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
    # External API service domain name
    server = "http://127.0.0.1:5000"
    # Configured visitor access key
    access_key = "abcd"
    # Configured secret key
    secret_key = "Admin123"
    # test_get(server, access_key, secret_key)
    # test_post(server, access_key, secret_key)
    test_upload_logo_image(server, access_key, secret_key)
    # test_get_logo_url(server, access_key, secret_key)


```

### Go Version of Signature and Interface Request Example

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
        fmt.Println("JsonMarshal error:", err)
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
    // Set request headers
    req.Header.Set("Content-Type", "application/json")
    req.Header.Set("X-Df-Access-Key", api.accessKey)
    req.Header.Set("X-Df-Timestamp", timestamp)
    req.Header.Set("X-Df-Nonce", nonce)
    req.Header.Set("X-Df-SVersion", "v20240417")
    req.Header.Set("X-Df-Signature", sign)
    return
}
 
func eTestGet(server, accessKey, secretKey string) {
    // Generate a random UUID and format it as a string
    nonce := uuid.New().String()
    timestamp := strconv.FormatInt(time.Now().Unix(), 10)
    //fullPath := "/api/v1/account/list?search=China&pageIndex=1&pageSize=10"
    v := url.Values{}
    v.Set("search", "China")
    v.Set("pageIndex", "1")
    v.Set("pageSize", "10")
 
    fullPath := fmt.Sprintf("/api/v1/account/list?%s", v.Encode())
 
    api := NewDFExternalAPI(server, accessKey, secretKey, false)
    sign := api.GetSign("GET", fullPath, timestamp, nonce, "")
 
    url := api.server + fullPath
    // Create a GET request
    req, err := http.NewRequest("GET", url, nil)
    if err != nil {
        fmt.Println("Failed to create request:", err)
        return
    }
    api.SetDFHeaders(req, timestamp, nonce, sign)
    // Send the request
    client := &http.Client{}
    resp, err := client.Do(req)
    if err != nil {
        fmt.Println("Request failed:", err)
        return
    }
    defer resp.Body.Close()
 
    // Read the response body
    body, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        fmt.Println("Failed to read response body:", err)
        return
    }
 
    // Print the response body
    fmt.Println(string(body))
}
 
func eTestPost(server, accessKey, secretKey string) {
    method := "POST"
    // Generate a random UUID and format it as a string
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
                    "q":             "L::re(`.*`):(fill(count(__docid), 0) as `count`){ (`index` IN ['default']) AND (`message` = queryString(\"Guance\")) } BY `status`",
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
    // Create a POST request
    req, err := http.NewRequest("POST", url, bytes.NewBuffer(bodyStr))
    if err != nil {
        fmt.Println("Failed to create request:", err)
        return
    }
    //// Set request headers
    api.SetDFHeaders(req, timestamp, nonce, sign)
    // Send the request
    client := &http.Client{}
    resp, err := client.Do(req)
    if err != nil {
        fmt.Println("Request failed:", err)
        return
    }
    defer resp.Body.Close()
    // Read the response body
    content, err := ioutil.ReadAll(resp.Body)
    if err != nil {
        fmt.Println("Failed to read response body:", err)
        return
    }
    // Print the response body
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