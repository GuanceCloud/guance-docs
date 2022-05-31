
# 应用场景
        分布式应用环境下，常常通过日志和链路来排查问题。观测云可以实现用户通过 Web 端进行的请求，通过 traceId 与后端的接口关联起来，如果后端接口输出了日志，通过 traceId 把链路和日志关联起来，最终形成 RUM、APM 和日志的联动，再运用观测云平台进行综合分析，能非常方便快捷地发现问题、定位问题。
        本文用一个简单容易上手的开源项目，一步一步实现全链路可观测。
# 前置条件

1. 您需要先创建一个[观测云账号](https://www.guance.com/)。
1. springboot 和 vue 应用。
1. 一台部署了 nginx 的 Linux 服务器。
# 环境版本

- JDK 1.8
- Vue 3.2
- DataKit 1.2.19
- Nginx 1.20.2
- SkyWalking 8.7.0
# 操作步骤
## 步骤 1：部署 DataKit
### 1.1 安装 Datakit
         登录『[观测云](https://console.guance.com/)』，依次进入『集成』-> 『DataKit』->『Linux』，点击“复制”图标复制安装命令。
![1653028665(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653028671286-6309fe7e-62f1-499d-af2d-004f57df0ce4.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=u60d6cda1&margin=%5Bobject%20Object%5D&name=1653028665%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=117728&status=done&style=none&taskId=ub8bddf9a-f03d-4324-a9bd-1f1311ab7d6&title=&width=1280)
        登录 Linux 服务器，执行复制的命令。
![1653030028(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653030034383-1cac4252-4b22-41ea-9c63-6a3212214fa3.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=512&id=ud4b581b3&margin=%5Bobject%20Object%5D&name=1653030028%281%29.png&originHeight=768&originWidth=1549&originalType=binary&ratio=1&rotation=0&showTitle=false&size=87145&status=done&style=none&taskId=ub757d829-9e20-4b32-9e9a-38db72523b5&title=&width=1032.6666666666667)
### 1.2 开通采集器
        开通 RUM，需要让用户远程访问到 DataKit 的 9529 端口，编辑下面文件。
```
/usr/local/datakit/conf.d/datakit.conf
```
        修改 listen 的值是“0.0.0.0:9529”。     
![1653030351(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653030358254-04ddf105-dc3e-4d9c-a7df-32a525c66a9f.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=416&id=u913caf34&margin=%5Bobject%20Object%5D&name=1653030351%281%29.png&originHeight=624&originWidth=740&originalType=binary&ratio=1&rotation=0&showTitle=false&size=26832&status=done&style=none&taskId=u4965b1d7-1f8f-41aa-a71e-53085f58bcd&title=&width=493.3333333333333)
        复制 conf 文件，开通 Skywalking 采集器。
```
cd /usr/local/datakit/conf.d/skywalking
cp skywalking.conf.sample skywalking.conf


```
        开通日志采集器。
```
cd /usr/local/datakit/conf.d/log
cp logging.conf.sample skywalking-service-log.conf
```
        编辑 skywalking-service-log.conf 文件，logfiles 填日志的文件路径，由于要把 jar 部署到 /usr/local/df-demo/skywalking 目录，这里日志路径是 “/usr/local/df-demo/skywalking/logs/log.log”，source 为 skywalking-service-log。
![1653031150(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653031162264-b79fd532-2268-4d5a-99e4-bc99ecbcaff0.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=512&id=u6b96b971&margin=%5Bobject%20Object%5D&name=1653031150%281%29.png&originHeight=768&originWidth=1549&originalType=binary&ratio=1&rotation=0&showTitle=false&size=46670&status=done&style=none&taskId=u9f6c6963-2334-4a7e-9d3e-6e1085579f2&title=&width=1032.6666666666667)
### 1.3 重启 DataKit
```
systemctl restart datakit
```
## 步骤 2 ：部署应用
### 2.1 部署后端服务
        下载[ skywalking-demo ](skywalking-demo)项目，使用 Idea 打开，点击右边“package”，即可生成 skywalking-user-service.jar 文件。
![1653031745(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653031761699-ca940cfd-4d8d-4792-9b02-494068deeef1.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=687&id=u4d38a534&margin=%5Bobject%20Object%5D&name=1653031745%281%29.png&originHeight=1031&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=142553&status=done&style=none&taskId=uc53b156b-0047-431c-b6e8-caf7d7f5a83&title=&width=1280)
        上传 skywalking-user-service.jar 到 /usr/local/df-demo/skywalking 目录。
![1653033040(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653033053069-a03c3195-d35e-41de-b6f4-dd106559c10c.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=81&id=u85a65889&margin=%5Bobject%20Object%5D&name=1653033040%281%29.png&originHeight=122&originWidth=502&originalType=binary&ratio=1&rotation=0&showTitle=false&size=10425&status=done&style=none&taskId=u6a679c52-0bad-4cb0-89d2-f7841afd822&title=&width=334.6666666666667)
       ** 特别说明：1、项目需要添加依赖。**
```
        <dependency>
            <groupId>org.apache.skywalking</groupId>
            <artifactId>apm-toolkit-logback-1.x</artifactId>
            <version>8.7.0</version>
        </dependency>
```
**        2、输出日志，需要把 traceId 输出。**
![1653035266(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653035273238-92d20c59-e706-47e3-aa42-f4340f4a6762.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=687&id=u7a334a70&margin=%5Bobject%20Object%5D&name=1653035266%281%29.png&originHeight=1031&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=249235&status=done&style=none&taskId=uc5b00b77-fe70-441b-8782-57db1bd8e83&title=&width=1280)
### 2.2 部署 web
        进入 web 项目的目录，命令行执行“cnpm install”。
![1653033799(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653033814915-67207c41-5ecf-46d9-b668-49a1a9e3c46a.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=382&id=ufa4d594e&margin=%5Bobject%20Object%5D&name=1653033799%281%29.png&originHeight=573&originWidth=1441&originalType=binary&ratio=1&rotation=0&showTitle=false&size=92170&status=done&style=none&taskId=u967d55a3-e048-4219-b574-0415c552a53&title=&width=960.6666666666666)
        执行 “npm run build”生成部署文件。
![1653033322(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653033334807-fd33d7e2-0b7d-4599-b318-115cb30a19be.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=279&id=u48c07d62&margin=%5Bobject%20Object%5D&name=1653033322%281%29.png&originHeight=418&originWidth=991&originalType=binary&ratio=1&rotation=0&showTitle=false&size=31575&status=done&style=none&taskId=u52ae7e1a-f32e-488b-96ff-4ee02038030&title=&width=660.6666666666666)

![1653034026(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653034037300-cc93371a-519b-43ea-99c8-d428b75a0553.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=421&id=ue8da2b4c&margin=%5Bobject%20Object%5D&name=1653034026%281%29.png&originHeight=632&originWidth=906&originalType=binary&ratio=1&rotation=0&showTitle=false&size=53101&status=done&style=none&taskId=u7799d631-6f2c-4830-9975-dfe62f9b630&title=&width=604)
        复制 disk 目录下的文件到服务器的“/usr/local/web”目录。
![1653034087(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653034129764-d0840e0c-ff44-42bf-ae64-c276e09b5aab.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=83&id=u5a477e87&margin=%5Bobject%20Object%5D&name=1653034087%281%29.png&originHeight=125&originWidth=475&originalType=binary&ratio=1&rotation=0&showTitle=false&size=7805&status=done&style=none&taskId=ua09b0d69-a8d1-4e4e-be1f-a8359f44743&title=&width=316.6666666666667)
        编辑 /etc/nginx/nginx.conf 文件，增加如下内容。
```
   location / {
            root   /usr/local/web;
            try_files $uri $uri/ /index.html;
            index  index.html index.htm;

        }

```
![1653034584(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653034596215-ca131732-48b6-47f4-be4e-d5d4cb820f29.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=512&id=u6ae36f63&margin=%5Bobject%20Object%5D&name=1653034584%281%29.png&originHeight=768&originWidth=1549&originalType=binary&ratio=1&rotation=0&showTitle=false&size=38467&status=done&style=none&taskId=u0de57ee8-ca00-46c6-a706-7edfaed833e&title=&width=1032.6666666666667)
        nginx 重新加载配置。
```
nginx -s reload
```
        浏览器输入 Linux 服务 IP，访问前端界面。
![1653035987.png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653035999812-ae804766-1ddf-43eb-b061-82cf1c00c092.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=ube9bc903&margin=%5Bobject%20Object%5D&name=1653035987.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=28162&status=done&style=none&taskId=u27c1008c-134d-4a8e-8d65-211e4c9dda7&title=&width=1280)
## 步骤 3 ：开启 APM
        下载 [SkyWalking](https://archive.apache.org/dist/skywalking/8.7.0/)。
![1653031512(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653031556858-cc2be537-27ce-4f60-abf4-9f4d096b7428.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=357&id=u35526fd8&margin=%5Bobject%20Object%5D&name=1653031512%281%29.png&originHeight=536&originWidth=646&originalType=binary&ratio=1&rotation=0&showTitle=false&size=31424&status=done&style=none&taskId=uadaafb05-4b8e-4102-8425-ed11686723d&title=&width=430.6666666666667)

        把 agent 目录上传到 Linux 的 /usr/local/df-demo/skywalking 目录。
![1653035746(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653035751730-55f3f51e-93bd-4b2c-af95-ae40408ad864.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=76&id=ubb0f42a4&margin=%5Bobject%20Object%5D&name=1653035746%281%29.png&originHeight=114&originWidth=517&originalType=binary&ratio=1&rotation=0&showTitle=false&size=9972&status=done&style=none&taskId=u24f602ae-cbec-4c5c-a144-1e5d1cfd49c&title=&width=344.6666666666667)
        执行如下命令，启动后端服务，点击前端界面的按钮，调用后端服务。
```
cd /usr/local/df-demo/skywalking
java  -javaagent:agent/skywalking-agent.jar -Dskywalking.agent.service_name=skywalking-log  -Dskywalking.collector.backend_service=localhost:13800 -jar skywalking-user-service.jar
```
         登录『[观测云](https://console.guance.com/)』，进入『应用性能监测』查看服务、链路及拓扑图。
![1653036095(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653036199826-524e0368-bb84-4237-9319-62b0395bcae6.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=uaee0653f&margin=%5Bobject%20Object%5D&name=1653036095%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=50724&status=done&style=none&taskId=u40a16819-8fa6-49de-b576-8a01af7499f&title=&width=1280)
## 步骤 4 ：开启 RUM
        登录『 [观测云](https://console.guance.com/)』，进入『用户访问监测』，新建应用 **skywalking-web-demo** ，复制下方 JS。
![1653036394(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653036408374-618d2bea-b563-474a-93fb-65f2563cd34f.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=uf915018d&margin=%5Bobject%20Object%5D&name=1653036394%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=82950&status=done&style=none&taskId=u2ef4d261-7b59-48ae-a2a3-143e575539c&title=&width=1280)
        修改 /usr/local/web/index.html，把 JS 复制到 head 中，修改 datakitOrigin 为 DataKit 的地址，这里是 Linux 的 IP 地址加 9529 端口，allowedTracingOrigins 为后端接口的地址，这里是 Linux 的 IP 地址加 8090 端口。
![1653036617(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653036632687-a5b35309-0971-44f0-bec6-245ac4ce5b06.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=512&id=u71cd400c&margin=%5Bobject%20Object%5D&name=1653036617%281%29.png&originHeight=768&originWidth=1549&originalType=binary&ratio=1&rotation=0&showTitle=false&size=60248&status=done&style=none&taskId=u4589136a-7c13-4f8b-aee8-2dd0069e9b2&title=&width=1032.6666666666667)
参数说明

- datakitOrigin：数据传输地址，这里是 datakit 的域名或 IP，必填。
- env：应用所属环境，必填。
- version：应用所属版本，必填。
- trackInteractions：是否开启用户行为统计，例如点击按钮、提交信息等动作，必填。
- traceType：trace类型，默认为 ddtrace，非必填。
- allowedTracingOrigins：实现 APM 与 RUM 链路打通，填写后端服务的域名或 IP ，非必填。

         点击前端界面的按钮。登录『 [观测云](https://console.guance.com/)』->『用户访问监测』，点击 “skywalking-web-demo”，查看 UV、PV、会话数、访问的页面等信息。![1653036855(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653036870738-9af1beaf-7673-4416-b746-927ddd979e9a.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=u6a8fe9bf&margin=%5Bobject%20Object%5D&name=1653036855%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=161657&status=done&style=none&taskId=u9fec6bfd-91df-4ef1-b29c-b7fd86243bc&title=&width=1280)
![1653036910(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653036915531-a8b05cdf-c613-48f8-b36d-cb62f420aea3.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=u9871736d&margin=%5Bobject%20Object%5D&name=1653036910%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=80107&status=done&style=none&taskId=u3d251828-7deb-412f-8a28-bea70b3cd2f&title=&width=1280)
## 步骤 5 ：全链路可观测
        登录『 [观测云](https://console.guance.com/)』->『用户访问监测』，点击 “skywalking-web-demo”进入后点击“查看器”，选择“view”，查看页面调用情况，然后点击“route_change”进入。
![1653037327(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653037336325-3c9695dc-2705-4bbd-a8c8-512c72f75acc.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=uf5244e54&margin=%5Bobject%20Object%5D&name=1653037327%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=120498&status=done&style=none&taskId=uff9d520c-f5cb-4f66-99dd-501d81aa428&title=&width=1280)
        选择“链路”。
![1653037538(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653037548001-2f109593-c653-47e6-bf63-aabfd0c588fd.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=577&id=u64582638&margin=%5Bobject%20Object%5D&name=1653037538%281%29.png&originHeight=866&originWidth=1920&originalType=binary&ratio=1&rotation=0&showTitle=false&size=70605&status=done&style=none&taskId=u7ed06227-e024-4493-8016-09c72054706&title=&width=1280)
        点击一条请求记录，可以观测“火焰图”、“Span 列表”、“服务调用关系”及这条链路调用产生的日志。
![1653037604(1).png](https://cdn.nlark.com/yuque/0/2022/png/21583952/1653037615980-eb0deb6a-8590-4c1d-a714-56cf854e2d77.png#clientId=u48ba55ac-914e-4&crop=0&crop=0&crop=1&crop=1&from=paste&height=541&id=u1bf3ef68&margin=%5Bobject%20Object%5D&name=1653037604%281%29.png&originHeight=811&originWidth=1515&originalType=binary&ratio=1&rotation=0&showTitle=false&size=46313&status=done&style=none&taskId=udfc96cbb-d205-46bf-8f31-284dd74d388&title=&width=1010)


