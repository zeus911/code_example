import yaml
from  jinja2  import Environment, FileSystemLoader, Template
import json
import sys

# convert json file to yaml 
f = open('network-config-DynamicOrg.json', 'r')
jsonData = json.load(f)
f.close()

ff = open('network-config-DynamicOrg.yaml', 'w+')
yaml.dump(jsonData, ff, allow_unicode=False)
f.close()

ENV = Environment(loader=FileSystemLoader('./'))
ENV.add_extension('jinja2.ext.loopcontrols')

with open("network-config-DynamicOrg.json") as simple:
    simple =  json.load(simple)
type(simple)
simple


template = ENV.get_template("certsUpdateChannel.j2")
f=open("certsUpdateChannel.sh", "w")
sys.stdout = f
print (template.render(simple=simple))
sys.stdout.flush()
f.close()


sys.stdout = sys.__stdout__


template = ENV.get_template("docker-compose.j2")
f=open("docker-compose.yaml", "w")
sys.stdout = f
print (template.render(simple=simple))
sys.stdout.flush()
f.close()
sys.stdout = sys.__stdout__