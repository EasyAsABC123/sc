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

- :create - creates a new service (default action)
- :delete - deletes a service
- :stop - stops a service
- :start - starts a service
- :recycle - stops and then starts a service

### Attribute Parameters

- service_name: name attribute, the name of the service to be created.
- path: The path the the folder you want to service.
- description: The description of the service.
- start_arguments: The arguments you want passed in when starting the service

### Examples
```ruby
# creates the service "service_name_here"
sc_windows 'service_name_here' do
  description "some description here"
  path "C:\the path\you\want\here.exe"
  action :create
end
```

```ruby
# deletes the service "service_name_here"
sc_windows 'service_name_here' do
  action :delete
end
```

```ruby
# stops the service "service_name_here"
sc_windows 'service_name_here' do
  action :stop
end
```

```ruby
# starts the service "service_name_here"
sc_windows 'service_name_here' do
  action :start
end
```

```ruby
# recycles the service "service_name_here"
sc_windows 'service_name_here' do
  action :recycle
end
```

License and Author
==================

* Author:: Justin Schuhmann (<justin.schuhmann@gmail.com>)