Function Get-SteamPaths {
    <#
.Synopsis

.DESCRIPTION

.EXAMPLE
    Get-SteamPaths
.NOTES
    #>

    [CmdletBinding()]
    Param (
        [string]$SteamRootPath = ((Get-ItemProperty -Path Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software\Valve\Steam\).SteamPath -replace "/", "\")
    )
    Begin {
        $SteamConfig = "$SteamRootPath\Config"
        $SteamControllerBase = "$SteamRootPath\controller_base"
        $SteamApps = "$SteamRootPath\SteamApps"
        $SteamAppsCommon = "$SteamRootPath\SteamApps\Common"
        $properties = [ordered]@{
            SteamRootPath       = $SteamRootPath
            SteamConfig         = $SteamConfig
            SteamControllerBase = $SteamControllerBase
            SteamAppsPath       = $SteamApps
            SteamAppsCommon     = $SteamAppsCommon
        }
    }
    Process {
        $SteamPaths = New-Object PSObject -Property $properties
        Write-Output $SteamPaths
    }
}