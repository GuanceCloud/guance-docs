ARG release_env
ARG GUANCE_HELPS_OSS_AK_ID
ARG GUANCE_HELPS_OSS_AK_SECRET
ARG GUANCE_HELPS_CDN_AK_ID
ARG GUANCE_HELPS_CDN_AK_SECRET
ARG GUANCE_HELPS_OSS_BUCKET
ARG GUANCE_HELPS_OSS_ENDPOINT
# 配置文档索引搜索的ES实例信息
ARG ES_VAR_DOC_SEARCH_TEST
ARG ES_VAR_DOC_SEARCH_PROD

FROM registry.jiagouyun.com/basis/mkdocs:2.6 as build

ARG release_env
ARG GUANCE_HELPS_OSS_AK_ID
ARG GUANCE_HELPS_OSS_AK_SECRET
ARG GUANCE_HELPS_CDN_AK_ID
ARG GUANCE_HELPS_CDN_AK_SECRET
ARG GUANCE_HELPS_OSS_BUCKET
ARG GUANCE_HELPS_OSS_ENDPOINT
# 配置文档索引搜索的ES实例信息
ARG ES_VAR_DOC_SEARCH_TEST
ARG ES_VAR_DOC_SEARCH_PROD

RUN mkdir /dataflux-doc
WORKDIR /dataflux-doc
COPY ./ /dataflux-doc

# set doc-search env
ENV ES_VAR_DOC_SEARCH_TEST=$ES_VAR_DOC_SEARCH_TEST
ENV ES_VAR_DOC_SEARCH_PROD=$ES_VAR_DOC_SEARCH_PROD

RUN \
    enFileArg=mkdocs.en.saas.yml; \
    zhFileArg=mkdocs.zh.saas.yml; \
    if [ "$release_env" = "saas_production" ]; then \
        echo "SaaS Build ..."; \
        cp -r -f overrides-saas/* overrides/; \
    # 添加对应的测试环境的配置信息 \
    elif [ "$release_env" = "peprod" ]; then \
        echo "Peprod Build ...."; \
        cp -r -f overrides-saas-test/* overrides/; \
        enFileArg=mkdocs.en.saas.test.yml; \
        zhFileArg=mkdocs.zh.saas.test.yml; \
    elif [ "$release_env" = "rtm" ]; then \
        echo "RTM Build ..."; \
        cp -r -f overrides-deploy/* overrides/; \
        enFileArg=mkdocs.en.yml; \
        zhFileArg=mkdocs.zh.yml; \
    fi; \
    if [ "$release_env" != "rtm" ]; then \
        # 安装对应文档先关的插件的pypi \
        pip install -i https://mirrors.aliyun.com/pypi/simple beautifulsoup4==4.12.2; \
        pip install -i https://pmgmt.jiagouyun.com/repository/guance-pypi/simple mkdocs-plugins==1.0.0; \
        # 打包编译中英文的索引信息 \
        mkdocs build -f ${enFileArg}; \
        mkdocs build -f ${zhFileArg}; \
    else \
        # 如何是部署版打包，直接从 SaaS 的 OSS 目录中下载静态资源 \
        echo "download from OSS bucket..."; \
        OSS_UPLOAD_PATH="oss://${GUANCE_HELPS_OSS_BUCKET}"; \
        dpkgArch="$(dpkg --print-architecture)"; \
        echo "arch: ${dpkgArch}"; \

        case "${dpkgArch}" in \
            *arm64*) \
                echo "do arm64 arch"; \
                tools/ossutilarm64 cp ${OSS_UPLOAD_PATH} site/zh -r -f -e ${GUANCE_HELPS_OSS_ENDPOINT} -i ${GUANCE_HELPS_OSS_AK_ID} -k ${GUANCE_HELPS_OSS_AK_SECRET}; \
                ;; \
            *amd64*) \
                echo "do amd64 arch"; \
                tools/ossutil64 cp ${OSS_UPLOAD_PATH} site/zh -r -f -e ${GUANCE_HELPS_OSS_ENDPOINT} -i ${GUANCE_HELPS_OSS_AK_ID} -k ${GUANCE_HELPS_OSS_AK_SECRET}; \
                ;; \
            *) \
                echo "Unsupported architecture ${dpkgArch}"; \
                exit 1; \
                ;; \
        esac ; \

        mkdir site/en && mv site/zh/en/* site/en; \

        # 部署版本不需要 RUM 埋点 \
        echo "" > site/zh/assets/javascripts/rum-config.js; \
        cat tools/on-premises.css > site/zh/assets/stylesheets/on-premises.css; \
        cat tools/on-premises.js > site/zh/assets/javascripts/on-premises.js; \

        # 禁止任何爬虫爬取部署版的文档，防止干扰 SaaS 的文档中心 \
        echo "User-agent: *" > site/zh/Robots.txt; \
        echo "Disallow: /" >> site/zh/Robots.txt; \
        echo "User-agent: *" > site/en/Robots.txt; \
        echo "Disallow: /" >> site/en/Robots.txt; \
    fi;

RUN \
    if [ "$release_env" = "saas_production" ]; then \
        echo "upload to OSS bucket..."; \
        OSS_UPLOAD_PATH="oss://${GUANCE_HELPS_OSS_BUCKET}"; \
        CDN_REFRESH_PATH="docs.guance.com/"; \
        pip install -r tools/requirements.txt -i https://mirrors.aliyun.com/pypi/simple; \

        # 发布前清空对象存储中的文件 \
        tools/ossutil64 rm ${OSS_UPLOAD_PATH} -r -f -e ${GUANCE_HELPS_OSS_ENDPOINT} -i ${GUANCE_HELPS_OSS_AK_ID} -k ${GUANCE_HELPS_OSS_AK_SECRET}; \

        tools/ossutil64 cp site/zh ${OSS_UPLOAD_PATH} -r -f -e ${GUANCE_HELPS_OSS_ENDPOINT} -i ${GUANCE_HELPS_OSS_AK_ID} -k ${GUANCE_HELPS_OSS_AK_SECRET}; \
        tools/ossutil64 cp site/en ${OSS_UPLOAD_PATH}/en -r -f -e ${GUANCE_HELPS_OSS_ENDPOINT} -i ${GUANCE_HELPS_OSS_AK_ID} -k ${GUANCE_HELPS_OSS_AK_SECRET}; \
        tools/ossutil64 cp tools/rum-config.js ${OSS_UPLOAD_PATH}/assets/javascripts/rum-config.js -r -f -e ${GUANCE_HELPS_OSS_ENDPOINT} -i ${GUANCE_HELPS_OSS_AK_ID} -k ${GUANCE_HELPS_OSS_AK_SECRET}; \

        # SaaS 版本不需要做专为私有部署做的 hack 操作，只要一个空的 css 和 js 文件，防止前端 404 \
        echo "" > tools/on-premises.css; \
        echo "" > tools/on-premises.js; \
        tools/ossutil64 cp tools/on-premises.css ${OSS_UPLOAD_PATH}/assets/stylesheets/on-premises.css -r -f -e ${GUANCE_HELPS_OSS_ENDPOINT} -i ${GUANCE_HELPS_OSS_AK_ID} -k ${GUANCE_HELPS_OSS_AK_SECRET}; \
        tools/ossutil64 cp tools/on-premises.js ${OSS_UPLOAD_PATH}/assets/javascripts/on-premises.js -r -f -e ${GUANCE_HELPS_OSS_ENDPOINT} -i ${GUANCE_HELPS_OSS_AK_ID} -k ${GUANCE_HELPS_OSS_AK_SECRET}; \

        echo "refresh CDN ..." ; \
        python tools/cdn-refresh-tool.py Directory ${CDN_REFRESH_PATH} -i ${GUANCE_HELPS_CDN_AK_ID} -k ${GUANCE_HELPS_CDN_AK_SECRET}; \
    fi

# build static site
FROM registry.jiagouyun.com/basis/nginx:1.18.0

RUN mkdir /etc/nginx/ssl
RUN mkdir /dataflux-doc
RUN mkdir /dataflux-doc/en

WORKDIR /dataflux-doc

COPY --from=build /dataflux-doc/site/zh /dataflux-doc
COPY --from=build /dataflux-doc/site/en /dataflux-doc/en
