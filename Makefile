# We ASSUME end-user uses
# # VMware on a Windows platform
# # Virtualbox on a Linux/OSX platform

ifeq ($(OS),Windows_NT)
    vm-provider := vmware
else
    vm-provider := vbox
endif

default: all

all: kitchen

nginx64-vbox.box: nginx64.json scripts/provision.sh http/preseed.cfg
	packer validate nginx64.json
	packer build -force -only=nginx64-vbox nginx64.json
	vagrant box add ./nginx64-vbox.box  --name nginx64

nginx64-vmware.box: nginx64.json scripts/provision.sh http/preseed.cfg
	packer validate nginx64.json
	packer build -force -only=nginx64-vmware nginx64.json
	vagrant box add ./nginx64-vbox.box  --name nginx64

kitchen-vbox: nginx64-vbox.box
	bundle exec kitchen test vbox

kitchen-vmware: nginx64-vmware.box
	bundle exec kitchen test vmware

kitchen: kitchen-$(vm-provider)

.PHONY: clean
clean:
	-vagrant box remove -f nginx64 --provider virtualbox
	-vagrant box remove -f nginx64 --provider vmware_desktop
	-rm -fr output-*/ *.box