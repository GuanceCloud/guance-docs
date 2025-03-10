# Web Session Replay

---

## Integration

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; Enable Session Replay</font>](./replay.md)

</div>


## View Session Replay {#view_replay}

After configuring session replay, you can view session replays in the RUM PV Session Explorer list and on all RUM PV Explorer detail pages.

**Note**: The data retention policy for Session Replay aligns with that of RUM. If RUM data is retained for 3 days, Session Replay data is also retained for 3 days. If the RUM data retention policy is changed, the retention period for Session Replay will be adjusted accordingly.

### Viewing in the Session Explorer List

In the Session Explorer list, a **Play** button is displayed. Click it to view the session replay.

![](../../img/16.session_replay_1.png)

### Viewing in Detail Pages {#view_replay_in_rum_detail}

- In the Session, View, Error Explorer detail pages, click the **View Replay** button in the top-right corner to view the current user session's operation replay.
- In the **Source** section of the View, Error, Resource, Action, Long Task Explorer detail pages, you can view the current user session's operation replay.
    - More: Click the **More** button to support **View Session Details**, **Filter Current Session ID**, and **Copy Session ID**
    - Play: Click the **Play** button to view the session replay

![](../../img/16.session_replay_8.png)

## View Session Replay Effects {#view_display_effect_of_replay}

On the session replay page, you can view the entire process of a user session, including visited pages, operation records, and error data. Click to play back the user's operation process.

On the left panel, you can:

- Share Link: Click :octicons-share-android-16: to copy the share link and share it with other team members for viewing and analysis;
- View Details: Click :material-text-search: to slide open the corresponding details page;
- Collapse Left Panel: Click :fontawesome-solid-angle-left: to collapse the left panel and view the session replay.

At the bottom of the player, you can:

- Skip Inactive: Enabled by default, this skips segments where no action occurred for over 1 minute;
- Playback Speed: Choose from 1x, 1.5x, 2x, 4x speeds for viewing;
- Full Screen Playback: Click the full screen playback button to view the session replay in full screen.

![](../../img/16.session_replay_9.1.png)