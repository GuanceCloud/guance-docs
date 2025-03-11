# DataKit Development Manual
---

## How to Add a Collector {#add-input}

Assume you are adding a new collector named `zhangsan`. Generally, follow these steps:

- Create a new module `zhangsan` under `plugins/inputs`, and create an `input.go`.
- In `input.go`, define a new struct.

```golang
// Uniformly named Input
type Input struct {
    // Collection interval
    Interval datakit.Duration
    // User-defined tags
    Tags map[string]string
    // (Optional) Cache for collected metrics, must be re-made in each collection cycle
    collectCache []*point.Point
    // (Optional) Cache for collected logs, must be re-made in each collection cycle
    loggingCache []*point.Point
    // Operating system type
    platform string
    // Trigger stopping the collector
    semStop *cliutils.Sem
    // (Optional) Related to election functionality
    Election bool `toml:"election"`
    // (Optional) Related to election functionality, json:"-" is used to prevent misjudgment during comparison
    pause bool `json:"-"`
    // (Optional) Related to election functionality, json:"-" is used to prevent misjudgment during comparison
    pauseCh chan bool `json:"-"`
}
```

- This struct implements several interfaces. For specific examples, refer to the `demo` collector:

```golang
// Classification of the collector, for example, MySQL collector belongs to the `db` category
Catalog() string                  
// Entry function of the collector, generally this is where data collection occurs, and data is sent to the `io` module
Run()                             
// Sample configuration of the collector
SampleConfig() string             
// Auxiliary structure for generating collector documentation
SampleMeasurement() []Measurement 
// Supported operating systems for the collector
AvailableArchs() []string 
// Read environment variables  
ReadEnv(envs map[string]string)  
// (Optional) Singleton pattern, collectors with this feature can only have one instance
Singleton()
// Trigger stopping the collector
Terminate()
// (Optional) Election functionality, set this collector not to collect data.
Pause() error
// (Optional) Election functionality, set this collector to start collecting data.
Resume() error
// (Optional) Election functionality, set whether this collector participates in elections.
ElectionEnabled() bool
```

<!-- markdownlint-disable MD046 -->
???+ attention

    Since new collector features are continuously added, new collectors should implement all interfaces in `plugins/inputs/inputs.go`.
<!-- markdownlint-enable -->

- Suggested structure for the `Run()` method:

```Golang
func (ipt *Input) Run() {

    // (Optional) ... Connect resources, prepare resources

    tick := time.NewTicker(ipt.Interval.Duration)
    defer tick.Stop()

    // Main collection loop
    for {
        select {
        // case ipt.pause = <-ipt.pauseCh: // Only needed for election
        case <-datakit.Exit.Wait():
            return
        case <-ipt.semStop.Wait():
            // ... Other close connection, resource operations
            return
        default:
        }

        start := time.Now()
        // if ipt.pause { // Code needed for election
        //     l.Debugf("not leader, skipped") // Code needed for election
        // } else { // Code needed for election
        // Collect data
        ipt.collectCache = make([]inputs.Measurement, 0) // Can also be placed in Collect()
        ipt.loggingCache = make([]*point.Point, 0)       // Can also be placed in Collect()
        if err := ipt.Collect(); err != nil {
            l.Errorf("Collect: %s", err)
            metrics.FeedLastError(inputName, err.Error())
        }

        // ... Upload metrics and logs

        // } // Code needed for election

        // Control loop interval
        <-tick.C
    }
}
```

- Add the following initialization entry in `input.go`:

```Golang
func init() {
    inputs.Add("zhangsan", func() inputs.Input {
        return &Input{
            // Here initialize a bunch of default configuration parameters for this collector
            platform:       runtime.GOOS,
            Interval:       datakit.Duration{Duration: time.Second * 10},
            semStop:        cliutils.NewSem(),
            Tags:           make(map[string]string),
            // (Optional) Election functionality
            pauseCh:  make(chan bool, inputs.ElectionPauseChannelLength),
            // (Optional) Election functionality
            Election: true,
        }
    })
}
```

- To enable election functionality, besides the above differences, modify the following positions:

`LineProto()` needs modification

```golang
func (m *zhangsanMeasurement) LineProto() (*point.Point, error) {
    // Use this without election
    return point.NewPoint(m.name, m.tags, m.fields, point.MOpt())

    // Use this with election
    return point.NewPoint(m.name, m.tags, m.fields, point.MOptElectionV2(m.election))
}
```

`AvailableArchs()` needs modification to display the "Election" icon in the documentation

```golang
func (*Input) AvailableArchs() []string { return datakit.AllOSWithElection }
```

The configuration file *zhangsan.conf* for this collector should include

```golang
election = true
```

- In `plugins/inputs/all/all.go`, add the `import`:

```Golang
import (
    ... // Other existing collectors
    _ "gitlab.jiagouyun.com/cloudcare-tools/datakit/internal/plugins/inputs/zhangsan"
)
```

- Execute `make lint`: Perform code checks
  
- Execute `make ut`: Run all test cases

- After compiling, replace the existing DataKit binary with the newly compiled one, for example on Mac:

```shell
$ make
$ tree dist/
dist/
└── datakit-darwin-amd64
    └── datakit          # Replace the existing datakit binary, usually located at /usr/local/datakit/datakit

sudo datakit service -T                                         # Stop the running datakit
sudo truncate -s 0 /var/log/datakit/log                         # Clear logs
sudo cp -r dist/datakit-darwin-amd64/datakit /usr/local/datakit # Overwrite the binary
sudo datakit service -S                                         # Restart datakit
datakit monitor                                                 # Monitor datakit's operation
```

- At this point, there should be a `zhangsan.conf.sample` in the */usr/local/datakit/conf.d/<Catalog\>/* directory. Note that *<Catalog\>* here is the return value of the interface `Catalog() string`.
- Enable the `zhangsan` collector by copying `zhangsan.conf.sample` to `zhangsan.conf`. Modify it as necessary (e.g., username, directory configuration), then restart DataKit.
- Check the collector status using the following commands:

```shell
sudo datakit check --config # Check if the collector configuration file is normal
datakit -M --vvv            # Check the operation status of all collectors
```

- Add the `man/docs/en/zhangsan.md` document. Refer to `demo.md` and use its template.

- For metrics in the document, by default list all collectable metrics sets and their respective metrics. If certain metrics or metric sets have prerequisites, explain them in the document.
    - If a metric set requires specific conditions, explain it in the `MeasurementInfo.Desc` of the metric set.
    - If a specific metric within a metric set has prerequisites, explain it in the `FieldInfo.Desc`.

- It is recommended to run `./b.sh` for testing version compilation and release, which can then be handed over to the testing team.

## Compilation Environment Setup {#setup-compile-env}

<!-- markdownlint-disable MD046 -->
=== "Linux"

    #### Install Golang
    
    Current Go version [1.18.3](https://golang.org/dl/go1.18.3.linux-amd64.tar.gz){:target="_blank"}
    
    #### CI Configuration
    
    > Assume go is installed in /root/golang directory
    
    - Set up directories
    
    ```
    # Create Go project path
    mkdir /root/go
    ```
    
    - Set the following environment variables
    
    ```
    export GO111MODULE=on
    # Set the GOPROXY environment variable
    export GOPRIVATE=gitlab.jiagouyun.com/*
    
    export GOPROXY=https://goproxy.io
    
    # Assume golang is installed in /root
    export GOROOT=/root/golang-1.18.3
    # Clone go code into GOPATH
    export GOPATH=/root/go
    export PATH=$GOROOT/bin:~/go/bin:$PATH
    ```
    
    Create a set of environment variables in `~/.ossenv`, fill in OSS Access Key and Secret Key for version release:
    
    ```shell
    export RELEASE_OSS_ACCESS_KEY='LT**********************'
    export RELEASE_OSS_SECRET_KEY='Cz****************************'
    export RELEASE_OSS_BUCKET='zhuyun-static-files-production'
    export RELEASE_OSS_PATH=''
    export RELEASE_OSS_HOST='oss-cn-hangzhou-internal.aliyuncs.com'
    ```
    
    #### Install Common Tools
    
    - `tree`
    - `make`
    - [`goyacc`](https://gist.github.com/tlightsky/9a163e59b6f3b05dbac8fc6b459a43c0){:target="_blank"}: `go install golang.org/x/tools/cmd/goyacc@master`
    - [`golangci-lint`](https://golangci-lint.run/usage/install/#local-installation){:target="_blank"}: `go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.46.2`
    - `gofumpt`: `go install mvdan.cc/gofumpt@v0.1.1`
    - `wget`
    - Docker
    - `curl`
    - [LLVM](https://apt.llvm.org/){:target="_blank"}: Version >= 10.0
    - Clang: Version >= 10.0
    - Linux kernel headers (>= 5.4.0-99-generic): `apt-get install -y linux-headers-$(uname -r)` 
    - [cspell](https://cspell.org/){:target="_blank"}: `npm install -g cspell@6.31.1`
    - [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli){:target="_blank"}: `npm install -g markdownlint-cli@0.34.0`

    #### Install Third-party Libraries
    
    - `gcc-multilib`
    
    ```shell
    # Debian/Ubuntu
    sudo apt-get install -y gcc-multilib
    sudo apt-get install -y linux-headers-$(uname -r)
    # Centos: TODO
    ```

    - IBM Db2 ODBC/CLI driver (only for Linux). Refer to the [IBM Db2 integration documentation](../integrations/db2.md#reqirement){:target="_blank"}.

=== "Mac"

    Not supported yet

=== "Windows"

    Not supported yet
<!-- markdownlint-enable -->

## Installation and Upgrade Testing {#install-upgrade-testing}

When releasing new DataKit features, it is best to perform comprehensive tests, including installation and upgrade processes. All current DataKit installation files are stored on OSS. We will use another isolated OSS bucket for installation and upgrade testing.

Try this *preset OSS path*: `oss://df-storage-dev/` (East China region). The following AK/SK can be applied for if needed:

> You can download the [OSS Browser](https://help.aliyun.com/document_detail/209974.htm?spm=a2c4g.11186623.2.4.2f643d3bbtPfN8#task-2065478){:target="_blank"} client tool to view files in OSS.

- AK: `LTAIxxxxxxxxxxxxxxxxxxxx`
- SK: `nRr1xxxxxxxxxxxxxxxxxxxxxxxxxx`

In this OSS bucket, each developer has a subdirectory to store their Datakit test files. The specific script is in the source code *scripts/build.sh*. Copy it to the root directory of the Datakit source code, make slight modifications, and it can be used for local compilation and release.

### Running DataKit in Custom Directory {#customize-workdir}

By default, Datakit runs as a service in a specified directory (*/usr/local/datakit* on Linux). However, through additional methods, you can customize the Datakit working directory, allowing it to run non-service mode and read configurations and data from a specified directory, mainly for debugging DataKit functionalities during development.

- Update the latest code (dev branch)
- Compile
- Create the expected DataKit working directory, e.g., `mkdir -p ~/datakit/conf.d`
- Generate the default *datakit.conf* configuration file. For Linux, execute

```shell
./dist/datakit-linux-amd64/datakit tool --default-main-conf > ~/datakit/conf.d/datakit.conf
```

- Modify the generated *datakit.conf*:

    - Fill in `default_enabled_inputs`, add the list of collectors you want to enable, generally `cpu,disk,mem`, etc.
    - Change the `http_api.listen` address
    - Modify the token in `dataway.urls`
    - Adjust the logging directory/level if necessary

- Start DataKit, for Linux, use: `DK_DEBUG_WORKDIR=~/datakit ./dist/datakit-linux-amd64/datakit`
- You can add an alias in your local bash so you can run `ddk` after compiling DataKit:

```shell
echo 'alias ddk="DK_DEBUG_WORKDIR=~/datakit ./dist/datakit-linux-amd64/datakit"' >> ~/.bashrc
source ~/.bashrc
```

This way, DataKit does not run as a service and can be stopped directly with Ctrl+C

```shell
$ ddk
2021-08-26T14:12:54.647+0800    DEBUG   config  config/load.go:55       apply main configure...
2021-08-26T14:12:54.647+0800    INFO    config  config/cfg.go:361       set root logger to /tmp/datakit/log ok
[GIN-debug] [WARNING] Running in "debug" mode. Switch to "release" mode in production.
 - using env:   export GIN_MODE=release
  - using code:  gin.SetMode(gin.ReleaseMode)

    [GIN-debug] GET    /stats                    --> gitlab.jiagouyun.com/cloudcare-tools/datakit/http.HttpStart.func1 (4 handlers)
    [GIN-debug] GET    /monitor                  --> gitlab.jiagouyun.com/cloudcare-tools/datakit/http.HttpStart.func2 (4 handlers)
    [GIN-debug] GET    /man                      --> gitlab.jiagouyun.com/cloudcare-tools/datakit/http.HttpStart.func3 (4 handlers)
    [GIN-debug] GET    /man/:name                --> gitlab.jiagouyun.com/cloudcare-tools/datakit/http.HttpStart.func4 (4 handlers)
    [GIN-debug] GET    /restart                  --> gitlab.jiagouyun.com/cloudcare-tools/datakit/http.HttpStart.func5 (4 handlers)
    ...
```

You can also use `ddk` to run some command-line tools directly:

```shell
# Install IPDB
ddk install --ipdb iploc

# Query IP information
ddk debug --ipinfo 1.2.3.4
        city: Brisbane
    province: Queensland
     country: AU
         isp: unknown
          ip: 1.2.3.4
```

## Testing {#testing}

Testing in Datakit is mainly divided into two categories: integration tests and unit tests. Essentially, there isn't much difference between them. Integration tests just require more external environments.

Running `make ut` generally runs all test cases. These test cases include both integration and unit tests. For integration tests, Docker participation is required. Here's an example of running tests during development.

- Configure a remote Docker, or use a locally installed Docker. If using a remote Docker, [configure its remote connection capability](https://medium.com/@ssmak/how-to-enable-docker-remote-api-on-docker-host-7b73bd3278c6){:target="_blank"}.
- Make a shell alias to start `make ut`:

```shell
alias ut='REMOTE_HOST=<YOUR-DOCKER-REMOTE-HOST> make ut'
```

Additional configurations:

- If you want to exclude some packages from testing (they may temporarily fail), add the corresponding package name after `make ut`, for example: `UT_EXCLUDE="gitlab.jiagouyun.com/cloudcare-tools/datakit/internal/plugins/inputs/snmp"`
- If you want to send test metrics to Guance, add a Dataway URL and the corresponding workspace token, like `DATAWAY_URL="https://openway.guance.com/v1/write/logging?token=<YOUR-TOKEN>"`

A complete example is as follows:

```shell
alias ut='REMOTE_HOST=<YOUR-DOCKER-REMOTE-HOST> make ut UT_EXCLUDE="<package-name>" DATAWAY_URL="https://openway.guance.com/v1/write/logging?token=<YOUR-TOKEN>"'
```

## Release {#release}

DataKit release includes two parts:

- DataKit version release
- Yuque documentation release

### DataKit Version Release {#release-dk}

Current DataKit version releases are implemented in GitLab. Once code from a specific branch is pushed to GitLab, it triggers the corresponding version release, see *.gitlab-ci.yml*.

Before version 1.2.6 (inclusive), DataKit version releases relied on the output of `git describe --tags`. Starting from version 1.2.7, DataKit versions no longer depend on this mechanism but are manually specified. Steps are as follows:

> Note: Currently, `script/build.sh` still relies on `git describe --tags`, this is only a version acquisition strategy issue and does not affect the main flow.

- Edit *.gitlab-ci.yml*, modify the `VERSION` variable inside, such as:

```yaml
    - make production GIT_BRANCH=$CI_COMMIT_BRANCH VERSION=1.2.8
```

Each version release requires manually editing *.gitlab-ci.yml* to specify the version number.

- After the version release is completed, add a tag to the code

```shell
git tag -f <same-as-the-new-version>
git push -f --tags
```

> Note: Mac version releases can currently only be done on amd64 architecture Macs due to CGO being enabled, preventing Mac version releases on GitLab. The implementation is as follows:

```shell
make production_mac VERSION=<the-new-version>
make pub_production_mac VERSION=<the-new-version>
```

### DataKit Version Number Mechanism {#version-naming}

- Stable version: Its version number is `x.y.z`, where `y` must be even.
- Unstable version: Its version number is `x.y.z`, where `y` must be odd.

### Documentation Release {#release-docs}

Documentation can only be released from the development machine and requires installing [MkDocs](https://www.mkdocs.org/){:target="_blank"}. The process is as follows:

- Execute *mkdocs.sh* (for more command-line options, run `./mkdocs.sh -h`)

``` shell
./mkdocs.sh
```

If no version is specified, it defaults to the latest tag name.

> Note: For online code releases, ensure consistency with the **current stable version** of online DataKit to avoid confusion for users.

## Coding Standards {#coding-rules}

We do not emphasize specific coding standards here. Existing tools can help standardize our coding habits. Currently, we introduce the *golint* tool to individually inspect existing code:

```golang
make lint
```

Various modification suggestions can be seen in `check.err`. For false positives, we can explicitly disable them with `//nolint`:

```golang
// Obviously, 16 is the largest single-byte hexadecimal number, but lint's gomnd reports an error:
// mnd: Magic number: 16, in <return> detected (gomnd)
// But here we can add a suffix to suppress this check
func digitVal(ch rune) int {
    switch {
    case '0' <= ch && ch <= '9':
        return int(ch - '0')
    case 'a' <= ch && ch <= 'f':
        return int(ch - 'a' + 10)
    case 'A' <= ch && ch <= 'F':
        return int(ch - 'A' + 10)
    }

    // larger than any legal digit val
    return 16 //nolint:gomnd
}
```

> When to use `nolint`, refer to [here](https://golangci-lint.run/usage/false-positives/){:target="_blank"}

However, we do not recommend frequently adding `//nolint:xxx,yyy` to ignore warnings. The following situations can use lint:

- Well-known magic numbers, such as 1024 representing 1K, 16 being the largest single-byte value.
- Some irrelevant security warnings, for example, running a command in the code with parameters passed externally. Although the lint tool mentions it, it is necessary to consider potential security issues.

```golang
// cmd/datakit/cmds/monitor.go
cmd := exec.Command("/bin/bash", "-c", string(body)) //nolint:gosec
```

- Other places where checking might indeed need to be disabled, handle cautiously.

## Diagnosing DATA RACE Issues {#data-race}

There are many DATA RACE issues in DataKit. These can be detected by adding specific options during DataKit compilation to automatically detect DATA RACE in the compiled binary during runtime.

Compiling DataKit with automatic DATA RACE detection requires the following conditions:

- CGO must be enabled, so only `make local` can be used (default execution of `make` is sufficient).
- Must pass the Makefile variable: `make RACE_DETECTION=on`

The compiled binary will be slightly larger, but this is negligible. We only need to test it locally. Automatic DATA RACE detection has a characteristic: it can only detect when the code reaches a specific section, so it is recommended to always compile with `RACE_DETECTION=on` during daily testing to discover all code causing DATA RACE as early as possible.

### DATA RACE Does Not Necessarily Cause Data Corruption {#data-race-mess}

When running a binary with DATA RACE detection, if two goroutines access the same data and one of them performs a write operation, a warning message similar to the following will be printed:

```shell hl_lines="8 9 10 11"
==================
WARNING: DATA RACE
Read at 0x00c000d40160 by goroutine 33:
  gitlab.jiagouyun.com/cloudcare-tools/datakit/vendor/github.com/GuanceCloud/cliutils/dialtesting.(*HTTPTask).GetResults()
      /Users/tanbiao/go/src/gitlab.jiagouyun.com/cloudcare-tools/datakit/vendor/github.com/GuanceCloud/cliutils/dialtesting/http.go:208 +0x103c
    ...

Previous write at 0x00c000d40160 by goroutine 74:
  gitlab.jiagouyun.com/cloudcare-tools/datakit/vendor/github.com/GuanceCloud/cliutils/dialtesting.(*HTTPTask).Run.func2()
      /Users/tanbiao/go/src/gitlab.jiagouyun.com/cloudcare-tools/datakit/vendor/github.com/GuanceCloud/cliutils/dialtesting/http.go:306 +0x8c
    ...
```

From these two pieces of information, you can determine that two pieces of code are operating on the same data object, with at least one performing a Write operation. However, note that this prints only WARNING information, meaning this code may not necessarily cause data problems. The final problem still needs manual verification, for example, the following code will not have data problems:

```golang

a = setupObject()

go func() {
    for {
        updateObject(a)
    }
}()
```

## Diagnosing DataKit Memory Leaks {#mem-leak}

[:octicons-tag-24: Version-1.9.2](changelog.md#cl-1.9.2) has pprof functionality enabled by default.

Edit *datakit.conf*, add the following configuration field at the top to enable DataKit's remote pprof functionality:

```toml
enable_pprof = true
```

> If installing Datakit via DaemonSet, inject the environment variable:

```yaml
- name: ENV_ENABLE_PPROF
  value: true
```

Restart DataKit for changes to take effect.

### Obtain pprof Files {#get-pprof}

```shell
# Download the current active memory pprof file of DataKit
wget http://<datakit-ip>:6060/debug/pprof/heap

# Download the total allocated memory pprof file of DataKit (including already freed memory)
wget http://<datakit-ip>:6060/debug/pprof/allocs
```

> The port 6060 is fixed and cannot be modified for now.

Alternatively, visiting `http://<datakit-ip>:6060/debug/pprof/heap?=debug=1` via web can also view some memory allocation information.

### View pprof Files {#use-pprof}

After downloading locally, run the following command. In interactive mode, you can enter `top` to view the top 10 memory hotspots:

```shell
$ go tool pprof heap 
File: datakit
Type: inuse_space
Time: Feb 23, 2022 at 9:06pm (CST)
Entering interactive mode (type "help" for commands, "o" for options)
(pprof) top                            <------ View top 10 memory hotspots
Showing nodes accounting for 7719.52kB, 88.28% of 8743.99kB total
Showing top 10 nodes out of 108
flat  flat%   sum%        cum   cum%
2048.45kB 23.43% 23.43%  2048.45kB 23.43%  gitlab.jiagouyun.com/cloudcare-tools/datakit/vendor/github.com/alecthomas/chroma.NewLexer
1031.96kB 11.80% 35.23%  1031.96kB 11.80%  regexp/syntax.(*compiler).inst
902.59kB 10.32% 45.55%   902.59kB 10.32%  compress/flate.NewWriter
591.75kB  6.77% 52.32%   591.75kB  6.77%  bytes.makeSlice
561.50kB  6.42% 58.74%   561.50kB  6.42%  gitlab.jiagouyun.com/cloudcare-tools/datakit/vendor/golang.org/x/net/html.init
528.17kB  6.04% 64.78%   528.17kB  6.04%  regexp.(*bitState).reset
516.01kB  5.90% 70.68%   516.01kB  5.90%  io.glob..func1
513.50kB  5.87% 76.55%   513.50kB  5.87%  gitlab.jiagouyun.com/cloudcare-tools/datakit/vendor/github.com/gdamore/tcell/v2/terminfo/v/vt220.init.0
513.31kB  5.87% 82.43%   513.31kB  5.87%  gitlab.jiagouyun.com/cloudcare-tools/datakit/vendor/k8s.io/apimachinery/pkg/conversion.ConversionFuncs.AddUntyped
512.28kB  5.86% 88.28%   512.28kB  5.86%  encoding/pem.Decode
(pprof) 
(pprof) pdf                            <------ Output as PDF, i.e., profile001.pdf will be generated in the current directory
Generating report in profile001.pdf
(pprof) 
(pprof) web                            <------ Directly view in the browser, same effect as PDF
```

> Use `go tool pprof -sample_index=inuse_objects heap` to view object allocation situations, refer to `go tool pprof -help` for more details.

Similarly, you can view the total allocated memory pprof file `allocs`. The PDF effect looks something like this:

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-pprof-pdf.png){ width="800" }
</figure>

For more usage methods of pprof, refer to [here](https://www.freecodecamp.org/news/how-i-investigated-memory-leaks-in-go-using-pprof-on-a-large-codebase-4bec4325e192/){:target="_blank"}.

## DataKit Auxiliary Functions {#assist}

In addition to the auxiliary functions listed in the [official documentation](datakit-tools-how-to.md), DataKit supports other functionalities mainly used during development.

### Check Sample Configurations {#check-sample-config}

```shell
datakit check --sample
------------------------
checked 52 sample, 0 ignored, 51 passed, 0 failed, 0 unknown, cost 10.938125ms
```

### Export Documentation {#export-docs}

Export existing DataKit documentation to a specified directory, specifying the documentation version, replacing `TODO` with `-`, and ignoring the `demo` collector

```shell
man_version=`git tag -l | sort -nr | head -n 1` # Get the most recently released tag version
datakit doc --export-docs /path/to/doc --version $man_version --TODO "-" --ignore demo
```

## Further Reading {#more-readings}

- [DataKit Monitor Explorer](datakit-monitor.md)
- [Overall Architecture of DataKit](datakit-arch.md)
