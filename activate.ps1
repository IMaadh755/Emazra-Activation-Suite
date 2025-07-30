# List of allowed MAC addresses - add your authorized MACs here (format: uppercase, with dashes)
$allowedMACs = @(
    "C0:B6:F9:89:A5:44"
)

# Get the real, physical, active MAC address
$mac = (Get-CimInstance Win32_NetworkAdapterConfiguration |
        Where-Object { $_.MACAddress -and $_.IPEnabled -eq $true -and $_.Description -notmatch "Hyper-V|Virtual|VMware|Loopback" } |
        Select-Object -First 1 -ExpandProperty MACAddress).ToUpper()

if ($mac -in $allowedMACs) {
    Write-Host "✅ Authorized device with MAC: $mac"
    
    # Your Windows product key here (replace with your actual key)
    $productKey = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"

    # Install product key
    slmgr /ipk $productKey

    # Activate Windows online
    slmgr /ato

    Write-Host "✅ Activation process triggered."
} else {
    Write-Host "❌ Unauthorized device. MAC address $mac is not in the allowed list."
    exit 1
}
