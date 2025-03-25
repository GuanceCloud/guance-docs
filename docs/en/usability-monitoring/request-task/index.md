# Testing Tasks
---

By simulating requests and operations globally, you can observe the performance of systems and applications in real time. <<< custom_key.brand_name >>> uses a controlled and stable method to track the performance of web pages and APIs from back-end to front-end, covering different network levels such as HTTP, WebSocket, TCP, ICMP, etc. Whenever faulty behavior occurs (such as performance regression, functional failure, excessively long response times, or unexpected status codes), the system will automatically send out alerts.

## Testing Types

### API Tests


Monitor the availability and response time of APIs and websites through single requests. You can quickly detect service status codes, response delays, or error content. Global nodes can be used to initiate tests, helping you discover and accurately locate issues in a timely manner.

### Multistep Tests

By chaining multiple requests, simulate complex business processes or end-to-end user journeys, supporting authentication scenarios (such as via Token). It can be used to monitor key business transactions, ensuring the availability and stability of complex processes.


## Manage Tasks {#manag}

All testing tasks can be managed via the task list, allowing you to perform the following actions:

- Quick filtering: Based on four major filtering options—testing type, status, tags, and testing frequency—you can customize your selection for filtering;
- Search: In the search bar, input the task name to quickly search and locate;
- Batch operations: Enable, disable, delete, or export specific tasks in batches;
- Import/Export: You can export or import tasks in JSON file format;
- Edit: Modify the configuration of testing tasks;
- Operation audit: View operation records for the current task;
- Delete: Delete the current task;
- Edit request steps: Applicable only to **Multistep Tests** tasks.


**Note**: If any node associated with a task is deleted, a :warning: symbol will appear. Clicking this symbol allows you to filter all tasks with the marker.


