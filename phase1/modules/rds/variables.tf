variable "allocated_storage" {
  default = "80"
}
variable "db_name" {
  default = "slecuatMySQLrds"
}
variable "rds_az" {
  default = "ap-southeast-1a"
}
variable "engine" {
  default = "mysql"
}
variable "engine_version" {
}
variable "instance_class" {
  default = "db.m6g.large"
}
variable "identifier" {
}
variable "vpc_security_group_ids" {
}
variable "username" {
}
variable "multi_az" {
  default = false
}
variable "password" {
}
variable "skip_final_snapshot" {
}
variable "Environment" {
}
variable "db_subnet_group_name" {
}
variable "subnet_ids" {
}