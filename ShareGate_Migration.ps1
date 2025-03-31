# Import ShareGate PowerShell Module
Import-Module Sharegate

$MyDir = "C:\Users\rajab\Downloads\Mayflower\PnP\"
# Define paths
$csvFile = $MyDir + "migration.csv"  # Path to CSV file
$sgumFile = $MyDir + "usermappings.sgum"  # Path to SGUM user mapping file
$logFile = $MyDir + "migration_log.txt"  # Log file for tracking migrations

# User input for Insane Mode or Normal Mode
$useInsaneMode = Read-Host "Do you want to use Insane Mode? (yes/no)"
$insaneMode = $false
if ($useInsaneMode -eq "yes") {
    $insaneMode = $true
}

# User input for Delta Migration
$performDelta = Read-Host "Do you want to perform a Delta Migration? (yes/no)"
$copySettings = New-CopySettings
if ($performDelta -eq "yes") {
    $copySettings = New-CopySettings -OnContentItemExists IncrementalUpdate
}

# User input for Pre-check
$runPreCheck = Read-Host "Do you want to run a Pre-check before migration? (yes/no)"
$preCheck = $false
if ($runPreCheck -eq "yes") {
    $preCheck = $true
}

# Import user mappings
$mappingSettings = Import-UserAndGroupMapping -Path $sgumFile

# Read migration CSV
$sites = Import-Csv -Path $csvFile -Delimiter "," 

# Loop through each site in CSV
foreach ($site in $sites) {
    $sourceSiteURL = $site.SourceSiteURL
    $targetSiteURL = $site.TargetSiteURL
    $listNames = $site.ListName  # Can be empty or contain list names separated by "|"

    Write-Host "Starting migration for $sourceSiteURL -> $targetSiteURL" -ForegroundColor Green
    Add-Content -Path $logFile -Value "Starting migration for $sourceSiteURL -> $targetSiteURL"

    # Connect to source and target sites
    $srcSite = Connect-Site -Url $sourceSiteURL
    $dstSite = Connect-Site -Url $targetSiteURL

    if (-not $srcSite -or -not $dstSite) {
        Write-Host "Error connecting to sites: $sourceSiteURL or $targetSiteURL" -ForegroundColor Red
        Add-Content -Path $logFile -Value "Error connecting to sites: $sourceSiteURL or $targetSiteURL"
        continue
    }
 
    # If specific lists are provided, only migrate those lists
    if ($listNames -ne "") {
        $listsToMigrate = $listNames -split "\|"  # Split list names if multiple lists are provided

        foreach ($list in $listsToMigrate) {
            Write-Host "Migrating list: $list from $sourceSiteURL to $targetSiteURL"
            Add-Content -Path $logFile -Value "Migrating list: $list from $sourceSiteURL to $targetSiteURL"

            # Get Source & Target List
            $srcList = Get-List -Name $list -Site $srcSite
            $dstList = Get-List -Name $list -Site $dstSite

            if ($preCheck) {
                # Perform a Pre-check
                Copy-Content -SourceList $srcList -DestinationList $dstList -MappingSettings $mappingSettings -CopySettings $copySettings -WhatIf
            } else {
                # Perform Actual Content Migration
                Copy-Content -SourceList $srcList -DestinationList $dstList -MappingSettings $mappingSettings -CopySettings $copySettings
            }
        }
    } 
    else {
        # If no list is specified, perform full site migration
        Write-Host "Performing full site migration from $sourceSiteURL to $targetSiteURL"
        Add-Content -Path $logFile -Value "Performing full site migration from $sourceSiteURL to $targetSiteURL"

        if ($preCheck) {
            # Pre-check mode (WhatIf)
            Copy-Site -SourceSite $srcSite -DestinationSite $dstSite -MappingSettings $mappingSettings -CopySettings $copySettings -WhatIf
        } 
        else {
            # Perform Full Site Migration with Insane Mode or Normal Mode
            if ($insaneMode) {
                Copy-Site -SourceSite $srcSite -DestinationSite $dstSite -MappingSettings $mappingSettings -CopySettings $copySettings -InsaneMode
            } 
            else {
                Copy-Site -SourceSite $srcSite -DestinationSite $dstSite -MappingSettings $mappingSettings -CopySettings $copySettings
            }
        }
    }

    Write-Host "Migration completed for $sourceSiteURL -> $targetSiteURL" -ForegroundColor Cyan
    Add-Content -Path $logFile -Value "Migration completed for $sourceSiteURL -> $targetSiteURL"
}

Write-Host "Migration process completed! Logs saved to: $logFile" -ForegroundColor Green
