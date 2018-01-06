#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""weather.py

Shows current temperature and weather condition by parsing raw data from
the National Weather Service. Valid ICAO codes may be found here [1].

[1] https://en.wikipedia.org/wiki/List_of_airports_by_IATA_and_ICAO_code
"""

from re import findall, sub
from sys import argv

try:
    from urllib.error import HTTPError
    from urllib.request import urlopen
except ImportError:
    from urllib2 import HTTPError
    from urllib2 import urlopen


def fetch_source(icao_code):
    """Requests the raw weather information through NWS's site."""
    url = "http://tgftp.nws.noaa.gov/weather/current/{}.html"
    return urlopen(url.format(icao_code)).read().decode('utf-8')


def parse_info(icao_code):
    """Transforms the raw page source so it is human-readable."""
    table_rows = findall(r'<TD><FONT FACE="Arial,Helvetica">'
                         '  .+?\n </FONT></TD>', fetch_source(icao_code))
    clean_data = [sub(r'<[^>]*>', '', i).strip() for i in table_rows]

    return "The temperature is now {}, and the weather is {}.".format(
        findall(r'\((.*)\)', clean_data[1])[0], clean_data[0])


if __name__ == '__main__':
    try:
        print(parse_info(argv[1]))
    except (IndexError, HTTPError):
        print("Invalid ICAO code.")
