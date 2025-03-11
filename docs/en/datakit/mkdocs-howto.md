# MkDocs Documentation Writing
---

This document primarily addresses the following issues:

- Steps for writing Datakit-related documentation
- How to write better documentation using MkDocs

## DataKit Writing Steps {#steps}

The steps for writing new documentation are as follows:

1. Add documents under *man/docs/en*; if it is a collector document, add it to the *man/docs/en/inputs* directory.
1. Document writing
1. If necessary, add corresponding English documents under *man/docs/en*
1. Execute the *export.sh* script in the project root directory

### Local Debugging of Documents {#debug}

When executing *export.sh*, you can first check its supported command-line parameters:

```shell
./export.sh -h
```

The basic environment dependencies for *export.sh*:

1. First, clone the [documentation repository](https://gitlab.jiagouyun.com/zy-docs/dataflux-doc){:target="_blank"} to the local directory *~/git/dataflux-doc*. This local directory is used by default. *export.sh* will generate and copy the Datakit documentation to the corresponding directory in this repo.
1. In the *dataflux-doc* project, there is a *requirements.txt*. Run `pip install -r requirements.txt` to install the corresponding dependencies.
1. Return to the Datakit code directory and execute the `./export.sh` script at the root directory.

## MkDocs Tips Sharing {#mkdocs-tips}

### Marking Experimental Features {#experimental}

For newly released features that are experimental, you can add special markers in the chapter, such as:

```markdown
## This is a New Feature {#ref-to-new-feature}

[:octicons-beaker-24: Experimental](index.md#experimental)

Description of the new feature ...
```

Its effect is to add an icon below the section:

[:octicons-beaker-24: Experimental](index.md#experimental)

Clicking on this icon will redirect to the explanation of the experimental feature.

### Marking Version Information {#version}

Some new features are available only in specific versions. In such cases, version tags can be added as follows:

```markdown
## This is a New Feature {#ref-to-new-feature}

[:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)
```

If it is also an experimental feature, they can be placed together with `·` as a separator:

```markdown
## This is a New Feature {#ref-to-new-feature}

[:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) ·
[:octicons-beaker-24: Experimental](index.md#experimental)
```

Taking the changelog of DataKit 1.4.6 as an example, clicking on the corresponding icon will redirect to the release history of the version:

[:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) ·
[:octicons-beaker-24: Experimental](index.md#experimental)

### External Link Redirects {#outer-linkers}

In some documents, we need to add external links with proper handling so that they open in a new browser tab instead of leaving the current documentation library:

```markdown
[Please refer here](https://some-outer-links.com){:target="_blank"}
```

### Predefined Section Links {#set-links}

We can predefine links in the sections of the document, for example:

```markdown
// some-doc.md
## This is a New Section {#new-feature}
```

Then, in other places, we can directly reference it:

```markdown
Refer to this [New Feature](some-doc.md#new-feature)
```

If referencing within the same document, **you must include the current document name**. See the [404 Check](mkdocs-howto.md#404-check) for reasons:

```markdown
Refer to this [New Feature](current.md#new-feature)
```

For cross-document references:

```markdown
Refer to this [New Feature](../integrations/some-doc.md#new-feature) in the integration library
```

### Adding Notes in Documents {#note}

Some documents require warning information, such as additional conditions for using a feature or providing some tips. In these cases, we can use MKDocs markdown extensions, for example:

```markdown
??? attention

    This is a prerequisite description ...
```

```markdown
??? tip

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor massa, nec semper lorem quam in massa.
```

Instead of just a simple note:

```markdown
> This is a simple note ...
```

For more beautiful alerts, see [here](https://squidfunk.github.io/mkdocs-material/reference/admonitions/){:target="_blank"}

### Tab Layout {#tab}

For certain features that have different usage methods in various scenarios, listing them separately can make the document look lengthy. A better way is to organize different scenarios using tabs, making the document page very concise:

<!-- markdownlint-disable MD046 -->
=== "Usage in Scenario A"

    In scenario A ...

=== "Usage in Scenario B"

    In scenario B ...
<!-- markdownlint-enable MD046 -->

For detailed usage, see [here](https://squidfunk.github.io/mkdocs-material/reference/content-tabs/){:target="_blank"}

### Markdown Formatting and Spelling Checks {#mdlint-cspell}

To standardize the basic writing style of Markdown and ensure consistent spelling (relatively correct and uniform), Datakit's documentation includes formatting checks and spelling checks using the following tools:

- [markdownlint](https://github.com/igorshubovych/markdownlint-cli){:target="_blank"}: Checks if the basic Markdown formatting adheres to established standards.
- [cspell](https://cspell.org/){:target="_blank"}: Checks the spelling of words and enforces consistent spelling of proprietary terms.

#### Formatting Check {#mdlint}

Since MkDocs' Markdown format introduces many extended features, which deviate from standard Markdown conventions, markdownlint may produce false positives when checking MkDocs. To disable specific checks for certain text blocks:

For example, the following document demonstrates Tab styling, but standard Markdown considers the indentation as a code block without specifying the language, leading to [MD046](https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md#md046---code-block-style){:target="_blank"} errors. You can disable this check by adding comments before and after the relevant section:

```markdown
<!-- markdownlint-disable MD046 -->
=== "Host Deployment"

    Enter the `conf.d/` directory under the DataKit installation directory, copy `.conf.sample` and rename it to `.conf`. Example:

    ...
=== "Kubernetes"

    Kubernetes supports modifying configuration parameters via environment variables:
    ...
<!-- markdownlint-enable MD046 -->
```

To disable multiple related checks, use the following format (separated by spaces):

```markdown
<!-- markdownlint-disable MD046 MD047 MD048 -->
...

<!-- markdownlint-enable MD046 MD047 MD048 -->
```

Notes:

- Disable what you enable below, keeping symmetry.
- Remember to re-enable all checks at appropriate positions.
- If it is not a false positive and the document indeed violates a rule that can be fixed by rewriting, do not disable the check; fix the document.

#### Spelling Check {#cspell}

Cspell is effective in detecting spelling errors in words (primarily English words; currently cannot detect Chinese spelling issues). Sometimes, we inadvertently misspell words or use inconsistent spellings for standard terms (e.g., `Datakit/DataKit/datakit`).

The cspell settings are stored in the *scripts* directory at the project root. Focus on the glossary file *glossary.txt*, where specialized terms, abbreviations, etc., are defined.

Modify the *glossary.txt* file under the following circumstances:

- Add new specialized terms, e.g., `Datakit`, to the specialized terms list.
- Add new abbreviations, e.g., `JDBC`, to the abbreviation list.
- For compound words, add them to the compound word list.
- Pay special attention to extreme terms that should not appear in the main text (relative to inline code and code blocks). For instance, `Java` should not be written as `java/JAVA`, and `JSON` should not be written as `Json/json`.
- If spelling cannot be avoided, besides adding it to the glossary, you can format it as inline code, ignoring code snippets and URLs during spelling checks (see the `ignoreRegExpList` configuration in *scripts/cspell.json*).

#### Mixed Chinese-English Text Checking {#zh-en-mix}

Mixed Chinese-English text involves two aspects:

- Insert an English space between mixed Chinese-English text (including numbers and Chinese characters) to alleviate reading fatigue.

For example, the following looks more spacious and less cramped visually:

```markdown
We hope to insert 1 English space between English and Chinese ...
```

However, no space is needed between Chinese punctuation and English (including numbers), as it does not affect readability:

```markdown
I wrote a sentence in English, followed by a Chinese comma ...
```

- Use Chinese punctuation in all Chinese contexts, not English punctuation (such as `,.:()'!`).

<!-- markdownlint-disable MD046 -->
??? warning

    All mixed Chinese-English text must follow this rule, regardless of code formatting.
<!-- markdownlint-enable MD046 -->

### 404 Link Check {#404-check}

During daily documentation writing, we generally create several types of document links:

- Internal links to other documents in the documentation library, e.g., ` This is a text with an [internal link](some-other.md#some-section) `
- External links, e.g., ` This is a text with an [external link](https://host.com#some-section){:target="_blank"} `
- References to other sections within the current document, e.g., ` Refer to the description in the [previous section](#prev-section) `, or ` Refer to the description in the [previous section](current.md#prev-section) `

To avoid false positives in 404 checks, follow these guidelines:

<!-- markdownlint-disable MD038 -->
- Internal links technically can be in two forms: `[xxx](datakit/datakit-conf/#config-http-server)` or `[xxx](datakit-conf.md#config-http-server)`. Both work on the page, but **the former will not pass the 404 check**, so use the second form.
- All internal section references must include the current document name, e.g., ` Refer to the description in the [previous section](current.md#prev-section) `. Only section names are considered invalid links.
- Link formats must be accurate and should not:
    - Include unnecessary extra spaces, like ` Refer to this [invalid link]( https://invalid-link.com)`
    - Have extra `#`, like ` Refer to this [invalid link](some.md#invalid-link/#)`
- If a link is mentioned in plain text, format it as code to avoid triggering a 404 false positive. For example, `` Set the host address to `http://localhost:8080` ``. The localhost link in the text, formatted as code, will not trigger a 404 false positive.
<!-- markdownlint-enable MD038 -->

## Further Reading {#more-reading}

- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/reference/admonitions/){:target="_blank"}
