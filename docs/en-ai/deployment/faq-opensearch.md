# OpenSearch FAQ

## 1 OpenSearch Accidentally Deleted Index

Problem Description: In some environments with limited disk space, it is necessary to [delete indexes](es-disk-full.md), which can easily lead to the accidental deletion of the largest index number, causing errors when Guance kodo-x writes to the index.

Solution:

Taking wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging as an example:

- Check if the largest index is missing

```shell
GET /_alias/wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging



wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000157  -- false
wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000158  -- false
wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000159  -- false

.....

```

> It is found that wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000159 is the largest index, and the next one should be wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000160


- Fix the write operation

```shell
PUT  wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000160
```

```shell
POST _alias
{
  "actions": [
  "add": 
    {
    "index": "wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging-000160",
    "alias": "wksp_f8f7efcc6c4948ec96c751bbcfb7c8fc_logging",
    "is_write_index": true
    }
  ]
}
```