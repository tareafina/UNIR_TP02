resource "azurerm_lb" "lb" {
 name                = "${var.lb_name}"
 location            = "${var.location}"
 resource_group_name = "${var.rg_name}"

 frontend_ip_configuration {
   name                 = "pubIpAddress"
   public_ip_address_id = "${var.pub_ip_id}"
 }
}

resource "azurerm_lb_backend_address_pool" "lb_back" {
 resource_group_name = "${var.rg_name}"
 loadbalancer_id     = azurerm_lb.lb.id
 name                = "beAddressPool"
 depends_on = ["azurerm_lb.lb"]
}