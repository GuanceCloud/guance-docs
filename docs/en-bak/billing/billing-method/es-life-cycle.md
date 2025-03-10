# Guance ES Multi-tenant Lifecycle Management Practices
---


## Life Cycle Management(ilm) 


### Data Stage

| **Stage Name** | **Description** | **Write in** | **Query** |
| --- | --- | --- | --- |
| hot | Thermal data stage | Frequent writing | Frequent query |
| warm | Temperature data stage | Unable to write | More frequent queries |
| cold | Cold data stage | Unable to write | Infrequent query, slow query |
| frozen | Freezing data stage | Unable to write | Very few queries, very slow queries |
| delete | Delete data stage | Unable to write | Unable to query |


### Index Operation

**Note**:

1. In the hot data phase, the starting point of rolling time is the index creation time

2. For other data stages (except hot data stage), the starting point of time calculation is the rolling end time

### Example

![](../img/es-1.png)

## Use Case


| **Storage Strategy** | **Description** | **Thermal Data Stage** | **Temperature Data Stage** | **Delete Data Stage** |
| --- | --- | --- | --- | --- |
| es_rp0 | Save data for 1 day | min_age = 0<br />rollover {30gb, 1d}  | min_age = 6h<br />forcemerge {1}<br />shrink {1} | min_age = 1d <br />delete |
| es_rp2d | Save data for 2 days | min_age = 0<br />rollover {30gb, 2d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 2d <br />delete |
| es_rp1 | Save data for 7 days (a week) | min_age = 0<br />rollover {30gb, 7d}  | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 7d <br />delete |
| es_rp2 | Save data for 14 days(2 weeks) | min_age = 0<br />rollover {30gb, 14d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 14d <br />delete |
| es_rp3 | Save data for 30 days(a month) | min_age = 0<br />rollover {30gb, 30d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 30d <br />delete |
| es_rp60d | Save data for 60 days (2 months) | min_age = 0<br />rollover {30gb, 60d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 60d <br />delete |
| es_rp4 | Save data for 90 days (3 months) | min_age = 0<br />rollover {30gb, 90d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 90d <br />delete |
| es_rp5 | Save data for 180 days (half a year) | min_age = 0<br />rollover {30gb, 180d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 180d <br />delete |
| es_rp6 | Save data for 360 days (a year) | min_age = 0<br />rollover {30gb, 360d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 360d <br />delete |
| es_rp720d | Save data for 720 days (nearly 2 years) | min_age = 0<br />rollover {30gb, 720d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age=720d <br />delete |
| es_rp7 | Save data for 1095 days (3 years) | min_age = 0<br />rollover {30gb, 1095d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age=1095d <br />delete |


## FAQ

### Reduced Data Storage Time

After modifying the saving strategy, a new index will be scrolled out. The previous index data will not be deleted until the deletion date condition is met, that is, the previous index data will be measured and charged all the time.

![](../img/image.png)

### Longer Data saving Time

After modifying the saving strategy, a new index will be scrolled out. Before that, the saving time of index data will not be longer, and the new index saving time will use the new configuration.

![](../img/image_0.png)

## More Reading

<font size=3>

<div class="grid cards" markdown>


- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **ILM: Manage the index lifecycleedit**</font>](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-lifecycle-management.html))

</div>



<div class="grid cards" markdown>


- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Using index lifecycle management to implement hot-Warm-Cold architecture**</font>](https://www.elastic.co/cn/blog/implementing-hot-warm-cold-in-elasticsearch-with-index-lifecycle-management)

</div>



<div class="grid cards" markdown>


- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Elasticsearch 6.6 index lifecycle management**</font>](https://elasticsearch.cn/article/6358)

</div>

</font>



