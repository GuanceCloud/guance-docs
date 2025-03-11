# Heatmap
---

A heatmap is a data visualization tool that intuitively displays user interactions on web pages, such as clicks and scrolls, using color gradients. This color coding helps front-end engineers quickly identify elements of interest to users and areas that may need optimization. For example, high-frequency regions on the heatmap might indicate a strong demand for specific features, guiding engineers to highlight or enhance these features.

At the same time, heatmaps can reveal frustration points users encounter while searching for information or functionality, helping engineers discover and resolve these obstacles, thereby improving the usability and satisfaction of the user interface. Heatmaps provide direct feedback based on user behavior, enabling engineers to make more precise design decisions and optimize the user experience.

## Viewing Heatmaps

1. Navigate to User Analysis > Session Heatmap;
2. Select [Application](./index.md#create);
3. Confirm the page URL, such as the current page `/rum/heatmapindex`;
4. Click confirm to enter the details page of the successfully created heatmap.

## Heatmap Details


### Click Heatmap

On the heatmap page, <<< custom_key.brand_name >>> defaults to opening the **Click Heatmap** type on the right side. Under this type, you can view statistics for different metrics on the current page and the top 100 events by page operation count.

<img src="../img/click.png" width="70%" >

Hover over the left heatmap page, click on a color block to directly view the number of clicks and percentage in that area. You can click to see more analysis and open the detailed page of the action on the right, or copy the action name to search in the Action Explorer; or directly open the action in the Action Explorer to view more details.

<img src="../img/click-1.png" width="70%" >

#### Statistics

| Statistical Dimension | Description |
| --- | --- |
| Total Clicks | The total number of clicks by users on the current page. |
| Rage Clicks | The number of times users repeatedly click in one place within a short period. |
| Average Time Spent on Page | The average time users spend on this page. |
| Session End Percentage | The percentage of users who end their session on the current page. |
| Page Error Count | The number of errors that occur on the current page. |

#### Top 100 Operations {#100}

Based on operational events, <<< custom_key.brand_name >>> will tally the number of clicks and percentages for each operation, defaulting to a descending order.

On the left side of an event, two icons will appear:

- :material-target:：Positioning: Clicking this icon will scroll the page to display the corresponding hot zone in the background image;
- :material-eye-off:：Invisible: This indicates that the operation's hot zone is not within the current background image.

Clicking on an event will take you to the operation details page. <<< custom_key.brand_name >>> will visualize the operation data for the current event using a time series distribution chart. It also provides statistical analysis from three dimensions: most popular operations, number of clicking users, and click counts. The last 10 related session replays are displayed (including time, duration, username, browser, etc.).

<img src="../img/top-100.png" width="70%" >

To view more detailed information, click the :fontawesome-solid-arrow-up-right-from-square: icon on the right side of the event to navigate to the explorer.

<img src="../img/top-100-jump.png" width="70%" >


### Element Analysis

Under this type, <<< custom_key.brand_name >>> will display the top 10 elements by click count. When hovering over a row in the right-side list, the left heatmap will highlight the corresponding position.

![](img/elments.png)

Clicking on an event will take you to the operation details page. Refer to [here](#100) for page details.

### Page Management

In addition to the different page displays under the two main types of heatmaps, you can manage the heatmap detail page with the following operations:

:material-numeric-1-circle-outline: On the current heatmap, you can use the [Time Widget](../getting-started/function-details/explorer-search.md#time) to view heatmap data across different time spans;

:material-numeric-2-circle-outline: At the top of the page, filter based on different metric dimensions including environment, version, service, city, etc. Hovering over a filter dimension allows you to delete it or add new filtering criteria by clicking **More**. Use as needed.

<img src="../img/filter.png" width="70%" >

:material-numeric-3-circle-outline: Set screen width, with four options available:

- Screen width greater than 1280 px;
- Screen width between 768px and 1280 px;
- Screen width less than 768px;
- Custom screen width, enter `min` and `max` values, then click confirm.

<img src="../img/size.png" width="70%" >

#### Switch Heatmap

To view heatmap data for other pages, simply click the dropdown box below the chart:

<img src="../img/switch.png" width="70%" >

To switch **Applications**, click the dropdown box. <<< custom_key.brand_name >>> will display the top 5 most visited page views (based on page visit frequency), then select a page as needed:

<img src="../img/switch-1.png" width="70%" >

When switching applications, if the session replay data required to generate the heatmap cannot be found, the heatmap page may not be displayed. You can try the following solutions:

1. Check if the heatmap code snippet has been added to the RUM SDK;
2. Verify that user visits and session replay data for your application are being collected correctly;
3. Adjust the filtering conditions to expand the query time range.

You can directly navigate to application management or jump to the page to check if there is any session data.

## Save Heatmap

You can save the current heatmap page, and any applied filters will be saved as well. Saved pages will be added to the homepage for quick access, allowing you to share, copy links, or delete them later.

<img src="../img/save.png" width="70%" >

Saved pages are displayed uniformly in the heatmap list:

<img src="../img/save-1.png" width="70%" >

For saved heatmaps, you can:

:material-numeric-1-circle-outline: Share the current heatmap as a snapshot externally, [follow the same steps as for snapshots](../getting-started/function-details/snapshot.md#share).

Shared heatmaps can be viewed in Manage > Share Management > Shared Snapshots:

<img src="../img/save-2.png" width="70%" >

???+ warning "Note: In the shared heatmap snapshot page"

    1. Shared heatmap snapshots cannot be resaved;
    2. Application switching is not supported;
    3. Opening in the explorer is not supported;
    4. Clicking session replays is not supported.

:material-numeric-2-circle-outline: Directly copy the heatmap link

:material-numeric-3-circle-outline: Delete the heatmap

## Change Page Screenshot

Considering that a page may contain embedded pages and you want to view other heatmaps under the same `view_name`, you can click to change the page screenshot. <<< custom_key.brand_name >>> will automatically capture screenshots from user session replays as the heatmap background, allowing you to choose among multiple page screenshots.

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