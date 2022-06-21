FROM registry.jiagouyun.com/basis/mkdocs:2.0 as build

RUN mkdir /dataflux-doc
WORKDIR /dataflux-doc
COPY ./ /dataflux-doc

RUN mkdocs build

# build static site
FROM nginx:1.18.0

RUN mkdir /etc/nginx/ssl
RUN mkdir /dataflux-doc
WORKDIR /dataflux-doc

COPY --from=build /dataflux-doc/site /dataflux-doc
