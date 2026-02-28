. (Join-Path $PSScriptRoot 'SdkMan-Main.ps1')

$home_dir = Join-Path $HOME ".sdkman"
$script:Config = @{
    SDKMAN_PLATFORM = "WINDOWSX64"
    SDKMAN_DIR = $home_dir
    SDKMAN_CANDIDATES_DIR = Join-Path $home_dir "candidates"
    SDKMAN_CANDIDATES_API = "https://api.sdkman.io/2"
    SDKMAN_BROKER_API = "https://broker.sdkman.io"
}

$javaHomeValue = [Environment]::GetEnvironmentVariable("JAVA_HOME", "User")
if (-not $javaHomeValue) {
    $javaHomeValue = Join-Path $script:Config.SDKMAN_CANDIDATES_DIR (Join-Path "java" "current")
    [Environment]::SetEnvironmentVariable("JAVA_HOME", $javaHomeValue, "User")
}
$pathValue =[Environment]::GetEnvironmentVariable("PATH", "User")
$binValue = Join-Path $javaHomeValue "bin"
if (-not $pathValue.Contains($binValue)) {
    [Environment]::SetEnvironmentVariable("PATH", "$pathValue;$binValue", "User")
}

Export-ModuleMember -Variable Config
Export-ModuleMember -Function Invoke-SdkMan -Alias sdk