---
title     : 'External'
summary   : 'Launch external programs for collection'
__int_icon      : 'icon/external'
dashboard :
  - desc  : 'Not available'
    path  : '-'
monitor   :
  - desc  : 'Not available'
    path  : '-'
---


:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:  · [:fontawesome-solid-flag-checkered:](../datakit/index.md#legends "Election Enabled")

---

The External collector can launch external programs for collection.

## Configuration {#config}

### Prerequisites {#requirements}

- The program of the startup command and its runtime environment dependencies are complete. For example, if using Python to start an external Python script, all required packages and dependencies for the script's execution must be present.

### Collector Configuration {#input-config}

<!-- markdownlint-disable MD046 -->
=== "HOST Installation"

    Navigate to the `conf.d/external` directory under the DataKit installation directory, copy `external.conf.sample`, and rename it to `external.conf`. An example is as follows:
    
    ```toml
        
    [[inputs.external]]
    
        # Collector's name.
        name = 'some-external-inputs'  # required
    
        # Whether or not to run the external program in the background.
        daemon = false
    
        # If the external program runs in Non-daemon mode,
        #     runs it at this interval time.
        #interval = '10s'
    
        # Environment variables for running the external program.
        #envs = ['LD_LIBRARY_PATH=/path/to/lib:$LD_LIBRARY_PATH',]
    
        # Full path of the external program. Use absolute paths whenever possible.
        cmd = "python" # required
    
        # Set "true" if this collector is involved in the election.
        # Note: The external program must run in daemon mode if involved in the election.
        election = false
        args = []
    
        [[inputs.external.tags]]
            # tag1 = "val1"
            # tag2 = "val2"
    
    ```
    
    After configuration, [restart DataKit](../datakit/datakit-service-how-to.md#manage-service).

=== "Kubernetes"

    You can currently enable the collector by [injecting the collector configuration via ConfigMap](../datakit/datakit-daemonset-deploy.md#configmap-setting).

<!-- markdownlint-enable -->