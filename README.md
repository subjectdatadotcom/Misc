[# Misc
](https://help.sharegate.com/en/articles/10236307-avoid-repeatedly-entering-your-credentials-with-the-browser-connection-method)

$batchWord = ([System.IO.Path]::GetFileNameWithoutExtension($path)) -split "_" | Select-Object -Last 1

Sharegate - M365 group sync / Graph connection ISSUE
https://help.sharegate.com/en/articles/10236716-cannot-connect-to-the-office-graph
https://help.sharegate.com/en/articles/10236689-external-sharing-setting-is-more-permissive

https://m365x76832558-my.sharepoint.com/personal/admin_m365x76832558_onmicrosoft_com
Connect-SPOService -Url https://m365x76832558-admin.sharepoint.com/
$emailId = "admin@M365x76832558.onmicrosoft.com"
$OneDriveLink = Get-SPOSite -IncludePersonalSite $true -Limit all -Filter "Url -like '-my.sharepoint.com/personal/'" | Where-Object { $_.Owner -eq $emailId } |Select-Object -ExpandProperty Url
