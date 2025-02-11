# DataKit Development Manual
---

## How to Add a New Collector {#add-input}

Assume we are adding a new collector named `zhangsan`. Generally, follow these steps:

- Create a new module `zhangsan` under `plugins/inputs`, and create an `input.go` file.
- In `input.go`, define a new struct.

```golang
// Uniformly named Input
type Input struct {
    // Collection interval
    Interval datakit.Duration
    // User-defined tags
    Tags map[string]string
    // (Optional) Cache for collected metrics; must be remade in each collection cycle
    collectCache []*point.Point
    // (Optional) Cache for collected logs; must be remade in each collection cycle
    loggingCache []*point.Point
    // Operating system type
    platform string
    // Trigger to stop the collector
    semStop *cliutils.Sem
    // (Optional) Related to election functionality
    Election bool `toml:"election"`
    // (Optional) Related to election functionality, json:"-" is used to prevent misjudgment during collector comparison
    pause bool `json:"-"`
    // (Optional) Related to election functionality, json:"-" is used to prevent misjudgment during collector comparison
    pauseCh chan bool `json:"-"`
}
```

- This struct implements several interfaces. For specific examples, refer to the `demo` collector:

```golang
// Classifier of the collector, e.g., MySQL collector belongs to the `db` category
Catalog() string                  
// Entry function of the collector, generally used for data collection and sending data to the `io` module
Run()                             
// Sample configuration for the collector
SampleConfig() string             
// Auxiliary structure for generating collector documentation
SampleMeasurement() []Measurement 
// Supported operating systems for the collector
AvailableArchs() []string 
// Read environment variables  
ReadEnv(envs map[string]string)  
// (Optional) Singleton mode, collectors with this feature can only have one instance
Singleton()
// Trigger to terminate the collector
Terminate()
// (Optional) Election functionality, set this collector not to collect data.
Pause() error
// (Optional) Election functionality, set this collector to collect data.
Resume() error
// (Optional) Election functionality, determine if this collector participates in elections.
ElectionEnabled() bool
```

<!-- markdownlint-disable MD046 -->
???+ attention

    Since new collector features are continuously added, new collectors should implement all interfaces defined in `plugins/inputs/inputs.go`.
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
            // ... Other operations for closing connections or handling resources
            return
        default:
        }

        start := time.Now()
        // if ipt.pause { // Code needed if election is enabled
        //     l.Debugf("not leader, skipped") // Code needed if election is enabled
        // } else { // Code needed if election is enabled
        // Collect data
        ipt.collectCache = make([]inputs.Measurement, 0) // Can also be placed in Collect()
        ipt.loggingCache = make([]*point.Point, 0)       // Can also be placed in Collect()
        if err := ipt.Collect(); err != nil {
            l.Errorf("Collect: %s", err)
            metrics.FeedLastError(inputName, err.Error())
        }

        // ... Upload metrics and logs

        // } // Code needed if election is enabled

        // Control loop interval
        <-tick.C
    }
}
```

- In `input.go`, add the following initialization entry:

```Golang
func init() {
    inputs.Add("zhangsan", func() inputs.Input {
        return &Input{
            // Here you can initialize a bunch of default configuration parameters for this collector
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

- To enable election functionality, besides the above changes, modify the following positions:

`LineProto()` needs modification

```golang
func (m *zhangsanMeasurement) LineProto() (*point.Point, error) {
    // Use this without election
    return point.NewPoint(m.name, m.tags, m.fields, point.MOpt())

    // Use this with election
    return point.NewPoint(m.name, m.tags, m.fields, point.MOptElectionV2(m.election))
}
```

`AvailableArchs()` needs modification to display the "election" icon in the documentation

```golang
func (*Input) AvailableArchs() []string { return datakit.AllOSWithElection }
```

The configuration file *zhangsan.conf* for this collector should include

```golang
election = true
```

- In `plugins/inputs/all/all.go`, add a new `import`:

```Golang
import (
    ... // Other existing collectors
    _ "gitlab.jiagouyun.com/cloudcare-tools/datakit/internal/plugins/inputs/zhangsan"
)
```

- Execute `make lint` to perform code checks
  
- Execute `make ut` to run all test cases

- After compiling, replace the existing DataKit binary with the newly compiled one, for example on Mac:

```shell
$ make
$ tree dist/
dist/
└── datakit-darwin-amd64
    └── datakit          # Replace the existing datakit binary usually located at /usr/local/datakit/datakit

sudo datakit service -T                                         # Stop the existing datakit
sudo truncate -s 0 /var/log/datakit/log                         # Clear logs
sudo cp -r dist/datakit-darwin-amd64/datakit /usr/local/datakit # Overwrite the binary
sudo datakit service -S                                         # Restart datakit
datakit monitor                                                 # Monitor datakit operation
```

- At this point, there will typically be a `zhangsan.conf.sample` under the directory */usr/local/datakit/conf.d/<Catalog\>/*. Note that `<Catalog\>` here is the return value of the interface `Catalog() string`.
- Enable the `zhangsan` collector by copying `zhangsan.conf.sample` to `zhangsan.conf`. If there are corresponding configurations (such as usernames, directory configurations, etc.), modify them, then restart DataKit.
- Execute the following commands to check the collector status:

```shell
sudo datakit check --config # Check if the collector configuration file is normal
datakit -M --vvv            # Check the running status of all collectors
```

- Add the `man/docs/zh/zhangsan.md` document, which can be written according to the template in `demo.md`.

- For the metrics in the documentation, by default, list all the metrics and their respective measurements that can be collected. For special measurements or metrics, if there are prerequisites, they need to be documented.
    - If a measurement requires certain conditions, it should be noted in the `MeasurementInfo.Desc`
    - If a metric within a measurement has specific prerequisites, it should be noted in `FieldInfo.Desc`

- It is recommended to execute `./b.sh` to compile and release a test version for testing by the QA team.

## Compilation Environment Setup {#setup-compile-env}

<!-- markdownlint-disable MD046 -->
=== "Linux"

    #### Install Golang
    
    Current Go version [1.18.3](https://golang.org/dl/go1.18.3.linux-amd64.tar.gz){:target="_blank"}
    
    #### CI Configuration
    
    > Assume Go is installed in the /root/golang directory
    
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
    
    # Assume Go is installed in the /root directory
    export GOROOT=/root/golang-1.18.3
    # Clone Go code into GOPATH
    export GOPATH=/root/go
    export PATH=$GOROOT/bin:~/go/bin:$PATH
    ```
    
    In `~/.ossenv`, create a set of environment variables, fill in OSS Access Key and Secret Key for version release:
    
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
    - Linux kernel (>= 5.4.0-99-generic) headers: `apt-get install -y linux-headers-$(uname -r)` 
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

    - IBM Db2 ODBC/CLI driver (only for Linux OS). Refer to the [IBM Db2 integration documentation](../integrations/db2.md#reqirement){:target="_blank"}.

=== "Mac"

    Not supported yet

=== "Windows"

    Not supported yet
<!-- markdownlint-enable -->

## Installation and Upgrade Testing {#install-upgrade-testing}

When releasing new features for DataKit, it's best to conduct comprehensive tests including installation and upgrades. All existing DataKit installation files are stored on OSS, so we use another isolated OSS bucket for installation and upgrade testing.

Try using this *preset OSS path*: `oss://df-storage-dev/` (East China region). If necessary, apply for the following AK/SK:

> You can download the [OSS Browser](https://help.aliyun.com/document_detail/209974.htm?spm=a2c4g.11186623.2.4.2f643d3bbtPfN8#task-2065478){:target="_blank"} client tool to view files in OSS.

- AK: `LTAIxxxxxxxxxxxxxxxxxxxx`
- SK: `nRr1xxxxxxxxxxxxxxxxxxxxxxxxxx`

In this OSS bucket, each developer has a subdirectory for storing their Datakit test files. The specific script is in the source code *scripts/build.sh*. Copy it to the root directory of the Datakit source code, make slight modifications, and it can be used for local compilation and release.

### Custom Directory Running DataKit {#customize-workdir}

By default, Datakit runs as a service in a specified directory (Linux: */usr/local/datakit*), but through additional methods, you can customize the Datakit working directory, allowing it to run in non-service mode and read configurations and data from the specified directory. This is mainly used for debugging DataKit functionalities during development.

- Update the latest code (dev branch)
- Compile
- Create the expected DataKit working directory, for example `mkdir -p ~/datakit/conf.d`
- Generate the default *datakit.conf* configuration file. For Linux, execute:

```shell
./dist/datakit-linux-amd64/datakit tool --default-main-conf > ~/datakit/conf.d/datakit.conf
```

- Modify the generated *datakit.conf*:

    - Fill in `default_enabled_inputs` with the list of collectors you want to enable, usually `cpu,disk,mem`, etc.
    - Change the `http_api.listen` address
    - Change the token in `dataway.urls`
    - Adjust logging directory/level if necessary

- Start DataKit, for Linux: `DK_DEBUG_WORKDIR=~/datakit ./dist/datakit-linux-amd64/datakit`
- You can add an alias in your local bash to directly run `ddk` after compiling DataKit (i.e., Debugging-DataKit):

```shell
echo 'alias ddk="DK_DEBUG_WORKDIR=~/datakit ./dist/datakit-linux-amd64/datakit"' >> ~/.bashrc
source ~/.bashrc
```

This way, DataKit does not run as a service and can be stopped with Ctrl+C directly:

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

You can also use `ddk` to execute some command-line tools directly:

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

Testing in Datakit is primarily divided into two categories: integration tests and unit tests. Essentially, there is no significant difference between them. Integration tests require more external environments.

Running `make ut` will run all test cases. However, these test cases include both integration and unit tests. For integration tests, Docker is required. Here’s an example of running tests during development:

- Configure a remote Docker, or use a local Docker installation. If using a remote Docker, configure its remote connection capability.
- Create a shell alias to start `make ut`:

```shell
alias ut='REMOTE_HOST=<YOUR-DOCKER-REMOTE-HOST> make ut'
```

Additional configurations:

- If you want to exclude some package tests (they may temporarily fail), add the corresponding package name after `make ut`, e.g., `UT_EXCLUDE="gitlab.jiagouyun.com/cloudcare-tools/datakit/internal/plugins/inputs/snmp"`
- If you want to send test metrics to Guance, add a Dataway URL and the corresponding workspace token, e.g., `DATAWAY_URL="https://openway.guance.com/v1/write/logging?token=<YOUR-TOKEN>"`

A complete example is as follows:

```shell
alias ut='REMOTE_HOST=<YOUR-DOCKER-REMOTE-HOST> make ut UT_EXCLUDE="<package-name>" DATAWAY_URL="https://openway.guance.com/v1/write/logging?token=<YOUR-TOKEN>"'
```

## Release {#release}

DataKit version release includes two parts:

- DataKit version release
- Yufaq (Yuque) documentation release

### DataKit Version Release {#release-dk}

Datakit version releases are currently implemented in GitLab. When specific branch code is pushed to GitLab, it triggers the corresponding version release, see *.gitlab-ci.yml*.

Prior to version 1.2.6 (inclusive), DataKit version releases depended on the output of `git describe --tags`. Since version 1.2.7, DataKit versions no longer rely on this mechanism but are manually specified, with the following steps:

> Note: The current script/build.sh still depends on `git describe --tags`, but this is just a version retrieval strategy and does not affect the main process.

- Edit *.gitlab-ci.yml* and modify the `VERSION` variable inside, such as:

```yaml
    - make production GIT_BRANCH=$CI_COMMIT_BRANCH VERSION=1.2.8
```

Each version release requires manually editing *.gitlab-ci.yml* to specify the version number.

- After the version release is complete, add a tag to the code:

```shell
git tag -f <same-as-the-new-version>
git push -f --tags
```

> Note: Mac version releases are currently only possible on Macs with amd64 architecture due to CGO being enabled, preventing Mac version releases on GitLab. The implementation is as follows:

```shell
make production_mac VERSION=<the-new-version>
make pub_production_mac VERSION=<the-new-version>
```

### DataKit Version Numbering {#version-naming}

- Stable version: Its version number is `x.y.z`, where `y` must be even.
- Unstable version: Its version number is `x.y.z`, where `y` must be odd.

### Documentation Release {#release-docs}

Documentation can only be released from a development machine and requires installing [MkDocs](https://www.mkdocs.org/){:target="_blank"}. The process is as follows:

- Execute *mkdocs.sh* (for more command-line options, run `./mkdocs.sh -h`):

``` shell
./mkdocs.sh
```

If no version is specified, it defaults to the latest tag name.

> Note: For online code releases, ensure consistency with the **current stable version of online DataKit** to avoid confusion for users.

## Coding Standards {#coding-rules}

We do not emphasize specific coding standards here. Existing tools help us standardize our coding habits. Currently, the *golint* tool can be used to check existing code individually:

```golang
make lint
```

Suggestions for modifications can be seen in check.err. For false positives, we can explicitly disable checks using `//nolint`:

```golang
// Obviously, 16 is the largest single-byte hexadecimal number, but lint's gomnd will report an error:
// mnd: Magic number: 16, in <return> detected (gomnd)
// But this check can be disabled by adding a suffix
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

> For when to use `nolint`, see [here](https://golangci-lint.run/usage/false-positives/){:target="_blank"}

However, we do not recommend frequently adding `//nolint:xxx,yyy` to ignore warnings. Lint can be used in the following situations:

- Well-known magic numbers, like 1024 for 1K, 16 for the largest single-byte value.
- Some security alerts that are indeed irrelevant, such as running a command with parameters passed from outside, but since lint tools mention it, consider potential security issues.

```golang
// cmd/datakit/cmds/monitor.go
cmd := exec.Command("/bin/bash", "-c", string(body)) //nolint:gosec
```

- Other places where it might be necessary to disable checks, handle with caution.

## Troubleshooting DATA RACE Issues {#data-race}

There are many DATA RACE issues in DataKit. These can be detected by compiling DataKit with specific options to automatically detect DATA RACE problems during runtime.

Compiling DataKit with automatic DATA RACE detection requires:

- CGO must be enabled, so only `make local` (default execution of `make`) is allowed.
- Must pass the Makefile variable: `make RACE_DETECTION=on`

The compiled binary will be slightly larger, but it's negligible. We only need it for local testing. Automatic DATA RACE detection has a characteristic: it only detects when the code reaches specific sections, so it's recommended to always compile with `RACE_DETECTION=on` to catch all DATA RACE code early.

### DATA RACE Does Not Necessarily Cause Data Corruption {#data-race-mess}

When running a binary with DATA RACE detection, if two goroutines access the same data and one performs a write operation, a warning similar to the following will be printed:

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

From this information, you can see that two pieces of code are accessing the same data object, and at least one is performing a write operation. However, note that this is only a WARNING message, indicating that this code may not necessarily cause data corruption, and ultimately, manual verification is required. For example, the following code will not cause data corruption:

```golang

a = setupObject()

go func() {
    for {
        updateObject(a)
    }
}()
```

## Troubleshooting DataKit Memory Leaks {#mem-leak}

[:octicons-tag-24: Version-1.9.2](changelog.md#cl-1.9.2) has enabled pprof functionality by default.

Edit *datakit.conf* and add the following configuration field at the top to enable remote pprof for DataKit:

```toml
enable_pprof = true
```

> If Datakit is installed via DaemonSet, inject the environment variable:

```yaml
- name: ENV_ENABLE_PPROF
  value: true
```

Restart DataKit for the changes to take effect.

### Obtain pprof Files {#get-pprof}

```shell
# Download the current active memory pprof file for DataKit
wget http://<datakit-ip>:6060/debug/pprof/heap

# Download the total allocated memory pprof file for DataKit (including already released memory)
wget http://<datakit-ip>:6060/debug/pprof/allocs
```

> Port 6060 is fixed and cannot be changed.

You can also visit `http://<datakit-ip>:6060/debug/pprof/heap?=debug=1` via a web browser to view some memory allocation information.

### View pprof Files {#use-pprof}

After downloading locally, run the following command. Enter interactive mode and input `top` to view the top 10 memory hotspots:

```shell
$ go tool pprof heap 
File: datakit
Type: inuse_space
Time: Feb 23, 2022 at 9:06pm (CST)
Entering interactive mode (type "help" for commands, "o" for options)
(pprof) top                            <------ View the top 10 memory hotspots
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
(pprof) web                            <------ View directly in the browser, same as PDF
```

> Use `go tool pprof -sample_index=inuse_objects heap` to view object allocation details, see `go tool pprof -help` for more information.

Similarly, you can view the total allocated memory pprof file `allocs`. The PDF effect is roughly as follows:

<figure markdown>
  ![](https://static.guance.com/images/datakit/datakit-pprof-pdf.png){ width="800" }
</figure>

For more pprof usage methods, see [here](https://www.freecodecamp.org/news/how-i-investigated-memory-leaks-in-go-using-pprof-on-a-large-codebase-4bec4325e192/){:target="_blank"}.

## DataKit Auxiliary Functions {#assist}

In addition to the auxiliary functions listed in the [official documentation](datakit-tools-how-to.md), DataKit supports other functionalities mainly used during development.

### Check Sample Configurations {#check-sample-config}

```shell
datakit check --sample
------------------------
checked 52 sample, 0 ignored, 51 passed, 0 failed, 0 unknown, cost 10.938125ms
```

### Export Documentation {#export-docs}

Export existing DataKit documentation to a specified directory, specifying the documentation version, replacing `TODO` with `-`, and ignoring the `demo` collector:

```shell
man_version=`git tag -l | sort -nr | head -n 1` # Get the most recent tag version
datakit doc --export-docs /path/to/doc --version $man_version --TODO "-" --ignore demo
```

## Further Reading {#more-readings}

- [DataKit Monitor Explorer](datakit-monitor.md)
- [Overall Architecture of DataKit](datakit-arch.md)