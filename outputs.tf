output "storage_account_id" {
  value       = azurerm_storage_account.storage.id
  description = "Storage Account Resource ID"
}

output "storage_account_name" {
  value       = azurerm_storage_account.storage.name
  description = "Storage Account Name"
}

output "primary_blob_endpoint" {
  value       = azurerm_storage_account.storage.primary_blob_endpoint
  description = "Primary Blob Service Endpoint"
}

output "primary_access_key" {
  value       = azurerm_storage_account.storage.primary_access_key
  description = "Primary Access Key"
  sensitive   = true
}