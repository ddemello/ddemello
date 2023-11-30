$MIGuid = (Get-AzUserAssignedIdentity -Name "MyManagedIdentity").Id;
$MI = Get-AzureADServicePrincipal -ObjectId $MIGuid;

$MDEAppId = 'include your managed identity guid';

$PermissionName = 'Machine.Scan';
$MDEServicePrincipal = Get-AzureADServicePrincipal -Filter "appId eq '$MDEAppId'";
$AppRole = $MDEServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains 'Application'};
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId `
-ResourceId $MDEServicePrincipal.ObjectId -Id $AppRole.Id;

$PermissionName = 'Machine.Read.All';
$AppRole = $MDEServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains 'Application'};
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId `
-ResourceId $MDEServicePrincipal.ObjectId -Id $AppRole.Id;

$PermissionName = 'Machine.ReadWrite.All';
$AppRole = $MDEServicePrincipal.AppRoles | Where-Object {$_.Value -eq $PermissionName -and $_.AllowedMemberTypes -contains 'Application'};
New-AzureAdServiceAppRoleAssignment -ObjectId $MI.ObjectId -PrincipalId $MI.ObjectId `
-ResourceId $MDEServicePrincipal.ObjectId -Id $AppRole.Id;
