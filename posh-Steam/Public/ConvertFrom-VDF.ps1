Function ConvertFrom-VDF {
    <# 
.Synopsis 
    Parses a Valve Data file and converts it into a PS object.
.Description 
    Parses a Valve Data file and converts it into a PS object.
.Notes
    Inspiration drawn from  https://github.com/ChiefIntegrator/Steam-GetOnTop
#>
    [CmdletBinding()]
    param
    (   [Parameter(ValueFromPipeline)]
        [String]$VDFFileName = "libraryfolders.vdf",
        [ValidateScript( {
                if (!($_ | Test-Path)) {
                    throw 'File or folder does note exist'
                }
                if (!($_ | Test-Path -PathType Leaf)) {
                    throw "`$VDFContents must be a file path, not a folder path."
                }
                if (!($_ -notmatch "(.\acf\.vdf)")) {
                    throw "File type does not match one of the following extensions: acf, vdf"
                }
            })]
        [String]$FilePath = (Get-SteamPaths).SteamAppsPath + "\" + $VDFFileName
    )
    process {
        $FileContents = Get-Content -Path $FilePath
        [PSObject]$object = New-Object -TypeName PSObject
        $chain = [ordered]@{}
        [int]$depth = 0
        $parent = $object
        $element = New-Object -TypeName PSObject
		
        ForEach ($line in $FileContents) {
            $VDFElements = (Select-String -Pattern '(?<=")([^"\t\s]*)+(?=")' -InputObject $line -AllMatches).Matches
    
            if ($VDFElements.Count -eq 1) {
                Add-Member -InputObject $parent -MemberType NoteProperty -Name $VDFElements[0].Value -Value $element
            }
            elseif ($VDFElements.Count -eq 2) {
                # Create a new String hash
                Add-Member -InputObject $element -MemberType NoteProperty -Name $VDFElements[0].Value -Value $VDFElements[1].Value
            }
            elseif ($line -match "{") {
                $chain.Add($depth, $element)
                $depth++
                $parent = $chain.($depth - 1) # AKA $element
                
            }
            elseif ($line -match "}") {
                $depth--
                $parent = $chain.($depth - 1)
                $element = $parent
                $chain.Remove($depth)
            }
            else {
            }
        }
        Write-Output $object
    }
}