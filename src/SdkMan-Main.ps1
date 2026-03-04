. (Join-Path $PSScriptRoot 'SdkMan-List.ps1')
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
        "l" {
            $COMMAND = "list"
        }
        "ls" {
            $COMMAND = "list"
        }
        "v" {
            $COMMAND = "version"
        }
        "u" {
            $COMMAND = "use"
        }
        "i" {
            $COMMAND = "install"
        }
        "rm" {
            $COMMAND = "uninstall"
        }
        "c" {
            $COMMAND = "current"
        }
        "ug" {
            $COMMAND = "upgrade"
        }
        "d" {
            $COMMAND = "default"
        }
        "h" {
            $COMMAND = "home"
        }
        "e" {
            $COMMAND = "env"
        }
    }
    switch ($COMMAND) {
        "list" {
            Invoke-List @QUALIFIER
        }
        "version" {
            Invoke-Version @QUALIFIER
        }
        "use" {
            Invoke-Use @QUALIFIER
        }
        "install" {
            Install-Sdk @QUALIFIER
        }
        default {
            Write-Output "Unknown command: $COMMAND"
        }
    }
}

Set-Alias -Name sdk -Value Invoke-SdkMan