# AZ-104 Lab 2a - Magic Trick
# ----------------------------

# Custom Role existiert
$CustomRoleName = "Support Request Contributor (Custom37651926)"
Get-AzRoleDefinition -Name $CustomRoleName

# User existiert
$UserPrincipalName = "az104-02-aaduser-37651926@LODSPRODMSLEARNMCA.onmicrosoft.com"
Get-AzADUser -UserPrincipalName $UserPrincipalName

# Management Group existiert
$MgName = "az104-02-mg37651926"
$Mg = Get-AzManagementGroup -GroupName $MgName
$MgScope = $Mg.Id

# Subscription existiert
$Subscription = Get-AzSubscription
$SubscriptionScope = "/subscriptions/$($Subscription.Id)"

# Hinweis:
# Bei 'Get-AzRoleAssignment' immer den Scope mit angeben, sonst wird als Scope die Subscription angenommen,
# siehe https://learn.microsoft.com/en-us/powershell/module/az.resources/get-azroleassignment


# Vor dem Magic Trick:
#     Custom Role --> Management Group
#                     Subscription hat keine Rollenzuweisung 
Get-AzRoleAssignment -RoleDefinitionName $CustomRoleName -Scope $MgScope           | Format-Table SignInName,Scope,RoleDefinitionName
Get-AzRoleAssignment -RoleDefinitionName $CustomRoleName -Scope $SubscriptionScope | Format-Table SignInName,Scope,RoleDefinitionName

# Nach dem Magic Trick:
#     Custom Role --> Management Group
#     Custom Role --> Subscription 
Get-AzRoleAssignment -RoleDefinitionName $CustomRoleName -Scope $MgScope           | Format-Table SignInName,Scope,RoleDefinitionName
Get-AzRoleAssignment -RoleDefinitionName $CustomRoleName -Scope $SubscriptionScope | Format-Table SignInName,Scope,RoleDefinitionName
