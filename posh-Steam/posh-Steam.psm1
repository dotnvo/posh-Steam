Get-ChildItem (Join-Path -Path $PSScriptRoot '*.ps1') -Recurse |
ForEach-Object {
    Write-Verbose ("Importing sub-module {0}." -f $_.FullName)
    . $_.FullName | Out-Null
} 
New-Alias -Name "ConvertFrom-ACF" -Value "ConvertFrom-VDF" -Description "ConvertFrom-VDF -> ConvertFrom-ACF" 
Set-Alias -Name "ConvertFrom-ACF" 
Export-ModuleMember -Function '*' -Cmdlet '*' -Alias '*' -Variable '*'
