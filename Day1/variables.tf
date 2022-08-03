variable "ports" {
    type = list
    default = []
}

variable "alb_protocol" {
    type = string
}


variable "alb_internal" {
    type = bool
}

variable "profile" {
    type = string
    description = "this varibale is for profile usually it will be prod or dev"
 #   default = "dev"
    validation {
    condition     = length(var.profile) == 3
    error_message = "Must be a 3 character long profile name"
  }
}