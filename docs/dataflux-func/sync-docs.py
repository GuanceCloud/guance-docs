# -*- coding: utf-8 -*-
import os
import sys
import argparse
import json
import re
import shutil
from urllib.parse import urljoin

import yaml
import requests

def colored(s, color=None):
    if not color:
        color = 'yellow'

    COLOR_MAP = {
        'grey'   : '\033[0;30m',
        'red'    : '\033[0;31m',
        'green'  : '\033[0;32m',
        'yellow' : '\033[0;33m',
        'blue'   : '\033[0;34m',
        'magenta': '\033[0;35m',
        'cyan'   : '\033[0;36m',
    }
    color = COLOR_MAP.get(color) or COLOR_MAP['yellow']

    return color + '{}\033[0m'.format(s)

def clear_docs(doc_dir):
    for file in os.listdir(path=doc_dir):
        if not file.endswith('.md') or file == 'index.md':
            continue

        folder = file[0:-3]

        os.remove(path=os.path.join(doc_dir, file))
        shutil.rmtree(path=os.path.join(doc_dir, folder), ignore_errors=True)

def load_doc_list(doc_dir):
    index_path = os.path.join(doc_dir, '.pages')
    index = None
    with open(index_path, 'r') as _f:
        index = yaml.safe_load(_f.read()) or {}

    doc_list = []
    def fetch_doc_list(nav):
        if not nav:
            return

        for x in nav:
            if isinstance(x, dict):
                x = list(x.values())[0]

            if isinstance(x, str):
                if x.startswith('http://') or x.startswith('https://'):
                    continue
                else:
                    doc_list.append(x)

            elif isinstance(x, list):
                fetch_doc_list(x)

    fetch_doc_list(index.get('nav'))
    doc_list = list(set(doc_list))

    return doc_list

def download_docs(doc_list, doc_dir, base_url):
    if not base_url.endswith('/'):
        base_url += '/'

    for doc_file in doc_list:
        doc_path = os.path.normpath(os.path.join(doc_dir, doc_file))
        doc_url  = urljoin(base_url, doc_file)

        # 下载文档
        md_lines = requests.get(doc_url).text.splitlines()

        # 提取并转换图片路径
        images = []
        for i, line in enumerate(md_lines):
            m = re.match('^\!\[(.*)\]\((.*)\)$', line.strip())
            if not m:
                continue

            img = os.path.normpath(os.path.join(doc_file, '..', m[2])) # xxx/yyy.png
            images.append(img)
            md_lines[i] = f'![{m[1]}]({img})'

        with open(doc_path, 'w') as _f:
            _f.write('\n'.join(md_lines))

        if images:
            for img in images:
                img_path = os.path.join(doc_dir, img)
                img_url  = urljoin(base_url, img)

                # 确保目录
                os.makedirs(os.path.dirname(img_path), exist_ok=True)

                # 下载图片
                _bin = requests.get(img_url).content
                with open(img_path, 'wb') as _f:
                    _f.write(_bin)

def main(options):
    doc_dir  = options.get('doc_dir')
    base_url = options.get('base_url')

    # 删除旧文件
    clear_docs(doc_dir)

    # 根据索引加载文档目录
    doc_list = load_doc_list(doc_dir)

    print('下载文档：\n' + '\n'.join(list(doc_list)))

    # 下载文档
    download_docs(doc_list, doc_dir, base_url)

def get_options_by_command_line():
    arg_parser = argparse.ArgumentParser(description='Doc Download Tool')

    arg_parser.add_argument('--doc-dir',  default='.',   dest='doc_dir', help='Doc Dir')
    arg_parser.add_argument('--base-url', required=True, dest='base_url',  help='Download Base URL')

    args = vars(arg_parser.parse_args())
    args = dict(filter(lambda x: x[1] is not None, args.items()))

    for k, v in args.items():
        if not v:
            raise Exception(f'Argument `{k}` not specified.')

    return args

if __name__ == '__main__':
    options = get_options_by_command_line()

    main(options)

    print(colored('Done', 'green'))