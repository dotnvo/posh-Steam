Function Get-SteamApps {
    <#
.Synopsis
    
.DESCRIPTION

.EXAMPLE
    Get-SteamApps 
.NOTES
    #>

    [CmdletBinding()]
    Param (
        [string]$SteamAppsPath = (Get-SteamPaths).SteamAppsCommon
    )
    Process {
        $Apps = Get-ChildItem -Path $SteamAppsPath | Select-Object -ExpandProperty Name
        Write-Output $Apps
    }
}