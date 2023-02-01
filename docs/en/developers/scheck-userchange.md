# Monitor System User Changes
  This time, we will show how to use Scheck to check the lua script implementation of sensitive files.

- Version: 1.0.7-5-gb83de2d
- Release date: 2022-08-30 03:31:26
- Operating system support: linux/arm,linux/arm64,linux/386,linux/amd64  


## Preconditions

- [Scheck](../scheck/scheck-install.md) has been installed.

## Development Steps


1. Go to the installation directory and edit the configuration file `scheck.conf` to set the `enable` field to `true`:

```toml
...
[scoutput]
   # ##Messages generated during Sheck can be sent to local, http and Alibaba Cloud sls.
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
id         = 'users-checker'
category   = 'system'
level      = 'warn'
title      = 'monitor system user changes'
desc       = '{{.Content}}'
cron       = '*/10 * * * *'
instanceId = 'id-xxx'
os_arch    = ["Linux"]
```


3. Create a new script file `users.lua` in the manifest file sibling directory and edit it as follows:
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
        content=content..'新用户: '..table.concat(adds, ',')
    end
    if #dels > 0 then
        if content ~= '' then content=content..'; ' end
        content=content..'删除的用户: '..table.concat(dels, ',')
    end
    if content ~= '' then
        trigger({Content=content})
        set_cache(cache_key, currents)
    end
end

check()
```

4. When a user is added, the next 10 seconds will detect and trigger the trigger function, sending the event to the file `/var/log/scheck/event.log`, adding a row of data, for example:  

```
users-checker,category=system,level=warn,title=monitor system user changes message="new user: xxx" 1617262230001916515
```
