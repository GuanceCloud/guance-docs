# Managing Configuration with Git
---

This document explains how to manage DataKit configurations using Git. These configurations include collection configurations, Pipeline scripts, etc. By maintaining a local or remote Git repository, we can manage changes in DataKit's configuration and leverage Git’s version control features to track historical changes in the configuration.

## Operating Mechanism {#mechanism}

DataKit integrates Git client functionality, which periodically (default 1min) fetches the latest configuration data from the Git repository. By loading these latest configurations, it achieves updates to DataKit's configuration.

## Usage Example {#example}

The complete usage example steps are as follows:

1. Create a Git repository
2. Plan the configuration within the repository according to predefined directory rules
3. Push the configuration to the Git repository
4. Add the Git repository in the main DataKit configuration
5. Restart DataKit

<!-- markdownlint-disable MD046 -->
???+ note

    The creation of the Git repository does not have to follow this order. For example, you can first create a remote repository URL, then clone the repository for modifications. The following example creates a local Git repository first and then pushes it to a remote repository.
<!-- markdownlint-enable -->

### Creating a Git Repository {#new-repo}

First, create a Git repository locally:

```shell
mkdir datakit-repo
git init
```

### Directory Planning {#dir-naming}

Create various [basic directories](git-config-how-to.md#repo-dirs):

```shell
mkdir -p conf.d   && touch conf.d/.gitkeep
mkdir -p pipeline && touch pipeline/.gitkeep
mkdir -p python.d && touch python.d/.gitkeep
```

### Pushing Configuration {#repo-push}

Use common Git commands to push configuration changes to the repository:

```shell
# cd your/path/to/repo
git add conf.d pipeline python.d

# Add any conf or pipeline to path conf.d/pipeline/python.d...

git commit -m "init datakit repo"

# Push the repo to YOUR GitHub (ssh or https)
git remote add origin ssh://git@github.com/PATH/TO/datakit-confs.git
git push origin --all
```

### Configuring the Repository in DataKit {#config-git-repo}

Enable the *git_repos* feature in *datakit.conf*. Find `git_repos` as shown below:

```toml
[[git_repos.repo]]
    enable = true # Enable the repo

    ###########################################
    # Git support http/git/ssh authentication
    ###########################################
    url = "http://username:password@github.com/PATH/TO/datakit-confs.git"

    branch = "master" # Specify which branch to pull

    # git/ssh authentication require key-path key-password configure
    # url = "git@github.com:PATH/TO/datakit-confs.git"
    # url = "ssh://git@github.com/PATH/TO/datakit-confs.git"
    # ssh_private_key_path = "/Users/username/.ssh/id_rsa"
    # ssh_private_key_password = "<YOUR-PASSSWORD>"
```

If the password contains special characters, refer to [this section](datakit-input-conf.md#password-encode).

### Restarting DataKit {#restart}

After completing the configuration, [restart DataKit](datakit-service-how-to.md#manage-service). Wait a moment, and use [DataKit Monitor](datakit-monitor.md) to check the status of the collectors.

## Using Git in Kubernetes {#k8s}

Refer to [here](datakit-daemonset-deploy.md#env-git).

## FAQ {#faq}

<!-- markdownlint-disable MD013 -->
### :material-chat-question: Error: Authentication Required {#auth-required}
<!-- markdownlint-enable -->

This error may occur due to the following reasons.

If using SSH, it is usually because the provided key is incorrect. If using HTTP, it may be because:

1. The provided username and password are incorrect
2. The protocol in the Git URL is wrong

For example, the original URL is

```not-set
https://username:password@github.com/path/to/repository.git
```

But it was written as

```not-set
http://username:password@github.com/path/to/repository.git
```

Changing `https` to `http` will cause this error. In this case, change `http` back to `https`.

### :material-chat-question: Repository Directory Constraints {#repo-dirs}

The Git repository must store various configurations in the following directory structure:

```shell
+── conf.d    # 
├── pipeline  # Specifically for storing Pipeline slicing scripts
└── python.d  # For storing Python scripts
```

Where

- *conf.d* specifically stores collector configurations. Subdirectories can be planned arbitrarily (subdirectories are allowed), and any collector configuration file should end with `.conf`
- *pipeline* is used for Pipeline scripts, which are recommended to be organized based on [data types](../pipeline/use-pipeline/pipeline-category.md#store-and-index)
- *python.d* is used for Python scripts

Below is an example of the DataKit directory structure after enabling Git synchronization:

```shell
DataKit root directory
├── conf.d   # Default main configuration directory
├── pipeline # Top-level Pipeline scripts
├── python.d # Top-level Python scripts
└── gitrepos
    ├── repo-1        # Repository 1
    │   ├── conf.d    # Specifically for storing collector configurations
    │   ├── pipeline  # Specifically for storing Pipeline slicing scripts
    │   └── python.d  # For storing Python scripts
    └── repo-2        # Repository 2
        ├── ...
```

### :material-chat-question: Git Configuration Loading Mechanism {#repo-apply-rules}

After Git synchronization is enabled, the priority of configurations (*.conf*/Pipeline) is defined as follows:

1. All collector configurations are loaded from the *gitrepos* directory
2. The loading order of Git repositories follows their appearance order in *datakit.conf*
3. For Pipeline scripts, the first found Pipeline file takes precedence. For example, when searching for *nginx.p*, if it is found in `repo-1`, it **will not** search in `repo-2`. If *nginx.p* is not found in either repository, it will then look in the top-level Pipeline directory. The same applies to Python scripts.

<!-- markdownlint-disable MD046 -->
???+ attention

    After enabling the remote Pipeline feature, the first loaded Pipeline is synchronized from the center.

    After enabling Git synchronization, the original *conf.d* directory collector configurations will no longer take effect. Additionally, the main configuration *datakit.conf* **cannot** be managed via Git.
<!-- markdownlint-enable -->