# Notes
---

## Overview

Under the scene, you can create multiple notes for summary report, support inserting real-time visual charts for data analysis, support inserting text documents for description, combine charts and documents for data analysis and summary report; support sharing notes with all members of the workspace and retaining abnormal data analysis to help retrace, locate and solve problems.

## New Notes 

After entering the scene, in 「Notes」, click 「+New Note」.

![](img/notebook.png)

Enter note titles, enter text using text charts, visual data analysis using other charts to display metrics, support for viewing help files while editing notes, support for copying, deleting, and editing text and visual chart components.

- For text input, please refer to the document [How to write text documents](../others/write-text.md).
- For chart creation, please refer to the document [visual-chart](visual-chart/index.md).

![](img/1.notebook_1.png)

When the notes are finished, click "Save Notes" to finish creating the notes.

![](img/1.notebook_2.png)

## Notes Configuration 

In the navigation bar 「Settings」, notes support 「Save Snapshot」, 「Export Notes JSON」, 「Import Notes JSON」, 「Export to PDF」 and 「Set Visibility Range」.

![](img/1.notebook_3.png)

- Save Snapshot: The user can save a snapshot of the current note, for more information see the document [Snapshot](../management/snapshot.md).

- Export notes JSON: Users can export current notes as "json files" locally to support notes being restored or shared in different Guance Cloud spaces.

- Import notes JSON: Users can import "template json files" to notes to quickly restore the contents of the "template json files".

  Note: In non-blank notes, after importing template JSON, the original notes will be overwritten and cannot be restored once overwritten.

  

- Export to PDF: Users can export the current note as a "pdf file" to local

  

- Set visibility range: Note "creator" can customize the viewing rights of the current note, including "public" and "only visible to you".

  - Public: Notes that are open to all members in the space, other members' viewing and editing permissions are not affected.
  - Visible only: Notes that can only be viewed by the "creator" of the note **Non-public**, other members do not have viewing privileges.

  Note: **Non-public notes** that are shared as links are still not visible to non-creators.

  

## Modify deleted notes

Click the drop-down button at the bottom right corner of the note and select 「Modify」or 「Delete」 to modify or delete the note.

Note: Only the space owner, administrator and note creator can delete notes, other workspace members can view but not delete.

![](img/notebook001.png)

## Time Range

"The Guance Cloud supports controlling the time range of charts in the current note (excluding charts with locked time ranges) via the time component, which you can customize.

![](img/z1.png)

Edit mode supports modifying the configured time to display the global lock time. After the global lock time is configured, all charts on that note page display data according to that lock time.

![](img/note01.png)

## Filter Notes

At the top of the notes, you can search by keywords and sort notes by time; on the left side of the notes, you can use "My Favorites", "My Created" and "Only visible to you" to Quickly filter and find the corresponding notes.

- My favorites: the current user's favorite notes, click the favorite icon at the bottom right corner of the note.
- My Created: all notes created by the current user.
- Visible only to you: only the "creator" of the note can view **non-public notes**, other members do not have viewing rights.

![](img/notebook.png)

