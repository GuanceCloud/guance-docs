
# OpenSeach FAQ

## 1 OpenSearch 误删除索引

问题描述：由于有些环境磁盘有限，需要[删除索引](es-disk-full.md)，容易误删除最大的索引编号，导致<<< custom_key.brand_name >>> kodo-x 写入索引报错。

问题解决： 

以 wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging 为列

- 查看是否缺失最大索引

```shell
GET /_alias/wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging



wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000157  -- false
wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000158  -- false
wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000159  -- false

.....

```

> 发现 wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000159 为最大索引，下一个为 wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000160


- 修复写入

```shell
PUT  wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000160
```

```shell
POST _aliases
{
  "actions": [
    {
      "add": {
        "index": "wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-001778",
        "alias": "wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging",
        "is_write_index": true
      }
    }
  ]
}
```

