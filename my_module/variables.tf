variable "name" {
  type    = string
  default = ""
}

variable "path" {
  type    = string
  default = "/"
}

variable "permissions_boundary" {
  type    = string
  default = ""
}

variable "force_destroy" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map
}