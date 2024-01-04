# Session Replay
---

## What is Session Replay?

Session Replay captures user interaction data of a web application by leveraging powerful APIs provided by modern browsers. It generates video recordings to replay and gain deeper insight into the user's experience at that time. Combined with RUM performance data, Session Replay is beneficial for error localization, reproduction, and resolution, as well as timely identification of defects in usage patterns and design of web applications.

## Session Replay Record

Session Replay Record is part of the RUM SDK. Record obtains snapshots of the browser's DOM and CSS by tracking and recording events that occur on the web page (e.g., DOM modifications, mouse movements, clicks, and input events) along with their timestamps. It then reconstructs the web page in the cloud and replays the recorded events in the view at the appropriate time.

Session Replay Record supports all browsers supported by the RUM Browser SDK, except for IE11.

Session Replay Record functionality is integrated within the RUM SDK, so there is no need to introduce additional packages or external plugins.

## Collector Configuration

Before using Session Replay, you need to [install Datakit](../../datakit/datakit-install.md) and then enable the corresponding parameter `session_replay_endpoints` for [RUM collector](../../integrations/rum.md).

**Note**: Session Replay functionality requires upgrading DataKit version to 1.5.5 or higher.

## Integration Configuration

After enabling the RUM collector, you can enable the [Session Replay](replay.md) feature when [configuring web application integration](../web/app-access.md).

**Note**: Session Replay functionality requires upgrading SDK version to `3.0` or higher.

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-up-right-from-square: &nbsp; How to integrate Session Replay</font>](replay.md)

</div>

## How to View Session Replay

After completing the Session Replay configuration, you can view it in **RUM > Session Explorer** as well as in the details page of all user access monitors.

### View Replay in Session Explorer

In the Session Explorer list, a **Play** button is displayed next to each session. Clicking on it allows you to view the replay.

![](../img/16.session_replay_1.png)

### View Replay in the Details Page

- In the Session, View, Error Explorer details page, you can view the replay of the user's session by clicking on **View Replay** in the top right corner.
- In the Source section of the View, Error, Resource, Action, Long Task Explorer details page, you can view the replay of the user's session.
    - More: Clicking on the **More** button supports **View Session Details**, **Filter the current Session ID**, **Copy Session ID**
    - Play: Clicking on the **Play** button allows you to view the session replay.

![](../img/16.session_replay_8.png)

## View Session Replay Effects

On the Session Replay page, you can view the entire process of the user's session, including the visited pages, operation records, and error data that occurred. Clicking on them allows you to play back the user's actions.

In the left panel, you can:

- Share Link: Click on :octicons-share-android-16: to copy the share link and share it with other team members for viewing and analysis.
- View Details: Click on :material-text-search: to show the corresponding details page in a sliding manner.
- Collapse Left Panel: Click on :fontawesome-solid-angle-left: to collapse the left panel and view the session replay.

At the bottom of the player, you can:

- Skip Inactive: Enabled by default, skipping inactive segments longer than 1 minute.
- Playback Speed: Support selecting 1x, 1.5x, 2x, 4x playback speed for viewing.
- Full Screen Playback: Clicking on the full screen playback button enlarges the view for session replay.

![](../img/16.session_replay_9.1.png)