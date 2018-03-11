import yaml
from  jinja2  import Environment, FileSystemLoader, Template
import json
import sys

#user input
with open('user_input.yaml') as simple: 
    user_input_dict =  yaml.load(simple)


type(user_input_dict)

user_input_dict
# with open('user_input.yaml') as the_file: 
# # with open('user_input.yaml.example') as the_file:   
#        print (the_file.read())

ENV = Environment(loader=FileSystemLoader('./'))
ENV.add_extension('jinja2.ext.loopcontrols')


#this file is based on user_input.yaml
template = ENV.get_template("./network-config-DynamicOrg.j2")
f=open("./network-config-DynamicOrg.tmp.json", "w")
sys.stdout = f
print (template.render(simple=user_input_dict))
sys.stdout.flush()
f.close()
sys.stdout = sys.__stdout__



# convert json file to yaml 
# f = open('network-config-DynamicOrg.json', 'r')
# jsonData = json.load(f)
# f.close()

# ff = open('network-config-DynamicOrg.yaml', 'w+')
# yaml.dump(jsonData, ff, allow_unicode=False)
# f.close()



# generate all sh and config file based on network-config-DynamicOrg.tmp.json
with open("network-config-DynamicOrg.tmp.json") as simple:
    simple =  json.load(simple)
type(simple)
simple


template = ENV.get_template("certsUpdateChannel.j2")
f=open("certsUpdateChannel.sh", "w")
# print (template.render(simple=simple))
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



template = ENV.get_template("./channel/cryptogen.j2")
f=open("./channel/cryptogen.yaml", "w")
sys.stdout = f
print (template.render(simple=simple))
sys.stdout.flush()
f.close()
sys.stdout = sys.__stdout__



template = ENV.get_template("./channel/configtx.j2")
f=open("./channel/configtx.yaml", "w")
sys.stdout = f
print (template.render(simple=simple))
sys.stdout.flush()
f.close()
sys.stdout = sys.__stdout__



template = ENV.get_template("./runEverything.ubuntu.j2")
f=open("./runEverything.ubuntu.sh", "w")
sys.stdout = f
user_input_plus_network_config_dict = dict(simple.items() + user_input_dict.items())
print (template.render(simple=user_input_plus_network_config_dict))
sys.stdout.flush()
f.close()
sys.stdout = sys.__stdout__
