# Create HTTP Synthetic Tests Task
---

HTTP Synthetic Tests monitor the availability of websites, domains, and backend APIs based on the `HTTP` protocol periodically. By continuously monitoring these endpoints, it provides uptime statistics, synthetic test logs, and real-time alerts, helping you quickly identify network issues and improve network access quality.

HTTP Synthetic Tests allow you to send HTTP requests to your application's API endpoints to validate request definitions and judgment criteria, such as request headers, status codes, response times, etc.

## Getting Started

Click **Create > Synthetic Tests**, then select **HTTP Protocol**.

![API Test HTTP](../../img/api_test_http.png)


### 1. Define Request Format

1. URL: Supports entering both HTTP or HTTPS URLs, including four request methods: `GET`, `POST`, `PUT`, and `HEAD`.
2. Advanced Settings: Customize advanced settings according to actual needs, including request settings, request body content, certificates, proxies, and privacy.
3. Name: Define a custom name for the HTTP Synthetic Tests task; duplicate names are not supported within the current workspace.

#### Advanced Settings {#advanced}

<div class="grid" markdown>

=== "Request Settings"

    1. Choose whether to follow redirects during the HTTP request execution;
    2. Define the request headers to be added to the current HTTP request;
    3. Define the cookies to be added to the HTTP request;
    4. Add HTTP authentication, including username/password.

=== "Request Body Content"

    1. Select the request body type: `text/plain`, `application/json`, `text/xml`, `None`;
    2. Enter the request body content.

=== "Certificates"

    1. Ignore server certificate errors: If checked, the HTTP test will continue even if SSL certificate verification fails;
    2. Upload client certificates, including private keys and certificates.

=== "Proxy"

    1. Specify the proxy server address that the HTTP request needs to go through;
    2. Add HTTP request headers to be included in requests sent to the proxy server.

=== "Privacy"

    Do not save response content: Checking this option prevents saving the response body content during runtime, avoiding sensitive data from appearing in test results. However, note that this may increase the difficulty of troubleshooting problems.


</div>


### 2. Availability Judgment {#test}

#### Default Mode

This involves adding judgment conditions to match data. Multiple conditions can be combined using "All" or "Any" to achieve AND or OR logical relationships.

After defining the request format and adding judgment conditions, click the "Test" button to the right of the URL to verify if the synthetic test configuration is successful.

**Note**: The test result is independent of the selected node.

#### Script Mode {#script}

Script mode allows writing Pipeline scripts to achieve the following:

- Set judgment conditions: Customize complex judgment logic based on business requirements, supporting single or multiple condition combinations;
- Process result data: Customize processing of synthetic test results, including data cleaning, format conversion, etc.

Script mode can flexibly meet the need to extract specific fields from responses or perform complex condition judgments.

Example:

```
body = load_json(response["body"])

if body["code"] == 200 {
  result["is_failed"] = false
} else {
  result["is_failed"] = true
  result["error_message"] = body["message"]
}
```

In the script, `load_json` is first used to parse the response content into a JSON object, then it checks if the response status code is 200. If `code` is 200, the result is marked as successful; otherwise, `result["is_failed"]` is set to `true`, and `result["error_message"]` is set to the `message` from the response content.

> For more information, refer to [Customize Synthetic Tests](../../integrations/dialtesting_json.md#post_script).

### 3. Select Synthetic Test Nodes

Currently <<< custom_key.brand_name >>> covers 14 global Synthetic Test nodes. You can choose one or more nodes in China or overseas regions (available only for Commercial Plan users and above) to quickly start monitoring site service quality.

### 4. Select Synthetic Test Frequency

Choose the execution frequency of the Synthetic Tests task, with the following options available:

- 1 minute (Commercial Plan users and above)
- 5 minutes (Commercial Plan users and above)
- 15 minutes (Commercial Plan users and above)
- 30 minutes
- 1 hour
- 6 hours
- 12 hours
- 24 hours