
<#
# Define source site credentials
$srcUsername = "RBandla@flexera.com"
$srcPasswordText = ""


$srcPassword = ConvertTo-SecureString $srcPasswordText -AsPlainText -Force

$TargetConn = Connect-Site -Url  https://flexera.sharepoint.com/sites/Spot_EcoTest -Browser -Username $srcUsername -Password $srcPassword


Connect-Site -Url  https://flexera.sharepoint.com/sites/Spot_sharegate_test_teamsite -UseCredentialsFrom $TargetConn
^i$b$h5U0E#H6;yT54+a8%P07l(hVShL
#>

NestorW@m365x76832558.onmicrosoft.com,RBandla@flexera.com

https://m365x76832558.sharepoint.com/sites/benefits,https://flexera.sharepoint.com/sites/Spot_EcoTest


    <Mapping>
      <Source AccountName="allcompany@m365x76832558.onmicrosoft.com" DisplayName="allcompany@m365x76832558.onmicrosoft.com" PrincipalType="None" />
      <Destination AccountName="Spot_Sharegate_Test_TeamSite@FLEXERA.onmicrosoft.com" DisplayName="Spot_Sharegate_Test_TeamSite@FLEXERA.onmicrosoft.com" PrincipalType="SecurityGroup" />
    </Mapping>




$mappingsettings = Set-UserAndGroupMapping -Source "allcompany@m365x76832558.onmicrosoft.com" -Destination "Spot_Sharegate_Test_TeamSite@FLEXERA.onmicrosoft.com"
Export-UserAndGroupMapping -MappingSettings $mappingsettings -Path "C:\Users\RBandla\Documents\SG_MigrationScripts\cmdM365"


$srcSite = Connect-Site -Url "https://m365x76832558.sharepoint.com/sites/allcompany" -UseCredentialsFrom $SourceConn
$dstSite = Connect-Site -Url "https://flexera.sharepoint.com/sites/Spot_Sharegate_Test_TeamSite" -UseCredentialsFrom $TargetConn

$mp = Get-UserAndGroupMapping -SourceSite $srcSite -DestinationSite $dstSite
$mp.UserAndGroupMappings | Format-List >> "C:\Users\RBandla\Documents\SG_MigrationScripts\mp.txt"

    <Mapping>
      <Source AccountName="c:0t.c|tenant|8d35f930-8049-467e-ab93-d814ab451ae6" DisplayName="sg-Engineering" PrincipalType="SecurityGroup" />
      <Destination AccountName="c:0t.c|tenant|4c9e6a02-1475-4a10-b91f-a03c1f39abe6" DisplayName="ActivTrak Whitelist - Test" PrincipalType="SecurityGroup" />
    </Mapping>

    <Mapping>
      <Source AccountName="c:0t.c|tenant|8d35f930-8049-467e-ab93-d814ab451ae6" DisplayName="sg-Engineering" PrincipalType="SecurityGroup" />
      <Destination AccountName="c:0t.c|tenant|4c9e6a02-1475-4a10-b91f-a03c1f39abe6" DisplayName="ActivTrak Whitelist - Test" PrincipalType="SecurityGroup" />
    </Mapping>