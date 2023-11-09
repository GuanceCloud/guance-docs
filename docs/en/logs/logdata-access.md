# Data Access
---

In order to make the data query scope of different [member roles](../management/role-list.md) in the current workspace finer, Guance supports configuring corresponding log data access query scope for different roles on the data access page.      


## Configuration {#config}   

On the **Logs > Access** page, click **Create**.

![](img/data-1.png)

> For more information on additional operations related to indexes, see [Log Index](../logs/multi-index.md). 

| <div style="width: 100px"> Field </div>      | Description                          |
| :---------- | :----------------------------------- |
| Index       | Multiple choices; Log index in current workspace includes <u>default index, custom index and bound external index</u>.  |
| Data Range      | The logical relationship between different fields can be customized to choose **OR** or **AND**;<br/>**AND** is selected by default, **AND** switching to **OR** is supported:<br/><br/><u>*Examples of logical relationships are as follows:* </u><br/>&emsp;Example 1: (default AND)<br/>&emsp;&emsp;host=[host1,host2] AND service = [service1,service2]；<br/>&emsp;Example 2: (switch to OR）<br/>&emsp;&emsp;host=[host1,host2] OR service = [service1,service2]。<br/><br/>It supports value filtering by `Label/Attribute`, including forward filtering, reverse filtering, fuzzy matching, reverse fuzzy matching, existence and nonexistence, etc. |
| Authorize to    | Multiple choices; Contain default roles and self-built roles in the system.  |


???+ info "Multi-role Data Query Permission"

    If some member has multiple roles (as follows), and the coverage of query permissions of each role is different, the data query permissions of the member finally <u>adopt the highest permissions under the roles</u>.

    ![](img/logdata_8.png)
    

???+ info "Permission Control Correspondence"

    1. The relationship between multiple filters in a rule: the relationship between multiple values with the same key is OR; the relationship between different keys is AND;  
    2. The relationship between multiple rules is OR.  
    
    So, if:  
    Rule 1：host = [host 1, host 2] AND service = [service 1, service 2]   
    Rule 2：host = [host 3, host 4] AND source = [source 1, source 2]  

    If the user has <u>both permission rules</u>, the actual data will display `rule 1 OR rule 2` to achieve the union effect.

    The actual range of data you can see is:  
    
    `（host = [host 1, host 2] AND service = [service 1, service 2]）OR （host = [host 3, host 4] AND source = [source 1, source 2]）`

### <u>Example</u>

i. On the **Logs > Index** page, create a new index named `tcp_dial_testing`, filter the log data whose filter `source` is `tcp_dial_testing`, and set the data storage strategy to 7 days.

![](img/logdata_5.png)

ii. Go back to the **Access** page, click **Create**, select the index `tcp_dial_testing`, set the filter condition as `container_type` to `kubernetes`, and select the target role that owns the log data query.

<img src="../img/logdata_4.png" width="60%" >

iii. After completing the creation, you can view the number of roles associated with data access rights under the index and the corresponding number of members under the roles.


![](img/logdata_6.png)


???+ warning  

    - When the default role is not configured with data access rules, it has data query permission for all logs;
    - The log data access rules can only take effect <u>based on the existence of log data query authority in user roles</u>;
    - After a role matches a rule, you can only continue to add filters within the basic range of the rule configuration. If you query beyond this range, the returned data is empty.


### Snapshot Sharing {#snapshot}      

Based on the support of log data access rights, you can save the filtered data under the current rule as a **[snapshot](../getting-started/function-details/snapshot.md)**. After the snapshot is shared, the shared object can view the filter criteria of the data list in the search bar at the top of the snapshot page, and can add search criteria, so as to achieve a more accurate data sharing effect of the data under the current snapshot.



![](img/logdatasnapshot.png)


## Other Operations

=== "View"

    After the rule configuration is completed, you can view the number of **roles** associated with this rule and the number of **members** corresponding to the roles:
  
    ![](img/logdata_2.png)

=== "Modify"

    Click to modify the index, filter conditiond and authorization target role settings under the rule:

    ![](img/logdata_1.png)

=== "Delete"

    Click :fontawesome-regular-trash-can: on the right side of the rule and click **Confirm** to delete the rule:
  
    <img src="../img/logdata_3.png" width="60%" >

