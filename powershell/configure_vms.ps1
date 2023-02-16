#!/usr/bin/pwsh

## YOUR VARIABLES GO HERE ##
$vcenter_server = "portal.vc.opentlc.com"
$vcenter_username = "VCENTER USER FROM RHDP"
$vcenter_password = "VCENTER PASSWORD FROM RHDP"
$guid = "GUID FROM RHDP"
## END OF YOUR VARIABLES ##

# Establish connection to vCenter
Connect-VIServer -Server $vcenter_server -User $vcenter_username -Password $vcenter_password

# Clone coreos VM to create bootstrap VM
$name = bootstrap.$guid.dynamic.opentlc.com
New-VM -VM coreos -Name $name -Location sandbox-$guid -Datastore WorkloadDatastore -ResourcePool Cluster-1

# Modify newly cloned VM - processors, memory, and advanced parameters
Set-VM -VM $name -NumCPU 4 -MemoryGB 16 -confirm:$false

$ignition = cat ~/ocpinstall/install/merge-bootstrap.ign | base64 -w0
$segment = hostname -I | cut -d. -f3
$afterburn = "ip=192.168.$segment.99::192.168.$segment.1:255.255.255.0:::none nameserver=192.168.$segment.10"

New-AdvancedSetting -Entity $name -Name "guestinfo.ignition.config.data" -Value $ignition -confirm:$false
New-AdvancedSetting -Entity $name -Name "guestinfo.afterburn.initrd.network-kargs" -Value $afterburn -confirm:$false

# Clone coreos VM to create master0 VM
$name = master0.$guid.dynamic.opentlc.com
New-VM -VM coreos -Name $name -Location sandbox-$guid -Datastore WorkloadDatastore -ResourcePool Cluster-1

# Modify newly cloned VM - processors, memory, and advanced parameters
Set-VM -VM $name -NumCPU 4 -MemoryGB 16 -confirm:$false

$ignition = cat ~/ocpinstall/install/master.ign | base64 -w0
$segment = hostname -I | cut -d. -f3
$afterburn = "ip=192.168.$segment.100::192.168.$segment.1:255.255.255.0:::none nameserver=192.168.$segment.10"

New-AdvancedSetting -Entity $name -Name "guestinfo.ignition.config.data" -Value $ignition -confirm:$false
New-AdvancedSetting -Entity $name -Name "guestinfo.afterburn.initrd.network-kargs" -Value $afterburn -confirm:$false

# Clone coreos VM to create master1 VM
$name = master1.$guid.dynamic.opentlc.com
New-VM -VM coreos -Name $name -Location sandbox-$guid -Datastore WorkloadDatastore -ResourcePool Cluster-1

# Modify newly cloned VM - processors, memory, and advanced parameters
Set-VM -VM $name -NumCPU 4 -MemoryGB 16 -confirm:$false

$ignition = cat ~/ocpinstall/install/master.ign | base64 -w0
$segment = hostname -I | cut -d. -f3
$afterburn = "ip=192.168.$segment.101::192.168.$segment.1:255.255.255.0:::none nameserver=192.168.$segment.10"

New-AdvancedSetting -Entity $name -Name "guestinfo.ignition.config.data" -Value $ignition -confirm:$false
New-AdvancedSetting -Entity $name -Name "guestinfo.afterburn.initrd.network-kargs" -Value $afterburn -confirm:$false

# Clone coreos VM to create master2 VM
$name = master2.$guid.dynamic.opentlc.com
New-VM -VM coreos -Name $name -Location sandbox-$guid -Datastore WorkloadDatastore -ResourcePool Cluster-1

# Modify newly cloned VM - processors, memory, and advanced parameters
Set-VM -VM $name -NumCPU 4 -MemoryGB 16 -confirm:$false

$ignition = cat ~/ocpinstall/install/master.ign | base64 -w0
$segment = hostname -I | cut -d. -f3
$afterburn = "ip=192.168.$segment.102::192.168.$segment.1:255.255.255.0:::none nameserver=192.168.$segment.10"

New-AdvancedSetting -Entity $name -Name "guestinfo.ignition.config.data" -Value $ignition -confirm:$false
New-AdvancedSetting -Entity $name -Name "guestinfo.afterburn.initrd.network-kargs" -Value $afterburn -confirm:$false

# Clone coreos VM to create worker0 VM
$name = worker0.$guid.dynamic.opentlc.com
New-VM -VM coreos -Name $name -Location sandbox-$guid -Datastore WorkloadDatastore -ResourcePool Cluster-1

# Modify newly cloned VM - processors, memory, and advanced parameters
Set-VM -VM $name -NumCPU 2 -MemoryGB 8 -confirm:$false

$ignition = cat ~/ocpinstall/install/worker.ign | base64 -w0
$segment = hostname -I | cut -d. -f3
$afterburn = "ip=192.168.$segment.200::192.168.$segment.1:255.255.255.0:::none nameserver=192.168.$segment.10"

New-AdvancedSetting -Entity $name -Name "guestinfo.ignition.config.data" -Value $ignition -confirm:$false
New-AdvancedSetting -Entity $name -Name "guestinfo.afterburn.initrd.network-kargs" -Value $afterburn -confirm:$false

# Clone coreos VM to create worker1 VM
$name = worker1.$guid.dynamic.opentlc.com
New-VM -VM coreos -Name $name -Location sandbox-$guid -Datastore WorkloadDatastore -ResourcePool Cluster-1

# Modify newly cloned VM - processors, memory, and advanced parameters
Set-VM -VM $name -NumCPU 2 -MemoryGB 8 -confirm:$false

$ignition = cat ~/ocpinstall/install/worker.ign | base64 -w0
$segment = hostname -I | cut -d. -f3
$afterburn = "ip=192.168.$segment.201::192.168.$segment.1:255.255.255.0:::none nameserver=192.168.$segment.10"

New-AdvancedSetting -Entity $name -Name "guestinfo.ignition.config.data" -Value $ignition -confirm:$false
New-AdvancedSetting -Entity $name -Name "guestinfo.afterburn.initrd.network-kargs" -Value $afterburn -confirm:$false

