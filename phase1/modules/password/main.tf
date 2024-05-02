#creating password 
resource "random_password" "password" {
  length           = var.password_length
  special          = var.special
  override_special = var.override_special
}