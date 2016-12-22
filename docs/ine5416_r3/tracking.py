#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pprint import pprint
from re import findall, search, sub
from sys import argv

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
    return findall(r'<td.+?</td>', fetch_source(tracking_code))


def parse_info(source):
    info = [sub(r'<[^>]*>', '', line) for line in source]
    markers = [info.index(line) for line in info
               if search(r'(\d+/\d+/\d+)', line)]

    return partition(info, markers)[1:][::-1] or 'Invalid tracking number.'


if len(argv) == 2:
    tracking_code = argv[1]
    assert len(tracking_code) == 13 and type(tracking_code) == str

    pprint(parse_info(raw_info(tracking_code)))
