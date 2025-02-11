# Service List


## Add Service {#create}


![Service](../../img/service-1.png)

1. Define the specific name of the service.

2. Select the service type; options include: `app`, `framework`, `cache`, `message_queue`, `custom`, `db`, `web`.

3. Choose the color for the current service; a default random color is generated, but you can also select from a dropdown.

4. Configure team information:

    - Team: The team to which the current service belongs; you can choose an existing team in the current workspace or manually enter a new team name and press Enter to create a new one.
    - Contact Information: This will be contacted first when the service encounters issues; supports email, phone, and Slack channels; multiple selections should be separated by commas, semicolons, or spaces.

    **Note**: After successfully creating the service list, any new teams created here will be synchronized to the **Management > Member Management > Team Management** list.

5. Configure related information:

    - Application: The application information associated with the current service; same as the RUM application ID.
    - Tags: Used to associate other configuration information within the current workspace, linking workspace information via global tags and supporting jump-to operations for viewing and analysis.

6. Configure help links:

    - Repository Configuration: Enter the display name, provider name, and repository code URL sequentially.
    - Help Documentation: Enter the display name, provider name, and other relevant document URLs sequentially.
    - View: You can bind built-in views needed for the current service. Once selected, these views can be viewed under the **Analysis Dashboard** for linked data.

7. Click Confirm.

## View Service

After creation, you can view the relevant parameters of the service in the following three lists:

![](../img/service-3.png)

## Manage List {#list-deatils}

You can manage the service list with the following operations:

1. Search: In the search bar, you can input keywords to search for service names.

2. Filter:

    - In the full list, quickly filter and find services using frequently browsed, my favorites, and my creations.
    - On the left side of the list, filter based on creation type, team, and service type.

3. On the list page:

    - Application: If the application matches the RUM application ID, it supports clicking to open a new page and redirecting to the Session Explorer.
    - Team: Supports clicking to open a new page and view team information.
    - Contact Information: Supports hovering over to view detailed information such as email, phone, and Slack; Slack supports redirection.
    - Repository Configuration & Documentation: Hover over the corresponding icon and click to automatically redirect to the associated repository or documentation.

4. In **Actions**:

    - Hover over the avatar icon to view the creator, creation time, updater, and update time of the service.
    - Click the :material-dots-vertical: button to modify or delete the current service.

5. Click the :octicons-star-24: button to bookmark the current service.

6. Click the :material-tray-arrow-up: button to export the current page data as a JSON file.

7. You can save the current page data as a [Snapshot](../../getting-started/function-details/snapshot.md).

![Snapshot](../../img/service-10.png)


### Memory Snapshot {#jvm}

For Java services, you can configure JVM memory snapshots.

#### Concept Explanation

A JVM (Java Virtual Machine) memory snapshot is a complete record capturing the state of the JVM's memory at a specific point in time. You can use the log information within the snapshot to view detailed information about the application's memory usage, promptly diagnose issues like memory leaks and performance problems, and optimize data structures based on this understanding.

> For more collector-side configurations, refer to [Collection](../../datakit/datakit-conf.md#remote-job).

#### Start Creation

1. Input the task name;
2. The system automatically fills in the current service;
3. Select the execution host or Pod;
4. Add a description as needed;
5. Click Confirm.

???+ warning "How is the execution target determined?"

    Guance queries the trace data from the past hour and determines whether the current service's trace data contains a POD. If a `pod_name` value exists, it lists `pod_name` in the dropdown; otherwise, it lists `host`.


#### Historical Memory Snapshots

All created snapshots can be viewed through the **Historical Memory Snapshots** entry above the list.

![](../img/service-4.png)

In the historical memory snapshot list, you can view the execution logs of the task and evaluate the execution results and logs.