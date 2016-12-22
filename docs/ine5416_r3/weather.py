#!/usr/bin/env python
# -*- coding: utf-8 -*-

from re import findall, sub
from sys import argv

try:
    from urllib.request import urlopen
except ImportError:
    from urllib2 import urlopen

# find the list of codes here:
# http://www.airlineupdate.com/content_public/codes/airportcodes/airport_icaocodes/airport_icao.htm

if len(argv) == 2:
    icao_code = argv[1]
    assert len(icao_code) == 4 and type(icao_code) == str

    url = "http://tgftp.nws.noaa.gov/weather/current/{}.html".format(icao_code)
    request = urlopen(url)
    source = request.read().decode('utf-8')

    table_rows = findall(r'<TD><FONT FACE="Arial,Helvetica">'
                         '  .+?\n </FONT></TD>', source)[:2]
    clean_data = []
    for i in table_rows:
        clean_data.append(sub(r'<[^>]*>', '', i).strip())

    temp = findall(r'\((.*)\)', clean_data[1])[0]
    cond = clean_data[0]
    print("The temperature is now %s, and the weather is %s." % (temp, cond))
