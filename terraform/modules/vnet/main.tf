resource "azurerm_virtual_network" "vnet" {
  name                = "${var.net_name}"
  address_space       = ["192.168.1.0/24"]
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"

  tags = {
    "Environment" = "${var.env}"    
    "Project" = "${var.project_name}"
  }  
}
