function Invoke-Version {
    $module = Get-Module -Name "sdkman-ps"
    Write-Host "SDKMAN-PS $($module.Version)" -Fore Yellow
}