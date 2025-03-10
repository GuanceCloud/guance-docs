# Multi-Step Synthetic Tests
---

Multi-step synthetic tests are advanced monitoring tools that simulate complex business processes or user operation paths by chaining multiple API requests. They allow the creation of tests using response data from multiple connected APIs, thereby validating critical business transactions, simulating end-to-end user journeys, and supporting authentication and authorization. This testing method can proactively monitor service availability and performance, ensuring the smooth operation of complex processes, and trigger alerts when issues arise.

## Start Creating

Click **Tasks > Create > Multi-Step Synthetic Tests**.


### 1. Basic Information

1. Define the test task name;
2. Fill in the description as needed;

### 2. Select Test Nodes

Currently <<< custom_key.brand_name >>> covers 14 global test nodes. You can choose one or more nodes from China or overseas regions (available only to Commercial Plan users and above) to quickly initiate site service quality monitoring.


### 3. Select Test Frequency

Choose the execution frequency for the test task, with the following options supported:

- 1 minute (Commercial Plan users and above only)
- 5 minutes (Commercial Plan users and above only)
- 15 minutes (Commercial Plan users and above only)
- 30 minutes
- 1 hour
- 6 hours
- 12 hours
- 24 hours

### 4. Define Request Steps {#request_step}

Click **Create First Request**.

![multitest_1](../../img/multitest_1.png)

#### Name

Define the request name.

#### Define Request Format

1. Define the request URL;
2. Perform [Advanced Settings](./http.md#advanced) as needed.

#### Success Criteria

##### Default Mode

This involves adding judgment conditions to define the success criteria for the test results.

Multiple conditions can be combined using "All" or "Any" to achieve AND or OR logical relationships.

| Type       | Operators                                      |
|------------|------------------------------------------------|
| Response Body | `Contains`, `Does Not Contain`, `Is`, `Is Not`, `Matches Regex`, `Does Not Match Regex` |
| Request Header | `Contains`, `Does Not Contain`, `Is`, `Is Not`, `Matches Regex`, `Does Not Match Regex` |
| Response Time | `Less Than` |
| Status Code | `Is`, `Is Not`, `Matches Regex`, `Does Not Match Regex` |

##### Script Mode {#script}

In multi-step synthetic tests, script mode allows writing Pipeline scripts to achieve the following functions:

- Set judgment conditions: Customize complex judgment logic based on business needs, supporting single or multiple condition combinations;
- Process result data: Custom process test results, including data cleaning, format conversion, etc.;
- Extract fields and define variables: Extract specific fields from responses and define them as variables for reuse in subsequent steps.

Script mode can flexibly meet the needs of extracting specific fields from responses or performing complex condition judgments.

Example:

```javascript
body = load_json(response["body"])

if body["code"] == 200 {
  result["is_failed"] = false
  vars["token"] = body["token"]
} else {
  result["is_failed"] = true
  result["error_message"] = body["message"]
}
```

In the script above, `load_json` is used to parse the response content into a JSON object. It then checks if the status code is 200. If it is 200, the `token` field from the response content is extracted and stored via `vars` for use in subsequent requests; otherwise, `result["is_failed"]` is set to `true`, and `error_message` is set to the `message` from the response content.

> For more information, refer to [Customize Synthetic Tests](../../integrations/dialtesting_json.md#post_script).

###### Local Variables {#variables}

Local variables defined in the current multi-step synthetic test can be referenced in subsequent request steps.

**Note**: Fields must first be extracted in the script before defining variables.

![multitest_2](../../img/multitest_2.png)

1. Enter the variable name, typically supporting uppercase letters, numbers, underscores, and no duplicates;
2. Select the variable value, which is the field defined as a variable in script mode;
3. Optionally choose to encrypt the variable value. If checked, the current variable value will be hidden in test results.

Created variables are displayed uniformly in the "Variables" area at the top left.

![multitest_5](../../img/multitest_5.png)

You can reference local variables in the request headers under Advanced Settings in the request format definition.

As shown in the image, `{DS_ID}` was defined as a local variable in Step 1, with its value being `dashboard_id`. In Request 2, you can directly reference this variable in the URL.

![multitest_9](../../img/multitest_9.png)

To manage these variables, click the button on the right side of the "Local Variable Configuration" area to edit or delete them.

![multitest_6](../../img/multitest_6.png)

**Note**:

- Deleting a local variable will prevent any requests referencing that variable from continuing to use it;
- Renaming a local variable will cause steps referencing the original name to no longer recognize the variable.

#### Execution Settings

Selecting "Continue to next step if this step fails" allows skipping errors and continuing to execute subsequent steps if the current step fails.

![multitest_3](../../img/multitest_3.png)


#### Testing

After creating the task steps, click the "Test" button to quickly verify the test results. The system will provide the following information for reference:

- Test Performance: Displays performance metrics during the test.
- Response Details: Provides detailed response content to help troubleshoot issues.
- Variables: View variables configured in the current task's requests and URLs.

![multitest_7](../../img/multitest_7.png)

If you start testing from a step after the first request task, you can test the current task directly or choose to test from the first task.

![multitest_8](../../img/multitest_8.png)

If the test fails, there may be unknown variables. Click the "Test from the first step to the current request" button to retest for troubleshooting.



#### Continue Creating Request Steps


After creating the first synthetic test task, you can continue to "[Create HTTP Request](#request_step)" or "[Create Wait Step](#waiting)".

**Note**: A maximum of 10 steps can be created (including HTTP requests and waits).

##### Wait Step {#waiting}

This indicates waiting for a specified duration before continuing to the next step. Duration options include 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 2 minutes, or 3 minutes.

![multitest_4](../../img/multitest_4.png)


#### Manage Tasks

After completing the creation of request steps, click Save.

For already created tasks, you can manage them through the following operations:

- Click the drag icon on the left side of the task to change the order of invocation steps;
- Click the :material-dots-vertical: icon on the right side of the task to clone or delete this step;
- Click "Batch" to batch clone or delete tasks.

**Note**: Local variables cannot be cloned along with the request steps.