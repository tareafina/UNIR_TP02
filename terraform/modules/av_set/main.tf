resource "azurerm_availability_set" "av_set" {
 name                         = "${var.av_name}"
 location                     = "${var.location}"
 resource_group_name          = "${var.rg_name}"
 platform_fault_domain_count  = 2
 platform_update_domain_count = 2
 managed                      = true
}