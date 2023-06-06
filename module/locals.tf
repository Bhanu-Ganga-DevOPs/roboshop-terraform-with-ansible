locals {
  name = var.component_name != "" ? "${var.component_name} - ${var.env}" : var.component_name
}