# Check the Change Implementation of Sensitive Files
  This time, we will show how to use Scheck to check the lua script implementation of sensitive files.

- Version: 1.0.7-5-gb83de2d
- Release date: 2022-08-30 03:31:26
- Operating system support: linux/arm,linux/arm64,linux/386,linux/amd64  

## Preconditions

- [Scheck](../scheck/scheck-install.md) has been installed.

## Development Steps

1. Go to the installation directory and edit the configuration file `scheck.conf` to set the `enable` field to`true`:

```toml
...
[scoutput]
   # ##Messages generated during Sheck can be sent to local, http and Alibaba Cloud sls
   # ##Remote server, such as http(s)://your.url
  [scoutput.http]
    enable = true
    output = "http://127.0.0.1:9529/v1/write/security"
  [scoutput.log]
    # ##Configurable local storage
    enable = false
    output = "/var/log/scheck/event.log"
...
```

2. Create a new manifest file `files.manifest` under the directory `/usr/local/scheck/custom.rules.d` (this directory is the user-defined script directory) and edit it as follows:

```toml
id       = 'check-file'
category = 'system'
level    = 'warn'
title    = 'monitor file changes'
desc     = 'the File {{.File}} has changed'
cron     = '*/10 * * * *' #Indicate that the lua script is executed every 10 seconds
os_arch  = ["Linux"]
```

3. Create a new script file `files.lua` in the manifest file sibling directory and edit it as follows:

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

4. When a sensitive file is altered, the next 10 seconds will detect and trigger the trigger function, sending the event to the file `/var/log/scheck/event.log`, adding a row of data, for example:  

```
check-file-01,category=security,level=warn,title=monitor file changes message="file /etc/passwd changed" 1617262230001916515
```
