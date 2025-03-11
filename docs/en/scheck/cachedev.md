# View Memory and Cache Usage in Developer Mode
---

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: windows/amd64, windows/386, linux/arm, linux/arm64, linux/386, linux/amd64

## Description
During development testing or actual operation, the size of Lua-generated caches can sometimes be uncontrollable. For example, caching a directory's file list can lead to excessive memory usage when the number of files is too large, which may severely trigger cgroup limits, causing the process to hang or freeze.

Therefore, using developer mode to monitor memory and cache usage in real-time during runtime is essential.

### cache_dev Developer Mode
### Problems to Solve and Solutions:

- Large fluctuations in memory or CPU usage that cannot be traced.
- To address the issue of excessive cache usage, it is necessary to know how much data has been cached.
- During caching, only storage and retrieval (within the same Lua script or similar functional scripts) know the type of cache.
- However, within the cache unit, the specific storage type is unknown.
- The sizes of string, bool, int/float types are known, but Lua.table structures cannot directly determine their size.
- Therefore, for Lua.table types, special handling should be applied, such as writing them to disk.
- This ensures that scheck does not consume too much memory during runtime; ideally, it should not exceed 150M.
- When scheck abnormally terminates the process, it can resume from the previous state.

#### Solutions:

- Scripts of the same type use the same cache with identical keys. However, due to different files (different rule IDs), two identical copies are stored separately. Therefore, they should share the same cache instead of storing two separate copies.
- Solving the above issue introduces another problem: each rule has its own cache key, which can easily cause confusion.
- Persistent and visualized caching helps quickly identify issues, perform mock tests, and test rules.
- After persistence, memory overhead can be reduced accordingly.

## Configuration
Open the configuration file and set pprof to true

```toml
[system]
    ...
 pprof = true
```

After enabling this switch, it listens on the local port `127.0.0.1:6060`, accessible only from the local machine. Use the go pprof command to view memory and CPU usage [Official Documentation](https://code.google.com/p/google-perftools/)

```shell
# Then use the pprof tool to view the heap profile:
go tool pprof http://localhost:6060/debug/pprof/heap
# top 20 
top 20
# list function name or package name 
list

# Or view the CPU profile over 30 seconds
go tool pprof http://localhost:6060/debug/pprof/profile
# Or view the goroutine blocking profile
go tool pprof http://localhost:6060/debug/pprof/block

# To view all available profiles, read http://localhost:6060/debug/pprof/ in your browser. To learn more about these profiling facilities, visit
http://blog.golang.org/2011/06/profiling-go-programs.html
```

### Cache
After enabling developer mode, Lua script caches will be serialized into the `cache.json` file in the installation directory.
Currently supported Lua types include: LTString, LTNumber, LTBool, LTTable.
Unsupported Lua types: LTChannel, LTFunction, LTNil, LTThread, LTUserData.

```json
{
	"msg_data": {
		"/boot/grub2/grub.cfg": {           // key
			"c_type": 0,
			"rule_name": "0070-grub-priv", // Rule Name
			"val": "-rw-r--r--"             // val string type
		},
		"/etc/fstab": {
			"c_type": 1,
			"rule_name": "0029-fstab-exist",
			"val": true             // val bool type
		},
		"/usr/lib/systemd/system/docker.socket": {
        	    "c_type": 2,
        	    "rule_name": "0307-docker-socket-priv",
        	    "val": 420          // val number type
        }
    ... 
  }
}
```

All caches are periodically written to the file. Scheck does not read the cached content.
Breakpoint restart and other features are pending future development.