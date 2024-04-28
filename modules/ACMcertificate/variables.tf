variable "common_name" {
}
variable "algorithm" {
  type    = string
  default = "RSA"
}
variable "rsa_bits" {
  type    = string
  default = 2048
}