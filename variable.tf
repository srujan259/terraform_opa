variable "project_name" {
  type        = string
  description = "Name of the project"
}

variable "environment" {
  type        = string
  description = "Environment (dev, staging, prod)"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "location" {
  type        = string
  description = "Azure region for resources"
  default     = "eastus2"
}

variable "account_tier" {
  type        = string
  description = "Storage Account Tier"
  default     = "Standard"
}

variable "replication_type" {
  type        = string
  description = "Storage Account Replication Type"
  default     = "GRS"
}

variable "allowed_ips" {
  type        = list(string)
  description = "List of allowed IP addresses"
  default     = []
}

variable "blob_soft_delete_retention" {
  type        = number
  description = "Number of days to retain deleted blobs"
  default     = 7
}

variable "container_soft_delete_retention" {
  type        = number
  description = "Number of days to retain deleted containers"
  default     = 7
}