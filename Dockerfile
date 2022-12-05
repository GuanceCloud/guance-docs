ARG release_env
ARG GUANCE_HELPS_OSS_AK_ID
ARG GUANCE_HELPS_OSS_AK_SECRET
ARG GUANCE_HELPS_OSS_BUCKET
ARG GUANCE_HELPS_OSS_ENDPOINT

FROM registry.jiagouyun.com/basis/mkdocs:2.3 as build

ARG release_env
ARG GUANCE_HELPS_OSS_AK_ID
ARG GUANCE_HELPS_OSS_AK_SECRET
ARG GUANCE_HELPS_OSS_BUCKET
ARG GUANCE_HELPS_OSS_ENDPOINT

RUN mkdir /dataflux-doc
WORKDIR /dataflux-doc
COPY ./ /dataflux-doc

RUN \
    enFileArg=mkdocs.en.saas.yml; \
    zhFileArg=mkdocs.zh.saas.yml; \
    if [ $release_env = "saas_production" ]; then \
        echo "SaaS Build ..."; \
        cp -r -f overrides-saas/* overrides/; \
    elif [ $release_env = "rtm" ]; then \
        echo "RTM Build ..."; \
        cp -r -f overrides-deploy/* overrides/; \
        enFileArg=mkdocs.en.yml; \
        zhFileArg=mkdocs.zh.yml; \
    fi; \
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
