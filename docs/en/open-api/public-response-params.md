# Common Response Structure

---

| Field        | Type      | Description                   |
|-----------|-----------|----------------------|
| code      | Number    | The returned status code remains the same as the HTTP status code and is fixed at 200 when there are no errors. |
| content   | String, Number, Array, Boolean, JSON | The data returned, and what Type of data returned is related to the business of the actual interface. |
| pageInfo  | JSON | List paging information for all list interface Response     |
| pageInfo.count | Number | Current page data amount               |
| pageInfo.pageIndex | Number | page number                 |
| pageInfo.pageSize | Number | Size per page                 |
| pageInfo.totalCount | Number | Total amount of eligible data            |
| errorCode | String | The error status code returned. Null means no error      |
| message   | String | Specific Description information corresponding to the returned error code      |
| success   | Boolean | Fixed to true, indicating that the interface call was successful   |
| traceId   | Boolean | traceId, which is used to track the status of each request |
