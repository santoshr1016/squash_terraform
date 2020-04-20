variable "var_region_name" {
  default = "us-central"
}
variable "network_self_link" {}



resource "google_compute_subnetwork" "public_subnet" {
  name          =  format("%s","${var.var_company}-${var.var_env}-${var.var_region_name["${var.var_region_name}"]}-pub-net")
  ip_cidr_range = var.uc1_public_subnet
  network       = var.network_self_link
  region        = var.var_region_name
}



resource "google_compute_subnetwork" "private_subnet" {
  name          =  format("%s","${var.var_company}-${var.var_env}-${var.var_region_name["${var.var_region_name}"]}-pri-net")
  ip_cidr_range = var.uc1_private_subnet
  network      = var.network_self_link
  region        = var.var_region_name
}