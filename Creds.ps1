
<#
# Define source site credentials
$srcUsername = "RBandla@test.com"
$srcPasswordText = ""


$srcPassword = ConvertTo-SecureString $srcPasswordText -AsPlainText -Force

$TargetConn = Connect-Site -Url  https://test.sharepoint.com/sites/Spot_EcoTest -Browser -Username $srcUsername -Password $srcPassword


Connect-Site -Url  https://test.sharepoint.com/sites/Spot_sharegate_test_teamsite -UseCredentialsFrom $TargetConn
^i$b$h5U0E#H6;yT54+a8%P07l(hVShL
#>

NestorW@m365x76832558.onmicrosoft.com,RBandla@test.com

https://m365x76832558.sharepoint.com/sites/benefits,https://test.sharepoint.com/sites/Spot_EcoTest


    <Mapping>
      <Source AccountName="allcompany@m365x76832558.onmicrosoft.com" DisplayName="allcompany@m365x76832558.onmicrosoft.com" PrincipalType="None" />
      <Destination AccountName="Spot_Sharegate_Test_TeamSite@test.onmicrosoft.com" DisplayName="Spot_Sharegate_Test_TeamSite@test.onmicrosoft.com" PrincipalType="SecurityGroup" />
    </Mapping>




$mappingsettings = Set-UserAndGroupMapping -Source "allcompany@m365x76832558.onmicrosoft.com" -Destination "Spot_Sharegate_Test_TeamSite@test.onmicrosoft.com"
Export-UserAndGroupMapping -MappingSettings $mappingsettings -Path "C:\Users\RBandla\Documents\SG_MigrationScripts\cmdM365"


$srcSite = Connect-Site -Url "https://m365x76832558.sharepoint.com/sites/allcompany" -UseCredentialsFrom $SourceConn
$dstSite = Connect-Site -Url "https://test.sharepoint.com/sites/Spot_Sharegate_Test_TeamSite" -UseCredentialsFrom $TargetConn

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
<#
# Path to input CSV
$csvPath = "C:\Path\To\Your\MappingFile.csv"

# Path to output SGUM file
$outputPath = "C:\Path\To\Output\UserAndGroupMappings.sgum"

# Load the CSV
$rows = Import-Csv -Path $csvPath

# Create XML Document
$xml = New-Object System.Xml.XmlDocument

# Create declaration
$decl = $xml.CreateXmlDeclaration("1.0", $null, $null)
$xml.AppendChild($decl) | Out-Null

# Create root node
$root = $xml.CreateElement("UserAndGroupMappings")
$xml.AppendChild($root) | Out-Null

# Add namespaces
$root.SetAttribute("xmlns:xsd", "http://www.w3.org/2001/XMLSchema")
$root.SetAttribute("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance")

# Create <Mappings> node
$mappingsNode = $xml.CreateElement("Mappings")
$root.AppendChild($mappingsNode) | Out-Null

# Loop through each row and build <Mapping> blocks
foreach ($row in $rows) {
    $mapping = $xml.CreateElement("Mapping")

    # Source node
    $src = $xml.CreateElement("Source")
    $src.SetAttribute("AccountName", $row.SourceAccountName)
    $src.SetAttribute("DisplayName", $row.SourceDisplayName)
    $src.SetAttribute("PrincipalType", $row.PrincipalType)
    $mapping.AppendChild($src) | Out-Null

    # Destination node
    $dst = $xml.CreateElement("Destination")
    $dst.SetAttribute("AccountName", $row.DestinationAccountName)
    $dst.SetAttribute("DisplayName", $row.DestinationDisplayName)
    $dst.SetAttribute("PrincipalType", $row.PrincipalType)
    $mapping.AppendChild($dst) | Out-Null

    # Add <Mapping> to <Mappings>
    $mappingsNode.AppendChild($mapping) | Out-Null
}

# Save to file
$xml.Save($outputPath)

Write-Host "file created successfully at: $outputPath" -ForegroundColor Green

#>
