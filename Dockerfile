ARG release_env

FROM registry.jiagouyun.com/basis/mkdocs:2.0 as build

ARG release_env

RUN mkdir /dataflux-doc
WORKDIR /dataflux-doc
COPY ./ /dataflux-doc

RUN \
    if [ "$release_env" == "saas_production" ];then \
        echo "SaaS Build ..." \
        cp -r overrides-saas/ overrides/ \
    elif [ "$release_env" == "rtm" ];then \
        echo "RTM Build ..." \
        cp -r overrides-deploy/ overrides/ \
    fi

RUN mkdocs build

# build static site
FROM nginx:1.18.0

RUN mkdir /etc/nginx/ssl
RUN mkdir /dataflux-doc
WORKDIR /dataflux-doc

COPY --from=build /dataflux-doc/site /dataflux-doc
