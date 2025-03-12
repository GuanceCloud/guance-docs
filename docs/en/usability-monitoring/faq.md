# Frequently Asked Questions
---

## Tags

:material-chat-question: When creating a Test task, associated tags were added. Later, when creating a monitor for this Test task and adding the `{df_label}` variable to the event content, the variable content appears empty in the final generated event.

The reason is that when creating a monitor, an event record contains a system field named `df_label`, which conflicts with the global tag fields from the Test task. In this scenario, the global tag fields from the Test task are discarded, and only the content of the `df_label` field in the event record is displayed.

Specifically, the tags added in the Test task belong to global tags, while `df_label` is a system field inherent in events (`event`). Therefore, when the monitor generates an event record, it prioritizes using the `df_label` field in the event, overriding the originally associated tag fields from the Test task.