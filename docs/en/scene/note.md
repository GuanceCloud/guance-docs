# Notes
---


Multiple notes can be created for summarizing reports and real-time insertion of visual charts for data analysis, along with the insertion of text documents for explanations. By combining charts and documents, data analysis and summary reports can be conducted. Additionally, the notes can be shared with all members of the workspace, preserving the analysis of abnormal data and facilitating the process of tracing, locating and resolving issues.

## Setup

1. After entering in **Notes**, click **Create**.<br/>
2. Edit the title and enter the text. Markdown is supported.<br/>
3. Select a chart template shown above the page to set and customize the display options.
4. When the notes are finished, click **Done** to finish creating the notes.

![](img/1.notebook_2.png)


> For chart creation, see [Visual Charts](visual-chart/index.md).

## Features

### Lock the Time Range

By default, Guance allows you to control the time range of the charts in the current note (excluding charts with a locked time range) through the time component. You can customize the time range.

> For more details, see [Time Widget](../getting-started/function-details/explorer-search.md#time).

![](img/9.note_6.png)

If you need to lock the query time range of the charts in a note, you can lock the time by clicking the button :fontawesome-solid-play: in the time component when in edit mode for the note.


Once the time range is locked, finish editing, and all charts on the note page will display data according to the locked time.

![](img/9.note_7.png)

### Settings 

After adding the note, click the button :fontawesome-solid-gear: to perform the following operations on the note:

<img src="../img/1.notebook_3.png" width="70%" >

- New Issue: You can create the current note content as an Issue.

    > For more related operations, see [How to manually create an Issue at the view level](../exception/issue.md#dashboards). For more information about Issues, see [Incidents](../exception/index.md).

- Save [Snapshot](../management/snapshot.md): The user can save a snapshot of the current note.

- Export Note JSON: Users can export current notes as json files locally to support notes being restored or shared in different Guance workspaces.

- Import Note JSON: Users can import template json files to notes to quickly restore the contents of the template json files.

    **Note**: In non-blank notes, the original notes will be overwritten after importing template JSON and cannot be restored once overwritten.

  
- Export PDF: Users can export the current note as a PDF file to local.


- Set Visibility Range: Note Creator can customize the viewing rights of the current note, including "Public" and "Private".

    - Public: Notes that are open to all members in the space, other members' viewing and editing permissions are not affected.
    
    - Private: Notes that can only be viewed by the **Creator** of the **non-public** note, other members do not have viewing permissions.

    **Note**: Non-public notes that are shared as links are still not visible to non-creators.

<!--
### Time Widget

Guance supports the function of controlling the time range of charts in the current note (excluding charts with locked time ranges) via the time widge, which you can customize.

![](img/z1.png)

If you need to lock the query time range of chart data in notes, you can lock the time through the buttons of the time component in the editing mode of notes.

After the time range is locked, all charts on the note display data according to that lock time.

![](img/note01.png)

-->

### Modify / Delete / Filter

![](img/notebook.png)


- Click the drop-down button at the bottom right corner of one certain note and then you can select **Modify** or **Delete** the note.

    **Note**: Only the workspace Owner, Administrator and note creator can delete notes; other workspace members can view but not delete.


- You can search by keyword and sort notes by time at the top of your notes; On the left side of notes, you can quickly filter and find the corresponding notes through Favorites, Creations and Just me.

    - **Favorites**: the current user's favorite notes, click the favorite icon at the bottom right corner of the note.
    - **Creations**: all notes created by the current user.
    - **Just me**: only the creator of the note can view **non-public notes**, other members do not have viewing permissions.





