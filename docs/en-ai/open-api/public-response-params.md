# Public Response Structure

---

| Field        | Type      | Description                   |
|-----------|-----------|----------------------|
| code      | Number    | The returned status code, which is the same as the HTTP status code. It is fixed at 200 when there are no errors. |
| content   | String, Number, Array, Boolean, JSON | The returned data, the specific type of which depends on the actual business of the interface |
| pageInfo  | JSON | Pagination information for all list interfaces      |
| pageInfo.count | Number | Data volume of the current page               |
| pageInfo.pageIndex | Number | Pagination page number                 |
| pageInfo.pageSize | Number | Size per page                 |
| pageInfo.totalCount | Number | Total data volume that meets the conditions            |
| errorCode | String | The returned error status code, an empty value indicates no error      |
| message   | String | Specific description corresponding to the returned error code      |
| success   | Boolean | Fixed at true, indicating successful API invocation    |
| traceId   | String | Trace ID, used to track each request situation |