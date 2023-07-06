# Notes
---

## Overview

**Notes** provide users with customized records, where you can insert contents you want to display to analyze data and summarize reports in the form of real-time visual charts and texts. Meanwhile, you can share notes with all members of the workspace and keep abnormal data analysis to help trace back, locate and solve problems.

## Setup

1. After entering in **Notes**, click **Create**.<br/>
2. Edit the title and enter the text. Markdown is supported.<br/>
3. Select a chart template shown above the page to set and customize the display options.
4. When the notes are finished, click **Save** to finish creating the notes.

![](img/1.notebook_2.png)

  Note: You can add new charts above or below existing charts by clicking the slogan **+**, and you can change the display spacing between charts.

- For text input, please refer to the document [How to Write Text Documents](../others/write-text.md).
- For chart creation, please refer to the document [Visual Charts](visual-chart/index.md).

## Features

### Configuration 

In the upper right corner of the page, you can view the settings: **Save Snapshot, Export Notes JSON, Import Notes JSON, Export to PDF and Set Visibility Range**.

![](img/1.notebook_3.png)

- **Save Snapshot**: The user can save a snapshot of the current note. See the document [Snapshot](../management/snapshot.md) for more.

- **Export Notes JSON**: Users can export current notes as json files locally to support notes being restored or shared in different Guance workspaces.

- **Import Notes JSON**: Users can import template json files to notes to quickly restore the contents of the template json files.

  Note: In non-blank notes, the original notes will be overwritten after importing template JSON and cannot be restored once overwritten.

  

- **Export to PDF**: Users can export the current note as a PDF file to local.

  

- **Set Visibility Range**: Note **Creator** can customize the viewing rights of the current note, including "Public" and "Private".

  - Public: Notes that are open to all members in the space, other members' viewing and editing permissions are not affected.
  - Private: Notes that can only be viewed by the **Creator** of the **non-public** note, other members do not have viewing permissions.

  Note: **Non-public notes** that are shared as links are still not visible to non-creators.


### Time Widget

Guance supports the function of controlling the time range of charts in the current note (excluding charts with locked time ranges) via the time widge, which you can customize.

![](img/z1.png)

If you need to lock the query time range of chart data in notes, you can lock the time through the buttons of the time component in the editing mode of notes.

After the time range is locked, all charts on the note display data according to that lock time.

![](img/note01.png)

### Modify and Delete

Click the drop-down button at the bottom right corner of one certain note and then you can select **Modify** or **Delete** the note.

Note: Only the space owner, administrator and note creator can delete notes, other workspace members can view but not delete.

![](img/notebook001.png)

### Filter

You can search by keyword and sort notes by time at the top of your notes; On the left side of notes, you can quickly filter and find the corresponding notes through **Favorites, Creations and Just me**.

- **Favorites**: the current user's favorite notes, click the favorite icon at the bottom right corner of the note.
- **Creations**: all notes created by the current user.
- **Just me**: only the creator of the note can view **non-public notes**, other members do not have viewing permissions.

![](img/notebook.png)




