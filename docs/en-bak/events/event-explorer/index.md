# Explorer

Enter the **Event > Explorer** to view and audit monitoring event information in one place, enabling real-time monitoring and unified querying of events triggered by monitoring sources such as monitors, intelligent inspections, and SLOs.

The Event Explorer mainly includes:

- **Unresolved Event Explorer**: Support viewing all unresolved events continuously triggered within the workspace, as well as data statistics of unresolved events under different alert levels, alert information details, etc.
- **All Event Explorer**: Support viewing the list of all events, filtering event data by selecting time range, searching keywords, etc., helping you quickly locate events within a specific time range, functional module, or behavior trigger.
- **Event Details**: In the Unresolved Event Explorer or All Event Explorer, you can click on any event to view the event details, including information, extended fields, alert notifications, history, related events and related SLOs.

## Event Sources

- All alarm events triggered by [Monitors](../../monitoring/monitor/index.md) based on configuration.
- All alarm events triggered by [Security Check](../../monitoring/bot-obs/index.md) based on configuration.  
- All alarm events triggered by [SLO](../../monitoring/slo.md) based on configuration.  
- [Audit events](../../management/settings/operation-audit.md) triggered by system operations.
- Support writing custom events through [OpenAPI](../../open-api/keyevent/create.md).


|                   <font color=coral size=3>:fontawesome-regular-circle-down: &nbsp;**Learn More**</font>                         |                                                              |                                                              |
| :----------------------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| [Unrecovered Events Explorer](unrecovered-events.md){ .md-button .md-button--primary } | [All Events Explorer](event-list.md){ .md-button .md-button--primary } | [Event Details](event-details.md){ .md-button .md-button--primary } |