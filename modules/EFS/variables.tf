variable "creation_token" {
  #efs-token
}
variable "efs_name" {
}
variable "Environment" {
}
variable "efs_encryption" {
  default = true
}

variable "kms_description" {
  default = "kms key"
}

variable "efs_kms_key" {
  default = "slec-prod-efs-kms"
}