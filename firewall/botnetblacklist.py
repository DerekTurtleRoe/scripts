# Derek "Turtle" Roe
# Licensed under the GNU GPLv3

import requests, csv, subprocess

# The source for the blocklists is the abuse.ch website, great resource!
response = requests.get("https://feodotracker.abuse.ch/downloads/ipblocklist.csv").text

rule="netsh advfirewall firewall delete rule name='BotnetIP'"
subprocess.run(["Powershell", "-Command", rule])

mycsv = csv.reader(filter(lambda x: not x.startwith("#"), response.splitlines()))
for row in mycsv:
	ip = row[1]
	if(ip)!=("dst_ip"):
		print("Added rule to block:",ip)
		rule="netsh advfirewall firewall add rule name='BotnetIP' Dir=Out Action=Block RemoteIP="+ip
		subprocess.run(["Powershell", "-Command", rule])
		rule="netsh advfirewall firewall add rule name='BotnetIP' Dir=In Action=Block RemoteIP="+ip
		subprocess.run(["Powershell", "-Command", rule])
