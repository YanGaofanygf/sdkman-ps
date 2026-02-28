. (Join-Path $PSScriptRoot 'SdkMan-Version.ps1')
. (Join-Path $PSScriptRoot 'SdkMan-Install.ps1')
. (Join-Path $PSScriptRoot 'SdkMan-Use.ps1')

function Invoke-SdkMan {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$COMMAND,
        [Parameter(ValueFromRemainingArguments=$true)]
        [string[]]$QUALIFIER
    )
    switch ($COMMAND) {
        "install" {
            Install-Sdk @QUALIFIER
        }
        "use" {
            Use-Sdk @QUALIFIER
        }
        default {
            Write-Output "Unknown command: $COMMAND"
        }
    }
}

Set-Alias -Name sdk -Value Invoke-SdkMan