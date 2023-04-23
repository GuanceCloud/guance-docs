# 本地函数

如果您想在**时序图 > 高级函数**中使用配置好的本地函数，可参考以下数据处理流程：		

```
# 观测云前端UI——> DQL ——>Func 函数
```

## 具体操作

### 步骤一

在 Func 中新建本地函数脚本，示例算法写法如下：

```
'''
高级函数示例算法

示例处理内容为：    
1. 数据传入 DQL 语句
2. 返回算法处理后的结果

注意：  
    检测算法的入口函数固定为`AlgorithmScriptName(data,**kwargs)`
    data 为 DQL 查询数据后里面'series'的结构，示例结构如下：
        [
            {
              'name': 'cpu',
              'tags': {'image': 'nginx'},
              'columns': ['usage_total', 'last'],
              'values': [[1681200000000, 8],[1681202880000, 23],......]
              }
              ...
           ]
    **kwargs 为算法可选参数

入口函数：DBSCAN(data,eps)
输出示例：  
    [
        {
            'status'        : "abnormal_series",
                            # 标记此条时序数据是正常还是离群，离群 status 为 "abnormal_series"，正常 status 为 "normal_series"
            'name'          : 'cpu',
            "tags"          : {'image': 'nginx'},
            'colums'        : ['usage_total', 'last'],
            "values"        : [[1681274880000,8],[1681277760000,20],……],
        },
        ...
    ]
'''
```

### 步骤二

函数写好后，添加 category 类型，用户 category 类别写法如下：

```
@DFF.API('用户自定义函数名称', category='guance.dqlFunc')
```

### 步骤三

在观测云**场景**中**新建仪表盘**，添加**时序图**，可在高**级函数**下看到本地函数，如图：

![](../img/ad-5.png)