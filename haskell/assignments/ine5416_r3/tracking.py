#!/usr/bin/env python

import re
import sys

from pprint import pprint

try:
    from urllib.request import urlopen
except ImportError:
    from urllib2 import urlopen


def fetch_source(tracking_code):
    url = "http://websro.correios.com.br/sro_bin/txect01$" + \
          ".QueryList?P_LINGUA=001&P_COD_UNI=%s" % tracking_code

    return urlopen(url).read().decode('latin-1')


def partition(list, indices):
    return [list[i:j] for i, j in
            zip([0] + indices, indices + [None])]


def raw_info(tracking_code):
    return re.findall(r'<td.+?</td>', fetch_source(tracking_code))


def parse_info(source):
    info = [re.sub(r'<[^>]*>', '', line) for line in source]
    markers = [info.index(line) for line in info
               if re.search(r'(\d+/\d+/\d+)', line)]

    return partition(info, markers)[1:][::-1] or 'Invalid tracking number.'

tracking_code = sys.argv[1]
assert len(tracking_code) == 13 and type(tracking_code) == str

pprint(parse_info(raw_info(tracking_code)))
