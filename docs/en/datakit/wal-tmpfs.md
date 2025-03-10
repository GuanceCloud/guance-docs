# Using tmpfs in WAL

:fontawesome-brands-linux : :material-kubernetes :

---

In some cases, if disk performance is insufficient, we can use a portion of memory to meet the disk read and write requirements of WAL.

<!-- markdownlint-disable MD046 -->
=== "Linux Host"

    1. Create a tmpfs mount directory on the host:
    
        ```shell
        sudo mkdir -p /mnt/wal-ramdisk
        ```
    
    1. Build a tmpfs disk using 1 GiB of memory:
    
        ```shell
        sudo mount -t tmpfs -o size=1G tmpfs /mnt/wal-ramdisk
        ```
    
    1. Check the mount status:
    
        ```shell
        $ df -h /mnt/wal-ramdisk/
        Filesystem      Size  Used Avail Use% Mounted on
        tmpfs           1.0G     0  1.0G   0% /mnt/wal-ramdisk
        ```
    
    1. Modify the WAL directory in *datakit.conf*:
    
        ```toml hl_lines="2"
        [dataway.wal]
          path = "/mnt/wal-ramdisk"
        ```

=== "DaemonSet"

    1. On the Kubernetes Node machine, create a *ramdisk* directory:
    
        ```shell
        # Here we changed the directory; by default, datakit.yaml already mounts the Node host's /root/datakit_cache
        # to the Datakit container's /usr/local/datakit/cache directory
        mkdir -p /root/datakit_cache/ramdisk
        ```
    
    1. Create a 1 GiB tmpfs:
    
        ```shell
        mount -t tmpfs -o size=1G tmpfs /root/datakit_cache/ramdisk
        ```
    
    1. Add the following environment variable in *datakit.yaml*, then restart the Datakit container:
    
        ```yaml
        - name: ENV_DATAWAY_WAL_PATH
          value: /usr/local/datakit/cache/ramdisk
        ```
<!-- markdownlint-enable -->

---

<!-- markdownlint-disable MD046 -->
???+ danger "Adjust tmpfs size as appropriate"

    By default, the disk space for each WAL category is set to 2 GiB, which is generally sufficient. In a tmpfs scenario, setting such large memory for each category is impractical, so here we use only 1 GiB (i.e., all data categories share 1 GiB of tmpfs space) to meet the disk requirements of WAL. This may be enough if the data volume is small and network conditions (between Datakit and Dataway) are normal.

    If the host (or Kubernetes Node) restarts, the data in these WALs will be lost, but restarting Datakit itself will not affect it.
<!-- markdownlint-enable -->

After setting up, you will see a *ramdisk* directory under the cache directory. Once Datakit starts and WAL data is generated, you can see various disk files corresponding to different data categories in the *ramdisk* directory:

```shell
# Enter /usr/local/datakit/cache or /mnt/wal-ramdisk/
$ du -sh ramdisk/*
8.0K    ramdisk/custom_object
0       ramdisk/dialtesting
4.0K    ramdisk/dynamic_dw
4.0K    ramdisk/fc
4.0K    ramdisk/keyevent
4.3M    ramdisk/logging
1000K   ramdisk/metric
4.0K    ramdisk/network
4.0K    ramdisk/object
4.0K    ramdisk/profiling
4.0K    ramdisk/rum
4.0K    ramdisk/security
4.0K    ramdisk/tracing
```