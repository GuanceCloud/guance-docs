---
skip: 'not-searchable-on-index-page'
title: 'Built-in CDN List'
---

<!-- markdownlint-disable -->

```toml
  cdn_map='''
  [
    {
        "domain":"15cdn.com",
        "name":"Tengzheng Security Acceleration (formerly 15CDN)",
        "website":"https://www.15cdn.com"
    },
    {
        "domain":"tzcdn.cn",
        "name":"Tengzheng Security Acceleration (formerly 15CDN)",
        "website":"https://www.15cdn.com"
    },
    {
        "domain":"cedexis.net",
        "name":"Cedexis GSLB",
        "website":"https://www.cedexis.com/"
    },
    {
        "domain":"cdxcn.cn",
        "name":"Cedexis GSLB (For China)",
        "website":"https://www.cedexis.com/"
    },
    {
        "domain":"qhcdn.com",
        "name":"360 Cloud CDN (Operated by QiAnXin)",
        "website":"https://cloud.360.cn/doc?name=cdn"
    },
    {
        "domain":"qh-cdn.com",
        "name":"360 Cloud CDN (Operated by Qihoo 360)",
        "website":"https://cloud.360.cn/doc?name=cdn"
    },
    {
        "domain":"qihucdn.com",
        "name":"360 Cloud CDN (Operated by Qihoo 360)",
        "website":"https://cloud.360.cn/doc?name=cdn"
    },
    {
        "domain":"360cdn.com",
        "name":"360 Cloud CDN (Operated by Qihoo 360)",
        "website":"https://cloud.360.cn/doc?name=cdn"
    },
    {
        "domain":"360cloudwaf.com",
        "name":"QiAnXin Website Guardian",
        "website":"https://wangzhan.qianxin.com"
    },
    {
        "domain":"360anyu.com",
        "name":"QiAnXin Website Guardian",
        "website":"https://wangzhan.qianxin.com"
    },
    {
        "domain":"360safedns.com",
        "name":"QiAnXin Website Guardian",
        "website":"https://wangzhan.qianxin.com"
    },
    {
        "domain":"360wzws.com",
        "name":"QiAnXin Website Guardian",
        "website":"https://wangzhan.qianxin.com"
    },
    {
        "domain":"akamai.net",
        "name":"Akamai CDN",
        "website":"https://www.akamai.com"
    },
    {
        "domain":"akamaiedge.net",
        "name":"Akamai CDN",
        "website":"https://www.akamai.com"
    },
    {
        "domain":"ytcdn.net",
        "name":"Akamai CDN",
        "website":"https://www.akamai.com"
    },
    {
        "domain":"edgesuite.net",
        "name":"Akamai CDN",
        "website":"https://www.akamai.com"
    },
    {
        "domain":"akamaitech.net",
        "name":"Akamai CDN",
        "website":"https://www.akamai.com"
    },
    {
        "domain":"akamaitechnologies.com",
        "name":"Akamai CDN",
        "website":"https://www.akamai.com"
    },
    {
        "domain":"edgekey.net",
        "name":"Akamai CDN",
        "website":"https://www.akamai.com"
    },
    {
        "domain":"tl88.net",
        "name":"Yitong Ruijin (Akamai China) Operated by Wangsu",
        "website":"https://www.akamai.com"
    },
    {
        "domain":"cloudfront.net",
        "name":"AWS CloudFront",
        "website":"https://aws.amazon.com/cn/cloudfront/"
    },
    {
        "domain":"worldcdn.net",
        "name":"CDN.NET",
        "website":"https://cdn.net"
    },
    {
        "domain":"worldssl.net",
        "name":"CDN.NET / CDNSUN / ONAPP",
        "website":"https://cdn.net"
    },
    {
        "domain":"cdn77.org",
        "name":"CDN77",
        "website":"https://www.cdn77.com/"
    },
    {
        "domain":"panthercdn.com",
        "name":"CDNetworks",
        "website":"https://www.cdnetworks.com"
    },
    {
        "domain":"cdnga.net",
        "name":"CDNetworks",
        "website":"https://www.cdnetworks.com"
    },
    {
        "domain":"cdngc.net",
        "name":"CDNetworks",
        "website":"https://www.cdnetworks.com"
    },
    {
        "domain":"gccdn.net",
        "name":"CDNetworks",
        "website":"https://www.cdnetworks.com"
    },
    {
        "domain":"gccdn.cn",
        "name":"CDNetworks",
        "website":"https://www.cdnetworks.com"
    },
    {
        "domain":"akamaized.net",
        "name":"Akamai CDN",
        "website":"https://www.akamai.com"
    },
    {
        "domain":"126.net",
        "name":"NetEase Cloud CDN",
        "website":"https://www.163yun.com/product/cdn"
    },
    {
        "domain":"163jiasu.com",
        "name":"NetEase Cloud CDN",
        "website":"https://www.163yun.com/product/cdn"
    },
    {
        "domain":"amazonaws.com",
        "name":"AWS Cloud",
        "website":"https://aws.amazon.com/cn/cloudfront/"
    },
    {
        "domain":"cdn77.net",
        "name":"CDN77",
        "website":"https://www.cdn77.com/"
    },
    {
        "domain":"cdnify.io",
        "name":"CDNIFY",
        "website":"https://cdnify.com"
    },
    {
        "domain":"cdnsun.net",
        "name":"CDNSUN",
        "website":"https://cdnsun.com"
    },
    {
        "domain":"bdydns.com",
        "name":"Baidu Cloud CDN",
        "website":"https://cloud.baidu.com/product/cdn.html"
    },
    {
        "domain":"ccgslb.com.cn",
        "name":"Chinanet Cache CDN",
        "website":"https://cn.chinacache.com/"
    },
    {
        "domain":"ccgslb.net",
        "name":"Chinanet Cache CDN",
        "website":"https://cn.chinacache.com/"
    },
    {
        "domain":"ccgslb.com",
        "name":"Chinanet Cache CDN",
        "website":"https://cn.chinacache.com/"
    },
    {
        "domain":"ccgslb.cn",
        "name":"Chinanet Cache CDN",
        "website":"https://cn.chinacache.com/"
    },
    {
        "domain":"c3cache.net",
        "name":"Chinanet Cache CDN",
        "website":"https://cn.chinacache.com/"
    },
    {
        "domain":"c3dns.net",
        "name":"Chinanet Cache CDN",
        "website":"https://cn.chinacache.com/"
    },
    {
        "domain":"chinacache.net",
        "name":"Chinanet Cache CDN",
        "website":"https://cn.chinacache.com/"
    },
    {
        "domain":"wswebcdn.com",
        "name":"Wangsu CDN",
        "website":"https://www.wangsu.com/"
    },
    {
        "domain":"lxdns.com",
        "name":"Wangsu CDN",
        "website":"https://www.wangsu.com/"
    },
    {
        "domain":"wswebpic.com",
        "name":"Wangsu CDN",
        "website":"https://www.wangsu.com/"
    },
    {
        "domain":"cloudflare.net",
        "name":"Cloudflare",
        "website":"https://www.cloudflare.com"
    },
    {
        "domain":"akadns.net",
        "name":"Akamai CDN",
        "website":"https://www.akamai.com"
    },
    {
        "domain":"chinanetcenter.com",
        "name":"Wangsu CDN",
        "website":"https://www.wangsu.com"
    },
    {
        "domain":"customcdn.com.cn",
        "name":"Wangsu CDN",
        "website":"https://www.wangsu.com"
    },
    {
        "domain":"customcdn.cn",
        "name":"Wangsu CDN",
        "website":"https://www.wangsu.com"
    },
    {
        "domain":"51cdn.com",
        "name":"Wangsu CDN",
        "website":"https://www.wangsu.com"
    },
    {
        "domain":"wscdns.com",
        "name":"Wangsu CDN",
        "website":"https://www.wangsu.com"
    },
    {
        "domain":"cdn20.com",
        "name":"Wangsu CDN",
        "website":"https://www.wangsu.com"
    },
    {
        "domain":"wsdvs.com",
        "name":"Wangsu CDN",
        "website":"https://www.wangsu.com"
    },
    {
        "domain":"wsglb0.com",
        "name":"Wangsu CDN",
        "website":"https://www.wangsu.com"
    },
    {
        "domain":"speedcdns.com",
        "name":"Wangsu CDN",
        "website":"https://www.wangsu.com"
    },
    {
        "domain":"wtxcdn.com",
        "name":"Wangsu CDN",
        "website":"https://www.wangsu.com"
    },
    {
        "domain":"wsssec.com",
        "name":"Wangsu WAF CDN",
        "website":"https://www.wangsu.com"
    },
    {
        "domain":"fastly.net",
        "name":"Fastly",
        "website":"https://www.fastly.com"
    },
    {
        "domain":"fastlylb.net",
        "name":"Fastly",
        "website":"https://www.fastly.com/"
    },
    {
        "domain":"hwcdn.net",
        "name":"Stackpath (formerly Highwinds)",
        "website":"https://www.stackpath.com/highwinds"
    },
    {
        "domain":"incapdns.net",
        "name":"Incapsula CDN",
        "website":"https://www.incapsula.com"
    },
    {
        "domain":"kxcdn.com.",
        "name":"KeyCDN",
        "website":"https://www.keycdn.com/"
    },
    {
        "domain":"lswcdn.net",
        "name":"LeaseWeb CDN",
        "website":"https://www.leaseweb.com/cdn"
    },
    {
        "domain":"mwcloudcdn.com",
        "name":"QUANTIL (Wangsu)",
        "website":"https://www.quantil.com/"
    },
    {
        "domain":"mwcname.com",
        "name":"QUANTIL (Wangsu)",
        "website":"https://www.quantil.com/"
    },
    {
        "domain":"azureedge.net",
        "name":"Microsoft Azure CDN",
        "website":"https://azure.microsoft.com/en-us/services/cdn/"
    },
    {
        "domain":"msecnd.net",
        "name":"Microsoft Azure CDN",
        "website":"https://azure.microsoft.com/en-us/services/cdn/"
    },
    {
        "domain":"mschcdn.com",
        "name":"Microsoft Azure CDN",
        "website":"https://azure.microsoft.com/en-us/services/cdn/"
    },
    {
        "domain":"v0cdn.net",
        "name":"Microsoft Azure CDN",
        "website":"https://azure.microsoft.com/en-us/services/cdn/"
    },
    {
        "domain":"azurewebsites.net",
        "name":"Microsoft Azure App Service",
        "website":"https://azure.microsoft.com/en-us/services/app-service/"
    },
    {
        "domain":"azurewebsites.windows.net",
        "name":"Microsoft Azure App Service",
        "website":"https://azure.microsoft.com/en-us/services/app-service/"
    },
    {
        "domain":"trafficmanager.net",
        "name":"Microsoft Azure Traffic Manager",
        "website":"https://azure.microsoft.com/en-us/services/traffic-manager/"
    },
    {
        "domain":"cloudapp.net",
        "name":"Microsoft Azure",
        "website":"https://azure.microsoft.com"
    },
    {
        "domain":"chinacloudsites.cn",
        "name":"Century互联 Shanghai BlueCloud (Supporting Azure China)",
        "website":"https://www.21vbluecloud.com/"
    },
    {
        "domain":"spdydns.com",
        "name":"Cloud Zhidu Fusion CDN",
        "website":"https://www.isurecloud.net/index.html"
    },
    {
        "domain":"jiashule.com",
        "name":"Zhidao Chuangyu Cloud Security Acceleration CDN",
        "website":"https://www.yunaq.com/jsl/"
    },
    {
        "domain":"jiasule.org",
        "name":"Zhidao Chuangyu Cloud Security Acceleration CDN",
        "website":"https://www.yunaq.com/jsl/"
    },
    {
        "domain":"365cyd.cn",
        "name":"Zhidao Chuangyu Cloud Security CYD (Government Special Use)",
        "website":"https://www.yunaq.com/cyd/"
    },
    {
        "domain":"huaweicloud.com",
        "name":"Huawei Cloud WAF High-Defense Cloud Shield",
        "website":"https://www.huaweicloud.com/product/aad.html"
    },
    {
        "domain":"cdnhwc1.com",
        "name":"Huawei Cloud CDN",
        "website":"https://www.huaweicloud.com/product/cdn.html"
    },
    {
        "domain":"cdnhwc2.com",
        "name":"Huawei Cloud CDN",
        "website":"https://www.huaweicloud.com/product/cdn.html"
    },
    {
        "domain":"cdnhwc3.com",
        "name":"Huawei Cloud CDN",
        "website":"https://www.huaweicloud.com/product/cdn.html"
    },
    {
        "domain":"dnion.com",
        "name":"DiLian Technology",
        "website":"http://www.dnion.com/"
    },
    {
        "domain":"ewcache.com",
        "name":"DiLian Technology",
        "website":"http://www.dnion.com/"
    },
    {
        "domain":"globalcdn.cn",
        "name":"DiLian Technology",
        "website":"http://www.dnion.com/"
    },
    {
        "domain":"tlgslb.com",
        "name":"DiLian Technology",
        "website":"http://www.dnion.com/"
    },
    {
        "domain":"fastcdn.com",
        "name":"DiLian Technology",
        "website":"http://www.dnion.com/"
    },
    {
        "domain":"flxdns.com",
        "name":"DiLian Technology",
        "website":"http://www.dnion.com/"
    },
    {
        "domain":"dlgslb.cn",
        "name":"DiLian Technology",
        "website":"http://www.dnion.com/"
    },
    {
        "domain":"newdefend.cn",
        "name":"NiuDun Cloud Security",
        "website":"https://www.newdefend.com"
    },
    {
        "domain":"ffdns.net",
        "name":"CloudXNS",
        "website":"https://www.cloudxns.net"
    },
    {
        "domain":"aocdn.com",
        "name":"KeKao Yun CDN (TieTuKu)",
        "website":"http://www.kekaoyun.com/"
    },
    {
        "domain":"bsgslb.cn",
        "name":"Baishan Cloud CDN",
        "website":"https://zh.baishancloud.com/"
    },
    {
        "domain":"qingcdn.com",
        "name":"Baishan Cloud CDN",
        "website":"https://zh.baishancloud.com/"
    },
    {
        "domain":"bsclink.cn",
        "name":"Baishan Cloud CDN",
        "website":"https://zh.baishancloud.com/"
    },
    {
        "domain":"trpcdn.net",
        "name":"Baishan Cloud CDN",
        "website":"https://zh.baishancloud.com/"
    },
    {
        "domain":"anquan.io",
        "name":"NiuDun Cloud Security",
        "website":"https://www.newdefend.com"
    },
    {
        "domain":"cloudglb.com",
        "name":"KuaiWang CDN",
        "website":"http://www.fastweb.com.cn/"
    },
    {
        "domain":"fastweb.com",
        "name":"KuaiWang CDN",
        "website":"http://www.fastweb.com.cn/"
    },
    {
        "domain":"fastwebcdn.com",
        "name":"KuaiWang CDN",
        "website":"http://www.fastweb.com.cn/"
    },
    {
        "domain":"cloudcdn.net",
        "name":"KuaiWang CDN",
        "website":"http://www.fastweb.com.cn/"
    },
    {
        "domain":"fwcdn.com",
        "name":"KuaiWang CDN",
        "website":"http://www.fastweb.com.cn/"
    },
    {
        "domain":"fwdns.net",
        "name":"KuaiWang CDN",
        "website":"http://www.fastweb.com.cn/"
    },
    {
        "domain":"hadns.net",
        "name":"KuaiWang CDN",
        "website":"http://www.fastweb.com.cn/"
    },
    {
        "domain":"hacdn.net",
        "name":"KuaiWang CDN",
        "website":"http://www.fastweb.com.cn/"
    },
    {
        "domain":"cachecn.com",
        "name":"KuaiWang CDN",
        "website":"http://www.fastweb.com.cn/"
    },
    {
        "domain":"qingcache.com",
        "name":"QingCloud CDN",
        "website":"https://www.qingcloud.com/products/cdn/"
    },
    {
        "domain":"qingcloud.com",
        "name":"QingCloud CDN",
        "website":"https://www.qingcloud.com/products/cdn/"
    },
    {
        "domain":"frontwize.com",
        "name":"QingCloud CDN",
        "website":"https://www.qingcloud.com/products/cdn/"
    },
    {
        "domain":"msscdn.com",
        "name":"Meituan Cloud CDN",
        "website":"https://www.mtyun.com/product/cdn"
    },
    {
        "domain":"800cdn.com",
        "name":"Western Digital",
        "website":"https://www.west.cn"
    },
    {
        "domain":"tbcache.com",
        "name":"Alibaba Cloud CDN",
        "website":"https://www.aliyun.com/product/cdn"
    },
    {
        "domain":"aliyun-inc.com",
        "name":"Alibaba Cloud CDN",
        "website":"https://www.aliyun.com/product/cdn"
    },
    {
        "domain":"aliyuncs.com",
        "name":"Alibaba Cloud CDN",
        "website":"https://www.aliyun.com/product/cdn"
    },
    {
        "domain":"alikunlun.net",
        "name":"Alibaba Cloud CDN",
        "website":"https://www.aliyun.com/product/cdn"
    },
    {
        "domain":"alikunlun.com",
        "name":"Alibaba Cloud CDN",
        "website":"https://www.aliyun.com/product/cdn"
    },
    {
        "domain":"alicdn.com",
        "name":"Alibaba Cloud CDN",
        "website":"https://www.aliyun.com/product/cdn"
    },
    {
        "domain":"aligaofang.com",
        "name":"Alibaba Cloud Shield High Defense",
        "website":"https://www.aliyun.com/product/ddos"
    },
    {
        "domain":"yundunddos.com",
        "name":"Alibaba Cloud Shield High Defense",
        "website":"https://www.aliyun.com/product/ddos"
    },
    {
        "domain":"kunlun*.com",
        "name":"Alibaba Cloud CDN",
        "website":"https://www.aliyun.com/product/cdn"
    },
    {
        "domain":"cdngslb.com",
        "name":"Alibaba Cloud CDN",
        "website":"https://www.aliyun.com/product/cdn"
    },
    {
        "domain":"yunjiasu-cdn.net",
        "name":"Baidu Cloud Acceleration",
        "website":"https://su.baidu.com"
    },
    {
        "domain":"momentcdn.com",
        "name":"MoMen Cloud CDN",
        "website":"https://www.cachemoment.com"
    },
    {
        "domain":"aicdn.com",
        "name":"YouPai Cloud",
        "website":"https://www.upyun.com"
    },
    {
        "domain":"qbox.me",
        "name":"Qiniu Cloud",
        "website":"https://www.qiniu.com"
    },
    {
        "domain":"qiniu.com",
        "name":"Qiniu Cloud",
        "website":"https://www.qiniu.com"
    },
    {
        "domain":"qiniudns.com",
        "name":"Qiniu Cloud",
        "website":"https://www.qiniu.com"
    },
    {
        "domain":"jcloudcs.com",
        "name":"JD Cloud CDN",
        "website":"https://www.jdcloud.com/cn/products/cdn"
    },
    {
        "domain":"jdcdn.com",
        "name":"JD Cloud CDN",
        "website":"https://www.jdcloud.com/cn/products/cdn"
    },
    {
        "domain":"qianxun.com",
        "name":"JD Cloud CDN",
        "website":"https://www.jdcloud.com/cn/products/cdn"
    },
    {
        "domain":"jcloudlb.com",
        "name":"JD Cloud CDN",
        "website":"https://www.jdcloud.com/cn/products/cdn"
    },
    {
        "domain":"jcloud-cdn.com",
        "name":"JD Cloud CDN",
        "website":"https://www.jdcloud.com/cn/products/cdn"
    },
    {
        "domain":"maoyun.tv",
        "name":"MaoCloud Fusion CDN",
        "website":"https://www.maoyun.com/"
    },
    {
        "domain":"maoyundns.com",
        "name":"MaoCloud Fusion CDN",
        "website":"https://www.maoyun.com/"
    },
    {
        "domain":"xgslb.net",
        "name":"WebLuker (ChinanetCache)",
        "website":"http://www.webluker.com"
    },
    {
        "domain":"ucloud.cn",
        "name":"UCloud CDN",
        "website":"https://www.ucloud.cn/site/product/ucdn.html"
    },
    {
        "domain":"ucloud.com.cn",
        "name":"UCloud CDN",
        "website":"https://www.ucloud.cn/site/product/ucdn.html"
    },
    {
        "domain":"cdndo.com",
        "name":"UCloud CDN",
        "website":"https://www.ucloud.cn/site/product/ucdn.html"
    },
    {
        "domain":"zenlogic.net",
        "name":"Zenlayer CDN",
        "website":"https://www.zenlayer.com"
    },
    {
        "domain":"ogslb.com",
        "name":"Zenlayer CDN",
        "website":"https://www.zenlayer.com"
    },
    {
        "domain":"uxengine.net",
        "name":"Zenlayer CDN",
        "website":"https://www.zenlayer.com"
    },
    {
        "domain":"tan14.net",
        "name":"TAN14 CDN",
        "website":"http://www.tan14.cn/"
    },
    {
        "domain":"verycloud.cn",
        "name":"VeryCloud Cloud Distribution",
        "website":"https://www.verycloud.cn/"
    },
    {
        "domain":"verycdn.net",
        "name":"VeryCloud Cloud Distribution",
        "website":"https://www.verycloud.cn/"
    },
    {
        "domain":"verygslb.com",
        "name":"VeryCloud Cloud Distribution",
        "website":"https://www.verycloud.cn/"
    },
    {
        "domain":"xundayun.cn",
        "name":"SpeedyCloud CDN",
        "website":"https://www.speedycloud.cn/zh/Products/CDN/CloudDistribution.html"
    },
    {
        "domain":"xundayun.com",
        "name":"SpeedyCloud CDN",
        "website":"https://www.speedycloud.cn/zh/Products/CDN/CloudDistribution.html"
    },
    {
        "domain":"speedycloud.cc",
        "name":"SpeedyCloud CDN",
        "website":"https://www.speedycloud.cn/zh/Products/CDN/CloudDistribution.html"
    },
    {
        "domain":"mucdn.net",
        "name":"Verizon CDN (Edgecast)",
        "website":"https://www.verizondigitalmedia.com/platform/edgecast-cdn/"
    },
    {
        "domain":"nucdn.net",
        "name":"Verizon CDN (Edgecast)",
        "website":"https://www.verizondigitalmedia.com/platform/edgecast-cdn/"
    },
    {
        "domain":"alphacdn.net",
        "name":"Verizon CDN (Edgecast)",
        "website":"https://www.verizondigitalmedia.com/platform/edgecast-cdn/"
    },
    {
        "domain":"systemcdn.net",
        "name":"Verizon CDN (Edgecast)",
        "website":"https://www.verizondigitalmedia.com/platform/edgecast-cdn/"
    },
    {
        "domain":"edgecastcdn.net",
        "name":"Verizon CDN (Edgecast)",
        "website":"https://www.verizondigitalmedia.com/platform/edgecast-cdn/"
    },
    {
        "domain":"zetacdn.net",
        "name":"Verizon CDN (Edgecast)",
        "website":"https://www.verizondigitalmedia.com/platform/edgecast-cdn/"
    },
    {
        "domain":"coding.io",
        "name":"Coding Pages",
        "website":"https://coding.net/pages"
    },
    {
        "domain":"coding.me",
        "name":"Coding Pages",
        "website":"https://coding.net/pages"
    },
    {
        "domain":"gitlab.io",
        "name":"GitLab Pages",
        "website":"https://docs.gitlab.com/ee/user/project/pages/"
    },
    {
        "domain":"github.io",
        "name":"GitHub Pages",
        "website":"https://pages.github.com/"
    },
    {
        "domain":"herokuapp.com",
        "name":"Heroku SaaS",
        "website":"https://www.heroku.com"
    },
    {
        "domain":"googleapis.com",
        "name":"Google Cloud Storage",
        "website":"https://cloud.google.com/storage/"
    },
    {
        "domain":"netdna.com",
        "name":"Stackpath (formerly MaxCDN)",
        "website":"https://www.stackpath.com/maxcdn/"
    },
    {
        "domain":"netdna-cdn.com",
        "name":"Stackpath (formerly MaxCDN)",
        "website":"https://www.stackpath.com/maxcdn/"
    },
    {
        "domain":"netdna-ssl.com",
        "name":"Stackpath (formerly MaxCDN)",
        "website":"https://www.stackpath.com/maxcdn/"
    },
    {
        "domain":"cdntip.com",
        "name":"Tencent Cloud CDN",
        "website":"https://cloud.tencent.com/product/cdn-scd"
    },
    {
        "domain":"dnsv1.com",
        "name":"Tencent Cloud CDN",
        "website":"https://cloud.tencent.com/product/cdn-scd"
    },
    {
        "domain":"tencdns.net",
        "name":"Tencent Cloud CDN",
        "website":"https://cloud.tencent.com/product/cdn-scd"
    },
    {
        "domain":"dayugslb.com",
        "name":"Tencent Cloud Dayu BGP High Defense",
        "website":"https://cloud.tencent.com/product/ddos-advanced"
    },
    {
        "domain":"tcdnvod.com",
        "name":"Tencent Cloud Video CDN",
        "website":"https://lab.skk.moe/cdn"
    },
    {
        "domain":"tdnsv5.com",
        "name":"Tencent Cloud CDN",
        "website":"https://cloud.tencent.com/product/cdn-scd"
    },
    {
        "domain":"ksyuncdn.com",
        "name":"Kingsoft Cloud CDN",
        "website":"https://www.ksyun.com/post/product/CDN"
    },
    {
        "domain":"ks-cdn.com",
        "name":"Kingsoft Cloud CDN",
        "website":"https://www.ksyun.com/post/product/CDN"
    },
    {
        "domain":"ksyuncdn-k1.com",
        "name":"Kingsoft Cloud CDN",
        "website":"https://www.ksyun.com/post/product/CDN"
    },
    {
        "domain":"netlify.com",
        "name":"Netlify",
        "website":"https://www.netlify.com"
    },
    {
        "domain":"zeit.co",
        "name":"ZEIT Now Smart CDN",
        "website":"https://zeit.co"
    },
    {
        "domain":"zeit-cdn.net",
        "name":"ZEIT Now Smart CDN",
        "website":"https://zeit.co"
    },
    {
        "domain":"b-cdn.net",
        "name":"Bunny CDN",
        "website":"https://bunnycdn.com/"
    },
    {
        "domain":"lsycdn.com",
        "name":"LanShi Cloud CDN",
        "website":"https://cloud.lsy.cn/"
    },
    {
        "domain":"scsdns.com",
        "name":"YiCloud Technology Cloud Acceleration CDN",
        "website":"http://www.exclouds.com/navPage/wise"
    },
    {
        "domain":"quic.cloud",
        "name":"QUIC.Cloud",
        "website":"https://quic.cloud/"
    },
    {
        "domain":"flexbalancer.net",
        "name":"FlexBalancer - Smart Traffic Routing",
        "website":"https://perfops.net/flexbalancer"
    },
    {
        "domain":"gcdn.co",
        "name":"G - Core Labs",
        "website":"https://gcorelabs.com/cdn/"
    },
    {
        "domain":"sangfordns.com",
        "name":"Sangfor AD Series Application Delivery Products Single-Sided Acceleration Solutions",
        "website":"http://www.sangfor.com.cn/topic/2011adn/solutions5.html"
    },
    {
        "domain":"stspg-customer.com",
        "name":"StatusPage.io",
        "website":"https://www.statuspage.io"
    },
    {
        "domain":"turbobytes.net",
        "name":"TurboBytes Multi-CDN",
        "website":"https://www.turbobytes.com"
    },
    {
        "domain":"turbobytes-cdn.com",
        "name":"TurboBytes Multi-CDN",
        "website":"https://www.turbobytes.com"
    },
    {
        "domain":"att-dsa.net",
        "name":"AT&T Content Delivery Network",
        "website":"https://www.business.att.com/products/cdn.html"
    },
    {
        "domain":"azioncdn.net",
        "name":"Azion Tech | Edge Computing PLatform",
        "website":"https://www.azion.com"
    },
    {
        "domain":"belugacdn.com",
        "name":"BelugaCDN",
        "website":"https://www.belugacdn.com"
    },
    {
        "domain":"cachefly.net",
        "name":"CacheFly CDN",
        "website":"https://www.cachefly.com/"
    },
    {
        "domain":"inscname.net",
        "name":"Instart CDN",
        "website":"https://www.instart.com/products/web-performance/cdn"
    },
    {
        "domain":"insnw.net",
        "name":"Instart CDN",
        "website":"https://www.instart.com/products/web-performance/cdn"
    },
    {
        "domain":"internapcdn.net",
        "name":"Internap CDN",
        "website":"https://www.inap.com/network/content-delivery-network"
    },
    {
        "domain":"footprint.net",
        "name":"CenturyLink CDN (formerly Level 3)",
        "website":"https://www.centurylink.com/business/networking/cdn.html"
    },
    {
        "domain":"llnwi.net",
        "name":"Limelight Network",
        "website":"https://www.limelight.com"
    },
    {
        "domain":"llnwd.net",
        "name":"Limelight Network",
        "website":"https://www.limelight.com"
    },
    {
        "domain":"unud.net",
        "name":"Limelight Network",
        "website":"https://www.limelight.com"
    },
    {
        "domain":"lldns.net",
        "name":"Limelight Network",
        "website":"https://www.limelight.com"
    },
    {
        "domain":"stackpathdns.com",
        "name":"Stackpath CDN",
        "website":"https://www.stackpath.com"
    },
    {
        "domain":"stackpathcdn.com",
        "name":"Stackpath CDN",
        "website":"https://www.stackpath.com"
    },
    {
        "domain":"mncdn.com",
        "name":"Medianova",
        "website":"https://www.medianova.com"
    },
    {
        "domain":"rncdn1.com",
        "name":"Relected Networks",
        "website":"https://reflected.net/globalcdn"
    },
    {
        "domain":"simplecdn.net",
        "name":"Relected Networks",
        "website":"https://reflected.net/globalcdn"
    },
    {
        "domain":"swiftserve.com",
        "name":"Conversant - SwiftServe CDN",
        "website":"https://reflected.net/globalcdn"
    },
    {
        "domain":"bitgravity.com",
        "name":"Tata communications CDN",
        "website":"https://cdn.tatacommunications.com"
    },
    {
        "domain":"zenedge.net",
        "name":"Oracle Dyn Web Application Security suite (formerly Zenedge CDN)",
        "website":"https://cdn.tatacommunications.com"
    },
    {
        "domain":"biliapi.com",
        "name":"Bilibili Business GSLB",
        "website":"https://lab.skk.moe/cdn"
    },
    {
        "domain":"hdslb.net",
        "name":"Bilibili High-Availability Load Balancing",
        "website":"https://github.com/bilibili/overlord"
    },
    {
        "domain":"hdslb.com",
        "name":"Bilibili High-Availability Regional Load Balancing",
        "website":"https://github.com/bilibili/overlord"
    },
    {
        "domain":"xwaf.cn",
        "name":"JiYu Cloud Security (Zhejiang YiYun Cloud Computing Co., Ltd.)",
        "website":"https://www.stopddos.cn"
    },
    {
        "domain":"shifen.com",
        "name":"Baidu Subsidiary Business Regional Load Balancing System",
        "website":"https://lab.skk.moe/cdn"
    },
    {
        "domain":"sinajs.cn",
        "name":"Sina Static Domain",
        "website":"https://lab.skk.moe/cdn"
    },
    {
        "domain":"tencent-cloud.net",
        "name":"Tencent Subsidiary Business Regional Load Balancing System",
        "website":"https://lab.skk.moe/cdn"
    },
    {
        "domain":"elemecdn.com",
        "name":"Ele.me Static Domain and Regional Load Balancing",
        "website":"https://lab.skk.moe/cdn"
    },
    {
        "domain":"sinaedge.com",
        "name":"SinaTech Fusion CDN Load Balancing",
        "website":"https://lab.skk.moe/cdn"
    },
    {
        "domain":"sina.com.cn",
        "name":"SinaTech Fusion CDN Load Balancing",
        "website":"https://lab.skk.moe/cdn"
    },
    {
        "domain":"sinacdn.com",
        "name":"SinaCloud CDN",
        "website":"https://www.sinacloud.com/doc/sae/php/cdn.html"
    },
    {
        "domain":"sinasws.com",
        "name":"SinaCloud CDN",
        "website":"https://www.sinacloud.com/doc/sae/php/cdn.html"
    },
    {
        "domain":"saebbs.com",
        "name":"SinaCloud SAE Cloud Engine",
        "website":"https://www.sinacloud.com/doc/sae/php/cdn.html"
    },
    {
        "domain":"websitecname.cn",
        "name":"MeichengInterconnect BuildSiteStar,
        "website":"https://www.sitestar.cn"
    },
    {
        "domain":"cdncenter.cn",
        "name":"Meicheng Interconnect CDN",
        "website":"https://www.cndns.com"
    },
    {
        "domain":"vhostgo.com",
        "name":"Western Digital Virtual Host",
        "website":"https://www.west.cn"
    },
    {
        "domain":"jsd.cc",
        "name":"Shanghai Yundun YUNDUN",
        "website":"https://www.yundun.com"
    },
    {
        "domain":"powercdn.cn",
        "name":"Power Online CDN",
        "website":"http://www.powercdn.com"
    },
    {
        "domain":"21vokglb.cn",
        "name":"Century Interconnect Cloud Express Business",
        "website":"https://www.21vianet.com"
    },
    {
        "domain":"21vianet.com.cn",
        "name":"Century Interconnect Cloud Express Business",
        "website":"https://www.21vianet.com"
    },
    {
        "domain":"21okglb.cn",
        "name":"Century Interconnect Cloud Express Business",
        "website":"https://www.21vianet.com"
    },
    {
        "domain":"21speedcdn.com",
        "name":"Century Interconnect Cloud Express Business",
        "website":"https://www.21vianet.com"
    },
    {
        "domain":"21cvcdn.com",
        "name":"Century Interconnect Cloud Express Business",
        "website":"https://www.21vianet.com"
    },
    {
        "domain":"okcdn.com",
        "name":"Century Interconnect Cloud Express Business",
        "website":"https://www.21vianet.com"
    },
    {
        "domain":"okglb.com",
        "name":"Century Interconnect Cloud Express Business",
        "website":"https://www.21vianet.com"
    },
    {
        "domain":"cdnetworks.net",
        "name":"Beijing Tongxing Wandian Network Technology",
        "website":"http://www.txnetworks.cn/"
    },
    {
        "domain":"txnetworks.cn",
        "name":"Beijing Tongxing Wandian Network Technology",
        "website":"http://www.txnetworks.cn/"
    },
    {
        "domain":"cdnnetworks.com",
        "name":"Beijing Tongxing Wandian Network Technology",
        "website":"http://www.txnetworks.cn/"
    },
    {
        "domain":"txcdn.cn",
        "name":"Beijing Tongxing Wandian Network Technology",
        "website":"http://www.txnetworks.cn/"
    },
    {
        "domain":"cdnunion.net",
        "name":"Baoteng Interconnect Shanghai Wangen Network (CDN Union)",
        "website":"http://www.cdnunion.com"
    },
    {
        "domain":"cdnunion.com",
        "name":"Baoteng Interconnect Shanghai Wangen Network (CDN Union)",
        "website":"http://www.cdnunion.com"
    },
    {
        "domain":"mygslb.com",
        "name":"Baoteng Interconnect Shanghai Wangen Network (YaoCDN)",
        "website":"http://www.vangen.cn"
    },
    {
        "domain":"cdnudns.com",
        "name":"Baoteng Interconnect Shanghai Wangen Network (YaoCDN)",
        "website":"http://www.vangen.cn"
    },
    {
        "domain":"sprycdn.com",
        "name":"Baoteng Interconnect Shanghai Wangen Network (YaoCDN)",
        "website":"http://www.vangen.cn"
    },
    {
        "domain":"chuangcdn.com",
        "name":"Chuangshi Cloud Fusion CDN",
        "website":"https://www.chuangcache.com/index.html"
    },
    {
        "domain":"aocde.com",
        "name":"Chuangshi Cloud Fusion CDN",
        "website":"https://www.chuangcache.com"
    },
    {
        "domain":"ctxcdn.cn",
        "name":"China Telecom Tianyi Cloud CDN",
        "website":"https://www.ctyun.cn/product2/#/product/10027560"
    },
    {
        "domain":"yfcdn.net",
        "name":"Yunfan Acceleration CDN",
        "website":"https://www.yfcloud.com"
    },
    {
        "domain":"mmycdn.cn",
        "name":"ManMan Cloud CDN (Zhonglian Lixin)",
        "website":"https://www.chinamaincloud.com/cloudDispatch.html"
    },
    {
        "domain":"chinamaincloud.com",
        "name":"ManMan Cloud CDN (Zhonglian Lixin)",
        "website":"https://www.chinamaincloud.com/cloudDispatch.html"
    },
    {
        "domain":"cnispgroup.com",
        "name":"Zhonglian Data (Zhonglian Lixin)",
        "website":"http://www.cnispgroup.com/"
    },
    {
        "domain":"cdnle.com",
        "name":"Xin Le Shi Yun Lian (formerly Letv Cloud) CDN",
        "website":"http://www.lecloud.com/zh-cn"
    },
    {
        "domain":"gosuncdn.com",
        "name":"Gaosheng Holdings CDN Technology",
        "website":"http://www.gosun.com"
    },
    {
        "domain":"mmtrixopt.com",
        "name":"mmTrix Performance Cube (under Gaosheng Holdings)",
        "website":"http://www.mmtrix.com"
    },
    {
        "domain":"cloudfence.cn",
        "name":"LanDun Cloud CDN",
        "website":"https://www.cloudfence.cn/#/cloudWeb/yaq/yaqyfx"
    },
    {
        "domain":"ngaagslb.cn",
        "name":"Xin Liu Cloud (Xin Liu Wan Lian)",
        "website":"https://www.ngaa.com.cn"
    },
    {
        "domain":"p2cdn.com",
        "name":"Xingyu Cloud P2P CDN",
        "website":"https://www.xycloud.com"
    },
    {
        "domain":"00cdn.com",
        "name":"Xingyu Cloud P2P CDN",
        "website":"https://www.xycloud.com"
    },
    {
        "domain":"sankuai.com",
        "name":"Meituan Cloud (SanKuai Technology) Load Balancing",
        "website":"https://www.mtyun.com"
    },
    {
        "domain":"lccdn.org",
        "name":"LingZhi Cloud CDN (Hangzhou LingZhi Cloud Painting)",
        "website":"http://www.linkingcloud.com"
    },
    {
        "domain":"nscloudwaf.com",
        "name":"LuMeng Cloud WAF",
        "website":"https://cloud.nsfocus.com"
    },
    {
        "domain":"2cname.com",
        "name":"NetDi Security",
        "website":"https://www.ddos.com"
    },
    {
        "domain":"ucloudgda.com",
        "name":"UCloud Rome Global Network Acceleration",
        "website":"https://www.ucloud.cn/site/product/rome.html"
    },
    {
        "domain":"google.com",
        "name":"Google Web Services",
        "website":"https://lab.skk.moe/cdn"
    },
    {
        "domain":"1e100.net",
        "name":"Google Web Services",
        "website":"https://lab.skk.moe/cdn"
    },
    {
        "domain":"ncname.com",
        "name":"NodeCache",
        "website":"https://www.nodecache.com"
    },
    {
        "domain":"alipaydns.com",
        "name":"Ant Financial Subsidiary Business Regional Load Balancing System",
        "website":"https://lab.skk.moe/cdn/"
    },
    {
        "domain":"wscloudcdn.com",
        "name":"QuanSu Cloud (Wangsu) CloudEdge Cloud Acceleration",
        "website":"https://www.quansucloud.com/product.action?product.id=270"
    }
]
'''
```
