variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "three-tier-rg"
}

variable "location" {
  description = "The Azure location for the resources"
  default     = "West Europe"
}

variable "allowed_ip" {
  description = "The IP address allowed to access the frontend"
  default     = "202.131.151.41"
}

variable "frontend_subnet" {
  default = "frontend-sub"
}

variable "backend_subnet" {
  default = "backend-sub"
}

variable "database_subnet" {
  default = "database-sub"
}

variable "mysql_password" {
  description = "The password for the MySQL admin user."
  type        = string
  sensitive   = true
  default     = "YngoeB4GX0VhmsZ"
}