Description
===========
Installs Services with SC.exe

Requirements
============

Platform
--------
* Windows Server 2012
* Windows Server 2012R2

Cookbooks
---------
* windows

Resource/Provider
=================

windows
---------

Allows for easy creation and deletion of Services.

### Actions

- :add: - add a new service (default action)

### Attribute Parameters

- service_name: name attribute, the name of the service to be created.
- path: The path the the folder you want to service.
- description: The description of the service.

### Examples
```
# stop and delete the default site
sc_windows 'service_name_here' do
  description "some description here"
  path "C:\the path\you\want\here.exe"
  action :add
end
```

License and Author
==================

* Author:: Justin Schuhmann (<justin.schuhmann@gmail.com>)