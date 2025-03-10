# Service List


## Add Service {#create}


![Service](../../img/service-1.png)

1. Define the specific name of the service.

2. Select the service type; options include: `app`, `framework`, `cache`, `message_queue`, `custom`, `db`, `web`.

3. Choose the color for the current service; defaults to a randomly generated color, but can also be selected from a dropdown.

4. Configure team information

    - Team: The team to which the current service belongs; you can choose an existing team within the current workspace or manually enter a new team name and press Enter to create a new team.
    - Contact Information: This will be contacted first when the current service encounters an issue; supports email, phone, and Slack channels; multiple entries should be separated by commas, semicolons, or spaces.

    **Note**: After successfully creating the service list, any new teams created here will be synchronized in the **Manage > Member Management > Team Management** list.

5. Configure associated information

    - Application: Information related to the application associated with the current service; this is the same as the RUM Application ID.
    - Tags: Used to associate other configuration information within the current workspace, linking workspace information through global tags, supporting operations such as jumping to view and analyze.

6. Configure help links

    - Repository Configuration: Enter the display name, provider name, and repository code URL sequentially.
    - Help Documentation: Enter the display name, provider name, and other related document URLs sequentially.
    - View: You can bind required built-in views to the current service. Once selected, you can view the bound built-in views under the **Analysis Dashboard** for the current service.

7. Click Confirm.

## View Service 

After creation, you can view relevant parameters of the service in the following three lists:

![](../img/service-3.png)

## Manage List {#list-deatils}

You can manage the service list according to the following operations:

1. Search: In the search bar, you can input keywords to search for service names.

2. Filter:

    - In the entire list, quickly filter and find corresponding services by frequently browsed, my favorites, and my created services.
    - On the left side of the list, filter based on creation type, team, and service type.

3. On the list page:

    - Application: If the application matches the RUM Application ID, it supports Hover-clicking to open a new tab to jump to the Session Explorer.
    - Team: Supports Hover-clicking to open a new tab to view team information.
    - Contact Information: Supports Hover-viewing detailed information for email, phone, and Slack; Slack supports jumping.
    - Repository Configuration & Documentation: Hover over the corresponding icon and click to automatically jump to the associated repository or documentation.

4. In **Operations**:

    - Hover over the avatar icon to view the creator, creation time, updater, and update time of the service.
    - Click the :material-dots-vertical: button to modify or delete the current service.

5. Click the :octicons-star-24: button to bookmark the current service.

6. Click the :material-tray-arrow-up: button to export the current page data as a JSON file.

7. You can save the current page data as a [Snapshot](../../getting-started/function-details/snapshot.md).

![Service Snapshot](../../img/service-10.png)


### Memory Snapshot {#jvm}

For Java services, you can configure JVM memory snapshots.

#### Concepts

JVM (Java Virtual Machine) memory snapshots are complete records capturing the state of JVM memory at a specific point in time. You can use the log information within the snapshot to view detailed information about the memory usage of the associated application, promptly identify issues such as memory leaks and performance problems, and further optimize data structures based on understanding memory usage.

> For more collector-side configurations, refer to [Collection](../../datakit/datakit-conf.md#remote-job).

#### Start Creation

1. Input the task name;
2. The system automatically fills in the current service for you;
3. Select the execution host or Pod;
4. Add a description if needed;
5. Click Confirm.

???+ warning "How is the execution target determined?"

    <<< custom_key.brand_name >>> queries link data from the past hour and determines whether the current service's link data contains PODs. If there is a `pod_name` value, it lists `pod_name` in the dropdown; otherwise, it lists `host`.


#### Historical Memory Snapshots

All created snapshots can be viewed by clicking the **Historical Memory Snapshots** entry above the list.

![](../img/service-4.png)

In the historical memory snapshot list, you can view the execution logs of the task and evaluate the execution results and logs.