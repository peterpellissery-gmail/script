# Config
$thumbprint = "20BDB4CEF549B262AF289855728F66EF5C9997E6"
$apiKey     = "iw2TNDZgvxeHTqYD4MpxxePlPMV5PWJW1gfE6QZRtWM="
$sppUrl     = "https://SPP11.IKEA.COM/service/a2a/v4/Credentials?type=Password"
#$sppUrl     = "https://10.59.225.154/service/a2a/v4/Credentials?type=Password"
#$sppUrl     = "https://a2apam.ikea.com/service/a2a/v4/Credentials?type=Password"
#$sppUrl     = "https://10.79.133.217/service/a2a/v4/Credentials?type=Password"


try {
    # Load cert
    $cert = Get-Item "Cert:\Currentuser\My\$thumbprint" -ErrorAction Stop
    
    # Call SPP
    $password = Invoke-RestMethod `
        -Uri $sppUrl `
        -Method GET `
        -Headers @{ "Authorization" = "A2A $apiKey" } `
        -Certificate $cert `
        -ErrorAction Stop

    Write-Host "Success — password retrieved"
    return $password

} catch [System.Net.WebException] {
    Write-Error "Network/TLS error: $_"
} catch {
    Write-Error "Failed: $_"
}