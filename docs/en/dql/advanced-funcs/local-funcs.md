# How to Report Custom Advanced Functions for Local Func

If you want to use the configured local functions in **Time Series Chart > Advanced Functions**, after creating the <<< custom_key.brand_name >>> connector, you need to create a new local function script in the local Func. After synchronizing and publishing it, you can use the custom advanced functions.



## Specific Operations

### Step One: Create <<< custom_key.brand_name >>> Connector

> Refer to [Create <<< custom_key.brand_name >>> Connector](https://<<< custom_key.func_domain >>>/doc/practice-guance-self-build-notify-function/#31)

### Step Two: Write Advanced Functions

> Refer to [Write Self-built Notification Functions](https://<<< custom_key.func_domain >>>/doc/practice-guance-self-build-notify-function/#32)

![](../img/local.png)

Create a new local function script in Func. The example algorithm is written as follows:

```
'''
Example Algorithm for Advanced Functions

Example processing content:
1. Data passed into DQL statement
2. Returns results after algorithm processing

Note:
    The entry function of the detection algorithm is fixed as `AlgorithmScriptName(data,**kwargs)`
    data is the 'series' structure inside the data queried by DQL, with an example structure as follows:
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
                            # Marks whether this time series data is normal or outlier; status is "abnormal_series" for outliers, "normal_series" for normal
            'name'          : 'cpu',
            "tags"          : {'image': 'nginx'},
            'colums'        : ['usage_total', 'last'],
            "values"        : [[1681274880000,8],[1681277760000,20],……],
        },
        ...
    ]
'''
```


After writing the function, add the category type. User category writing method is as follows:

```
@DFF.API('User-defined Function Name', category='guance.dqlFunc')
```

???+ warning

    Don't forget to publish after completing the code writing!!!

### Step Three: Use Local Functions

After completing the above steps, the custom advanced function has been added to the <<< custom_key.brand_name >>> workspace. In the <<< custom_key.brand_name >>> **Use Cases**, when **Creating a Dashboard**, adding a **Time Series Chart**, you can see the local function under **Advanced Functions**, as shown in the figure:

![](../img/ad-5.png)

### Step Four: Display Styles

- Configuration effect for outliers:

![](../img/ad-3.png)

- If there are no outliers, the original data is displayed on the front end:

![](../img/ad-4.png)