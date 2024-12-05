package terraform.analysis

# Default decision to deny all changes
default allow = false

# Deny if nested items are allowed to be public
deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "azurerm_storage_account"
  resource.change.after.allow_nested_items_to_be_public == true
  msg := "Public access for nested items is not allowed."
}

# Deny if the location is not 'eastus'
deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "azurerm_storage_account"
  resource.change.after.location != "eastus"
  msg := sprintf("Storage account must be in 'eastus', but is in %s.", [resource.change.after.location])
}

# Allow only if there are no deny messages
allow {
  count(deny) == 0
}
