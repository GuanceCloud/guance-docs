
# ebpftrace
---

:fontawesome-brands-linux: :material-kubernetes:

---

## Configuation {#config}

=== "Host Installation"

    Go to the `conf.d/ebpftrace` directory under the DataKit installation directory, copy `ebpftrace.conf.sample` and name it `ebpftrace.conf`. Examples are as follows:
    
    ```toml
        
    [[inputs.ebpftrace]]
      sqlite_path = "/usr/local/datakit/ebpf_spandb"
      use_app_trace_id = true
      window = "20s"
      sampling_rate = 0.1
    
    ```
    
    The default configuration does not turn on ebpf-bash. If you need to turn on, add `ebpf-bash` in the `enabled_plugins` configuration item;
    
    After configuration, restart DataKit.

## Measurements {#measurements}

For all of the following data collections, a global tag named `host` is appended by default (the tag value is the host name of the DataKit), or other tags can be specified in the configuration by `[inputs.ebpftrace.tags]`:

``` toml
 [inputs.ebpftrace.tags]
  # some_tag = "some_value"
  # more_tag = "some_other_value"
  # ...
```


