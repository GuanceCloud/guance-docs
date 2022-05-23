FROM python:3.7.7 as build

RUN mkdir /dataflux-doc
WORKDIR /dataflux-doc

RUN pip install --upgrade pip -i https://pypi.douban.com/simple


RUN pip install -i https://mirrors.aliyun.com/pypi/simple/ mkdocs-material
RUN pip install -i https://mirrors.aliyun.com/pypi/simple/ mkdocs-awesome-pages-plugin
RUN pip install -i https://mirrors.aliyun.com/pypi/simple/ mkdocs-section-index
RUN pip install -i https://mirrors.aliyun.com/pypi/simple/ jieba

COPY ./ /dataflux-doc

RUN mkdocs build

FROM nginx:1.18.0

RUN mkdir /etc/nginx/ssl
RUN mkdir /dataflux-doc
WORKDIR /dataflux-doc

COPY --from=build /dataflux-doc/site /dataflux-doc