# Detailed Explanation of Audit Event Logic
---

Operation audit helps you monitor and record the access behavior of all members within the <<< custom_key.brand_name >>> workspace, including login access and operational use through the <<< custom_key.brand_name >>> console and OpenAPI.

**Scope of Audit Events**:

- Records of user login access behavior;
- Records of user operational behavior;
- DQL query examples for audit events.

**Audit Event Query DQL**:

```
TAE::re(`.*`):(`*`){ `df_source` IN ['audit'] }
```

## Field Description

| Field Name | Type | Required | Description |
| --- | --- | --- | --- |
| `date` | Int | Required | Event generation time, Unix timestamp in milliseconds |
| `df_date_range` | Int | Required | Time range in seconds |
| `df_source` | Str | Required | Data source, operation events have a value of audit |
| `df_status` | Str | Required | Status, default value for operation events is info |
| `df_origin` | Str | Required | Operation source, used to record the current operation entry point |
| `df_menu` | Str | Required | Menu path accessed by the user, e.g., Logs > Explorer |
| `df_event_id` | Str | Required | Unique event ID |
| `df_title` | Str | Required | Title |
| `df_message` | Str | Required | Description |
| `df_user_id` | Str | Required | User ID |
| `df_user_name` | Str | Required | User name |
| `df_user_email` | Str | Required | User email, corresponding to the ID, name, and email in "Member Management" |
| `df_user_team` | Str | Required | Team the user belongs to at the time of the event |
| `df_role_scope` | Str | Required | Role scope the user has at the time of the event |
| `df_operation_id` | Str | Required | Unique ID of the actual operation item corresponding to the current audit |
| `df_operation_name` | Str | Required | Menu name corresponding to the operation that generated the current audit event. For example, if an audit event corresponds to a notification strategy operation, this field would be the name of the current notification strategy |
| `df_query_typeDQL` | String | Required | Query type |
| `df_query` | String | Required | DQL query |
| `df_query_range` | String | Required | Duration of DQL query, in milliseconds |
| `df_cost` | String | Required | DQL query duration |
| `df_hit_count` | String | Required | Number of query hits |