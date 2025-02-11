---
title     : 'DDTrace C++'
summary   : 'DDTrace C++ Integration'
tags      :
  - 'Tracing'
  - 'C/C++'
__int_icon: 'icon/ddtrace'
---

To apply DDTrace in C++ code, you need to modify the business code. There are no corresponding SDK integrations for common middleware and libraries, so **manual instrumentation must be performed in the existing business code**.

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

    If you encounter issues while compiling the SDK, you can temporarily use the [header files][5] and [shared libraries][6] prepared by Guance for testing.

=== "Windows"

    Coming Soon...

???+ attention "cmake Installation"

    cmake may not be installed to a higher version via yum or apt-get. It is recommended to download the latest version directly from its [official website][3]{:target="_blank"}. You can also use the [source code][1] or [Windows binary][2] hosted by Guance.
    
    ```shell
    # Install cmake from source
    wget https://static.guance.com/gfw/cmake-3.24.2.tar.gz
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

The following C++ code demonstrates basic trace instrumentation operations, simulating a business operation that reads a file from the local disk.

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

### Build and Run {#build-run}

```shell
LD_LIBRARY_PATH=/usr/local/lib64 g++ -std=c++14 -o demo demo.cc -ldd_opentracing -I ./dd-opentracing-cpp/deps/include
LD_LIBRARY_PATH=/usr/local/lib64 DD_AGENT_HOST=localhost DD_TRACE_AGENT_PORT=9529 ./demo
```

You can place *libdd_opentracing.so* and the corresponding header files in any directory and adjust the `LD_LIBRARY_PATH` and `-I` parameters accordingly.

After running the program for some time, you can see similar trace data in Guance:

<figure markdown>
  ![](https://static.guance.com/images/datakit/cpp-ddtrace-example.png){ width="800"}
  <figcaption>C++ trace data display</figcaption>
</figure>

## Supported Environment Variables {#envs}

## Environment Variable Support {#start-options}

The following environment variables support specifying some configuration parameters of DDTrace when starting the program. The basic format is:

```shell
DD_XXX=<env-value> DD_YYY=<env-value> ./demo
```

Commonly used ENV variables include the following. For more ENV support, refer to the [DDTrace documentation][7]{:target="_blank"}.

- **`DD_VERSION`**

    Set the application version, such as `1.2.3`, `2022.02.13`

- **`DD_AGENT_HOST`**

    **Default value**: `localhost`

    Set the DataKit address

- **`DD_TRACE_AGENT_PORT`**

    Set the receiving port for DataKit trace data. You need to manually specify the [HTTP port of DataKit][4] (usually 9529)

- **`DD_ENV`**

    Set the current environment of the application, such as prod, pre-prod, etc.

- **`DD_SERVICE`**

    Set the application service name

- **`DD_TRACE_SAMPLING_RULES`**

    Use a JSON array to represent sampling settings (sampling rates are applied in the order of the array). `sample_rate` represents the sampling rate, with values ranging from `[0.0, 1.0]`.

    **Example 1**: Set the global sampling rate to 20%: `DD_TRACE_SAMPLE_RATE='[{"sample_rate": 0.2}]' ./my-app`

    **Example 2**: For services matching `app1.*` and spans named `abc`, set the sampling rate to 10%. Otherwise, set it to 20%: `DD_TRACE_SAMPLE_RATE='[{"service": "app1.*", "name": "b", "sample_rate": 0.1}, {"sample_rate": 0.2}]' ./my-app`

- **`DD_TAGS`**

    Inject a set of global tags, which will appear in each span and profile data. Multiple tags can be separated by spaces and commas, e.g., `layer:api,team:intake` or `layer:api team:intake`

<!-- markdownlint-disable MD053 -->
[1]: https://static.guance.com/gfw/cmake-3.24.2.tar.gz
[2]: https://static.guance.com/gfw/cmake-3.24.2-windows-x86_64.msi
[3]: https://cmake.org/download/
[4]: ../datakit/datakit-conf.md#config-http-server
[5]: https://static.guance.com/gfw/dd-cpp-include.tar.gz
[6]: https://static.guance.com/gfw/libdd_opentracing.so
[7]: https://docs.datadoghq.com/tracing/trace_collection/library_config/cpp/
<!-- markdownlint-enable -->