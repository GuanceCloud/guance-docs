ARG release_env
ARG GUANCE_HELPS_OSS_AK_ID
ARG GUANCE_HELPS_OSS_AK_SECRET
ARG GUANCE_HELPS_OSS_BUCKET
ARG GUANCE_HELPS_OSS_ENDPOINT
# 配置文档索引搜索的ES实例信息
ARG ES_VAR_DOC_SEARCH_TEST
ARG ES_VAR_DOC_SEARCH_PROD

FROM registry.jiagouyun.com/basis/mkdocs:2.3 as build

ARG release_env
ARG GUANCE_HELPS_OSS_AK_ID
ARG GUANCE_HELPS_OSS_AK_SECRET
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
    if [ $release_env = "saas_production" ]; then \
        echo "SaaS Build ..."; \
        cp -r -f overrides-saas/* overrides/; \
    # 添加对应的测试环境的配置信息
    elif [ $release_env = "peprod" ]; then \
        echo "Peprod Build ...."; \
        cp -r -f overrides-saas-test/* overrides/; \
        enFileArg=mkdocs.en.saas.test.yml; \
        zhFileArg=mkdocs.zh.saas.test.yml; \
    elif [ $release_env = "rtm" ]; then \
        echo "RTM Build ..."; \
        cp -r -f overrides-deploy/* overrides/; \
        enFileArg=mkdocs.en.yml; \
        zhFileArg=mkdocs.zh.yml; \
    fi; \
    if [ $release_env != "rtm" ]; then \
        # 安装对应文档先关的插件的pypi
        pip install -i https://mirrors.aliyun.com/pypi/simple/ mkdocs==1.4.2 beautifulsoup4==4.11.2 requests==2.28.2; \
        pip install -i https://pmgmt.jiagouyun.com/repository/guance-pypi/simple mkdocs-plugins==0.0.9; \
    fi; \
    # 打包编译中英文的索引信息
    mkdocs build -f ${enFileArg}; \
    mkdocs build -f ${zhFileArg}

RUN \
    if [ $release_env = "saas_production" ]; then \
        echo "upload to OSS bucket..."; \
        OSS_UPLOAD_PATH="oss://${GUANCE_HELPS_OSS_BUCKET}"; \
        CDN_REFRESH_PATH="docs.guance.com/"; \
        pip install -r tools/requirements.txt -i https://mirrors.aliyun.com/pypi/simple; \
        tools/ossutil64 cp site/zh ${OSS_UPLOAD_PATH} -r -f -e ${GUANCE_HELPS_OSS_ENDPOINT} -i ${GUANCE_HELPS_OSS_AK_ID} -k ${GUANCE_HELPS_OSS_AK_SECRET}; \
        tools/ossutil64 cp site/en ${OSS_UPLOAD_PATH}/en -r -f -e ${GUANCE_HELPS_OSS_ENDPOINT} -i ${GUANCE_HELPS_OSS_AK_ID} -k ${GUANCE_HELPS_OSS_AK_SECRET}; \
        tools/ossutil64 cp tools/rum-config.js ${OSS_UPLOAD_PATH}/assets/javascripts/rum-config.js -r -f -e ${GUANCE_HELPS_OSS_ENDPOINT} -i ${GUANCE_HELPS_OSS_AK_ID} -k ${GUANCE_HELPS_OSS_AK_SECRET}; \
        echo "refresh CDN ..." ; \
        python tools/cdn-refresh-tool.py Directory ${CDN_REFRESH_PATH} -i ${GUANCE_HELPS_OSS_AK_ID} -k ${GUANCE_HELPS_OSS_AK_SECRET}; \
    fi

# build static site
FROM nginx:1.18.0

RUN mkdir /etc/nginx/ssl
RUN mkdir /dataflux-doc
RUN mkdir /dataflux-doc/en

WORKDIR /dataflux-doc

COPY --from=build /dataflux-doc/site/zh /dataflux-doc
COPY --from=build /dataflux-doc/site/en /dataflux-doc/en
