# Integration Document Consolidation

---

This document primarily describes how to merge existing integration documents into Datakit's documentation. The current integration documents can be found [here](https://www.yuque.com/dataflux/integrations){:target="_blank"}.

<!-- markdownlint-disable MD046 -->
???+ Attention

    Documents related to DataKit integrations should not be directly modified in *dataflux-doc/docs/integrations*, as the export of Datakit's own documentation overwrites this directory, which could result in manually added documents being overwritten.
<!-- markdownlint-enable -->

Definitions:

- Documentation Repository: Refers to the new documentation repository `dataflux-doc`

After a preliminary review, there are several possibilities for merging integration documents into Datakit documentation:

- Merging Integration Documents: Existing collector documents can be expanded directly, for example, the [CPU Integration Document](https://www.yuque.com/dataflux/integrations/fyiw75){:target="_blank"}, which can be merged into the cpu.md (man/manuals/cpu.md) file.
- Adding New Datakit Documents: If Datakit does not have corresponding documents, new ones need to be created manually in Datakit.

The following sections will describe how to merge these documents based on the above scenarios.

## Merging Integration Documents {#merge}

Most of the content from existing Datakit documents is already present; what is mainly missing are screenshots and scenario navigation. Additionally, environment configurations and metric information are mostly covered. Therefore, when merging, only some screenshots need to be added:

- Obtain screenshot URLs from the existing Yuque integration documents and download them directly into the current integration documentation repository:

```shell
cd dataflux-doc/docs/integrations
wget http://yuque-img-url.png -O imgs/input-xxx-0.png
wget http://yuque-img-url.png -O imgs/input-xxx-1.png
wget http://yuque-img-url.png -O imgs/input-xxx-2.png
...
```

> Note: Do not download images into the documentation directory of the Datakit project.

For specific collectors, there may be multiple screenshots. It is recommended to use a consistent naming convention for saving these images. All images should be saved in the *imgs* directory of the integration documentation repository with `input-` as the prefix and numbered accordingly.

After downloading the images, add them to the Datakit documentation. For specifics, refer to the existing CPU collector example (man/manuals/cpu.md).

- Compile DataKit

Since changes are made to Datakit's own documentation, compilation is required for the changes to take effect. For compiling Datakit, see [here](https://github.com/GuanceCloud/datakit/blob/github-mirror/README.zh_CN.md){:target="_blank"}.

If you encounter difficulties during compilation, you can temporarily ignore it and submit the modifications as a merge request to the Datakit repository. The development team can handle the compilation and synchronization to the documentation repository.

## Adding New Datakit Documents {#add}

For integration documents that do not have direct collector support in Datakit, the process is simpler. Using Resin from the existing integration library as an example, the steps are outlined below.

- Obtain the Markdown source from the existing Yuque page and save it to the *man/manuals/* directory

By appending "markdown" to the URL of the Resin integration page, [you can access its Markdown source](https://www.yuque.com/dataflux/integrations/resin/markdown){:target="_blank"}. Select all and copy, then save it as *man/manuals/resin.md*.

After downloading, adjust the formatting inside, removing unnecessary HTML decorations (refer to the current *resin.md* for guidance). Additionally, download all images (similar to the CPU example) and save them, then reference these images in the new *resin.md*.

- Modify the directory structure in *man/manuals/integrations.pages* and add the corresponding document

Since Resin is a type of Web server, in the existing *integrations.pages* file, place it alongside Nginx/Apache:

```yaml
- "Web Server"
  - 'Nginx': nginx.md
  - apache.md
  - resin.md
```

- Modify the *mkdocs.sh* script

Modify the *mkdocs.sh* script to add the new document to the export list:

```shell
cp man/manuals/resin.md $integration_docs_dir/
```

## Document Generation and Export {#export}

In the existing Datakit repository, running *mkdocs.sh* directly will compile and publish the documents. Currently, *mkdocs.sh* exports the documents into two separate directories, syncing them to the *datakit* and *developers* directories in the documentation repository.

To insert images into the documents, place them in the respective *imgs* directories under *datakit* and *integrations*. Refer to [the previous examples](integrations-to-dk-howto.md#merge) for image referencing.

Below are the specific steps for local operations in the documentation repository.

- Clone the existing documentation repository and install dependencies

```shell
cd ~/ && mkdir -p git && cd git
git clone ssh://git@gitlab.jiagouyun.com:40022/zy-docs/dataflux-doc.git
cd dataflux-doc
pip install -r requirements.txt # You might need to update your pip version
```

<!-- markdownlint-disable MD046 -->
???+ attention

    After installing MKDocs, you may need to set `$PATH`. On Mac, the setup might look like this (find the `mkdocs` binary location):

    ```shell
    PATH="/System/Volumes/Data/Users/<user-name>/Library/Python/3.8/bin:$PATH"
    ```
<!-- markdownlint-enable -->

- Familiarize yourself with *mkdocs.sh*

In the root directory of Datakit, there is a *mkdocs.sh* script responsible for exporting all Datakit documents and copying them to different directories in the documentation repository, finally starting the local documentation service.

- Access `http://localhost:8000` to view the documents locally.
- After debugging is complete, submit a Merge Request to the `mkdocs` branch of the Datakit project.
