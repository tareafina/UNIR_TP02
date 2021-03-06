#General Variables
variable "location" {}
variable "project_name" {}
variable "env" {}

#Module Variables
variable "vm_name" {}
variable "rg_name" {}
variable "ni_id" {
    type = "list"
}
variable "vm_size" {}
variable "os_disk_name" {}
variable "data_disk_name" {}
variable "data_disk_id" {}
variable "vm_os_name" {}
variable "vm_os_user" {}
variable "av_set_id" {}
