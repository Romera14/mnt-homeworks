###cloud vars

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
}

variable "vm_web_famaly" {
  type        = string
  default     = "centos-7"
}
variable "vm_web_name" {
  type        = string
  default     = "web"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vm_web_resources" {
  type = map(number)
  default = {
    cores = 2
    memory = 1
    core_fraction = 5
  }
}

variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}