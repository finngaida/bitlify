#!/usr/bin/python
import urllib2
import urllib
import sys
import json

accessToken = "your-access-token"
url = "https://api-ssl.bitly.com/v3/shorten?access_token=" + accessToken

if (len(sys.argv) > 1):
	url = url + "&longUrl=" + urllib.quote_plus(sys.argv[1])

data = urllib2.urlopen(url)
str = data.read()

jsonStr = json.loads(str)

print jsonStr["data"]["url"]
