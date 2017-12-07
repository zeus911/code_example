#!/opt/local/bin/python
import json

a_dict = {'new_key': 'new_value'}
print "abc"
with open('/opt/centos-lx-brand-image-builder/test-lx-centos-7.2-20161021.json') as f:
    data = json.load(f)

data.update(a_dict)

with open('/opt/centos-lx-brand-image-builder/test-lx-centos-7.2-20161021.json', 'w') as f:
    json.dump(data, f)
