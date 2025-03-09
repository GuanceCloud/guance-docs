# Notes
---

In specific scenarios, multiple notes can be created for summary reports, supporting real-time insertion of visual charts for data analysis and text documents for explanations. Combining charts and documents allows for comprehensive data analysis and reporting. Additionally, notes can be shared with all members of the workspace, preserving anomaly data analysis which aids in tracing, locating, and solving problems.

## Create a Note

After entering the scene, under **Notes**, click **Create**.

![](img/9.note_8.png)

Enter the note title, choose to input text or select other chart components to display visualized data analysis of metrics.

> For text input, refer to [How to Write Text Documents](../others/write-text.md);
>
> For chart creation, refer to [Visual Charts](visual-chart/index.md).

![](img/9.note_1.png)

Once completed, click **Finish Editing** to complete the creation.

## Options

### Lock Time Range

By default, <<< custom_key.brand_name >>> supports controlling the time range of charts (excluding locked time range charts) in the current note via the time component, allowing you to customize the time range.

> For more details, refer to the documentation [Time Widget Explanation](../getting-started/function-details/explorer-search.md#time).

![](img/9.note_4.png)

If you need to lock the query time range for chart data in the note, while in edit mode, use the ![](img/9.note_10.png) button in the time component to lock the time.

![](img/9.note_6.png)

After locking the time range, complete the editing; all charts on the note page will display data according to the locked time.

![](img/9.note_7.png)

### Settings

After adding a note, click the **Settings** button in the navigation bar to perform the following operations:

![](img/9.note_3.png)

- You can create an Issue from the current note content.
  
    > For more related operations, refer to [How to Manually Create an Issue at the View Level](../exception/issue.md#dashboards). For more information about Issues, refer to [Incident](../exception/index.md).

- Save Snapshot: Users can save a [snapshot](../getting-started/function-details/snapshot.md) of the current note;

- Export Note JSON: Users can export the current note as a "JSON file" to their local machine to support restoration or sharing of the note in different <<< custom_key.brand_name >>> workspaces;

- Import Note JSON: Users can import a "template JSON file" into the note to quickly restore the content of the "template JSON file";
  
    **Note**: In non-blank notes, importing a template JSON will overwrite existing notes, and once overwritten, it cannot be restored.

- Export as PDF: Users can export the current note as a "PDF file" to their local machine;

- Set Visibility Scope: The note creator can customize the viewing permissions of the current note, including **Public** and **Only Visible to Me**.

    - Public: Notes open to all members within the workspace, with no restrictions on viewing and editing permissions for other members;
    - Only Visible to Me: **Non-public notes** that only the note creator can view, other members do not have viewing permissions.

    **Note**: Non-public notes shared via links are still invisible to non-creators.

### Modify/Delete/Search/Filter

![](img/9.note_9.png)

- Click the drop-down button in the lower right corner of the note and select **Modify** or **Delete** to modify or delete the note.

    **Note**: Only workspace owners, administrators, and note creators can delete notes; other workspace members can view but not delete them.

- At the top of the notes, you can search by keyword and sort notes by time; on the left side of the notes, you can filter and find corresponding notes quickly through **My Favorites**, **Created by Me**, and **Only Visible to Me**.

    - My Favorites: Notes favorited by the current user; click the favorite icon in the lower right corner of the note;
    - Created by Me: All notes created by the current user;
    - Only Visible to Me: **Non-public notes** that only the note creator can view, other members do not have viewing permissions.