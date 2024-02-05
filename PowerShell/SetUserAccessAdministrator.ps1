# Elevate access to manage all Azure subscriptions and management groups

# https://learn.microsoft.com/en-us/azure/role-based-access-control/elevate-access-global-admin

$User = 'Paul@az.training'
Get-AzRoleDefinition -Name 'User Access Administrator'
Get-AzRoleAssignment -RoleDefinitionName 'User Access Administrator' | Format-Table Scope,RoleDefinitionName,SignInName
New-AzRoleAssignment -RoleDefinitionName 'User Access Administrator' -SignInName $User -Scope '/'  
Remove-AzRoleAssignment -RoleDefinitionName 'User Access Administrator' -SignInName $User -Scope '/'