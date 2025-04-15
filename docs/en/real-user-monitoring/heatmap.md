# Heatmap
---

A heatmap is a data visualization tool that intuitively displays user interactions on a web page using color gradients, such as clicks and scrolling. This color coding helps frontend engineers quickly identify elements users focus on and areas that may need optimization. For example, high-frequency areas on the click heatmap might indicate strong user demand for specific features, guiding engineers to highlight interfaces or enhance functionalities.

At the same time, heatmaps can reveal frustration points users may encounter while searching for information or features, helping engineers discover and resolve these obstacles, improving the usability and satisfaction of the user interface. Heatmaps provide engineers with direct feedback based on user behavior, enabling them to make more precise design decisions and optimize user experience.

## Viewing Heatmaps

1. Navigate to User Analysis > Session Heatmap;
2. Select [Application](./index.md#create);
3. Confirm the page address, such as the current page `/rum/heatmapindex`;
4. Click confirm to enter the details page of the successfully created heatmap.

## Heatmap Details


### Click Heatmap

On the heatmap page, <<< custom_key.brand_name >>> defaults to opening the **Click Heatmap** type on the right side. Under this type, you can view statistical data for different metrics on the current page as well as the top 100 events by number of page operations.

<img src="../img/click.png" width="70%" >

Hover over the left heatmap page, clicking on a color block allows you to directly view the number of clicks and the percentage in that area. You can open the details page of the operation on the right side by viewing more analysis, or copy the operation name of the area directly to search in the Action Explorer; or directly open the operation in the Action Explorer to view more details.

<img src="../img/click-1.png" width="70%" >

#### Statistics

| Statistical Dimension | Description |
| --- | --- |
| Total Clicks | The total number of clicks made by users on the current page. |
| Angry Clicks | The number of repeated clicks in a short period of time at one location. |
| Average Time Spent on Page | The average time users spend on this page. |
| Session End Ratio | The percentage of users who end their session on the current page. |
| Page Errors | The number of errors that occurred on the current page. |

#### Top 100 Operations {#100}

Based on operation events, <<< custom_key.brand_name >>> will count the number of clicks and percentages for this operation, defaulting to listing from highest to lowest.

On the left side of the event, two icons will appear:

- :material-target:：Positioning: i.e., when clicked, it scrolls the page to display the hotspot in the background image on the left;
- :material-eye-off:：Invisible: The hotspot of this operation is not within the current background image.

Clicking on an event allows you to enter the operation details page. <<< custom_key.brand_name >>> will visualize the operation data of the current operation event for you using a time-series distribution chart. It also performs statistical analysis from three dimensions: most popular operations, number of clicking users, and number of clicks. The latest 10 session replays related to this operation are also displayed (including time, duration, username, browser, etc.).

<img src="../img/top-100.png" width="70%" >

To view more detailed information, click the :fontawesome-solid-arrow-up-right-from-square: on the right side of the event to jump to the explorer and open it.

<img src="../img/top-100-jump.png" width="70%" >


### Element Analysis

Under this type, <<< custom_key.brand_name >>> will display the top 10 elements by number of clicks. When hovering over a row in the list on the right side, the heatmap on the left will highlight the corresponding position.

![](img/elments.png)

Clicking on an event allows you to enter the operation details page. Refer to [here](#100) for page details.

### Page Management

Besides the different page displays under the two main types of heatmaps mentioned above, you can manage the heatmap details page through the following actions:

:material-numeric-1-circle-outline: On the current heatmap, you can use the [Time Widget](../getting-started/function-details/explorer-search.md#time) to view heatmap data across different time spans;

:material-numeric-2-circle-outline: At the top of the page, filter based on different metric dimensions, including environment, version, service, city, etc. Hovering over a filtering dimension allows you to delete it by clicking, or click **More** to adopt new filtering dimensions as needed.

<img src="../img/filter.png" width="70%" >

:material-numeric-3-circle-outline: Set screen width, with four options available as needed:

- Screen width greater than 1280 px;
- Screen width between 768px and 1280 px;
- Screen width less than 768px;
- Custom screen width, input `min` and `max` values, then click confirm.

<img src="../img/size.png" width="70%" >

#### Switch Heatmaps

To view heatmap data for other pages, simply click the dropdown box as shown in the figure:

<img src="../img/switch.png" width="70%" >

To switch **Applications**, click the dropdown box, <<< custom_key.brand_name >>> will display the top 5 most popular page views for the application (based on page visit counts), then select a page as needed:

<img src="../img/switch-1.png" width="70%" >

When switching applications, if the page cannot find session replay data used to generate the heatmap, it will be unable to display the heatmap page for you. You can try the following methods:

1. Check if the heatmap code snippet has been added to the RUM SDK;
2. Check if your application's user visits and session replay data are being collected normally;
3. Adjust the filtering conditions and expand the query time range.

You can go directly to the application management or jump to the details page to check if there is session data.


## Save Heatmap

You can save the current heatmap page, and any added filtering conditions will be saved synchronously. Saved pages will be added to the homepage for quick queries, and later you can perform operations like sharing, copying links, or deleting the saved pages.

<img src="../img/save.png" width="70%" >

Saved pages will be uniformly displayed in the heatmap list:

<img src="../img/save-1.png" width="70%" >

For already saved heatmaps, you can:

:material-numeric-1-circle-outline: Share the current heatmap as a snapshot externally, [the steps are the same as for snapshots](../getting-started/function-details/share-snapshot.md).

Shared heatmaps can be viewed in Management > Share Management > Shared Snapshots:

<img src="../img/save-2.png" width="70%" >

???+ warning "Note"

    In the shared heatmap snapshot page:

    - Shared heatmap snapshots cannot be saved again;
    - Application switching is not supported;
    - Opening in the Explorer is not supported;
    - Clicking session replays is not supported.

:material-numeric-2-circle-outline: Directly copy the heatmap link

:material-numeric-3-circle-outline: Delete the heatmap

## Change Page Screenshot

Considering that a page may contain other embedded pages, and you want to view other heatmaps under the same `view_name`, you can click to change the page screenshot. <<< custom_key.brand_name >>> will automatically capture a screenshot from user session replays as the heatmap background, allowing you to choose among multiple page screenshots.

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