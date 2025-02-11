# How to Report Custom Advanced Functions with Local Func

If you want to use locally configured functions in **Time Series Graph > Advanced Functions**, you need to create a Guance connector and then create a new local function script in your local Func. After synchronizing and publishing, you can use custom advanced functions.


## Specific Operations

### Step One: Create a Guance Connector

> Refer to [Create a Guance Connector](https://func.guance.com/doc/practice-guance-self-build-notify-function/#31)

### Step Two: Write an Advanced Function

> Refer to [Write a User-defined Notification Function](https://func.guance.com/doc/practice-guance-self-build-notify-function/#32)

![](../img/local.png)

Create a new local function script in Func. The example algorithm is as follows:

```
'''
Example Algorithm for Advanced Functions

Example processing content:
1. Data input via DQL statement
2. Return the result after processing by the algorithm

Note:
    The entry function for the algorithm must be `AlgorithmScriptName(data,**kwargs)`
    `data` is the structure of 'series' inside the data returned by the DQL query, for example:
        [
            {
              'name': 'cpu',
              'tags': {'image': 'nginx'},
              'columns': ['usage_total', 'last'],
              'values': [[1681200000000, 8],[1681202880000, 23],......]
              }
              ...
           ]
    **kwargs are optional parameters for the algorithm

Entry function: DBSCAN(data,eps)
Output example:
    [
        {
            'status'        : "abnormal_series",
                            # Marks whether this time series data is normal or outlier; "abnormal_series" for outliers, "normal_series" for normal
            'name'          : 'cpu',
            "tags"          : {'image': 'nginx'},
            'colums'        : ['usage_total', 'last'],
            "values"        : [[1681274880000,8],[1681277760000,20],……],
        },
        ...
    ]
'''
```


After writing the function, add the category type. The user-defined category format is as follows:

```
@DFF.API('User-defined Function Name', category='guance.dqlFunc')
```

???+ warning

    Don't forget to publish after completing the code!!!

### Step Three: Use the Local Function

After completing the above steps, the custom advanced function will be added to the Guance workspace. In the Guance **Scenarios**, when **creating a new dashboard** and adding a **Time Series Graph**, you can see the local function under **Advanced Functions**, as shown in the figure:

![](../img/ad-5.png)

### Step Four: Display Style

- Configuration effect for outliers:

![](../img/ad-3.png)

- If there are no outliers, the original data is displayed on the frontend:

![](../img/ad-4.png)