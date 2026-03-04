function Invoke-Use {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Candidate,
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Version
    )
    $CandidateDir = Join-Path $script:Config.SDKMAN_CANDIDATES_DIR $Candidate
    $VersionDir = Join-Path $CandidateDir $Version
    if (! (Test-Path $VersionDir -PathType Container)) {
        Write-Host ""
        Write-Host "Stop! Candidate version is not installed." -Fore Red
        Write-Host ""
        Write-Host "Tip: Run the following to install this version" -Fore Yellow
        Write-Host ""
        Write-Host "$ sdk install $Candidate $Version" -Fore Yellow
        return
    }
    $HomeEnvVar = "${Candidate}_HOME"
    [Environment]::SetEnvironmentVariable($HomeEnvVar, $VersionDir, "Process")
    $OldPath = $env:PATH
    $Pattern = [regex]::Escape(${CandidateDir}) + '\\[^\\]+'
    $NewPath = $OldPath -replace $Pattern, $VersionDir
    [Environment]::SetEnvironmentVariable("PATH", $NewPath, "Process")
    $CurrentDir = Join-Path $CandidateDir "current"
    if (! (Test-Path $CurrentDir)) {
        Write-Host "Setting ${Candidate} version ${Version} as default." -Fore Green
        New-Item -ItemType Junction -Path $CurrentDir -Target $VersionDir
    }
    Write-Host ""
    Write-Host "Using ${Candidate} version ${Version} in this shell." -Fore Green
}