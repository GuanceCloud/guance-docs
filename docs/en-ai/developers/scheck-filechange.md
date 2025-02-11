# Implementation of Checking Changes in Sensitive Files
  This section will demonstrate how to use Scheck to check sensitive files with a Lua script.

- Version: 1.0.7-5-gb83de2d
- Release Date: 2022-08-30 03:31:26
- Supported Operating Systems: linux/arm, linux/arm64, linux/386, linux/amd64  

## Prerequisites

- [Scheck](../scheck/scheck-install.md) is installed

## Development Steps

1. Navigate to the installation directory and set the `enable` field in the configuration file `scheck.conf` to `true`:

```toml
...
[scoutput]
   # ##Messages generated during Security Check can be sent to local, http, or Alibaba Cloud SLS.
   # ##Remote server, example: http(s)://your.url
  [scoutput.http]
    enable = true
    output = "http://127.0.0.1:9529/v1/write/security"
  [scoutput.log]
    # ##Local storage can be configured
    enable = false
    output = "/var/log/scheck/event.log"
...
```

2. Create a manifest file `files.manifest` in the directory `/usr/local/scheck/custom.rules.d` (this directory is for user-defined scripts), and edit it as follows:

```toml
id       = 'check-file'
category = 'system'
level    = 'warn'
title    = 'Monitor File Changes'
desc     = 'File {{.File}} has changed'
cron     = '*/10 * * * *' # Indicates that this Lua script runs every 10 seconds
os_arch  = ["Linux"]
```

3. In the same directory as the manifest file, create a script file `files.lua`, and edit it as follows:

```lua
local files={
	'/etc/passwd',
	'/etc/group'
}

local function check(file)
	local cache_key=file
	local hashval = file_hash(file)

	local old = get_cache(cache_key)
	if not old then
		set_cache(cache_key, hashval)
		return
	end

	if old ~= hashval then
		trigger({File=file})
		set_cache(cache_key, hashval)
	end
end

for i,v in ipairs(files) do
	check(v)
end
```

4. When a sensitive file is modified, within the next 10 seconds, the change will be detected and the `trigger` function will be invoked, sending the event to the log file `/var/log/scheck/event.log`. An entry will be added, for example:

```
check-file-01,category=security,level=warn,title=Monitor File Changes message="File /etc/passwd has changed" 1617262230001916515
```