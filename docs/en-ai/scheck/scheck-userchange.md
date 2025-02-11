# Monitoring System User Changes
  This will demonstrate how to use Scheck to implement a Lua script for checking sensitive files.

- Version: 1.0.7-7-g251eead
- Release Date: 2023-04-06 11:17:57
- Supported Operating Systems: linux/arm, linux/arm64, linux/386, linux/amd64  

## Prerequisites

- [Scheck](scheck-install.md) is installed

## Development Steps

1. Enter the installation directory and edit the `enable` field in the configuration file `scheck.conf` to set it to `true`:

```toml
...
[scoutput]
   # ##Messages generated during Security Check can be sent to local storage, HTTP, or Alibaba Cloud SLS.
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

2. Create a manifest file `files.manifest` under the directory `/usr/local/scheck/custom.rules.d` (this directory is for user-defined scripts), and edit it as follows:

```toml
id         = 'users-checker'
category   = 'system'
level      = 'warn'
title      = 'Monitoring System User Changes'
desc       = '{{.Content}}'
cron       = '*/10 * * * *'
instanceId = 'id-xxx'
os_arch    = ["Linux"]
```

3. In the same directory as the manifest file, create a script file `users.lua`, and edit it as follows:
```lua
local function check()
    local cache_key="current_users"
    local currents=users()

    local old=get_cache(cache_key)
    if not old then
        set_cache(cache_key, currents)
        return
    end

    local adds={}
    for i,v in ipairs(currents) do
        local exist=false
        for ii,vv in ipairs(old) do
            if vv["username"] == v["username"] then
                exist = true
                break
            end
        end
        if not exist then
            table.insert(adds, v["username"])
        end
    end

    local dels={}
    for i,v in ipairs(old) do
        local exist=false
        for ii,vv in ipairs(currents) do
            if vv["username"] == v["username"] then
                exist = true
                break
            end
        end
        if not exist then
            table.insert(dels, v["username"])
        end
    end

    local content=''
    if #adds > 0 then
        content=content..'New users: '..table.concat(adds, ',')
    end
    if #dels > 0 then
        if content ~= '' then content=content..'; ' end
        content=content..'Deleted users: '..table.concat(dels, ',')
    end
    if content ~= '' then
        trigger({Content=content})
        set_cache(cache_key, currents)
    end
end

check()
```

4. When a user is added, it will be detected within the next 10 seconds and trigger the `trigger` function, sending the event to the file `/var/log/scheck/event.log`. An entry will be added, for example:

```
users-checker,category=system,level=warn,title=Monitoring System User Changes message="New users: xxx" 1617262230001916515
```