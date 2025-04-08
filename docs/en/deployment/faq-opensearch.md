# OpenSearch FAQ

## 1 OpenSearch Accidentally Deleted Index

Problem description: Since some environments have limited disk space, it is necessary to [delete the index](es-disk-full.md), which can easily lead to accidental deletion of the largest index number, causing <<< custom_key.brand_name >>> kodo-x to report errors when writing to the index.

Solution:

Take wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging as an example.

- Check if the largest index is missing

```shell
GET /_alias/wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging



wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000157  -- false
wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000158  -- false
wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000159  -- false

.....

```

> It is found that wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000159 is the largest index, and the next one is wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000160


- Fix the write operation

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