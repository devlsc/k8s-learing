### THIS IS GARBAGE

* create modules and understand whats going on
* do I need to commit the .terraform
* manage state with at least a local postgres or something for better understanding


### Notes
* Install mkisofs `pacman -S cdrkit`

* [creating kvm setup for k8s](https://github.com/Pick1a1username/kubernetes-the-hard-way-on-kvm/blob/master/docs/02-compute-resources.md)
* [provisioning stuff](https://registry.terraform.io/providers/multani/libvirt/latest/docs/resources/network)

#### DHCP/DNS with dnsmasq

In `/etc/NetworkManager/conf.d/localdns.conf`
add
```
[main]
dns=dnsmasq
```
This tells the NetworkManager to use dnsmasq for localdns resolving.

In `/etc/NetworkManager/dnsmasq.d/libvirt_dnsmasq.conf`
```
server=/kubernetes/10.240.0.1
```
this will tell the dnsmasq which host should be redirected to the libvirt dnsmasq service


### State

Currently it's stored in a local postgres instance

`docker run -e POSTGRES_PASSWORD=postgres -p 5432:5432 -v $(pwd)/data:/var/lib/postgresql/data -d postgres`



### TODOS
- [ ] SEC-0001: remove sensitive data from state [read carefully](https://www.terraform.io/language/settings/backends/configuration#credentials-and-sensitive-data)
- [ ] LIBVIRT-0001: checkout if there is a better workaround, than hardcoded ip-address ranges.


### Useful commands

List all networks: `$ virsh net-list --all` </br>
Create a new network: `$ virsh net-define --file <FILE>` </br>
Start the network: `$ virsh net-start <NW-NAME>` </br>
Delete all spawned inactive vms `sudo virsh list --inactive --name | xargs -r -n 1 sudo virsh undefine` </br>



### Tags

* SEC: Security related topics
* LIBVIRT: virtualization related topics
