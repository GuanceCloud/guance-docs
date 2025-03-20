---
title     : 'Profiling PHP'
summary   : 'PHP Profiling Integration'
tags:
  - 'PHP'
  - 'PROFILE'
__int_icon: 'icon/profiling'
---


Starting from Datakit [:octicons-tag-24: Version-1.13.0](../datakit/changelog.md#cl-1.13.0){:target="_blank"} support for using [`dd-trace-php`](https://github.com/DataDog/dd-trace-php){:target="_blank"} as an application performance monitoring tool for `PHP` projects is available.

## Prerequisites {#prerequisites}

- `Linux X64 with glibc 2.17+，Linux X64 with musl v1.2+`
- `PHP 7.1+ NTS(Non-Thread Safe)`

## Install `dd-trace-php` {#install-dd-trace-php}

Download the installation script [*datadog-setup.php*](https://github.com/DataDog/dd-trace-php/releases/download/0.90.0/datadog-setup.php){:target="_blank"} and execute it:

```shell
wget https://github.com/DataDog/dd-trace-php/releases/download/0.90.0/datadog-setup.php
php datadog-setup.php --enable-profiling
```

During the installation, the script will automatically detect the installed paths of `php` and `php-fpm`, allowing you to select which programs need profiling enabled. Just enter the corresponding numbers based on your needs.

```shell
Searching for available php binaries, this operation might take a while.
Multiple PHP binaries detected. Please select the binaries the datadog library will be installed to:

   1. php --> /usr/bin/php8.1
   2. php8.1 --> /usr/bin/php8.1
   3. php-fpm8.1 --> /usr/sbin/php-fpm8.1

Select binaries using their number. Multiple binaries separated by space (example: 1 3): 1 2 3
```


If you know the installation path of `php` or `php-fpm` on your system, you can specify the path of `php` directly during the execution of the installation script using the `--php-bin` parameter, skipping the above detection and selection steps. For example:

```shell
php datadog-setup.php --enable-profiling --php-bin=/usr/bin/php8.1 --php-bin=/usr/sbin/php-fpm8.1
```

The installation process requires downloading packages from `github.com`. Depending on your network conditions, this may take some time. Wait until the installation program exits successfully, then you can run the command `php --ri "datadog-profiling"` to verify if the installation was successful.

```shell
php --ri "datadog-profiling"

datadog-profiling

Version => 0.90.0
Profiling Enabled => true
Experimental CPU Time Profiling Enabled => true
Allocation Profiling Enabled => true
...
```


<!-- markdownlint-disable MD046 -->
???+ Note

    At the time of writing this document, `Datakit` supports up to version [`dd-trace-php v0.90.0`](https://github.com/DataDog/dd-trace-php/releases/tag/0.90.0){:target="_blank"}. Higher versions have not been systematically tested, and compatibility is unknown. If you encounter any issues during use, feel free to contact us.
<!-- markdownlint-enable -->


## Start Profiling {#start-profiling}

<!-- markdownlint-disable MD046 -->
=== "PHP CLI"

    Set the following environment variables when launching the PHP script:
    ```shell
    DD_PROFILING_ENABLED=1 \
    DD_PROFILING_ENDPOINT_COLLECTION_ENABLED=1 \
    DD_PROFILING_ALLOCATION_ENABLED=1 \
    DD_PROFILING_EXPERIMENTAL_CPU_TIME_ENABLED=1 \
    DD_PROFILING_EXPERIMENTAL_TIMELINE_ENABLED=1 \
    DD_PROFILING_LOG_LEVEL=info \
    DD_SERVICE=my-php-cli-app \
    DD_ENV=prod \
    DD_VERSION=1.22.333 \
    DD_AGENT_HOST=127.0.0.1 \
    DD_TRACE_AGENT_PORT=9529 \
    php <your-path-to>.php
    ```

=== "PHP-FPM"

    In the configuration files under the *pool.d* directory for the `PHP-FPM` process pool (by default, there is only one *www.conf* file), add the following environment variables to *www.conf* using the `env` directive:

    ???+ Note
        You can try using `php-fpm -i | grep Configuration` to confirm the location of the currently loaded `php-fpm` configuration file:
        ```shell
        php-fpm8.1 -i | grep Configuration
        Configuration File (php.ini) Path => /etc/php/8.1/fpm
        ...
        ls -l /etc/php/8.1/fpm/pool.d
        total 48
        -rw-r--r-- 1 root root 20901 Aug  7 21:22 www.conf
        ```
        If your `php-fpm` program is registered as a `systemd` service, you can also try using the command `systemctl status php-fpm.service | grep .conf` to check the current configuration file path:
        ```shell
        systemctl status php8.1-fpm.service | grep .conf
        Process: 629814 ExecStart=/usr/sbin/php-fpm8.1 --nodaemonize --fpm-config /etc/php/8.1/fpm/php-fpm.conf (code=exited, status=0/SUCCESS)
        Process: 629818 ExecStartPost=/usr/lib/php/php-fpm-socket-helper install /run/php/php-fpm.sock /etc/php/8.1/fpm/pool.d/www.conf 81 (code=exited, status=0/SUCCESS)
        Process: 630872 ExecStopPost=/usr/lib/php/php-fpm-socket-helper remove /run/php/php-fpm.sock /etc/php/8.1/fpm/pool.d/www.conf 81 (code=exited, status=0/SUCCESS)
        ...
        ```


    ```shell
    ...
    ; Pass environment variables like LD_LIBRARY_PATH. All $VARIABLEs are taken from
    ; the current environment.
    ; Default Value: clean env
    ;env[HOSTNAME] = $HOSTNAME
    ;env[PATH] = /usr/local/bin:/usr/bin:/bin
    ;env[TMP] = /tmp
    ;env[TMPDIR] = /tmp
    ;env[TEMP] = /tmp

    env[DD_PROFILING_ENABLED]=true
    env[DD_PROFILING_ENDPOINT_COLLECTION_ENABLED]=true
    env[DD_PROFILING_ALLOCATION_ENABLED]=true
    env[DD_PROFILING_EXPERIMENTAL_CPU_TIME_ENABLED]=true
    env[DD_PROFILING_EXPERIMENTAL_TIMELINE_ENABLED]=true
    env[DD_PROFILING_LOG_LEVEL]=info
    env[DD_SERVICE]=my-fpm-app
    env[DD_ENV]=dev
    env[DD_VERSION]=1.2.33
    env[DD_AGENT_HOST]=127.0.0.1
    env[DD_TRACE_AGENT_PORT]=9529

    ```

    Restart `php-fpm` and access your project.
<!-- markdownlint-enable -->

After a few minutes, you can view the related data in the [<<< custom_key.brand_name >>> Console](https://<<< custom_key.studio_main_site >>>/tracing/profile){:target="_blank"}.