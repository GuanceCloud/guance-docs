# Common Request Parameters

---

This document introduces the common request parameters for External API.

## Common Request Headers (Header)

| Parameter Name         | Required | Example               | Description                                                                                          |
|:------------------|:-------|:-------------------|:--------------------------------------------------------------------------------------------|
| Content-Type      | Yes     | application/json   | The content type of the request. This request header must be added to the API interface, and the default value is `application/json`.                                             |
| X-Df-Access-Key   | Yes     | e243xxxxxxxx       | Identifier for the requester. This value is the `accessKey` described in the 「Service Configuration」  |
| X-Df-Timestamp    | Yes     | 1711701527         | The time point when the request is initiated, in seconds timestamp format. The allowed absolute error is the value of `timeliness` described in the 「Service Configuration」. Requests outside this time range will trigger the `ft.MissingAuthHeaderInfo` exception. |
| X-Df-SVersion     | Yes     | v20240417          | Signature algorithm version, fixed as: `v20240417` |
| X-Df-Nonce        | Yes     | 5931f3059ba244dxxx | A randomly generated nonce for each request |
| X-Df-Signature    | Yes     | 4SW5WlUkeNoFsh+KPdJob2SAdZ2hrp7l2txXjCAub2g= | The result of the signature |