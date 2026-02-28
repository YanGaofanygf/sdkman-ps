function Use-Sdk {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Candidate,
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Version
    )
    $candidateDir = Join-Path $script:Config.SDKMAN_CANDIDATES_DIR $Candidate
    $versionDir = Join-Path $candidateDir $Version
    $currentDir = Join-Path $candidateDir "current"
    if (Test-Path $currentDir) {
        Remove-Item $currentDir -Force
    }
    New-Item -ItemType Junction -Path $currentDir -Target $versionDir
}