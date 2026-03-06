function Initialize-SdkMan {
    $sdkmanDir = Join-Path $HOME ".sdkman"
    $candidatesDir = Join-Path $sdkmanDir "candidates"

    if (-not (Test-Path $candidatesDir)) {
        return
    }

    $candidates = Get-ChildItem -Path $candidatesDir -Directory

    foreach ($candidate in $candidates) {
        $currentDir = Join-Path $candidate.FullName "current"

        if (Test-Path $currentDir -PathType Container) {
            $homeVar = "$($candidate.Name)_HOME"
            [Environment]::SetEnvironmentVariable($homeVar, $currentDir, "Process")

            $binDir = Join-Path $currentDir "bin"

            if (Test-Path $binDir -PathType Container) {
                $envPath = [Environment]::GetEnvironmentVariable("PATH", "Process")
                if ($envPath -notlike "*$binDir*") {
                    [Environment]::SetEnvironmentVariable("PATH", "$envPath;$binDir", "Process")
                }
            }
        }
    }
}

Initialize-SdkMan
