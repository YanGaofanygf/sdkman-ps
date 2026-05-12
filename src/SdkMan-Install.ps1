function Install-Sdk {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Candidate,
        
        [Parameter(Mandatory = $true, Position = 1)]
        [string]$Version
    )
    $base_name = "$Candidate-$Version"
    $tmp_dir = Join-Path $script:Config.SDKMAN_DIR "tmp"
    $binary_input = Join-Path $tmp_dir "$base_name.bin"
    $zip_output = Join-Path $tmp_dir "${base_name}.zip"
    $sdk_dir = Join-Path $script:Config.SDKMAN_CANDIDATES_DIR (Join-Path $Candidate $Version)
    $out_dir = Join-Path $tmp_dir "out"
    
    # Create tmp directory if it doesn't exist
    if (-not (Test-Path -Path $tmp_dir)) {
        New-Item -ItemType Directory -Path $tmp_dir -Force | Out-Null
    }
    
    $url = "$($script:Config.SDKMAN_BROKER_API)/download/$Candidate/$Version/$($script:Config.SDKMAN_PLATFORM)"
    Write-Output "Downloading $Candidate $Version to $binary_input..."
    Write-Output "URL: $url"
    Invoke-WebRequest -Uri $url -OutFile $binary_input -UseBasicParsing -Verbose
    Write-Output "Download completed successfully."
    Move-Item -Path $binary_input -Destination $zip_output -Force
    if (Test-Path -Path $out_dir) {
        Remove-Item -Path (Join-Path $tmp_dir "out") -Recurse -Force
    }
    Expand-Archive -Path $zip_output -DestinationPath $out_dir -Force
    if (-not (Test-Path -Path $sdk_dir)) {
        New-Item -ItemType Directory -Path $sdk_dir -Force | Out-Null
    }
    Move-Item -Path (Join-Path $out_dir "*")  -Destination $sdk_dir -Force
}