terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.8.0"
    }
  }
  #backend "azurerm" {}
  backend "local" {}
}

provider "azurerm" {
  features {}
  subscription_id = "0c614c7a-ac19-478e-afef-4bdefcb5f09c"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-${var.environment}-rg"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_storage_account" "storage" {
  name                            = "${var.project_name}${var.environment}sa"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  account_tier                    = var.account_tier
  account_replication_type        = var.replication_type
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = true

  network_rules {
    default_action = "Deny"
    ip_rules       = var.allowed_ips
    bypass         = ["AzureServices"]
  }

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = var.blob_soft_delete_retention
    }

    container_delete_retention_policy {
      days = var.container_soft_delete_retention
    }
  }

  tags = local.common_tags
}