resource "azurerm_public_ip" "pub_ip" {
 name                         = "${var.pub_ip_name}"
 location                     = "${var.location}"
 resource_group_name          = "${var.rg_name}"
 allocation_method            = "Static"
}