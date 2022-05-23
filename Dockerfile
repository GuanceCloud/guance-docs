FROM python:3.7.7 as build

RUN mkdir /dataflux-doc
WORKDIR /dataflux-doc

RUN pip install mkdocs-materia
RUN pip install mkdocs-awesome-pages-plugin
RUN pip install mkdocs-section-index
RUN pip install jieba

COPY ./ /dataflux-doc

RUN mkdocs build

FROM nginx:1.18.0

RUN mkdir /etc/nginx/ssl
RUN mkdir /dataflux-doc
WORKDIR /dataflux-doc

COPY --from=build /dataflux-doc /dataflux-doc