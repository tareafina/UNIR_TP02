resource "azurerm_network_interface" "ni" {
  name                = "${var.ni_name}"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"

  ip_configuration {
    name                          = "vnetconf"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Static"
    private_ip_address = "${var.ip_addr}"
    public_ip_address_id = "${var.pub_ip_addr_id}"
  }
}