# Availability Zones in Azure
#
# Logical zones to physical zones mapping
# --------------------------------------
$subscriptionId = (Get-AzContext).Subscription.ID

# Azure CLI
az rest --method get --uri "/subscriptions/${subscriptionId}/locations?api-version=2022-12-01" --query "value[?name == 'westeurope'].{displayName: displayName, name: name, availabilityZoneMappings: availabilityZoneMappings}"

# Azure PowerShell
$response = Invoke-AzRestMethod -Method GET -Path "/subscriptions/$subscriptionId/locations?api-version=2022-12-01" 
($response.Content | ConvertFrom-Json).value | ?{$_.name -eq 'westeurope'} | Select-Object displayName, name, availabilityZoneMappings | ConvertTo-Json -Depth 10



# See   https://learn.microsoft.com/en-us/azure/reliability/availability-zones-overview?tabs=azure-cli