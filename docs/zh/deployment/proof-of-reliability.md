# 可靠性验证
---

本文通过完整的数据链路来验证中心部署的可靠性：

- 通过 Datakit 特定的采集器，采集大量数据
- 经过 Dataway 将数据上传到 Kodo
- Kodo 依据已有流程，将数据写入日志类存储


## 环境准备 {#prepare}

- 一台基本的 Linux 机器，安装了 Datakit，并开启 [logstreaming 采集器](../integrations/logstreaming.md)
- 准备测试脚本，往 Datakit 的 lostreaming 采集器推送数据
- 开启一个不限量的工作空间，使得其可以承接大量的日志数据

## 实施 {#go}

- 下载测试数据，该数据集中含 10000 条日志，单条长度均为 1KB：

```bash
wget https://static.guance.com/testing-data/10000-1kb.log
```

- 修改如下脚本，填写上面准备好的 Datakit IP，保存脚本为 *curl-log-streaming.sh*：

```bash
#!/bin/bash

# 检查是否提供了参数
if [ $# -eq 0 ]; then
    echo "Usage: $0 <number_of_iterations>"
    exit 1
fi

# 读取命令行参数作为循环次数
num_iterations=$1
file=$2

# 使用for循环执行指定次数的迭代
for ((i=1; i<=num_iterations; i++)); do
		curl -v http://<YOUR-DATAKIT-IP>:9529/v1/write/logstreaming?source=drop-testing --data-binary "@$2"
        sleep 2.5 # 休眠 2.5s
done
```

- 执行上面的脚本，此处脚本会推送 40k 次请求给 Datakit，持续 28h 左右：

```bash
bash curl-log-streaming.sh 40000 10000-1kb.log
```

## 结果查看 {#show}

执行完上面的步骤后，在 Datakit 的 monitor 中能看到有 `logstreaming/drop-testing` 的采集：

```bash
datakit monitor -MI
```

通过如下命令能看到 Datakit 上报 Dataway 的请求 latency：

```bash
datakit monitor -MW
```

在观测云的日志查看器中，选择日志来源（`source`）为 `drop-testing`，其状态分布图每一根柱子（间隔为 1min）的高度大概为 22~24w（`60s/2.5s*10000`）。正常情况下，数据是很均匀的，不会出现突增或突降的情况（因为数据写入是固定频率的）

在这个过程中，可以去内置视图中搜索「dataway」，可查看 Dataway 自身的指标情况，还需要去查看 NSQ/GuanceDB/Kodo/Kodo-X 等组建的查看器，以确保其部署成功。
