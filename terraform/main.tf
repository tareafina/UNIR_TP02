##################################
#         Resource Groups        #
##################################
module rg_main {
    source = "./modules/rg"
    rg_name = "rg-main-${var.env}-${var.project_name}"
    location = var.location
    env = var.env
    project_name = var.project_name    
}

##################################
#             Network            #
##################################
module vnet_main {
    source = "./modules/vnet"
    location = var.location
    env = var.env
    project_name = var.project_name    
    rg_name = "${module.rg_main.rg_name}"
    net_name = "vnet-main-${var.env}-${var.project_name}"
}

module subnet_main {
    source = "./modules/subnet"
    subnet_name = "subnet-main-${var.env}-${var.project_name}"
    rg_name = "${module.rg_main.rg_name}"
    net_name = "${module.vnet_main.net_name}"
}

module ni_nfs {
    source = "./modules/network_interface"
    ni_name = "ni-nfs-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    ip_addr = "192.168.1.13"
    subnet_id = "${module.subnet_main.net_id}"
    pub_ip_addr_id = ""
}

module ni_master {
    source = "./modules/network_interface"
    ni_name = "ni-master-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    ip_addr = "192.168.1.10"
    subnet_id = "${module.subnet_main.net_id}"
    pub_ip_addr_id = ""
}

module ni_worker_1 {
    source = "./modules/network_interface"
    ni_name = "ni-worker-01-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    ip_addr = "192.168.1.11"
    subnet_id = "${module.subnet_main.net_id}"
    pub_ip_addr_id = ""
}

module ni_worker_2 {
    source = "./modules/network_interface"
    ni_name = "ni-worker-02-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    ip_addr = "192.168.1.12"
    subnet_id = "${module.subnet_main.net_id}"
    pub_ip_addr_id = ""
}

module ni_bastion {
    source = "./modules/network_interface"
    ni_name = "ni-bastion-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    ip_addr = "192.168.1.14"
    subnet_id = "${module.subnet_main.net_id}"
    pub_ip_addr_id = "${module.pub_ip_bastion.pub_ip_id}"
}

##################################
#       Load Balancer            #
##################################

module pub_ip_lb {
    source = "./modules/public_ip"
    pub_ip_name = "LoadBalancerPubIpAddress"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
}

module pub_ip_bastion {
    source = "./modules/public_ip"
    pub_ip_name = "BastionPubIpAddress"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
}

module lb {
    source = "./modules/lb"
    lb_name = "lb${var.env}${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    pub_ip_id = "${module.pub_ip_lb.pub_ip_id}"
}

module av_set {
    source = "./modules/av_set"
    av_name = "avset${var.env}${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
}

##################################
#             Storage            #
##################################
module st_nfs {
    source = "./modules/storage"
    disk_name = "data-nfs-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    env = var.env
    project_name = var.project_name    
}

module st_master {
    source = "./modules/storage"
    disk_name = "data-master-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    env = var.env
    project_name = var.project_name    
}

module st_worker_1 {
    source = "./modules/storage"
    disk_name = "data-worker-01-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    env = var.env
    project_name = var.project_name    
}

module st_worker_2 {
    source = "./modules/storage"
    disk_name = "data-worker-02-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    env = var.env
    project_name = var.project_name    
}

module st_bastion {
    source = "./modules/storage"
    disk_name = "data-bastion-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    env = var.env
    project_name = var.project_name    
}
##################################
#        Virtual Machines        #
##################################
module vm_nfs {
    source = "./modules/vm"
    vm_name = "vm-nfs-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    av_set_id = ""     
    ni_id = [ "${module.ni_nfs.ni_id}" ]
    vm_size = "Standard_DS1_v2"
    os_disk_name = "OSDiskNfs${var.env}${var.project_name}"
    data_disk_name = module.st_nfs.disk_name
    data_disk_id = module.st_nfs.disk_id
    vm_os_name = "k8s_nfs"
    vm_os_user = "${var.os_username}"
    env = var.env
    project_name = var.project_name
}

module vm_master {
    source = "./modules/vm"
    vm_name = "vm-nfs-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    av_set_id = ""     
    ni_id = [ "${module.ni_master.ni_id}" ]
    vm_size = "Standard_DS1_v2"
    os_disk_name = "OSDiskMaster${var.env}${var.project_name}"
    data_disk_name = "${module.st_master.disk_name}"
    data_disk_id = "${module.st_master.disk_id}"
    vm_os_name = "k8s_master"
    vm_os_user = "${var.os_username}"
    env = var.env
    project_name = var.project_name
}

module vm_worker_1 {
    source = "./modules/vm"
    vm_name = "vm-nfs-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    av_set_id = "${module.av_set.av_set_id}"    
    ni_id = [ "${module.ni_worker_1.ni_id}" ]
    vm_size = "Standard_DS1_v2"
    os_disk_name = "OSDiskWorker01${var.env}${var.project_name}"
    data_disk_name = "${module.st_worker_1.disk_name}"
    data_disk_id = "${module.st_worker_2.disk_id}"
    vm_os_name = "k8s_worker_01"
    vm_os_user = "${var.os_username}"
    env = var.env
    project_name = var.project_name
}

module vm_worker_2 {
    source = "./modules/vm"
    vm_name = "vm-nfs-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    av_set_id = "${module.av_set.av_set_id}"    
    ni_id = [ "${module.ni_worker_2.ni_id}" ]
    vm_size = "Standard_DS1_v2"
    os_disk_name = "OSDiskWorker02${var.env}${var.project_name}"
    data_disk_name = "${module.st_worker_2.disk_name}"
    data_disk_id = "${module.st_worker_2.disk_id}"
    vm_os_name = "k8s_worker_02"
    vm_os_user = "${var.os_username}"
    env = var.env
    project_name = var.project_name
}

module vm_bastion {
    source = "./modules/vm"
    vm_name = "vm-bastion-${var.env}-${var.project_name}"
    location = var.location
    rg_name = "${module.rg_main.rg_name}"
    ni_id = [ "${module.ni_bastion.ni_id}" ]
    av_set_id = ""    
    vm_size = "Standard_DS1_v2"
    os_disk_name = "OSDiskBastion${var.env}${var.project_name}"
    data_disk_name = "${module.st_bastion.disk_name}"
    data_disk_id = "${module.st_bastion.disk_id}"    
    vm_os_name = "bastion"
    vm_os_user = "${var.os_username}"
    env = var.env
    project_name = var.project_name
}

##################################
#         Configuration          #
##################################

module conf_master {
    source = "./modules/provision"
    bastion_host = "${module.pub_ip_bastion.pub_ip_id}"
    vm_os_user = "${var.os_username}"
    priv_ip = "${module.ni_master.private_ip_address}"
    env = var.env
}

module conf_nfs {
    source = "./modules/provision"
    bastion_host = "${module.pub_ip_bastion.pub_ip_id}"
    vm_os_user = "${var.os_username}"
    priv_ip = "${module.ni_nfs.private_ip_address}"
    env = var.env
}

module conf_worker1 {
    source = "./modules/provision"
    bastion_host = "${module.pub_ip_bastion.pub_ip_id}"
    vm_os_user = "${var.os_username}"
    priv_ip = "${module.ni_worker_1.private_ip_address}"
    env = var.env
}

module conf_worker2 {
    source = "./modules/provision"
    bastion_host = "${module.pub_ip_bastion.pub_ip_id}"
    vm_os_user = "${var.os_username}"
    priv_ip = "${module.ni_worker_2.private_ip_address}"
    env = var.env
}
