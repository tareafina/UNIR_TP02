resource "azurerm_subnet" "subnet" {
  name                 = "${var.subnet_name}"
  resource_group_name  = "${var.rg_name}"
  virtual_network_name = "${var.net_name}"
  address_prefixes       = ["192.168.1.0/24"]
}