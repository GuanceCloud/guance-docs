# Heatmap
---

A heatmap is a data visualization tool that intuitively displays user interactions on web pages, such as clicks and scrolls, using color gradients. This color coding helps frontend engineers quickly identify elements of interest to users and areas that may need optimization. For example, high-frequency areas on the heatmap might indicate a strong demand for specific features, guiding engineers to highlight or enhance these functionalities.

Additionally, heatmaps can reveal frustration points users encounter while searching for information or features, helping engineers discover and resolve these obstacles, improving the usability and satisfaction of the user interface. Heatmaps provide direct feedback based on user behavior, enabling engineers to make more precise design decisions and optimize user experience.

## Viewing Heatmaps

1. Navigate to User Analysis > Session Heatmap;
2. Select [Application](./index.md#create);
3. Confirm the page address, such as the current page `/rum/heatmapindex`;
4. Click Confirm to enter the detailed page of the successfully created heatmap.

## Heatmap Details


### Click Heatmap

On the heatmap page, Guance defaults to opening the **Click Heatmap** type on the right side. Under this type, you can view statistics for different metrics on the current page and the top 100 events by click frequency.

<img src="../img/click.png" width="70%" >

Hover over the left heatmap area, click on a color block to directly view the number of clicks and the percentage in that region. You can click to view more analysis and open the detailed page for the action on the right, or copy the action name and search in the Action Explorer; or directly open the action in the Action Explorer to view more details.

<img src="../img/click-1.png" width="70%" >

#### Statistics

| Statistical Dimension | Description |
| --- | --- |
| Total Clicks | The total number of clicks by users on the current page. |
| Rage Clicks | The number of repeated clicks in a short time on one spot. |
| Average Time Spent | The average time users spend on this page. |
| Session End Ratio | The percentage of users who end their session on the current page. |
| Page Errors | The number of errors that occurred on the current page. |

#### Top 100 Actions {#100}

Based on action events, Guance will tally the click counts and percentages for each action, listing them from highest to lowest by default.

On the left side of the event, two icons appear:

- :material-target:：Locate: Clicking this icon scrolls the page to show the corresponding hot zone in the background image;
- :material-eye-off:：Invisible: The action hot zone is not visible in the current background image.

Clicking an event takes you to the action detail page. Guance visualizes the operation data of the current action event with a time series distribution chart. It also analyzes the most popular actions, the number of clicking users, and the click count across three dimensions. The last 10 related session replays are displayed together (including time, duration, username, browser, etc.).

<img src="../img/top-100.png" width="70%" >

To view more detailed information, click the arrow icon :fontawesome-solid-arrow-up-right-from-square: on the right side of the event to open the explorer.

<img src="../img/top-100-jump.png" width="70%" >


### Element Analysis

Under this type, Guance displays the top 10 elements by click count. When hovering over a row in the right-side list, the heatmap on the left highlights the corresponding position.

![](img/elments.png)

Clicking an event takes you to the action detail page. Refer to [this section](#100) for page details.

### Page Management

Besides managing different page displays under the two main heatmap types, you can perform the following operations on the heatmap detail page:

:material-numeric-1-circle-outline: Use the [time control](../getting-started/function-details/explorer-search.md#time) to view heatmap data across different time spans;

:material-numeric-2-circle-outline: At the top of the page, filter by different metric dimensions including environment, version, service, city, etc. Hover over a filter dimension to delete it or click **More** to add new filter dimensions as needed.

<img src="../img/filter.png" width="70%" >

:material-numeric-3-circle-outline: Set screen width options, including four presets, choose as needed:

- Screen width greater than 1280 px;
- Screen width between 768px and 1280 px;
- Screen width less than 768px;
- Custom screen width, input `min` and `max` values, then click Confirm.

<img src="../img/size.png" width="70%" >

#### Switch Heatmap

To view heatmap data for other pages, simply click the dropdown box below the chart:

<img src="../img/switch.png" width="70%" >

To switch **Applications**, click the dropdown box. Guance will display the top 5 most visited page views (based on page visit frequency), then select a page as needed:

<img src="../img/switch-1.png" width="70%" >

When switching applications, if no session replay data is available to generate the heatmap for the page, the heatmap page will not be displayed. Try the following methods:

1. Check if the heatmap code snippet has been added to the RUM SDK;
2. Verify that your application's user visits and session replay data are being collected properly;
3. Adjust the filtering conditions and expand the query time range.

You can directly navigate to application management or check the session data details page from the page.

## Saving Heatmaps

You can save the current heatmap page, and any applied filters will be saved together. Saved pages will be added to the homepage for quick access, allowing you to share, copy links, delete, etc., later.

<img src="../img/save.png" width="70%" >

Saved pages are displayed uniformly in the heatmap list:

<img src="../img/save-1.png" width="70%" >

For saved heatmaps, you can:

:material-numeric-1-circle-outline: Share the current heatmap as a snapshot externally, [follow the same steps as snapshots](../getting-started/function-details/snapshot.md#share).

Shared heatmaps can be viewed under Management > Sharing Management > Shared Snapshots:

<img src="../img/save-2.png" width="70%" >

???+ warning "Note: In the shared heatmap snapshot page"

    1. Shared heatmap snapshots cannot be saved again;
    2. Application switching is not supported;
    3. Opening in the Explorer is not supported;
    4. Clicking session replays is not supported.

:material-numeric-2-circle-outline: Directly copy the heatmap link

:material-numeric-3-circle-outline: Delete the heatmap

## Changing Page Screenshots

Considering that a page may contain other embedded pages, and you want to view other heatmaps under the same `view_name`, you can click Change Page Screenshot. Guance will automatically capture a screenshot from user session replays to use as the heatmap background, allowing you to choose from multiple page screenshots.

<img src="../img/change.png" width="70%" >


## Further Reading

<font size=2>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **What is Session Replay?**</font>](./session-replay/index.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **How to Integrate Session Replay?**</font>](./session-replay/web/replay.md)

</div>



<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Action Explorer**</font>](./explorer/action.md)

</div>


<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **Snapshots to Enhance Collaboration Efficiency**</font>](../getting-started/function-details/snapshot.md)

</div>

<div class="grid cards" markdown>

- [<font color="coral"> :fontawesome-solid-arrow-right-long: &nbsp; **How Does Session Replay Ensure Your Data Security?**</font>](../security/index.md#session-replay)


</div>

</font>