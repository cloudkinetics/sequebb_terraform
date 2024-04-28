variable "cloud_trail_name" {
}
variable "bucket_name" {
  type = string
}
variable "include_global_service_events" {
  default = true
}
variable "cloudtrail_policy_name" {
  default = "cloud_trail_bucket_policy"
}

variable "s3_key_prefix" {
  default = "prefix"
}


variable "force_destroy" {
  default = true
}
variable "cloud_trail_multiregion" {
  default = true
}
