# MkDocs Documentation Writing
---

This article primarily addresses the following issues:

- Steps for writing Datakit-related documentation
- How to write better documentation using MkDocs

## DataKit Related Writing Steps {#steps}

The steps for writing new documentation are as follows:

1. Add documents under *man/docs/en*; if it is a collector document, add it to the *man/docs/en/inputs* directory.
1. Document writing
1. If necessary, add corresponding English documents under *man/docs/en*
1. Execute the *export.sh* script in the project root directory

### Local Document Debugging {#debug}

When executing *export.sh*, you can first check its supported command-line parameters:

```shell
./export.sh -h
```

The basic environment dependencies of *export.sh*:

1. First clone the [documentation repository](https://gitlab.jiagouyun.com/zy-docs/dataflux-doc){:target="_blank"} to the local directory *~/git/dataflux-doc*. This guide assumes this local directory by default. *export.sh* will generate and copy the Datakit documentation into the corresponding directories of this repo.
1. In the *dataflux-doc* project, there is a *requirements.txt*. Run `pip install -r requirements.txt` to install the required dependencies.
1. Go back to the Datakit code directory and execute the `./export.sh` script from the root directory.

## MkDocs Tips Sharing {#mkdocs-tips}

### Marking Experimental Features {#experimental}

For newly released features that are experimental, you can add special markers in the section, for example:

```markdown
## This is a New Feature {#ref-to-new-feature}

[:octicons-beaker-24: Experimental](index.md#experimental)

Description of the new feature...
```

This results in an icon legend being added below the section:

[:octicons-beaker-24: Experimental](index.md#experimental)

Clicking on this icon will redirect to the explanation of experimental features.

### Marking Version Information {#version}

Some new features are only available in specific versions. In such cases, we can add version identifiers as follows:

```markdown
## This is a New Feature {#ref-to-new-feature}

[:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6)
```

If it's also an experimental feature, they can be placed together separated by `·`:

```markdown
## This is a New Feature {#ref-to-new-feature}

[:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) ·
[:octicons-beaker-24: Experimental](index.md#experimental)
```

Taking DataKit 1.4.6 changelog as an example, clicking on the corresponding icons will redirect to the version release history:

[:octicons-tag-24: Version-1.4.6](changelog.md#cl-1.4.6) ·
[:octicons-beaker-24: Experimental](index.md#experimental)

### External Link Transitions {#outer-linkers}

In some documents, we need to add external links with proper handling to open them in a new browser tab rather than navigating away from the current document library:

```markdown
[Please refer here](https://some-outer-links.com){:target="_blank"}
```

### Predefined Section Links {#set-links}

We can predefine links for sections within the document, for example:

```markdown
// some-doc.md
## This is a New Section {#new-feature}
```

Then in other places, we can directly reference it like this:

```markdown
Refer to this [new feature](some-doc.md#new-feature)
```

If referencing within the same document, **the current document name must be included**. For reasons see the [404 Detection](mkdocs-howto.md#404-check) explanation:

```markdown
Refer to this [new feature](current.md#new-feature)
```

For cross-document references:

```markdown
Refer to this [new feature](../integrations/some-doc.md#new-feature) in the integration library
```

### Adding Notes in Documents {#note}

Some document writings require warning information, for instance, certain functionalities may have additional prerequisites or provide tips. In these cases, we can use MKDocs markdown extensions, such as:

```markdown
??? attention

    Here is a prerequisite explanation ...
```

```markdown
??? tip

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor massa, nec semper lorem quam in massa.
```

And not just a simple note:

```markdown
> This is a simple note ...
```

For more beautiful alert usages, see [here](https://squidfunk.github.io/mkdocs-material/reference/admonitions/){:target="_blank"}

### Tab Layout {#tab}

For certain functionalities that differ in various scenarios, listing them separately can make the document lengthy. A better approach is to organize different scenario uses with tabs, making the document page very concise:

<!-- markdownlint-disable MD046 -->
=== "Usage in Scenario A"

    In Scenario A ...

=== "Usage in Scenario B"

    In Scenario B ...
<!-- markdownlint-enable MD046 -->

Specific usage can be found [here](https://squidfunk.github.io/mkdocs-material/reference/content-tabs/){:target="_blank"}

### Markdown Formatting and Spelling Check {#mdlint-cspell}

To standardize Markdown writing and ensure spelling consistency (relatively correct and consistent), DataKit documentation includes formatting checks and spell checks through two tools:

- [markdownlint](https://github.com/igorshubovych/markdownlint-cli){:target="_blank"}: Checks if basic Markdown formatting conforms to established standards
- [cspell](https://cspell.org/){:target="_blank"}: Ensures correct spelling and enforces uniformity for proprietary terms

#### Formatting Check {#mdlint}

Due to MkDocs' extensive Markdown extensions, markdownlint may produce false positives. To disable specific checks for certain text blocks:

For example, if the document demonstrates tab styles but triggers [MD046](https://github.com/DavidAnson/markdownlint/blob/main/doc/Rules.md#md046---code-block-style){:target="_blank"} because Markdown treats the indentation as code without specifying the language, you can disable the check as follows:

```markdown
<!-- markdownlint-disable MD046 -->
=== "Host Deployment"

    Enter the `conf.d/` directory under the DataKit installation directory, copy `.conf.sample`, and rename it to `.conf`. Example:

    ...
=== "Kubernetes"

    Kubernetes supports modifying configuration parameters via environment variables:
    ...
<!-- markdownlint-enable MD046 -->
```

To disable multiple related checks:

```markdown
<!-- markdownlint-disable MD046 MD047 MD048 -->
...

<!-- markdownlint-enable MD046 MD047 MD048 -->
```

Notes:

- Disable what you enable below, keeping symmetry.
- Remember to re-enable all checks at appropriate positions.
- If it's not a false positive and the document violates rules that can be fixed, do not disable the check; instead, correct the document.

#### Spelling Check {#cspell}

CSpell effectively detects spelling errors (primarily English words; currently unable to check Chinese spelling). Sometimes we inadvertently misspell words or inconsistently spell terms (e.g., `Datakit/DataKit/datakit`).

The cSpell settings are stored in the *scripts* directory under the project root. Focus on the glossary file *glossary.txt*, where specialized terms, abbreviations, etc., are defined.

Modify *glossary.txt* under these circumstances:

- Add new specialized terms like `Datakit`
- Add new abbreviations like `JDBC`
- Add compound words (rarely used)
- Pay special attention to extreme words; we strictly prohibit certain words in the main text (excluding inline code and code blocks). For example, `Java` should not be written as `java/JAVA`, `JSON` should not be written as `Json/json`.
- If spelling cannot be avoided, besides adding to the glossary, format it as inline code. Spelling checks ignore code snippets, URLs, etc. (see the `ignoreRegExpList` configuration in *scripts/cspell.json*)

#### Mixed Chinese-English Text Check {#zh-en-mix}

Mixed Chinese-English text involves two aspects:

- Insert an English space between mixed Chinese-English texts (including numbers and Chinese) to alleviate reading fatigue.

For example, it looks more spacious visually:

```markdown
We hope to insert 1 English space between English and Chinese ...
```

However, no spaces are needed between Chinese punctuation and English (including numbers):

```markdown
I wrote a sentence in English, followed by a Chinese comma ...
```

- Use Chinese punctuation in all Chinese contexts (e.g., `,.:()'!` should not appear around Chinese characters)

<!-- markdownlint-disable MD046 -->
??? warning

    All mixed Chinese-English text must follow this rule, regardless of code formatting.
<!-- markdownlint-enable MD046 -->

### 404 Link Check {#404-check}

During daily documentation writing, we generally create the following types of document links:

- Internal links to other documents in the documentation library, e.g., `This is a text with [internal document link](some-other.md#some-section)`
- External links, e.g., `This is a text with [external link](https://host.com#some-section){:target="_blank"}`
- References to other sections in the current document, e.g., `See the description in the [previous section](#prev-section)` or `See the description in the [previous section](current.md#prev-section)`

To avoid 404 detection misreporting, follow these guidelines:

<!-- markdownlint-disable MD038 -->
- Internal links can technically take two forms: `[xxx](datakit/datakit-conf/#config-http-server)` or `[xxx](datakit-conf.md#config-http-server)`. Both work on the page but **the former fails the 404 check**, so use the latter form.
- All internal section references must include the current document name, e.g., `See the description in the [previous section](current.md#prev-section)`. Only section names are considered invalid.
- Links must be accurate and not contain:
    - Meaningless extra spaces, e.g., `See this [invalid link]( https://invalid-link.com)`
    - Extra `#`, e.g., `See this [invalid link](some.md#invalid-link/#)`
- If plain text contains a URL, format it as code to prevent 404 misreporting. For example: `` Set the host address to `http://localhost:8080` ``. The localhost link in the text, when formatted as code, does not trigger a 404 misreport.
<!-- markdownlint-enable MD038 -->

## Further Reading {#more-reading}

- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/reference/admonitions/){:target="_blank"}