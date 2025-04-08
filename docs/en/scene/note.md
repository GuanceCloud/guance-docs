# Notes
---


The Notes module allows you to create multiple notes for summary reports and supports real-time insertion of visual charts for data analysis. By combining charts and documents, you can conduct in-depth data analysis and summary reporting. Notes can be shared with all members of the workspace, preserving anomaly data analysis, which is helpful for tracing, locating, and solving problems.

## Create

1. Click **Create Note**;
2. Define the note title;
3. Select text or charts as needed to edit the note content;
4. Click **Finish Editing**, and the creation will be completed.


> For text input, refer to [How to Write Text Documents](../others/write-text.md);
> 
> For chart creation, refer to [Visual Charts](visual-chart/index.md).



## Manage Notes


### Note Page Settings

After adding a note, click the :octicons-gear-24: button at the top of the page to perform the following operations on the note:


- Create the current note content [as an Issue](../exception/issue.md#dashboards);

- Save Snapshot: Save the current note as a [Snapshot](../getting-started/function-details/snapshot.md);

- Export Note JSON: Export the current note as a JSON file to your local system to support restoration or sharing of the note in different workspaces;

- Import Note JSON: Import a template JSON file;

- Export as PDF: Export the current note as a PDF file to your local system;

- Set Visibility Scope: Set the viewing permissions for the note;

    - Public: Open to all members within the workspace; other members' viewing and editing permissions remain unaffected;
    - Only Visible to Me: Only the note creator can view it; other members do not have viewing permissions.

???+ warning "Note"

    - Non-public notes shared via link are still invisible to non-creators;
    - In non-blank notes, importing a template JSON will overwrite the original note, and once overwritten, it cannot be recovered.

### Note List Options


- Edit/Delete: Click the dropdown button at the bottom right corner of the note to choose edit or delete;

- Search/Filter: Supports searching by keywords and sorting by modification time, as well as filtering quickly using the options on the left side.

    - My Favorites: Notes favorited by the current user; click the favorite icon at the bottom right corner of the note;
    - My Creations: All notes created by the current user;
    - Only Visible to Me: Non-public notes that only the note creator can view; other members do not have viewing permissions.