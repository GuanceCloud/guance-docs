# <<< custom_key.brand_name >>> ES Multi-Tenant Lifecycle Management Practice
---

## Lifecycle Management (ILM)

### Data Stages

| **Stage Name** | **Description** | **Write** | **Query** |
| --- | --- | --- | --- |
| hot | Hot data stage | Frequent writes | Frequent queries |
| warm | Warm data stage | No writes | Moderately frequent queries |
| cold | Cold data stage | No writes | Infrequent queries, slow queries |
| frozen | Frozen data stage | No writes | Rare queries, very slow queries |
| delete | Data deletion stage | No writes | Unqueryable |

### Index Operations

**Note**:

1. For the hot data stage, the rolling start time is the index creation time;

2. For other data stages (except the hot data stage), the time calculation starts from the end of the rolling period.

### Example

![](../img/es-1.png)

## <<< custom_key.brand_name >>> Practical Application

| **Retention Policy** | **Description** | **Hot Data Stage** | **Warm Data Stage** | **Data Deletion Stage** |
| --- | --- | --- | --- | --- |
| es_rp0 | Data retained for 1 day | min_age = 0<br />rollover {30gb, 1d}  | min_age = 6h<br />forcemerge {1}<br />shrink {1} | min_age = 1d <br />delete |
| es_rp2d | Data retained for 2 days | min_age = 0<br />rollover {30gb, 2d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 2d <br />delete |
| es_rp1 | Data retained for 7 days (1 week) | min_age = 0<br />rollover {30gb, 7d}  | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 7d <br />delete |
| es_rp2 | Data retained for 14 days (2 weeks) | min_age = 0<br />rollover {30gb, 14d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 14d <br />delete |
| es_rp3 | Data retained for 30 days (1 month) | min_age = 0<br />rollover {30gb, 30d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 30d <br />delete |
| es_rp60d | Data retained for 60 days (2 months) | min_age = 0<br />rollover {30gb, 60d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 60d <br />delete |
| es_rp4 | Data retained for 90 days (3 months) | min_age = 0<br />rollover {30gb, 90d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 90d <br />delete |
| es_rp5 | Data retained for 180 days (6 months) | min_age = 0<br />rollover {30gb, 180d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 180d <br />delete |
| es_rp6 | Data retained for 360 days (1 year) | min_age = 0<br />rollover {30gb, 360d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age = 360d <br />delete |
| es_rp720d | Data retained for 720 days (nearly 2 years) | min_age = 0<br />rollover {30gb, 720d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age=720d <br />delete |
| es_rp7 | Data retained for 1095 days (3 years) | min_age = 0<br />rollover {30gb, 1095d} | min_age = 1d<br />forcemerge {1}<br />shrink {1} | min_age=1095d <br />delete |

## Common Issues

### Shortened Data Retention Time

After modifying the retention policy, new indexes will roll over. Previous index data will not be deleted until it meets the deletion date condition, meaning that previous index data will continue to incur charges.

![](../img/image.png)

### Extended Data Retention Time

After modifying the retention policy, new indexes will roll over. The retention time of previous index data will not be extended, and new indexes will use the new configuration.

![](../img/image_0.png)

## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **ILM: Manage the index lifecycle edit**</font>](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-lifecycle-management.html))

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Implementing Hot-Warm-Cold Architecture with Index Lifecycle Management**</font>](https://www.elastic.co/en/blog/implementing-hot-warm-cold-in-elasticsearch-with-index-lifecycle-management)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **[Latest] Elasticsearch 6.6 Index Lifecycle Management Preview**</font>](https://elasticsearch.cn/article/6358)

</div>

</font>