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

Allows for easy creation and deletion of Samba Shares.

### Actions

- :add: - add a new samba share (default action)
- :delete: - delete an existing samba share

### Attribute Parameters

- share_name: name attribute, the name of the share to be created.
- path: The path the the folder you want to share.
- description: The description of the share.
- change_access: The list of comma separated users that have modify access.
- full_access: The list of comma separated users that will have full access.
- no_access: The list of command separated users that will have no access.
- read_access: The list of command separated users that will have read access.

### Examples
```
# stop and delete the default site
hps_samba_windows 'wwwroot' do
  full_access 'hps\hscbuildadmins'
  read_access 'hps\jvilledev'
  action :add
end
```

```
# create and start a new site that maps to
# the physical location C:\inetpub\wwwroot\testfu
iis_site 'my share' do
  path "C:\testing"
  read_access 'hps\jvilledev'
  description 'THIS IS MY SHARE!!!!'
  action :add
end
```

```
# do the same but map to testfu.opscode.com domain
iis_site 'my share' do
  action :delete
end
```

License and Author
==================

* Author:: Justin Schuhmann (<justin.schuhmann@e-hps.com>)

Copyright:: 2014 Heartland Payment Systems
