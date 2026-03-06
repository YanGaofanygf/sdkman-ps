$scriptPath = Join-Path $PSScriptRoot 'src'
. (Join-Path $scriptPath 'SdkMan-Main.ps1')

$profileLine = '. ' + (Join-Path $scriptPath 'SdkMan-Init.ps1')

if (-not (Test-Path $PROFILE.CurrentUserCurrentHost)) {
    New-Item -ItemType File -Path $PROFILE.CurrentUserCurrentHost -Force
}

$profileContent = Get-Content $PROFILE -Raw
if ($null -eq $profileContent) {
    $profileContent = ""
}

if ($profileContent -notlike "*$profileLine*") {
    Add-Content -Path $PROFILE -Value $profileLine
}

$home_dir = Join-Path $HOME ".sdkman"
$script:Config = @{
    SDKMAN_PLATFORM = "WINDOWSX64"
    SDKMAN_DIR = $home_dir
    SDKMAN_CANDIDATES_DIR = Join-Path $home_dir "candidates"
    SDKMAN_CANDIDATES_API = "https://api.sdkman.io/2"
    SDKMAN_BROKER_API = "https://broker.sdkman.io"
}

Export-ModuleMember -Variable Config
Export-ModuleMember -Function Invoke-SdkMan -Alias sdk