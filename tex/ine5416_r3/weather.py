#!/usr/bin/env python

import re
import sys

try:
    from urllib.request import urlopen
except ImportError:
    from urllib2 import urlopen

# find the list of codes here:
# http://www.airlineupdate.com/content_public/codes/airportcodes/airport_icaocodes/airport_icao.htm

icao_code = sys.argv[1]
assert len(icao_code) == 4 and type(icao_code) == str

url = "http://weather.noaa.gov/weather/current/%s.html" % icao_code
request = urlopen(url)
source = request.read().decode('utf-8')

table_rows = re.findall(r'<TD><FONT FACE="Arial,Helvetica">  .+?\n </FONT></TD>', source)[:2]
clean_data = []
for i in table_rows:
    clean_data.append(re.sub(r'<[^>]*>', '', i).strip())

temp = re.findall(r'\((.*)\)', clean_data[1])[0]
cond = clean_data[0]
print("The temperature is now %s, and the weather is %s." % (temp, cond))
