
# Node.js
---

## 视图预览

Node.js 应用的链路追踪, 埋点后可在"应用性能监测" 应用列表里看到对应的应用,可以查看对应链路拓扑和所有 链路信息,以及对 Node.js 应用请求的一些链路指标: 请求数、错误率、延迟时间分布、响应时间等。

![image](../imgs/input-ddtrace-nodejs-1.png)

## 版本支持

操作系统：Linux <br />Node 版本：>=12

## 前置条件

- 在 Node 应用服务器上安装 Datakit <[安装 Datakit](../../datakit/datakit-install.md)>
- 查看 Node 版本是否>=12 

## 安装配置

### 部署实施

#### 1. 开启 ddtrace for datakit 

 1、 进入`/usr/local/datakit/conf.d/ddtrace/` ，复制 sample 文件, 去掉.sample 后缀

```
cd /usr/local/datakit/conf.d/ddtrace/
cp ddtrace.conf.sample ddtrace.conf
```
主要配置说明

-  Datakit 默认开放 http://localhost:9529 接收 ddtrace 数据

2、 重启 Datakit 

```
systemctl restart datakit
```

#### 2. 安装 ddtrace for node 

```
npm install dd-trace --save
```


#### 3. 启动 node 应用

通过环境变量的方式,动态配置 nodejs 应用的相关的 tag

```
# 必选
export DD_AGENT_HOST=localhost
export DD_TRACE_AGENT_PORT=9529

# 可选 ,采样配置
export DD_TRACE_SAMPLE_RATE=0.1
```

改变一下启动方式

```
# 原本是 node app.js 的话, 添加启动参数 --require dd-trace/init

node --require dd-trace/init app.js
```

即可对 nodejs 应用进行链路采集

#### 4. 针对使用Nest.js框架的说明

1） 在Nest.js的项目中安装ddtrace for node。参考上面的**步骤2**.

2） 编辑Nest.js项目中的 package.json配置文件
```
需要把script部分中的"start": "nest start"，
替换为：
"start": "node -r dd-trace/init -r ts-node/register src/main.ts"，
```
3）设置ddtrace 需要的环境变量
```
方式一 - 设置系统环境变量：
  # 必选
  export DD_AGENT_HOST=localhost
  export DD_TRACE_AGENT_PORT=9529

  # 可选 ,采样配置
  export DD_TRACE_SAMPLE_RATE=0.1
  
方式二 - 在启动脚本中添加变量：
  "start": "cross-env NODE_ENV=test DD_AGENT_HOST=localhost DD_TRACE_AGENT_PORT=9529 node -r dd-trace/init -r ts-node/register src/main.ts"
```
4）启动应用
```
npm run start
```

#### 5. 进入观测云查看

访问一下应用, 以便生成链路数据, 进入观测云 应用性能监测即可看到自己的应用。

## 常见问题排查

<[无数据上报排查](../../datakit/why-no-data.md)>
