#!/usr/bin/env python

import re
import sys

from pprint import pprint

try:
    from urllib.request import urlopen
except ImportError:
    from urllib2 import urlopen

def fetch_source(tracking_code):
    url = "http://websro.correios.com.br/sro_bin/txect01$"+\
            ".QueryList?P_LINGUA=001&P_COD_UNI=%s" % tracking_code

    source = urlopen(url).read()
    return source.decode('latin-1')

def partition(list, indices):
    return [list[i:j] for i, j in 
                zip([0] + indices, indices + [None])]

tracking_code = sys.argv[1]
assert len(tracking_code) == 13 and type(tracking_code) == str 

source = fetch_source(tracking_code)

table_rows = re.findall(r'<td.+?</td>', source)
if table_rows:
    plain_text = [re.sub(r'<[^>]*>', '', a) for a in table_rows]

    date_markers = [plain_text.index(a) for a in plain_text
                        if re.search(r'(\d+/\d+/\d+)', a)]

    final_information = partition(plain_text, date_markers)
    pprint(final_information[1:][::-1])
else:
    print("Invalid tracking number.")
