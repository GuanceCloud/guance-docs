# 【Measurement】Metrics and Label Information Retrieval

---

<br />**GET /api/v1/metric_info/get**

## Overview
Retrieve the Measurement and label information corresponding to the Metrics



## Query Request Parameters

| Parameter Name        | Type     | Required   | Description              |
|:-------------------|:-------|:-------|:----------------|
| metric | string | Y | Measurement name<br>Example: cpu <br>Nullable: False <br>Empty String Allowed: False <br> |


## Additional Parameter Notes



## Request Example
```shell
curl 'https://openapi.<<< custom_key.brand_main_domain >>>/api/v1/metric_info/get?metric=kube_replicaset' \
-H 'DF-API-KEY: <DF-API-KEY>' \
--compressed
```



## Response
```shell
{"code":200,"content":{"declaration":{"asd":"aa,bb,cc,1,True","asdasd":"dawdawd","business":"aaa","dd":"dd","fawf":"afawf","organization":"64fe7b4062f74d0007b46676"},"metric_fields_info":[{"data_type":"int","desc":"The number of fully labeled replicas per ReplicaSet.","field":"fully_labeled_replicas","type":"inner","unit":"count"},{"data_type":"int","desc":"The most recently observed number of replicas.","field":"replicas","type":"inner","unit":"custom/[\\"angle\\",\\"rad\\"]"},{"data_type":"int","desc":"The number of available replicas (ready for at least minReadySeconds) for this replica set.","field":"replicas_available","type":"inner","unit":"count"},{"data_type":"int","desc":"The number of desired replicas.","field":"replicas_desired","type":"inner","unit":"count"},{"data_type":"int","desc":"The number of ready replicas for this replica set.","field":"replicas_ready","type":"inner","unit":"count"}],"tags_info":[{"tag_desc":"Namespace defines the space within each name must be unique.","tag_key":"namespace"},{"tag_desc":"K8s cluster name(default is `default`). We can rename it in datakit.yaml on ENV_CLUSTER_NAME_K8S.","tag_key":"cluster_name_k8s"},{"tag_desc":"","tag_key":"replica_set"},{"tag_desc":"","tag_key":"guance_site"},{"tag_desc":"The UID of ReplicaSet.","tag_key":"uid"},{"tag_desc":"Name must be unique within a namespace.","tag_key":"replicaset"}]},"errorCode":"","message":"","success":true,"traceId":"TRACE-B865D1FC-CB17-4676-B72C-AC3E5FE55334"} 
```