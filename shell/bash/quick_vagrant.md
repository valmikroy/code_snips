Quickly create vagrant instance with following 

```
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.synced_folder '.', "/vagrant_home"
end
```
