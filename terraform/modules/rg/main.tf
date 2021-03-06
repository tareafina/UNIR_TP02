resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.location}"

  tags = {
    "Environment" = "${var.env}"    
    "Project" = "${var.project_name}"
  }  
}