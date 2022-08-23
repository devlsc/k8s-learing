### THIS IS GARBAGE

* create modules and understand whats going on
* do I need to commit the .terraform
* manage state with at least a local postgres or something for better understanding


### Notes
* Install mkisofs `pacman -S cdrkit`

* [creating kvm setup for k8s](https://github.com/Pick1a1username/kubernetes-the-hard-way-on-kvm/blob/master/docs/02-compute-resources.md)
* [provisioning stuff](https://registry.terraform.io/providers/multani/libvirt/latest/docs/resources/network)


### TODOS
* remove sensitive data from state [read carefully](https://www.terraform.io/language/settings/backends/configuration#credentials-and-sensitive-data)
* local dns resolving for vms
### Useful commands

List all networks: `$ virsh net-list --all` </br>
Create a new network: `$ virsh net-define --file <FILE>` </br>
Start the network: `$ virsh net-start <NW-NAME>` </br>
Delete all spawned inactive vms `sudo virsh list --inactive --name | xargs -r -n 1 sudo virsh undefine` </br>

