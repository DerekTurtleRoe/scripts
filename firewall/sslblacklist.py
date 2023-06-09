# Derek "Turtle" Roe
# Licensed under the GNU GPLv3

import requests, csv, subprocess

# The source for the blocklists is the abuse.ch website, great resource!
response = requests.get("https://sslbl.abuse.ch/blacklist/sslipblacklist.csv").text

rule="netsh advfirewall firewall delete rule name='BadSSLIP'"
subprocess.run(["Powershell", "-Command", rule])

mycsv = csv.reader(filter(lambda x: not x.startwith("#"), response.splitlines()))
for row in mycsv:
	ip = row[1]
	if(ip)!=("dst_ip"):
		print("Added rule to block:",ip)
		rule="netsh advfirewall firewall add rule name='BadSSLIP' Dir=Out Action=Block RemoteIP="+ip
		subprocess.run(["Powershell", "-Command", rule])
		rule="netsh advfirewall firewall add rule name='BadSSLIP' Dir=In Action=Block RemoteIP="+ip
		subprocess.run(["Powershell", "-Command", rule])
