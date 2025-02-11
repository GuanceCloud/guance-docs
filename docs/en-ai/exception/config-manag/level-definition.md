# Level Definitions {#definition}

Guance has configured four default level options for Incident: P0, P1, P2, and Unknown.

| Field | Description |
| --- | --- |
| P0 | Default level configuration, critical business functions are unavailable and widely impact users. |
| P1 | Default level configuration, important business functions are unavailable but affect a limited number of users, such as only internal users. |
| P2 | Default level configuration, peripheral business functions are unavailable, prolonged failure will significantly impact user experience. |
| Unknown | Default level configuration, business impact is unknown. |

In addition to the default levels, you can configure custom levels to meet various needs.

Click **Add Level**, select the level color block, enter the level name and its description, and the creation will be successful.

![](../img/issue-level.png)

For levels, you can perform the following operations:

1. Edit: Click the edit button to modify the current custom level's color, name, and description.

2. Delete: Click to delete the current level.

**Note**: You can add up to 10 levels.

## Enable/Disable Default Configuration

- Enable: If the default configuration is enabled, and there are new custom levels within the current workspace, you can choose both default and custom levels when creating or modifying an Incident;

- Disable: If the default configuration is disabled, you can only choose custom level configurations when creating/modifying an Incident.

???+ warning "Three Points to Note When Disabling This Option:"

    - Custom levels already exist to ensure that there are selectable levels when creating/modifying an Issue;
    - In cases where anomalies occur in monitors, intelligent monitoring, or automatic discovery of Issues, and an Issue Incident is created synchronously, the Issue level will be left blank;
    - If the workspace still contains Issues using default levels, their levels will be set to blank.


## Platform-Level Level Configuration Impact {#backstage}

![](../img/issue-backstage.png)

1. Guance supports [managing Incident level configurations at the platform level](../../deployment/setting.md#global-settings), and once global configuration is enabled, the workspace-level Incident level configurations will no longer apply.
2. After enabling the global level, if other level configurations are applied in rules such as monitors, intelligent monitoring, or Issue auto-discovery within the workspace, newly created Issues will have their levels set to blank.