# -*- coding: utf-8 -*-

import os
import sys
import argparse

import simplejson as json

from aliyun_sdk import AliyunClient

COLOR_MAP = {
    'grey'   : '\033[0;30m',
    'red'    : '\033[0;31m',
    'green'  : '\033[0;32m',
    'yellow' : '\033[0;33m',
    'blue'   : '\033[0;34m',
    'magenta': '\033[0;35m',
    'cyan'   : '\033[0;36m',
}
def colored(s, color=None):
    if not color:
        color = 'yellow'

    color = COLOR_MAP[color]

    return color + '{}\033[0m'.format(s)

PROJECT_ROOT = os.path.join(sys.path[0], '..')

def main(options):
    client = AliyunClient(access_key_id=options.get('ak_id'), access_key_secret=options.get('ak_secret'));

    api_res = client.cdn(Action='RefreshObjectCaches', ObjectType=options.get('object_type'), ObjectPath=options.get('object_path'))

    print(api_res)

def get_options_by_command_line():
    arg_parser = argparse.ArgumentParser(description='Aliyun CDN Refresh Tool')

    arg_parser.add_argument('object_type', metavar='<Object Type>')
    arg_parser.add_argument('object_path', metavar='<Object Path>')

    # 阿里云AK
    arg_parser.add_argument('-i', '--access-key-id', dest='ak_id',help='AccessKey ID')
    arg_parser.add_argument('-k', '--access-key-secret', dest='ak_secret',help='AccessKey Secret')

    args = vars(arg_parser.parse_args())
    args = dict(filter(lambda x: x[1] is not None, args.items()))

    return args

if __name__ == '__main__':
    options = get_options_by_command_line()

    main(options)

    print(colored('Done', 'green'))
