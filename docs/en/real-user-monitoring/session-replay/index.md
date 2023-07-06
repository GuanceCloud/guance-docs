# Session Replay
---

## Overview

Session replay is the reconstruction demonstration of user experience website, which generates video records by capturing clicks, mouse movements and page scrolling, and deeply understands the user's operation experience; Combined with user access performance data, it helps users to locate errors, reproduce and solve problems.

## Collector Configuration

Before using session playback, you need to [install Datakit](../../datakit/datakit-install.md) and then turn on the [RUM collector](../../datakit/rum.md) session playback parameter `session_replay_endpoints`.

> Note: The session playback feature needs to be upgraded to version 1.5.5 and above of DataKit.

## Access Configuration

After the RUM collector is turned on, you can turn on the [session playback](replay.md) function while [configuring web application access](../web/app-access.md).

> Note: The session playback function needs to be upgraded to SDK version `3.0` and above, and can be configured according to the document [how to access session replay](replay.md).

## How to View Session Replay

After the session replay configuration is complete, you can view the session replay on the RUM session explorer list and on the all RUM explorer details page.

### View Playback in the Session Explorer List

In the session explorer list, if session replay has been configured for the current session, prompt the **Play** button in the explorer list, and click to view the session replay of the session.

![](../img/16.session_replay_1.png)

### View the Playback on the Details Page

- On the Session, View, Error explorer details page, click **Replay** in the upper right corner to view the operational replay of the current user session.
- In the **Source** section of the View, Error, Resource, Action, Long Task explorer details page, you can view the action replay of the current user session.
    - More: Click the **More** button to support **View Session Details**, **Filter Current Session ID** and **Copy Session ID**
    - Play: Click the **Play** button to view the session replay

![](../img/16.session_replay_8.png)

## View Session Playback Effect

On the session playback page, you can view the whole session process of the user, including the visited page, operation record and error data, and click to play the user's operation process.

In the left list, you can:

- Sharing link: Click on the **Sharing link** icon to copy the sharing link and share it with other team members for viewing and analysis
- View Details: Click the **View Details** icon to display the corresponding details page
- Fold the left list: Click the **<** icon to fold the left list and view the session replay

At the bottom of the player, you can:

- Skip inactive: it is turned on by default, and when it is turned on, it skips non-operation fragments exceeding 1 minute.
- Double-speed playback: support to select 1x, 1.5 x, 2x and 4x double-speed viewing.
- Full-screen play: Click the **Full-screen** play button to enlarge the full screen to view session playback.

![](../img/16.session_replay_9.1.png)