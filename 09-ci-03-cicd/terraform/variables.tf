###cloud vars
variable "vm_platform_id" {
  type        = string
  default     = "standard-v1"
}


variable "vm1_resources" {
  type = map(number)
  default = {
    cores = 2
    memory = 4
    core_fraction = 5
  }
}

variable "vm2_resources" {
  type = map(number)
  default = {
    cores = 2
    memory = 2
    core_fraction = 5
  }
}

variable "vm_metadata" {
  type = map(string)
  default = {
    serial-port-enable = "1"
  }
}

variable "linux_famaly" {
  type        = string
  default     = "centos-7"
}


variable "vm1" {
  type        = string
  default     = "vm1"
}

variable "vm2" {
  type        = string
  default     = "vm2"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "user_ssh_key" {
  sensitive = true
}

variable "token" {
  type        = string
}

variable "folder_id" {
  type        = string
}


