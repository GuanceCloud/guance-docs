---
title     : 'External'
summary   : 'Start external program for collection'
__int_icon      : 'icon/external'
dashboard :
  - desc  : 'N/A'
    path  : '-'
monitor   :
  - desc  : 'N/A'
    path  : '-'
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

External Collector launch outside program to collecting data.

## Configuration {#config}

### Preconditions {#requirements}

- The command and its running environment must have complete dependencies. For example, if Python is used to start an external Python script, the `import` package and other dependencies required for the script to run must be prepared.

### Input configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "Host Installation"

    Go to the `conf.d/external` directory under the DataKit installation directory, copy `external.conf.sample` and name it `external.conf`. Examples are as follows:

    ```toml
        
    [[inputs.external]]
    
        # Collector's name.
        name = 'some-external-inputs'  # required
    
        # Whether or not to run the external program in the background.
        daemon = false
    
        # If the external program running in a Non-daemon mode,
        #     runs it in every this interval time.
        #interval = '10s'
    
        # The environment variables running the external program.
        #envs = ['LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH',]
    
        # The external program' full path. Filling in absolute path whenever possible.
        cmd = "python" # required
    
        # Filling "true" if this collecor is involved in the election.
        # Note: The external program must running in a daemon mode if involving the election.
        election = false
        args = []
    
        [[inputs.external.tags]]
            # tag1 = "val1"
            # tag2 = "val2"
    
    ```
    
    Once configured, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    The collector can now be turned on by [ConfigMap injection collector configuration](../datakit/datakit-daemonset-deploy.md#configmap-setting).
<!-- markdownlint-enable -->
