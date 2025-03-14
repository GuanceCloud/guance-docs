# Dial Testing Tasks
---

By simulating requests and operations globally, real-time observation of system and application performance can be achieved. Guance monitors the performance of web pages and APIs from backend to frontend in a controlled and stable manner, covering different network layers such as HTTP, WebSocket, TCP, ICMP, etc. If any faulty behavior occurs (such as performance regression, functional failures, excessively long response times, or unexpected status codes), the system will automatically issue alerts.

## Types of Dial Testing

### Synthetic Tests

Single-request monitoring of API and website availability and response time allows for quick detection of service status codes, response delays, or error content. Tests can be initiated from global nodes to help you promptly identify and precisely locate issues.

### Multi-step Dial Testing

By chaining multiple requests, complex business processes or end-to-end user journeys can be simulated, supporting authentication scenarios (such as via Token). This can be used to monitor critical business transactions to ensure the availability and stability of complex workflows.


## Manage Tasks {#manag}

All dial testing tasks can be managed through the task list, where you can perform the following operations:

- Quick Filtering: Based on four filtering criteria—dial testing type, status, tags, and dial testing frequency—you can customize your selections for filtering;
- Search: Enter the task name in the search bar to quickly locate it;
- Batch Operations: Enable, disable, delete, or export specific tasks in bulk;
- Import/Export: You can export or import tasks in JSON file format;
- Edit: Modify the configuration of the dial testing task;
- Operation Audit: View the operation records of the current task;
- Delete: Delete the current task;
- Edit Request Steps: Applicable only to **multi-step dial testing** tasks.

**Note**: If any node associated with a task is deleted, a :warning: symbol will appear. Clicking this symbol will filter out all tasks with the marker.