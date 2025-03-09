# Create HTTP Test Task
---

HTTP Test performs periodic availability monitoring of websites, domains, and backend APIs based on the `HTTP` protocol. By continuously monitoring the site in real time, it statistically tracks its availability, provides test logs and real-time alerts, helping you quickly identify network issues and improve network access quality.

HTTP Test allows you to send HTTP requests to your application's API interfaces to validate defined requests and judgment conditions, such as request headers, status codes, response times, etc.

## Getting Started

Click **Create > Synthetic Tests**, and select **HTTP Protocol**.

![API Test HTTP](../../img/api_test_http.png)

### :material-numeric-1-circle: Define Request Format

1. URL: Supports entering HTTP or HTTPS URLs, including four request methods: `GET`, `POST`, `PUT`, and `HEAD`;
2. Advanced Settings: Adjust advanced settings according to actual needs, including request settings, request body content, certificates, proxies, and privacy;
3. Name: Customize the name of the HTTP Test task; duplicate names are not supported within the current workspace.

#### Advanced Settings {#advanced}

<div class="grid" markdown>

=== "Request Settings"

    1. Choose whether to follow redirects during the execution of the current HTTP request;
    2. Define the request header information to be added to the current HTTP request;
    3. Define the cookies to be added to the HTTP request;
    4. Add HTTP authentication, including username/password.

=== "Request Body Content"

    1. Select the request body type: `text/plain`, `application/json`, `text/xml`, `None`;
    2. Enter the request body content.

=== "Certificate"

    1. Ignore server certificate errors: If selected, even if SSL certificate verification fails, the HTTP test will continue to execute the connection;
    2. Upload client certificate, including private key and certificate.

=== "Proxy"

    1. Specify the proxy server address that the HTTP request needs to go through;
    2. Add HTTP request header information to be included when sending requests to the proxy server.

=== "Privacy"

    Do not save response content: If selected, the response body content will not be saved during runtime, thus avoiding sensitive data appearing in the test results. However, please note that this may increase the difficulty of troubleshooting issues.

</div>

### :material-numeric-2-circle: Availability Judgment {#test}

#### Default Mode

This involves adding judgment conditions to match data. Multiple conditions can be combined using "All" or "Any" to achieve AND or OR logical relationships.

After defining the request format and adding judgment conditions, click the "Test" button next to the URL to verify if the test configuration is successful.

**Note**: The test result is independent of the selected node.

#### Script Mode {#script}

Script mode uses Pipeline scripts to achieve the following functions:

- Set judgment conditions: Customize complex judgment logic based on business needs, supporting single or multiple condition combinations;
- Process result data: Customize processing of test results, including data cleaning, format conversion, etc.

Script mode can flexibly meet the needs of extracting specific fields from responses or performing complex condition judgments.

Example:

```python
body = load_json(response["body"])

if body["code"] == "200":
  result["is_failed"] = False
else:
  result["is_failed"] = True
  result["error_message"] = body["message"]
```

In the script, `load_json` is first used to parse the response content into a JSON object, then check if the response status code is 200. If `code` is 200, mark the result as successful; otherwise, set `result["is_failed"]` to `true` and set `result["error_message"]` to the `message` in the response content.

> For more information, refer to [Customize Test Tasks](../../integrations/dialtesting_json.md#post_script).

### :material-numeric-3-circle: Select Test Nodes

Currently <<< custom_key.brand_name >>> covers 14 global test nodes. You can choose one or more nodes in China or overseas regions (available only for Commercial Plan users and above) to quickly start monitoring the quality of service for your site.

### :material-numeric-4-circle: Select Test Frequency

Choose the execution frequency of the test task, with the following options available:

- 1 minute (available only for Commercial Plan users and above)
- 5 minutes (available only for Commercial Plan users and above)
- 15 minutes (available only for Commercial Plan users and above)
- 30 minutes
- 1 hour
- 6 hours
- 12 hours
- 24 hours