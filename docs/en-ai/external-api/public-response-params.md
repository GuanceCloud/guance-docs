# Public Response Structure

---

| Field         | Type               | Description                                                                 |
|---------------|--------------------|-----------------------------------------------------------------------------|
| code          | Number             | The returned status code, which is the same as the HTTP status code. It is fixed at 200 when there are no errors. |
| content       | String, Number, Array, Boolean, JSON | The returned data. The specific type of data returned depends on the actual business logic of the interface. |
| pageInfo      | JSON               | Pagination information for all list interface responses                     |
| pageInfo.count | Number             | The number of data items on the current page                                |
| pageInfo.pageIndex | Number         | Pagination page number                                                     |
| pageInfo.pageSize | Number           | Page size                                                                  |
| pageInfo.totalCount | Number         | Total number of data items that meet the conditions                        |
| errorCode     | String             | The returned error status code. An empty value indicates no error.          |
| message       | String             | Specific description information corresponding to the returned error code   |
| success       | Boolean            | Fixed at true, indicating successful API invocation                         |
| traceId       | Boolean            | TraceId, used to track each request                                         |