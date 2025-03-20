---
title     : 'DDTrace C++'
summary   : 'DDTrace C++ Integration'
tags      :
  - 'APM'
  - 'C/C++'
__int_icon: 'icon/ddtrace'
---

To apply DDTrace in C++ code, you need to modify the business code, and there is no corresponding SDK integration for common MIDDLEWARE and libraries. **Manual instrumentation must be performed in the existing business code**.

## Install Libraries and Dependencies {#dependence}

<!-- markdownlint-disable MD046 -->
=== "Linux/macOS"

    - Download the DDTrace-C++ SDK
    
    ```shell
    git clone https://github.com/DataDog/dd-opentracing-cpp
    ```
    
    - Compile and install the SDK
    
    ```shell
    # Install dependencies
    cd dd-opentracing-cpp && sudo scripts/install_dependencies.sh
    
    # Compile and install
    mkdir .build && cd .build && cmake .. && make && make install
    ```

    If there are issues compiling the SDK, you can temporarily use the [header files][5] and [dynamic library][6] prepared by <<< custom_key.brand_name >>> for testing.

=== "Windows"

    Coming Soon...

???+ attention "cmake Installation"

    It may not be possible to install a higher version of cmake via yum or apt-get. We recommend downloading the latest version directly from its [website][3]{:target="_blank"}. You can also use the [source code][1] or [Windows binary][2] hosted by <<< custom_key.brand_name >>>.
    
    ```shell
    # Install cmake from source
    wget https://static.<<< custom_key.brand_main_domain >>>/gfw/cmake-3.24.2.tar.gz
    tar -zxvf cmake-3.24.2.tar.gz
    ./bootstrap --prefix=/usr/local
    make
    make install

    # Verify the current version
    cmake --version
    cmake version 3.24.2
    ```

    Install gcc version 7.x:

    ```shell
    yum install centos-release-scl
    yum install devtoolset-7-gcc*
    scl enable devtoolset-7 bash
    which gcc
    gcc --version
    ```
<!-- markdownlint-enable -->

## C++ Code Example {#simple-example}

The following C++ code demonstrates basic trace instrumentation operations, simulating a business operation that reads a local disk file.

```cpp linenums="1" hl_lines="1-2 13-14 40-43 53" title="demo.cc"
#include <datadog/opentracing.h>
#include <datadog/tags.h>

#include <stdarg.h>
#include <memory> 
#include <chrono>
#include <fstream>
#include <string>
#include <chrono>
#include <thread>
#include <sys/stat.h>

datadog::opentracing::TracerOptions tracer_options{"", 0, "compiled-in-example"};
auto tracer = datadog::opentracing::makeTracer(tracer_options);

std::ifstream::pos_type filesize(const char* filename) {
    std::ifstream in(filename, std::ifstream::ate | std::ifstream::binary);
    return in.tellg(); 
}

std::string string_format(const std::string fmt_str, ...) {
    int final_n, n = ((int)fmt_str.size()) * 2;
    std::unique_ptr<char[]> formatted;
    va_list ap;
    while(1) {
        formatted.reset(new char[n]);
        strcpy(&formatted[0], fmt_str.c_str());
        va_start(ap, fmt_str);
        final_n = vsnprintf(&formatted[0], n, fmt_str.c_str(), ap);
        va_end(ap);
        if (final_n < 0 || final_n >= n)
            n += abs(final_n - n + 1);
        else
            break;
    }
    return std::string(formatted.get());
}

int runApp(const char* f) {
    auto span_a = tracer->StartSpan(f);
    span_a->SetTag(datadog::tags::environment, "production");
    span_a->SetTag("tag", "app-ok");
    span_a->SetTag("file_len", string_format("%d", filesize(f)));
}

int main(int argc, char* argv[]) {
    for (;;) {
        runApp(argv[0]);
        runApp("file-not-exists");
        std::this_thread::sleep_for(std::chrono::milliseconds(1000));
    }

    tracer->Close();
    return 0;
} 
```

### Compile and Run {#build-run}

```shell
LD_LIBRARY_PATH=/usr/local/lib64 g++ -std=c++14 -o demo demo.cc -ldd_opentracing -I ./dd-opentracing-cpp/deps/include
LD_LIBRARY_PATH=/usr/local/lib64 DD_AGENT_HOST=localhost DD_TRACE_AGENT_PORT=9529 ./demo
```

You can place the *libdd_opentracing.so* and corresponding header files in any directory, then adjust the `LD_LIBRARY_PATH` and `-I` parameters accordingly.

After running the program for a while, similar trace data will be visible in <<< custom_key.brand_name >>> as follows:

<figure markdown>
  ![](https://static.<<< custom_key.brand_main_domain >>>/images/datakit/cpp-ddtrace-example.png){ width="800"}
  <figcaption>C++ trace Data Display</figcaption>
</figure>

## Supported Environment Variables {#envs}

## Supported ENV Variables {#start-options}

The following environment variables support specifying some configuration parameters for DDTrace when starting the program. The basic format is:

```shell
DD_XXX=<env-value> DD_YYY=<env-value> ./demo
```

Below are some commonly used ENV variables. For more ENV support, refer to the [DDTrace Documentation][7]{:target="_blank"}.

- **`DD_VERSION`**

    Set the application version, such as `1.2.3`, `2022.02.13`.

- **`DD_AGENT_HOST`**

    **Default value**: `localhost`

    Set the DataKit address.

- **`DD_TRACE_AGENT_PORT`**

    Set the receiving port for DataKit trace data. Here, you need to manually specify the [HTTP port of DataKit][4] (usually 9529).

- **`DD_ENV`**

    Set the current environment of the application, such as prod, pre-prod, etc.

- **`DD_SERVICE`**

    Set the application service name.

- **`DD_TRACE_SAMPLING_RULES`**

    This uses a JSON array to represent sampling settings (sampling rates are applied in the order of the array), where `sample_rate` is the sampling rate with a range of `[0.0, 1.0]`.

    **Example One**: Set the global sampling rate to 20%: `DD_TRACE_SAMPLE_RATE='[{"sample_rate": 0.2}]' ./my-app`

    **Example Two**: For service names matching `app1.*` and span names being `abc`, set the sampling rate to 10%, otherwise set it to 20%: `DD_TRACE_SAMPLE_RATE='[{"service": "app1.*", "name": "b", "sample_rate": 0.1}, {"sample_rate": 0.2}]' ./my-app`

- **`DD_TAGS`**

    A set of global tags can be injected here. These tags will appear in each span and profile data. Multiple tags can be separated by spaces or commas, e.g., `layer:api,team:intake` or `layer:api team:intake`.

<!-- markdownlint-disable MD053 -->
[1]: https://static.<<< custom_key.brand_main_domain >>>/gfw/cmake-3.24.2.tar.gz
[2]: https://static.<<< custom_key.brand_main_domain >>>/gfw/cmake-3.24.2-windows-x86_64.msi
[3]: https://cmake.org/download/
[4]: ../datakit/datakit-conf.md#config-http-server
[5]: https://static.<<< custom_key.brand_main_domain >>>/gfw/dd-cpp-include.tar.gz
[6]: https://static.<<< custom_key.brand_main_domain >>>/gfw/libdd_opentracing.so
[7]: https://docs.datadoghq.com/tracing/trace_collection/library_config/cpp/
<!-- markdownlint-enable -->