# Integration Document Consolidation

---

This document primarily introduces how to consolidate existing integration documents into Datakit's documentation. The current integration documents are available [here](https://www.yuque.com/dataflux/integrations){:target="_blank"}.

<!-- markdownlint-disable MD046 -->
???+ Attention

    For DataKit-related integration documents, it is not recommended to directly modify them in *dataflux-doc/docs/integrations*, as the Datakit documentation export process overwrites the content in this directory, which may result in manually added documents being overwritten.
<!-- markdownlint-enable -->

Definitions:

- Documentation Repository: Refers to the new documentation repository `dataflux-doc`

After a preliminary review, there are several possibilities for consolidating integration documents into Datakit documentation:

- Merging Integration Documents: Existing collector documents can be expanded directly. For example, the [CPU Integration Document](https://www.yuque.com/dataflux/integrations/fyiw75){:target="_blank"} can be merged into the CPU.md file (man/manuals/cpu.md).
- Adding New Datakit Documents: If Datakit does not have corresponding documents, new ones need to be created manually within Datakit.

The following sections will detail how to handle these scenarios.

## Merging Integration Documents {#merge}

Most of the existing Datakit documents already contain the necessary content for integrations, mainly lacking screenshots and navigation scenarios. Environmental configurations and metrics information are mostly covered. Therefore, during consolidation, only some screenshots need to be added:

- Obtain screenshot URLs from the existing Yuque integration documents and download them directly into the current integration documentation repository:

```shell
cd dataflux-doc/docs/integrations
wget http://yuque-img-url.png -O imgs/input-xxx-0.png
wget http://yuque-img-url.png -O imgs/input-xxx-1.png
wget http://yuque-img-url.png -O imgs/input-xxx-2.png
...
```

> Note: Do not download images into the documentation directory of the Datakit project.

For specific collectors, multiple screenshots may be involved. It is recommended to save these images with a fixed naming convention in the *imgs* directory of the integration documentation repository, prefixed with `input-` and numbered accordingly.

After downloading the images, add them to the Datakit documentation, referring to the existing CPU collector example (man/manuals/cpu.md).

- Compile DataKit

Since modifications are made to Datakit's own documentation, compilation is required for changes to take effect. For compiling Datakit, refer to [this guide](https://github.com/GuanceCloud/datakit/blob/github-mirror/README.zh_CN.md){:target="_blank"}.

If you encounter difficulties during compilation, you can temporarily ignore this step and submit the above changes as a merge request to the Datakit repository. Developers can compile and synchronize the changes to the documentation repository.

## Adding New Datakit Documents {#add}

For integration documents that do not have direct collector support in Datakit, the process is simpler. Using Resin from the existing integration library as an example, here’s how to proceed:

- Retrieve the Markdown source from the existing Yuque page and save it to the *man/manuals/* directory.

By appending "markdown" to the URL of the Resin integration page, [you can access its Markdown source](https://www.yuque.com/dataflux/integrations/resin/markdown){:target="_blank"}. Copy and save it to *man/manuals/resin.md*.

After downloading, adjust the formatting by removing unnecessary HTML decorations (refer to the current *resin.md* for guidance). Also, download all images (following the same procedure as the CPU example) and reference them in the new *resin.md*.

- Modify the structure in *man/manuals/integrations.pages* and add the corresponding document

Since Resin is a type of Web server, place it alongside Nginx and Apache in the existing *integrations.pages* file:

```yaml
- "Web Server"
  - 'Nginx': nginx.md
  - apache.md
  - resin.md
```

- Modify the *mkdocs.sh* script

Update the *mkdocs.sh* script to include the new document in the export list:

```shell
cp man/manuals/resin.md $integration_docs_dir/
```

## Documentation Generation and Export {#export}

In the existing Datakit repository, running *mkdocs.sh* handles both compilation and publication steps. Currently, the documentation is exported into two directories, *datakit* and *developers*, within the documentation repository.

To insert images into the documentation, place them in the respective *imgs* directories under *datakit* and *integrations*. Refer to [the previous example](integrations-to-dk-howto.md#merge) for image referencing.

Below are detailed local operations for the documentation repository. Mainly follow these steps:

- Clone the existing documentation repository and install dependencies

``` shell
cd ~/ && mkdir -p git && cd git
git clone ssh://git@gitlab.jiagouyun.com:40022/zy-docs/dataflux-doc.git
cd dataflux-doc
pip install -r requirements.txt # You might need to update your pip version
```

<!-- markdownlint-disable MD046 -->
???+ attention

    After installing MKDocs, you may need to set `$PATH`. On Mac, it might look like this (find the exact `mkdocs` binary location):

    ``` shell
    PATH="/System/Volumes/Data/Users/<user-name>/Library/Python/3.8/bin:$PATH"
    ```
<!-- markdownlint-enable -->

- Familiarize yourself with *mkdocs.sh*

In the root directory of Datakit, there is a *mkdocs.sh* script responsible for exporting all Datakit documentation, copying it to different directories in the documentation repository, and starting the local documentation service.

- Access `http://localhost:8000` locally to view the documentation.
- After debugging, submit a Merge Request to the `mkdocs` branch of the Datakit project.