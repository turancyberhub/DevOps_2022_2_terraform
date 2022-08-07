variable "bucket_name" {
  type = string
  #default = "mybucket-12345-test"
}

variable "create" {
  type = string
}

variable "is_it_for_production" {
  type = string
}

variable "production_instance_type" {
  type = string
}

variable "non_production_instance_type" {
  type = string
}