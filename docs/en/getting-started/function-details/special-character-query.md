# Special Character Escape Query
---

## Explorer

In the Explorer, certain characters have special meanings. For example, `space` is used to separate multiple words. Therefore, if the search content contains any of the following characters, special handling is required: `space` `:` `"` `“` `\` `(` `)` `[` `]` `{` `}` `!`

Since the query syntax for searching and filtering differs, the handling of special characters also varies:
- Search: Uses the [query_string()](../../dql/funcs.md#query_string) query syntax
- Filter: Supports multiple [operators](explorer-search.md#operator), including `=` `!=` `wildcard`, etc.

**The Explorer handles special characters in the following two ways**

### Method One: Convert Text into a Phrase

???+ warning 

    - Enclose the text in double quotes (`"`), which converts it into a phrase.
    - In this format, the content within double quotes is treated as a single unit for matching searches, and wildcards do not take effect;
    - If the text contains `\` or `"`, this method will not work for retrieval; please use "Method Two" for queries.

For example, searching the field name `cmdline` with the field value `nginx: worker process`:

- Search

```
"nginx: worker process"   // Successful retrieval, exact match
```

```
"nginx * process"   // Failed retrieval, because * inside double quotes is not treated as a wildcard
```

- Filter

```
cmdline:"nginx: worker process"   // Successful retrieval, exact match
```

```
cmdline:"nginx: worker*"  // Failed retrieval, because * inside double quotes is not treated as a wildcard
```
![](character-filter1.png)
![](character-search1.png)

### Method Two: Escape Characters

???+ warning 
  
    - Add a backslash (`\`) before special characters.
    - If the search text itself contains `\`, the handling differs between search and filter: for search, add three more backslashes (`\`) before the character to escape it; for filter, only one backslash (`\`) is needed.

For example, searching the field name `cmdline` with the field value `E:\software_installer\vm\vmware-authd.exe`:

- Search

```
E\:\\\\software_installer\\\\vm\\\\vmware-authd.exe     // Successful retrieval, exact match
```

```
E\:\\\\software_installer*exe     // Successful retrieval, wildcard fuzzy match
```

- Filter

```
cmdline:E\:\\software_installer\\vm\\vmware-authd.exe    // Successful retrieval, exact match
```

```
cmdline:E\:\\software_installer*exe    // Successful retrieval, wildcard fuzzy match
```
![](character-filter2.png)
![](character-search2.png)

## DQL Query

When querying data using DQL in the platform, special characters need to be handled, especially for features like chart queries, query tools, metrics analysis, monitors, etc.

## Filter (wildcard)

Since the backslash (`\`) has a special meaning in wildcard syntax, it needs to be escaped. If the search text contains a `\`, add another `\` before it for escape querying.

If using other operators (such as `=` `!=`), no escaping is required.

## Search (query_string)

In the query_string syntax, both `\` and `"` have special meanings and need to be escaped:

- `\` : Add three backslashes (`\`) before it to escape.
- `"` : Add one backslash (`\`) before it to escape.