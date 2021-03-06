output "out_bastion_pub_ip" {
    value = module.pub_ip_bastion.ip_address
}

output "out_lb_pub_ip" {
    value = module.pub_ip_lb.ip_address
}

output "out_bastion_pub_fqdn" {
    value = module.pub_ip_bastion.fqdn
}

output "out_lb_pub_fqdn" {
    value = module.pub_ip_lb.fqdn
}
