# Special Character Escaping Query
---

## Explorer

In the Explorer, certain characters have special meanings. For example, `space` is used to separate multiple words. Therefore, if the search content contains the following characters, special handling is required: `space` `:` `"` `“` `\` `(` `)` `[` `]` `{` `}` `!`

Since the query syntax for search and filtering differs, the handling of special characters also varies:
- Search: Uses the [query_string()](../../dql/funcs.md#query_string) query syntax
- Filtering: Supports multiple [operators](explorer-search.md#operator), including `=` `!=` `wildcard`, etc.

**The Explorer handles special characters in the following two ways**

### Method One: Convert Text to a Phrase

???+ warning 

    - Enclose the text in double quotes (`"`), which converts the text into a phrase.
    - Under this format, the content within double quotes is treated as a single unit for matching searches; wildcards will not work.
    - If the text contains `\` or `"`, this method will not retrieve results; please use "Method Two" for queries.

Example: Searching the field name `cmdline`, with the field value `nginx: worker process`

- Search

```
"nginx: worker process"   // Successful retrieval, precise word match
```

```
"nginx * process"   // Failed retrieval, because * inside double quotes is not treated as a wildcard
```

- Filter

```
cmdline:"nginx: worker process"   // Successful retrieval, precise word match
```

```
cmdline:"nginx: worker*"  // Failed retrieval, because * inside double quotes is not treated as a wildcard
```
![](character-filter1.png)
![](character-search1.png)

### Method Two: Escape Characters

???+ warning 
  
    - Add a backslash (`\`) before special characters.
    - If the search text itself contains `\`, the handling differs between search and filter: for search, add three additional backslashes (`\`) before the character; for filter, only one backslash (`\`) is needed.

Example: Searching the field name `cmdline`, with the field value `E:\software_installer\vm\vmware-authd.exe`

- Search

```
E\:\\\\software_installer\\\\vm\\\\vmware-authd.exe     // Successful retrieval, precise word match
```

```
E\:\\\\software_installer*exe     // Successful retrieval, wildcard fuzzy match
```

- Filter

```
cmdline:E\:\\software_installer\\vm\\vmware-authd.exe    // Successful retrieval, precise word match
```

```
cmdline:E\:\\software_installer*exe    // Successful retrieval, wildcard fuzzy match
```
![](character-filter2.png)
![](character-search2.png)

## DQL Query

When querying data using DQL in the platform, special characters need to be handled, involving features such as: chart queries, query tools, metrics analysis, monitors, etc.

## Filtering (wildcard)

Since the backslash (`\`) has a special meaning in wildcard syntax, it needs to be escaped. If the search text contains `\`, add another backslash (`\`) for escaping.

If using other operators (such as `=`, `!=`, etc.), no escaping is required.

## Search (query_string)

In query_string syntax, both backslashes (`\`) and double quotes (`"`) have special meanings and need to be escaped:

- `\`: Add three additional backslashes (`\`) before it for escaping.
- `"`: Add one backslash (`\`) before it for escaping.