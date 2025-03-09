# Multi-Step Synthetic Tests
---

Multi-step synthetic tests are advanced monitoring tools that simulate complex business processes or user operation paths by chaining multiple API requests. They allow the creation of tests using response data from multiple connected APIs, thereby validating critical business transactions, simulating end-to-end user journeys, and supporting authentication and authorization. This testing method can proactively monitor service availability and performance, ensuring the smooth operation of complex processes and providing timely alerts when issues arise.

## Getting Started

Click **Tasks > Create > Multi-Step Synthetic Tests**.


### :material-numeric-1-circle: Basic Information

1. Define the task name for the synthetic test;
2. Fill in the description as needed;

### :material-numeric-2-circle: Select Synthetic Test Nodes

Currently <<< custom_key.brand_name >>> covers 14 global synthetic test nodes. You can choose one or more nodes from China or overseas regions (for Commercial Plan users and above) to quickly start site service quality monitoring.

### :material-numeric-3-circle: Select Frequency

Choose the execution frequency for the synthetic test task. The following options are supported:

- 1 minute (Commercial Plan users and above only)
- 5 minutes (Commercial Plan users and above only)
- 15 minutes (Commercial Plan users and above only)
- 30 minutes
- 1 hour
- 6 hours
- 12 hours
- 24 hours

### :material-numeric-4-circle: Define Request Steps {#request_step}

Click **Create First Request**.

![multitest_1](../../img/multitest_1.png)

#### Name

Define the request name.

#### Define Request Format

1. Define the request URL;
2. Configure [Advanced Settings](./http.md#advanced) as needed.

#### Availability Check

##### Default Mode

This involves adding conditions to define the success criteria for the synthetic test result.

Multiple conditions can be combined using "All" or "Any" to achieve AND or OR logical relationships.

| Type | Operator |
| --- | --- |
| Response Body | `contains`, `does not contain`, `equals`, `does not equal`, `regex matches`, `regex does not match` |
| Request Header | `contains`, `does not contain`, `equals`, `does not equal`, `regex matches`, `regex does not match` |
| Response Time | `less than` |
| Status Code | `equals`, `does not equal`, `regex matches`, `regex does not match` |

##### Script Mode {#script}

In multi-step synthetic test tasks, script mode allows writing Pipeline scripts to achieve the following functionalities:

- Set conditions: Customize complex judgment logic based on business needs, supporting single or multiple condition combinations;
- Process result data: Customize processing of synthetic test results, including data cleaning, format conversion, etc.;
- Extract fields and define variables: Extract specific fields from responses and define them as variables for reuse in subsequent steps.

Script mode can flexibly meet the needs of extracting specific fields from responses or performing complex condition judgments.

Example:

```
body = load_json(response["body"])

if body["code"] == "200" {
  result["is_failed"] = false
  vars["token"] = body["token"]
} else {
  result["is_failed"] = true
  result["error_message"] = body["message"]
}
```

In the script above, `load_json` is first used to parse the response content into a JSON object, then it checks if the status code is 200. If it is 200, it extracts the `token` from the response content and stores it in `vars` for use in subsequent requests; otherwise, it sets `result["is_failed"]` to `true` and sets `error_message` to the message in the response content.

> For more information, refer to [Customize Synthetic Test Tasks](../../integrations/dialtesting_json.md#post_script).

###### Local Variables {#variables}

Local variables defined in the current multi-step synthetic test task can be referenced in subsequent request steps.

**Note**: Fields must be extracted in the script before defining variables.

![multitest_2](../../img/multitest_2.png)

1. Enter the variable name, which generally supports uppercase letters, numbers, and underscores, and cannot be duplicated;
2. Select the variable value, i.e., the field defined as a variable in script mode;
3. Optionally encrypt the variable value. When selected, the current variable value will be hidden in the test results.

Created variables are displayed uniformly in the "Variables" area at the top left.

![multitest_5](../../img/multitest_5.png)

You can reference local variables in the Advanced Settings > Request Headers section when defining request formats.

As shown in the figure, the local variable `{DS_ID}` was defined in Step 1 with the value `dashboard_id`. In Request 2, this variable can be directly referenced in the URL.

![multitest_9](../../img/multitest_9.png)

To manage these variables, click the button on the right side of the "Local Variable Configuration" area to edit or delete them.

![multitest_6](../../img/multitest_6.png)

**Note**:

- Deleting a local variable will prevent any requests referencing that variable in the current multi-step synthetic test from continuing to use it;
- Renaming a local variable will make steps that reference the original name unable to recognize the variable.

#### Execution Settings

Selecting "Continue to next step if this step fails" allows skipping errors and continuing to execute subsequent steps when the current step fails.

![multitest_3](../../img/multitest_3.png)

#### Testing

After creating the task steps, click the "Test" button to quickly verify the test results. The system will provide the following information for reference:

- Test Performance: Displays performance metrics during the test.
- Response Details: Provides detailed response content to help troubleshoot issues.
- Variables: View variables configured in the current task's requests and URLs.

![multitest_7](../../img/multitest_7.png)

If you start testing from a step after the first request task, you can either test the current task directly or choose to start testing from the first task.

![multitest_8](../../img/multitest_8.png)

If the test fails, there may be unknown variables. Click the "Test from First Step to Current Request" button to re-initiate the test for troubleshooting.

#### Continue Creating Request Steps

After creating the first synthetic test task, you can continue to "[Create HTTP Request](#request_step)" or "[Create Wait Step](#waiting)".

**Note**: Up to 10 steps (including HTTP requests and waits) can be created.

##### Wait Step {#waiting}

This indicates waiting for a specific duration before continuing to the next step. The duration can be selected as 1 second, 5 seconds, 15 seconds, 30 seconds, 1 minute, 2 minutes, or 3 minutes.

![multitest_4](../../img/multitest_4.png)

#### Manage Task

After creating the request steps, click Save to complete.

For already created tasks, you can manage them through the following operations:

- Click the drag icon on the left side of the task to change the order of the steps;
- Click the :material-dots-vertical: icon on the right side of the task to clone or delete this step;
- Click "Batch" to batch clone or delete tasks.

**Note**: Local variables cannot be cloned along with cloning request steps.