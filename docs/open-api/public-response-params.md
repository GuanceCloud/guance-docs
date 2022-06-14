# 公共响应结构

---

| 字段        | 类型      | 说明                   |
|-----------|-----------|----------------------|
| code      | Number    | 返回的状态码，与 HTTP 状态码保持相同，无错误时固定为 200 |
| content   | String、Number、Array、Boolean、JSON | 返回的数据，具体返回什么类型的数据与实际接口的业务有关 |
| pageInfo  | JSON | 所有列表接口响应的列表分页信息      |
| pageInfo.count | Number | 当前页数据量               |
| pageInfo.pageIndex | Number | 分页页码                 |
| pageInfo.pageSize | Number | 每页大小                 |
| pageInfo.totalCount | Number | 符合条件的总数据量            |
| errorCode | String | 返回的错误状态码，空表示无错误      |
| message   | String | 返回的错误码对应的具体说明信息      |
| success   | Boolean | 固定为 true，表示接口调用成功    |
| traceId   | Boolean | traceId，用于跟踪每一次的请求情况 |
