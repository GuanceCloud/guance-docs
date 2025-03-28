# Pipeline Manual

## Introduction {#intro}

Since DataKit v1.4.0, the built-in Pipeline data processor function can be used to modify, extract, filter, aggregate, and perform other operations on data collected or received by DataKit. It supports all current data categories (such as Logging, Metric, Tracing, Network, and Object, etc.).

The DataKit Pipeline programmable data processor supports the runtime provided by <<<custom_key.brand_name>>> developed domain-specific language Platypus. More programming languages and runtimes will be added for the Pipeline in the future.


## Table of Contents {#toc}

1. [Quick Start](pipeline-quick-start.md)
2. [Basics and Principles](pipeline-architecture.md)
3. [Platypus Syntax](pipeline-platypus-grammar.md)
4. [Built-in Functions](pipeline-built-in-function.md)
5. Additional Features
6. [Performance Benchmarks and Optimization](pipeline-benchmark.md)