
# 采集器配置
---

:fontawesome-brands-linux: :fontawesome-brands-windows: :fontawesome-brands-apple: :material-kubernetes: :material-docker:

---

RUM（Real User Monitor）采集器用于收集网页端或移动端上报的用户访问监测数据。

## 接入方式 {#supported-platforms}

<div class="grid cards" markdown>
- :material-web: [__JavaScript__](../real-user-monitoring/web/app-access.md)
- :material-wechat: [__微信小程序__](../real-user-monitoring/miniapp/app-access.md)
- :material-android: [__Android__](../real-user-monitoring/android/app-access.md)
- :material-apple-ios: [__iOS__](../real-user-monitoring/ios/app-access.md)
- [__Flutter__](../real-user-monitoring/flutter/app-access.md)
- :material-react:[__ReactNative__](../real-user-monitoring/react-native/app-access.md)
</div>

## 前置条件 {#requirements}

- 将 DataKit 部署成公网可访问

建议将 RUM 以单独的方式部署在公网上，==不要跟已有的服务部署在一起==（如 Kubernetes 集群）。因为 RUM 这个接口上的流量可能很大，集群内部的流量会被它干扰到，而且一些可能的集群内部资源调度机制，可能影响 RUM 服务的运行。

- 在 DataKit 上[安装 IP 地理信息库](datakit-tools-how-to.md#install-ipdb)
- 自 [1.2.7](changelog.md#cl-1.2.7) 之后，由于调整了 IP 地理信息库的安装方式，默认安装不再自带 IP 信息库，需手动安装

## 配置 {#config}

=== "主机安装"

    进入 DataKit 安装目录下的 `conf.d/rum` 目录，复制 `rum.conf.sample` 并命名为 `rum.conf`。示例如下：
    
    ```toml
        
    [[inputs.rum]]
      ## profile Agent endpoints register by version respectively.
      ## Endpoints can be skipped listen by remove them from the list.
      ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
      endpoints = ["/v1/write/rum"]
    
      ## use to upload rum screenshot,html,etc...
      session_replay_endpoints = ["/v1/write/rum/replay"]
    
      ## Android command-line-tools HOME
      android_cmdline_home = "/usr/local/datakit/data/rum/tools/cmdline-tools"
    
      ## proguard HOME
      proguard_home = "/usr/local/datakit/data/rum/tools/proguard"
    
      ## android-ndk HOME
      ndk_home = "/usr/local/datakit/data/rum/tools/android-ndk"
    
      ## atos or atosl bin path
      ## for macOS datakit use the built-in tool atos default
      ## for Linux there are several tools that can be used to instead of macOS atos partially,
      ## such as https://github.com/everettjf/atosl-rs
      atos_bin_path = "/usr/local/datakit/data/rum/tools/atosl"
    
      ## Threads config controls how many goroutines an agent cloud start to handle HTTP request.
      ## buffer is the size of jobs' buffering of worker channel.
      ## threads is the total number fo goroutines at running time.
      # [inputs.rum.threads]
        # buffer = 100
        # threads = 8
    
      ## Storage config a local storage space in hard dirver to cache trace data.
      ## path is the local file path used to cache data.
      ## capacity is total space size(MB) used to store data.
      # [inputs.rum.storage]
        # path = "./rum_storage"
        # capacity = 5120
    
      # Provide a list to resolve CDN of your static resource.
      # Below is the Datakit default built-in CDN list, you can uncomment that and change it to your cdn list, 
      # it's a JSON array like: [{"domain": "CDN domain", "name": "CDN human readable name", "website": "CDN official website"},...],
      # domain field value can contains '*' as wildcard, for example: "kunlun*.com", 
      # it will match "kunluna.com", "kunlunab.com" and "kunlunabc.com" but not "kunlunab.c.com".
      # cdn_map = '[{"domain":"15cdn.com","name":"腾正安全加速(原 15CDN)","website":"https://www.15cdn.com"},{"domain":"tzcdn.cn","name":"腾正安全加速(原 15CDN)","website":"https://www.15cdn.com"},{"domain":"cedexis.net","name":"Cedexis GSLB","website":"https://www.cedexis.com/"},{"domain":"cdxcn.cn","name":"Cedexis GSLB (For China)","website":"https://www.cedexis.com/"},{"domain":"qhcdn.com","name":"360 云 CDN (由奇安信运营)","website":"https://cloud.360.cn/doc?name=cdn"},{"domain":"qh-cdn.com","name":"360 云 CDN (由奇虎 360 运营)","website":"https://cloud.360.cn/doc?name=cdn"},{"domain":"qihucdn.com","name":"360 云 CDN (由奇虎 360 运营)","website":"https://cloud.360.cn/doc?name=cdn"},{"domain":"360cdn.com","name":"360 云 CDN (由奇虎 360 运营)","website":"https://cloud.360.cn/doc?name=cdn"},{"domain":"360cloudwaf.com","name":"奇安信网站卫士","website":"https://wangzhan.qianxin.com"},{"domain":"360anyu.com","name":"奇安信网站卫士","website":"https://wangzhan.qianxin.com"},{"domain":"360safedns.com","name":"奇安信网站卫士","website":"https://wangzhan.qianxin.com"},{"domain":"360wzws.com","name":"奇安信网站卫士","website":"https://wangzhan.qianxin.com"},{"domain":"akamai.net","name":"Akamai CDN","website":"https://www.akamai.com"},{"domain":"akamaiedge.net","name":"Akamai CDN","website":"https://www.akamai.com"},{"domain":"ytcdn.net","name":"Akamai CDN","website":"https://www.akamai.com"},{"domain":"edgesuite.net","name":"Akamai CDN","website":"https://www.akamai.com"},{"domain":"akamaitech.net","name":"Akamai CDN","website":"https://www.akamai.com"},{"domain":"akamaitechnologies.com","name":"Akamai CDN","website":"https://www.akamai.com"},{"domain":"edgekey.net","name":"Akamai CDN","website":"https://www.akamai.com"},{"domain":"tl88.net","name":"易通锐进(Akamai 中国)由网宿承接","website":"https://www.akamai.com"},{"domain":"cloudfront.net","name":"AWS CloudFront","website":"https://aws.amazon.com/cn/cloudfront/"},{"domain":"worldcdn.net","name":"CDN.NET","website":"https://cdn.net"},{"domain":"worldssl.net","name":"CDN.NET / CDNSUN / ONAPP","website":"https://cdn.net"},{"domain":"cdn77.org","name":"CDN77","website":"https://www.cdn77.com/"},{"domain":"panthercdn.com","name":"CDNetworks","website":"https://www.cdnetworks.com"},{"domain":"cdnga.net","name":"CDNetworks","website":"https://www.cdnetworks.com"},{"domain":"cdngc.net","name":"CDNetworks","website":"https://www.cdnetworks.com"},{"domain":"gccdn.net","name":"CDNetworks","website":"https://www.cdnetworks.com"},{"domain":"gccdn.cn","name":"CDNetworks","website":"https://www.cdnetworks.com"},{"domain":"akamaized.net","name":"Akamai CDN","website":"https://www.akamai.com"},{"domain":"126.net","name":"网易云 CDN","website":"https://www.163yun.com/product/cdn"},{"domain":"163jiasu.com","name":"网易云 CDN","website":"https://www.163yun.com/product/cdn"},{"domain":"amazonaws.com","name":"AWS Cloud","website":"https://aws.amazon.com/cn/cloudfront/"},{"domain":"cdn77.net","name":"CDN77","website":"https://www.cdn77.com/"},{"domain":"cdnify.io","name":"CDNIFY","website":"https://cdnify.com"},{"domain":"cdnsun.net","name":"CDNSUN","website":"https://cdnsun.com"},{"domain":"bdydns.com","name":"百度云 CDN","website":"https://cloud.baidu.com/product/cdn.html"},{"domain":"ccgslb.com.cn","name":"蓝汛 CDN","website":"https://cn.chinacache.com/"},{"domain":"ccgslb.net","name":"蓝汛 CDN","website":"https://cn.chinacache.com/"},{"domain":"ccgslb.com","name":"蓝汛 CDN","website":"https://cn.chinacache.com/"},{"domain":"ccgslb.cn","name":"蓝汛 CDN","website":"https://cn.chinacache.com/"},{"domain":"c3cache.net","name":"蓝汛 CDN","website":"https://cn.chinacache.com/"},{"domain":"c3dns.net","name":"蓝汛 CDN","website":"https://cn.chinacache.com/"},{"domain":"chinacache.net","name":"蓝汛 CDN","website":"https://cn.chinacache.com/"},{"domain":"wswebcdn.com","name":"网宿 CDN","website":"https://www.wangsu.com/"},{"domain":"lxdns.com","name":"网宿 CDN","website":"https://www.wangsu.com/"},{"domain":"wswebpic.com","name":"网宿 CDN","website":"https://www.wangsu.com/"},{"domain":"cloudflare.net","name":"Cloudflare","website":"https://www.cloudflare.com"},{"domain":"akadns.net","name":"Akamai CDN","website":"https://www.akamai.com"},{"domain":"chinanetcenter.com","name":"网宿 CDN","website":"https://www.wangsu.com"},{"domain":"customcdn.com.cn","name":"网宿 CDN","website":"https://www.wangsu.com"},{"domain":"customcdn.cn","name":"网宿 CDN","website":"https://www.wangsu.com"},{"domain":"51cdn.com","name":"网宿 CDN","website":"https://www.wangsu.com"},{"domain":"wscdns.com","name":"网宿 CDN","website":"https://www.wangsu.com"},{"domain":"cdn20.com","name":"网宿 CDN","website":"https://www.wangsu.com"},{"domain":"wsdvs.com","name":"网宿 CDN","website":"https://www.wangsu.com"},{"domain":"wsglb0.com","name":"网宿 CDN","website":"https://www.wangsu.com"},{"domain":"speedcdns.com","name":"网宿 CDN","website":"https://www.wangsu.com"},{"domain":"wtxcdn.com","name":"网宿 CDN","website":"https://www.wangsu.com"},{"domain":"wsssec.com","name":"网宿 WAF CDN","website":"https://www.wangsu.com"},{"domain":"fastly.net","name":"Fastly","website":"https://www.fastly.com"},{"domain":"fastlylb.net","name":"Fastly","website":"https://www.fastly.com/"},{"domain":"hwcdn.net","name":"Stackpath (原 Highwinds)","website":"https://www.stackpath.com/highwinds"},{"domain":"incapdns.net","name":"Incapsula CDN","website":"https://www.incapsula.com"},{"domain":"kxcdn.com.","name":"KeyCDN","website":"https://www.keycdn.com/"},{"domain":"lswcdn.net","name":"LeaseWeb CDN","website":"https://www.leaseweb.com/cdn"},{"domain":"mwcloudcdn.com","name":"QUANTIL (网宿)","website":"https://www.quantil.com/"},{"domain":"mwcname.com","name":"QUANTIL (网宿)","website":"https://www.quantil.com/"},{"domain":"azureedge.net","name":"Microsoft Azure CDN","website":"https://azure.microsoft.com/en-us/services/cdn/"},{"domain":"msecnd.net","name":"Microsoft Azure CDN","website":"https://azure.microsoft.com/en-us/services/cdn/"},{"domain":"mschcdn.com","name":"Microsoft Azure CDN","website":"https://azure.microsoft.com/en-us/services/cdn/"},{"domain":"v0cdn.net","name":"Microsoft Azure CDN","website":"https://azure.microsoft.com/en-us/services/cdn/"},{"domain":"azurewebsites.net","name":"Microsoft Azure App Service","website":"https://azure.microsoft.com/en-us/services/app-service/"},{"domain":"azurewebsites.windows.net","name":"Microsoft Azure App Service","website":"https://azure.microsoft.com/en-us/services/app-service/"},{"domain":"trafficmanager.net","name":"Microsoft Azure Traffic Manager","website":"https://azure.microsoft.com/en-us/services/traffic-manager/"},{"domain":"cloudapp.net","name":"Microsoft Azure","website":"https://azure.microsoft.com"},{"domain":"chinacloudsites.cn","name":"世纪互联旗下上海蓝云(承载 Azure 中国)","website":"https://www.21vbluecloud.com/"},{"domain":"spdydns.com","name":"云端智度融合 CDN","website":"https://www.isurecloud.net/index.html"},{"domain":"jiashule.com","name":"知道创宇云安全加速乐CDN","website":"https://www.yunaq.com/jsl/"},{"domain":"jiasule.org","name":"知道创宇云安全加速乐CDN","website":"https://www.yunaq.com/jsl/"},{"domain":"365cyd.cn","name":"知道创宇云安全创宇盾(政务专用)","website":"https://www.yunaq.com/cyd/"},{"domain":"huaweicloud.com","name":"华为云WAF高防云盾","website":"https://www.huaweicloud.com/product/aad.html"},{"domain":"cdnhwc1.com","name":"华为云 CDN","website":"https://www.huaweicloud.com/product/cdn.html"},{"domain":"cdnhwc2.com","name":"华为云 CDN","website":"https://www.huaweicloud.com/product/cdn.html"},{"domain":"cdnhwc3.com","name":"华为云 CDN","website":"https://www.huaweicloud.com/product/cdn.html"},{"domain":"dnion.com","name":"帝联科技","website":"http://www.dnion.com/"},{"domain":"ewcache.com","name":"帝联科技","website":"http://www.dnion.com/"},{"domain":"globalcdn.cn","name":"帝联科技","website":"http://www.dnion.com/"},{"domain":"tlgslb.com","name":"帝联科技","website":"http://www.dnion.com/"},{"domain":"fastcdn.com","name":"帝联科技","website":"http://www.dnion.com/"},{"domain":"flxdns.com","name":"帝联科技","website":"http://www.dnion.com/"},{"domain":"dlgslb.cn","name":"帝联科技","website":"http://www.dnion.com/"},{"domain":"newdefend.cn","name":"牛盾云安全","website":"https://www.newdefend.com"},{"domain":"ffdns.net","name":"CloudXNS","website":"https://www.cloudxns.net"},{"domain":"aocdn.com","name":"可靠云 CDN (贴图库)","website":"http://www.kekaoyun.com/"},{"domain":"bsgslb.cn","name":"白山云 CDN","website":"https://zh.baishancloud.com/"},{"domain":"qingcdn.com","name":"白山云 CDN","website":"https://zh.baishancloud.com/"},{"domain":"bsclink.cn","name":"白山云 CDN","website":"https://zh.baishancloud.com/"},{"domain":"trpcdn.net","name":"白山云 CDN","website":"https://zh.baishancloud.com/"},{"domain":"anquan.io","name":"牛盾云安全","website":"https://www.newdefend.com"},{"domain":"cloudglb.com","name":"快网 CDN","website":"http://www.fastweb.com.cn/"},{"domain":"fastweb.com","name":"快网 CDN","website":"http://www.fastweb.com.cn/"},{"domain":"fastwebcdn.com","name":"快网 CDN","website":"http://www.fastweb.com.cn/"},{"domain":"cloudcdn.net","name":"快网 CDN","website":"http://www.fastweb.com.cn/"},{"domain":"fwcdn.com","name":"快网 CDN","website":"http://www.fastweb.com.cn/"},{"domain":"fwdns.net","name":"快网 CDN","website":"http://www.fastweb.com.cn/"},{"domain":"hadns.net","name":"快网 CDN","website":"http://www.fastweb.com.cn/"},{"domain":"hacdn.net","name":"快网 CDN","website":"http://www.fastweb.com.cn/"},{"domain":"cachecn.com","name":"快网 CDN","website":"http://www.fastweb.com.cn/"},{"domain":"qingcache.com","name":"青云 CDN","website":"https://www.qingcloud.com/products/cdn/"},{"domain":"qingcloud.com","name":"青云 CDN","website":"https://www.qingcloud.com/products/cdn/"},{"domain":"frontwize.com","name":"青云 CDN","website":"https://www.qingcloud.com/products/cdn/"},{"domain":"msscdn.com","name":"美团云 CDN","website":"https://www.mtyun.com/product/cdn"},{"domain":"800cdn.com","name":"西部数码","website":"https://www.west.cn"},{"domain":"tbcache.com","name":"阿里云 CDN","website":"https://www.aliyun.com/product/cdn"},{"domain":"aliyun-inc.com","name":"阿里云 CDN","website":"https://www.aliyun.com/product/cdn"},{"domain":"aliyuncs.com","name":"阿里云 CDN","website":"https://www.aliyun.com/product/cdn"},{"domain":"alikunlun.net","name":"阿里云 CDN","website":"https://www.aliyun.com/product/cdn"},{"domain":"alikunlun.com","name":"阿里云 CDN","website":"https://www.aliyun.com/product/cdn"},{"domain":"alicdn.com","name":"阿里云 CDN","website":"https://www.aliyun.com/product/cdn"},{"domain":"aligaofang.com","name":"阿里云盾高防","website":"https://www.aliyun.com/product/ddos"},{"domain":"yundunddos.com","name":"阿里云盾高防","website":"https://www.aliyun.com/product/ddos"},{"domain":"kunlun*.com","name":"阿里云 CDN","website":"https://www.aliyun.com/product/cdn"},{"domain":"cdngslb.com","name":"阿里云 CDN","website":"https://www.aliyun.com/product/cdn"},{"domain":"yunjiasu-cdn.net","name":"百度云加速","website":"https://su.baidu.com"},{"domain":"momentcdn.com","name":"魔门云 CDN","website":"https://www.cachemoment.com"},{"domain":"aicdn.com","name":"又拍云","website":"https://www.upyun.com"},{"domain":"qbox.me","name":"七牛云","website":"https://www.qiniu.com"},{"domain":"qiniu.com","name":"七牛云","website":"https://www.qiniu.com"},{"domain":"qiniudns.com","name":"七牛云","website":"https://www.qiniu.com"},{"domain":"jcloudcs.com","name":"京东云 CDN","website":"https://www.jdcloud.com/cn/products/cdn"},{"domain":"jdcdn.com","name":"京东云 CDN","website":"https://www.jdcloud.com/cn/products/cdn"},{"domain":"qianxun.com","name":"京东云 CDN","website":"https://www.jdcloud.com/cn/products/cdn"},{"domain":"jcloudlb.com","name":"京东云 CDN","website":"https://www.jdcloud.com/cn/products/cdn"},{"domain":"jcloud-cdn.com","name":"京东云 CDN","website":"https://www.jdcloud.com/cn/products/cdn"},{"domain":"maoyun.tv","name":"猫云融合 CDN","website":"https://www.maoyun.com/"},{"domain":"maoyundns.com","name":"猫云融合 CDN","website":"https://www.maoyun.com/"},{"domain":"xgslb.net","name":"WebLuker (蓝汛)","website":"http://www.webluker.com"},{"domain":"ucloud.cn","name":"UCloud CDN","website":"https://www.ucloud.cn/site/product/ucdn.html"},{"domain":"ucloud.com.cn","name":"UCloud CDN","website":"https://www.ucloud.cn/site/product/ucdn.html"},{"domain":"cdndo.com","name":"UCloud CDN","website":"https://www.ucloud.cn/site/product/ucdn.html"},{"domain":"zenlogic.net","name":"Zenlayer CDN","website":"https://www.zenlayer.com"},{"domain":"ogslb.com","name":"Zenlayer CDN","website":"https://www.zenlayer.com"},{"domain":"uxengine.net","name":"Zenlayer CDN","website":"https://www.zenlayer.com"},{"domain":"tan14.net","name":"TAN14 CDN","website":"http://www.tan14.cn/"},{"domain":"verycloud.cn","name":"VeryCloud 云分发","website":"https://www.verycloud.cn/"},{"domain":"verycdn.net","name":"VeryCloud 云分发","website":"https://www.verycloud.cn/"},{"domain":"verygslb.com","name":"VeryCloud 云分发","website":"https://www.verycloud.cn/"},{"domain":"xundayun.cn","name":"SpeedyCloud CDN","website":"https://www.speedycloud.cn/zh/Products/CDN/CloudDistribution.html"},{"domain":"xundayun.com","name":"SpeedyCloud CDN","website":"https://www.speedycloud.cn/zh/Products/CDN/CloudDistribution.html"},{"domain":"speedycloud.cc","name":"SpeedyCloud CDN","website":"https://www.speedycloud.cn/zh/Products/CDN/CloudDistribution.html"},{"domain":"mucdn.net","name":"Verizon CDN (Edgecast)","website":"https://www.verizondigitalmedia.com/platform/edgecast-cdn/"},{"domain":"nucdn.net","name":"Verizon CDN (Edgecast)","website":"https://www.verizondigitalmedia.com/platform/edgecast-cdn/"},{"domain":"alphacdn.net","name":"Verizon CDN (Edgecast)","website":"https://www.verizondigitalmedia.com/platform/edgecast-cdn/"},{"domain":"systemcdn.net","name":"Verizon CDN (Edgecast)","website":"https://www.verizondigitalmedia.com/platform/edgecast-cdn/"},{"domain":"edgecastcdn.net","name":"Verizon CDN (Edgecast)","website":"https://www.verizondigitalmedia.com/platform/edgecast-cdn/"},{"domain":"zetacdn.net","name":"Verizon CDN (Edgecast)","website":"https://www.verizondigitalmedia.com/platform/edgecast-cdn/"},{"domain":"coding.io","name":"Coding Pages","website":"https://coding.net/pages"},{"domain":"coding.me","name":"Coding Pages","website":"https://coding.net/pages"},{"domain":"gitlab.io","name":"GitLab Pages","website":"https://docs.gitlab.com/ee/user/project/pages/"},{"domain":"github.io","name":"GitHub Pages","website":"https://pages.github.com/"},{"domain":"herokuapp.com","name":"Heroku SaaS","website":"https://www.heroku.com"},{"domain":"googleapis.com","name":"Google Cloud Storage","website":"https://cloud.google.com/storage/"},{"domain":"netdna.com","name":"Stackpath (原 MaxCDN)","website":"https://www.stackpath.com/maxcdn/"},{"domain":"netdna-cdn.com","name":"Stackpath (原 MaxCDN)","website":"https://www.stackpath.com/maxcdn/"},{"domain":"netdna-ssl.com","name":"Stackpath (原 MaxCDN)","website":"https://www.stackpath.com/maxcdn/"},{"domain":"cdntip.com","name":"腾讯云 CDN","website":"https://cloud.tencent.com/product/cdn-scd"},{"domain":"dnsv1.com","name":"腾讯云 CDN","website":"https://cloud.tencent.com/product/cdn-scd"},{"domain":"tencdns.net","name":"腾讯云 CDN","website":"https://cloud.tencent.com/product/cdn-scd"},{"domain":"dayugslb.com","name":"腾讯云大禹 BGP 高防","website":"https://cloud.tencent.com/product/ddos-advanced"},{"domain":"tcdnvod.com","name":"腾讯云视频 CDN","website":"https://lab.skk.moe/cdn"},{"domain":"tdnsv5.com","name":"腾讯云 CDN","website":"https://cloud.tencent.com/product/cdn-scd"},{"domain":"ksyuncdn.com","name":"金山云 CDN","website":"https://www.ksyun.com/post/product/CDN"},{"domain":"ks-cdn.com","name":"金山云 CDN","website":"https://www.ksyun.com/post/product/CDN"},{"domain":"ksyuncdn-k1.com","name":"金山云 CDN","website":"https://www.ksyun.com/post/product/CDN"},{"domain":"netlify.com","name":"Netlify","website":"https://www.netlify.com"},{"domain":"zeit.co","name":"ZEIT Now Smart CDN","website":"https://zeit.co"},{"domain":"zeit-cdn.net","name":"ZEIT Now Smart CDN","website":"https://zeit.co"},{"domain":"b-cdn.net","name":"Bunny CDN","website":"https://bunnycdn.com/"},{"domain":"lsycdn.com","name":"蓝视云 CDN","website":"https://cloud.lsy.cn/"},{"domain":"scsdns.com","name":"逸云科技云加速 CDN","website":"http://www.exclouds.com/navPage/wise"},{"domain":"quic.cloud","name":"QUIC.Cloud","website":"https://quic.cloud/"},{"domain":"flexbalancer.net","name":"FlexBalancer - Smart Traffic Routing","website":"https://perfops.net/flexbalancer"},{"domain":"gcdn.co","name":"G - Core Labs","website":"https://gcorelabs.com/cdn/"},{"domain":"sangfordns.com","name":"深信服 AD 系列应用交付产品  单边加速解决方案","website":"http://www.sangfor.com.cn/topic/2011adn/solutions5.html"},{"domain":"stspg-customer.com","name":"StatusPage.io","website":"https://www.statuspage.io"},{"domain":"turbobytes.net","name":"TurboBytes Multi-CDN","website":"https://www.turbobytes.com"},{"domain":"turbobytes-cdn.com","name":"TurboBytes Multi-CDN","website":"https://www.turbobytes.com"},{"domain":"att-dsa.net","name":"AT&T Content Delivery Network","website":"https://www.business.att.com/products/cdn.html"},{"domain":"azioncdn.net","name":"Azion Tech | Edge Computing PLatform","website":"https://www.azion.com"},{"domain":"belugacdn.com","name":"BelugaCDN","website":"https://www.belugacdn.com"},{"domain":"cachefly.net","name":"CacheFly CDN","website":"https://www.cachefly.com/"},{"domain":"inscname.net","name":"Instart CDN","website":"https://www.instart.com/products/web-performance/cdn"},{"domain":"insnw.net","name":"Instart CDN","website":"https://www.instart.com/products/web-performance/cdn"},{"domain":"internapcdn.net","name":"Internap CDN","website":"https://www.inap.com/network/content-delivery-network"},{"domain":"footprint.net","name":"CenturyLink CDN (原 Level 3)","website":"https://www.centurylink.com/business/networking/cdn.html"},{"domain":"llnwi.net","name":"Limelight Network","website":"https://www.limelight.com"},{"domain":"llnwd.net","name":"Limelight Network","website":"https://www.limelight.com"},{"domain":"unud.net","name":"Limelight Network","website":"https://www.limelight.com"},{"domain":"lldns.net","name":"Limelight Network","website":"https://www.limelight.com"},{"domain":"stackpathdns.com","name":"Stackpath CDN","website":"https://www.stackpath.com"},{"domain":"stackpathcdn.com","name":"Stackpath CDN","website":"https://www.stackpath.com"},{"domain":"mncdn.com","name":"Medianova","website":"https://www.medianova.com"},{"domain":"rncdn1.com","name":"Relected Networks","website":"https://reflected.net/globalcdn"},{"domain":"simplecdn.net","name":"Relected Networks","website":"https://reflected.net/globalcdn"},{"domain":"swiftserve.com","name":"Conversant - SwiftServe CDN","website":"https://reflected.net/globalcdn"},{"domain":"bitgravity.com","name":"Tata communications CDN","website":"https://cdn.tatacommunications.com"},{"domain":"zenedge.net","name":"Oracle Dyn Web Application Security suite (原 Zenedge CDN)","website":"https://cdn.tatacommunications.com"},{"domain":"biliapi.com","name":"Bilibili 业务 GSLB","website":"https://lab.skk.moe/cdn"},{"domain":"hdslb.net","name":"Bilibili 高可用负载均衡","website":"https://github.com/bilibili/overlord"},{"domain":"hdslb.com","name":"Bilibili 高可用地域负载均衡","website":"https://github.com/bilibili/overlord"},{"domain":"xwaf.cn","name":"极御云安全(浙江壹云云计算有限公司)","website":"https://www.stopddos.cn"},{"domain":"shifen.com","name":"百度旗下业务地域负载均衡系统","website":"https://lab.skk.moe/cdn"},{"domain":"sinajs.cn","name":"新浪静态域名","website":"https://lab.skk.moe/cdn"},{"domain":"tencent-cloud.net","name":"腾讯旗下业务地域负载均衡系统","website":"https://lab.skk.moe/cdn"},{"domain":"elemecdn.com","name":"饿了么静态域名与地域负载均衡","website":"https://lab.skk.moe/cdn"},{"domain":"sinaedge.com","name":"新浪科技融合CDN负载均衡","website":"https://lab.skk.moe/cdn"},{"domain":"sina.com.cn","name":"新浪科技融合CDN负载均衡","website":"https://lab.skk.moe/cdn"},{"domain":"sinacdn.com","name":"新浪云 CDN","website":"https://www.sinacloud.com/doc/sae/php/cdn.html"},{"domain":"sinasws.com","name":"新浪云 CDN","website":"https://www.sinacloud.com/doc/sae/php/cdn.html"},{"domain":"saebbs.com","name":"新浪云 SAE 云引擎","website":"https://www.sinacloud.com/doc/sae/php/cdn.html"},{"domain":"websitecname.cn","name":"美橙互联旗下建站之星","website":"https://www.sitestar.cn"},{"domain":"cdncenter.cn","name":"美橙互联CDN","website":"https://www.cndns.com"},{"domain":"vhostgo.com","name":"西部数码虚拟主机","website":"https://www.west.cn"},{"domain":"jsd.cc","name":"上海云盾YUNDUN","website":"https://www.yundun.com"},{"domain":"powercdn.cn","name":"动力在线CDN","website":"http://www.powercdn.com"},{"domain":"21vokglb.cn","name":"世纪互联云快线业务","website":"https://www.21vianet.com"},{"domain":"21vianet.com.cn","name":"世纪互联云快线业务","website":"https://www.21vianet.com"},{"domain":"21okglb.cn","name":"世纪互联云快线业务","website":"https://www.21vianet.com"},{"domain":"21speedcdn.com","name":"世纪互联云快线业务","website":"https://www.21vianet.com"},{"domain":"21cvcdn.com","name":"世纪互联云快线业务","website":"https://www.21vianet.com"},{"domain":"okcdn.com","name":"世纪互联云快线业务","website":"https://www.21vianet.com"},{"domain":"okglb.com","name":"世纪互联云快线业务","website":"https://www.21vianet.com"},{"domain":"cdnetworks.net","name":"北京同兴万点网络技术","website":"http://www.txnetworks.cn/"},{"domain":"txnetworks.cn","name":"北京同兴万点网络技术","website":"http://www.txnetworks.cn/"},{"domain":"cdnnetworks.com","name":"北京同兴万点网络技术","website":"http://www.txnetworks.cn/"},{"domain":"txcdn.cn","name":"北京同兴万点网络技术","website":"http://www.txnetworks.cn/"},{"domain":"cdnunion.net","name":"宝腾互联旗下上海万根网络(CDN 联盟)","website":"http://www.cdnunion.com"},{"domain":"cdnunion.com","name":"宝腾互联旗下上海万根网络(CDN 联盟)","website":"http://www.cdnunion.com"},{"domain":"mygslb.com","name":"宝腾互联旗下上海万根网络(YaoCDN)","website":"http://www.vangen.cn"},{"domain":"cdnudns.com","name":"宝腾互联旗下上海万根网络(YaoCDN)","website":"http://www.vangen.cn"},{"domain":"sprycdn.com","name":"宝腾互联旗下上海万根网络(YaoCDN)","website":"http://www.vangen.cn"},{"domain":"chuangcdn.com","name":"创世云融合 CDN","website":"https://www.chuangcache.com/index.html"},{"domain":"aocde.com","name":"创世云融合 CDN","website":"https://www.chuangcache.com"},{"domain":"ctxcdn.cn","name":"中国电信天翼云CDN","website":"https://www.ctyun.cn/product2/#/product/10027560"},{"domain":"yfcdn.net","name":"云帆加速CDN","website":"https://www.yfcloud.com"},{"domain":"mmycdn.cn","name":"蛮蛮云 CDN(中联利信)","website":"https://www.chinamaincloud.com/cloudDispatch.html"},{"domain":"chinamaincloud.com","name":"蛮蛮云 CDN(中联利信)","website":"https://www.chinamaincloud.com/cloudDispatch.html"},{"domain":"cnispgroup.com","name":"中联数据(中联利信)","website":"http://www.cnispgroup.com/"},{"domain":"cdnle.com","name":"新乐视云联(原乐视云)CDN","website":"http://www.lecloud.com/zh-cn"},{"domain":"gosuncdn.com","name":"高升控股CDN技术","website":"http://www.gosun.com"},{"domain":"mmtrixopt.com","name":"mmTrix性能魔方(高升控股旗下)","website":"http://www.mmtrix.com"},{"domain":"cloudfence.cn","name":"蓝盾云CDN","website":"https://www.cloudfence.cn/#/cloudWeb/yaq/yaqyfx"},{"domain":"ngaagslb.cn","name":"新流云(新流万联)","website":"https://www.ngaa.com.cn"},{"domain":"p2cdn.com","name":"星域云P2P CDN","website":"https://www.xycloud.com"},{"domain":"00cdn.com","name":"星域云P2P CDN","website":"https://www.xycloud.com"},{"domain":"sankuai.com","name":"美团云(三快科技)负载均衡","website":"https://www.mtyun.com"},{"domain":"lccdn.org","name":"领智云 CDN(杭州领智云画)","website":"http://www.linkingcloud.com"},{"domain":"nscloudwaf.com","name":"绿盟云 WAF","website":"https://cloud.nsfocus.com"},{"domain":"2cname.com","name":"网堤安全","website":"https://www.ddos.com"},{"domain":"ucloudgda.com","name":"UCloud 罗马 Rome 全球网络加速","website":"https://www.ucloud.cn/site/product/rome.html"},{"domain":"google.com","name":"Google Web 业务","website":"https://lab.skk.moe/cdn"},{"domain":"1e100.net","name":"Google Web 业务","website":"https://lab.skk.moe/cdn"},{"domain":"ncname.com","name":"NodeCache","website":"https://www.nodecache.com"},{"domain":"alipaydns.com","name":"蚂蚁金服旗下业务地域负载均衡系统","website":"https://lab.skk.moe/cdn/"},{"domain":"wscloudcdn.com","name":"全速云(网宿)CloudEdge 云加速","website":"https://www.quansucloud.com/product.action?product.id=270"}]'
    
    ```

    或者直接在 *datakit.conf* 中默认采集器中开启即可：

    ``` toml
    default_enabled_inputs = [ "rum", "cpu", "disk", "diskio", "mem", "swap", "system", "hostobject", "net", "host_processes" ]
    ```

    配置好后，[重启 DataKit](datakit-service-how-to.md#manage-service) 即可。

=== "Kubernetes"

    在 datakit.yaml 中，环境变量 `ENV_DEFAULT_ENABLED_INPUTS` 增加 rum 采集器名称（如下 `value` 中第一个所示）：

    ```yaml
    - name: ENV_DEFAULT_ENABLED_INPUTS
      value: rum,cpu,disk,diskio,mem,swap,system,hostobject,net,host_processes,container
    ```

## 安全限制 {#security-setting}

由于 RUM DataKit 一般部署在公网环境，但是只会使用其中特定的 [DataKit API](apis.md) 接口，其它接口是不能开放的。通过如下方式可加强 API 访问控制，在 *datakit.conf* 中，修改如下 *public_apis* 字段配置：

```toml
[http_api]
  rum_origin_ip_header = "X-Forwarded-For"
  listen = "0.0.0.0:9529"
  disable_404page = true
  rum_app_id_white_list = []

  public_apis = [  # 如果该列表为空，则所有 API 不做访问控制
    "/v1/write/rum",
    "/some/other/apis/..."

    # 除此之外的其他 API，只能 localhost 访问，比如 datakit -M 就需要访问 /stats 接口
    # 另外，DCA 不受这个影响，因为它是独立的 HTTP server
  ]
```

其它接口依然可用，但只能通过 DataKit 本机访问，比如[查询 DQL](datakit-dql-how-to.md) 或者查看 [DataKit 运行状态](datakit-tools-how-to.md#using-monitor)。

### 禁用 DataKit 404 页面 {#disable-404}

可通过如下配置，禁用公网访问 DataKit 404 页面：

```toml
# datakit.conf
disable_404page = true
```

## 指标集 {#measurements}

RUM 采集器默认会采集如下几个指标集：

- `error`
- `view`
- `resource`
- `long_task`
- `action`

## Sourcemap 转换 {#sourcemap}

通常生产环境的 js 文件或移动端App代码会经过混淆和压缩以减小应用的尺寸，发生错误时的调用堆栈与开发时的源代码差异较大，不便于排错(`troubleshoot`)。如果需要定位错误至源码中，就得借助于`sourcemap`文件。

DataKit 支持这种源代码文件信息的映射，方法是将对应符号表文件进行 zip 压缩打包，命名格式为 `<app_id>-<env>-<version>.zip`，上传至`<DataKit安装目录>/data/rum/<platform>`，这样就可以对上报的`error`指标集数据自动进行转换，并追加 `error_stack_source` 字段至该指标集中。

### 安装 sourcemap 工具集 {#install-tools}

首先需要安装相应的符号还原工具，datakit 提供了一键安装命令来简化工具的安装：

```shell
sudo datakit install --symbol-tools
```

如果安装过程中出现某个软件安装失败的情况，你可能需要根据错误提示手动安装对应的软件


### Zip 包打包说明 {#zip}

=== "Web"

    将js文件经 webpack 混淆和压缩后生成的 `.map` 文件进行 zip 压缩打包，再拷贝到 `<DataKit安装目录>/data/rum/web`目录下，必须要保证该压缩包解压后的文件路径与`error_stack`中 URL 的路径一致。 假设如下 `error_stack`：

    ```
    ReferenceError
      at a.hideDetail @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:1037
      at a.showDetail @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:986
      at <anonymous> @ http://localhost:8080/static/js/app.7fb548e3d065d1f48f74.js:1:1174
    ```

    需要转换的路径是`/static/js/app.7fb548e3d065d1f48f74.js`，与其对应的`sourcemap`路径为`/static/js/app.7fb548e3d065d1f48f74.js.map`，那么对应压缩包解压后的目录结构如下：

    ```
    static/
    └── js
    └── app.7fb548e3d065d1f48f74.js.map
    
    ```

    转换后的`error_stack_source`：
    
    ```
    
    ReferenceError
      at a.hideDetail @ webpack:///src/components/header/header.vue:94:0
      at a.showDetail @ webpack:///src/components/header/header.vue:91:0
      at <anonymous> @ webpack:///src/components/header/header.vue:101:0
    ```

=== "Android"
    
    Android 目前存在两种 `sourcemap` 文件，一种是 Java 字节码经 `R8`/`Proguard` 压缩混淆后产生的 mapping 文件，另一种为 C/C++ 原生代码编译时未清除符号表和调试信息的（unstripped） `.so` 文件，如果你的安卓应用同时包含这两种 `sourcemap` 文件， 打包时需要把这两种文件都打包进 zip 包中，之后再把 zip 包拷贝到 `<DataKit安装目录>/data/rum/android` 目录下，zip 包解压后的目录结构类似：
    
    ```
    <app_id>-<env>-<version>/
    ├── mapping.txt
    ├── armeabi-v7a/
    │   ├── libgameengine.so
    │   ├── libothercode.so
    │   └── libvideocodec.so
    ├── arm64-v8a/
    │   ├── libgameengine.so
    │   ├── libothercode.so
    │   └── libvideocodec.so
    ├── x86/
    │   ├── libgameengine.so
    │   ├── libothercode.so
    │   └── libvideocodec.so
    └── x86_64/
        ├── libgameengine.so
        ├── libothercode.so
        └── libvideocodec.so
    ```

    默认情况下，`mapping` 文件将位于： `<项目文件夹>/<Module>/build/outputs/mapping/<build-type>/`，`.so` 文件在用CMake编译项目时位于： `<项目文件夹>/<Module>/build/intermediates/cmake/debug/obj/`，用NDK编译时位于：`<项目文件夹>/<Module>/build/intermediates/ndk/debug/obj/`（debug编译） 或 `<项目文件夹>/<Module>/build/intermediates/ndk/release/obj/`（release编译）。

    转换的效果如下：

    === "Java/Kotlin"

        转换前 `error_stack` :

        ```
        java.lang.ArithmeticException: divide by zero
            at prof.wang.activity.TeamInvitationActivity.o0(Unknown Source:1)
            at prof.wang.activity.TeamInvitationActivity.k0(Unknown Source:0)
            at j9.f7.run(Unknown Source:0)
            at java.lang.Thread.run(Thread.java:1012)
        ```
        
        转换后 `error_stack_source` :
    
        ```
        java.lang.ArithmeticException: divide by zero
        at prof.wang.activity.TeamInvitationActivity.onClick$lambda-0(TeamInvitationActivity.java:1)
        at java.lang.Thread.run(Thread.java:1012)
        ```

    === "C/C++ 原生代码"

        转换前 `error_stack` :
    
        ```
        backtrace:
        #00 pc 00000000000057fc  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_4+12)
        #01 pc 00000000000058a4  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_3+8)
        #02 pc 00000000000058b4  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_2+12)
        #03 pc 00000000000058c4  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_1+12)
        #04 pc 0000000000005938  /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_crash+112)
        ...
        ```
        
        转换后 `error_stack_source` :
    
        ```
        backtrace:
        
        Abort message: 'abort message for ftNative internal testing'
        #00 0x00000000000057fc /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_4+12)
        xc_test_call_4
        /Users/Brandon/Documents/workplace/working/StudioPlace/xCrash/xcrash_lib/src/main/cpp/xcrash/xc_test.c:65:9
        #01 0x00000000000058a4 /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_3+8)
        xc_test_call_3
        /Users/Brandon/Documents/workplace/working/StudioPlace/xCrash/xcrash_lib/src/main/cpp/xcrash/xc_test.c:73:13
        #02 0x00000000000058b4 /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_2+12)
        xc_test_call_2
        /Users/Brandon/Documents/workplace/working/StudioPlace/xCrash/xcrash_lib/src/main/cpp/xcrash/xc_test.c:79:13
        #03 0x00000000000058c4 /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_call_1+12)
        xc_test_call_1
        /Users/Brandon/Documents/workplace/working/StudioPlace/xCrash/xcrash_lib/src/main/cpp/xcrash/xc_test.c:85:13
        #04 0x0000000000005938 /data/app/~~Taci3mQyw7W7iWT7Jxo-ag==/com.ft-Q8m2flQFG1MbGImPiuAZmQ==/lib/arm64/libft_native_exp_lib.so (xc_test_crash+112)
        xc_test_crash
        /Users/Brandon/Documents/workplace/working/StudioPlace/xCrash/xcrash_lib/src/main/cpp/xcrash/xc_test.c:126:9
        ...
        ```

=== "iOS"

    iOS平台上的 `sourcemap` 文件是以 `.dSYM` 为后缀的带有调试信息的符号表文件，一般情况下，项目编译完和 `.app` 文件在同一个目录下，如下所示：

    ```
    $ ls -l Build/Products/Debug-iphonesimulator/
    total 0
    drwxr-xr-x   6 zy  staff  192  8  9 15:27 Fishing.app
    drwxr-xr-x   3 zy  staff   96  8  9 14:02 Fishing.app.dSYM
    drwxr-xr-x  15 zy  staff  480  8  9 15:27 Fishing.doccarchive
    drwxr-xr-x   6 zy  staff  192  8  9 13:55 Fishing.swiftmodule
    ```

    需要注意，XCode Release编译默认会生成 `.dSYM` 文件，而Debug编译默认不会生成，需要对 XCode 做如下相应的设置：

    ```
    Build Settings -> Code Generation -> Generate Debug Symbols -> Yes
    Build Settings -> Build Option -> Debug Information Format -> DWARF with dSYM File
    ```

    进行 zip 打包时，把相应的 `.dSYM` 文件打包进 zip 包即可，如果你的项目涉及多个 `.dSYM` 文件，需要一起打包到 zip 包内，之后再把 zip 包拷贝到 `<DataKit安装目录>/data/rum/ios` 目录下，zip 包解压后的目录结构类似如下(`.dSYM` 文件本质上是一个目录，和macOS下的可执行程序 `.app` 文件类似)：


    ```
    <app_id>-<env>-<version>/
    ├── AFNetworking.framework.dSYM
    │   └── Contents
    │       ├── Info.plist
    │       └── Resources
    │           └── DWARF
    │               └── AFNetworking
    └── App.app.dSYM
        └── Contents
            ├── Info.plist
            └── Resources
                └── DWARF
                    └── App
    
    ```

### 文件上传和删除 {#upload-delete}

打包完成后，除了手动拷贝至 DataKit 相关目录，还可通过 http 接口上传和删除该文件，前提是 Datakit 开启了 DCA 服务。

上传：

```shell
curl -X POST '<dca_address>/v1/rum/sourcemap?app_id=<app_id>&env=<env>&version=<version>&platform=<platform>' -F "file=@<sourcemap_path>" -H "Content-Type: multipart/form-data"
```

删除：

```shell
curl -X DELETE '<dca_address>/v1/rum/sourcemap?app_id=<app_id>&env=<env>&version=<version>&platform=<platform>'
```

变量说明：

- `<dca_address>`: DCA 服务的地址，如 `http://localhost:9531`
- `<app_id>`: 对应 RUM 的 `applicationId`
- `<env>`: 对应 RUM 的 `env`
- `<version>`: 对应 RUM 的 `version`
- `<platform>` 应用平台，当前支持 `web`/ `android` / `ios`
- `<sourcemap_path>`: 待上传的`sourcemap` 压缩包文件路径

???+ attention

    - 该转换过程，只针对 `error` 指标集
    - 当前只支持 Javascript/Android/iOS 的 sourcemap 转换
    - 如果未找到对应的 sourcemap 文件，将不进行转换
    - 通过接口上传的 sourcemap 压缩包，不需要重启 DataKit 即可生效。但如果是手动上传，需要重启 DataKit，方可生效


## CDN 标注 {#cdn-resolve}

对于 `resource` 指标，DataKit 尝试分析资源是否使用了 CDN 以及对应的 CDN 厂家，当指标集中的 `provider_type` 字段值是 "CDN" 时，表明该资源使用了 CDN，此时 `provider_name` 字段值为具体的 CDN 厂家名称。

### 自定义 CDN 查询列表 {#customize-cdn-map}

DataKit 内置了一个主流 CDN 厂家信息列表，如果发现你所使用的 CDN 无法被正常识别，可以在配置文件中修改该列表，配置文件默认位于 */usr/local/datakit/conf.d/rum/rum.conf*，具体根据你的 DataKit 安装位置确定，其中的 `cdn_map` 配置项即用于自定义 CDN 列表集，配置值是一个类似如下的 JSON：

```json
[
  {
    "domain": "alicdn.com",
    "name": "阿里云CDN",
    "website": "https://www.aliyun.com"
  },
  ...
]
```

可以简单复制 [内置CDN配置列表](built-in_cdn_dict_config.md){:target="_blank"} 并修改后直接粘贴到配置文件中，修改完需要重启 DataKit。


## RUM 会话重放 {#rum-session-replay}

从 Datakit [1.5.5](changelog.md#cl-1.5.5) 版本开始支持采集 RUM 会话重放数据，该功能需要修改 RUM 采集器配置，增加配置项 `session_replay_endpoints` 并重启 Datakit。

```toml
[[inputs.rum]]
  ## profile Agent endpoints register by version respectively.
  ## Endpoints can be skipped listen by remove them from the list.
  ## Default value set as below. DO NOT MODIFY THESE ENDPOINTS if not necessary.
  endpoints = ["/v1/write/rum"]

  ## use to upload rum screenshot,html,etc...
  session_replay_endpoints = ["/v1/write/rum/replay"]

  ...
```

???+ info

    RUM 配置文件默认位于 `/usr/local/datakit/conf.d/rum/rum.conf`，具体根据你所使用的操作系统和 Datakit 安装位置确定。