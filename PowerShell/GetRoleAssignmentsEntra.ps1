# Entra ID built in roles
Get-AzureADMSRoleDefinition | Sort-Object DisplayName | Format-Table DisplayName,Description
Get-AzureADMSRoleDefinition | Measure-Object

# Permissions associated with a role
$role = Get-AzureADMSRoleDefinition -Filter "displayName eq 'User Administrator'"
$role.RolePermissions.AllowedResourceActions

# Which users have the role "Global Administrator"
$role = Get-AzureADMSRoleDefinition -Filter "displayName eq 'Global Administrator'"
$roleAssignments = Get-AzureADMSRoleAssignment -Filter "roleDefinitionId eq '$($role.Id)'"
$roleAssignments

# Translate PrincipalId --> User Display Name
$roleAssignments | ForEach-Object {
    try {$userDisplayName = Get-AzureADUser -ObjectId $_.PrincipalId | % DisplayName}
    catch {$userDisplayName = '<not a user>'}
    $roleDisplayName = Get-AzureADMSRoleDefinition -Id $_.RoleDefinitionId | % DisplayName
    "$roleDisplayName $userDisplayName"
}

