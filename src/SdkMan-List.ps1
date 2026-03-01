function Invoke-List {
    param(
        [Parameter(Mandatory = $false, Position = 0)]
        [string]$candidate
    )
    if ($candidate) {
        $response = Invoke-WebRequest -Uri "$($script:Config.SDKMAN_CANDIDATES_API)/candidates/$candidate/$($script:Config.SDKMAN_PLATFORM)/versions/list" -UseBasicParsing
        Write-Host "$($response.Content)"
    } else {
        $response = Invoke-WebRequest -Uri "$($script:Config.SDKMAN_CANDIDATES_API)/candidates/list" -UseBasicParsing
        Write-Host "$($response.Content)"
    }
}