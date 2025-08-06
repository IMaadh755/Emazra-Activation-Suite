<#
    Emazra Activator Suite - Professional Windows Activation Tool
    Version 2.0.0
    Copyright © 2023 Emazra Technologies. All rights reserved.
    App Developed by IMaadh
#>

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# Initialize Firebase
$firebaseConfig = @{
    apiKey = "AIzaSyAIkxPBr-NRgpT2PjsoyOoR5gSUxwWTAVQ"
    authDomain = "emazra-activator-suit.firebaseapp.com"
    projectId = "emazra-activator-suit"
    storageBucket = "emazra-activator-suit.appspot.com"
    messagingSenderId = "881246610119"
    appId = "1:881246610119:web:04ad30ccf5c13b2b66d4e2"
    measurementId = "G-J846E7FTNC"
}

# Function to get Firebase Auth Token (simplified version)
function Get-FirebaseToken {
    # In a real implementation, you would use OAuth2 flow to get a token
    # For simplicity, we'll use the API key directly (not recommended for production)
    return $firebaseConfig.apiKey
}

# Function to get data from Firestore
function Get-FirestoreData {
    param (
        [string]$collection,
        [string]$document = $null
    )
    
    try {
        $token = Get-FirebaseToken
        $firestoreUrl = "https://firestore.googleapis.com/v1/projects/$($firebaseConfig.projectId)/databases/(default)/documents/$collection"
        if ($document) {
            $firestoreUrl += "/$document"
        }
        
        $headers = @{
            "Authorization" = "Bearer $token"
            "Content-Type" = "application/json"
        }
        
        $response = Invoke-RestMethod -Uri $firestoreUrl -Method Get -Headers $headers
        return $response
    }
    catch {
        Write-Host "Error accessing Firestore: $_"
        return $null
    }
}

# Get product key from Firestore
$productKeyResponse = Get-FirestoreData -collection "productKeys" -document "defaultKey"
if ($productKeyResponse -and $productKeyResponse.fields) {
    $productKey = $productKeyResponse.fields.key.stringValue
} else {
    $productKey = "R3YVV-2N6QX-XJBX4-78WQR-8B49M" # Fallback key
}

# Get allowed MAC addresses from Firestore
$allowedMACs = @()
$macsResponse = Get-FirestoreData -collection "devices"
if ($macsResponse -and $macsResponse.documents) {
    foreach ($doc in $macsResponse.documents) {
        if ($doc.fields.status.stringValue -eq "active") {
            $allowedMACs += $doc.fields.macAddress.stringValue
        }
    }
} else {
    # Fallback MAC addresses if Firestore is not accessible
    $allowedMACs = @(
        "C0-B6-F9-89-A5-44",
        "D8-3B-BF-D9-93-2E",
        "48-22-54-80-52-F9"
    )
}

# Main Form
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Text = "Emazra Activator Suite Powered By IMaadh"
$mainForm.Size = New-Object System.Drawing.Size(900, 600)
$mainForm.StartPosition = "CenterScreen"
$mainForm.BackColor = "#2c3e50"
$mainForm.FormBorderStyle = "FixedSingle"
$mainForm.MaximizeBox = $false
$mainForm.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon((Get-Command powershell).Path)

# Fonts
$titleFont = New-Object System.Drawing.Font("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)
$subtitleFont = New-Object System.Drawing.Font("Segoe UI", 12)
$buttonFont = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
$normalFont = New-Object System.Drawing.Font("Segoe UI", 10)

# Colors
$primaryColor = [System.Drawing.Color]::FromArgb(52, 152, 219)
$secondaryColor = [System.Drawing.Color]::FromArgb(44, 62, 80)
$textColor = [System.Drawing.Color]::FromArgb(236, 240, 241)
$successColor = [System.Drawing.Color]::FromArgb(46, 204, 113)
$errorColor = [System.Drawing.Color]::FromArgb(231, 76, 60)

# Header Panel
$headerPanel = New-Object System.Windows.Forms.Panel
$headerPanel.Size = New-Object System.Drawing.Size(880, 80)
$headerPanel.Location = New-Object System.Drawing.Point(10, 10)
$headerPanel.BackColor = $primaryColor

# Title Label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Text = "Emazra Activator Suite Powered By IMaadh"
$titleLabel.Font = $titleFont
$titleLabel.ForeColor = [System.Drawing.Color]::White
$titleLabel.AutoSize = $true
$titleLabel.Location = New-Object System.Drawing.Point(20, 20)

# Navigation Panel
$navPanel = New-Object System.Windows.Forms.Panel
$navPanel.Size = New-Object System.Drawing.Size(880, 50)
$navPanel.Location = New-Object System.Drawing.Point(10, 100)
$navPanel.BackColor = $secondaryColor

# Navigation Buttons
$homeBtn = New-Object System.Windows.Forms.Button
$homeBtn.Text = "Home"
$homeBtn.Font = $buttonFont
$homeBtn.Size = New-Object System.Drawing.Size(150, 40)
$homeBtn.Location = New-Object System.Drawing.Point(10, 5)
$homeBtn.BackColor = $primaryColor
$homeBtn.ForeColor = [System.Drawing.Color]::White
$homeBtn.FlatStyle = "Flat"
$homeBtn.FlatAppearance.BorderSize = 0

$activateBtn = New-Object System.Windows.Forms.Button
$activateBtn.Text = "Activate Windows"
$activateBtn.Font = $buttonFont
$activateBtn.Size = New-Object System.Drawing.Size(150, 40)
$activateBtn.Location = New-Object System.Drawing.Point(170, 5)
$activateBtn.BackColor = $primaryColor
$activateBtn.ForeColor = [System.Drawing.Color]::White
$activateBtn.FlatStyle = "Flat"
$activateBtn.FlatAppearance.BorderSize = 0

# Content Panel
$contentPanel = New-Object System.Windows.Forms.Panel
$contentPanel.Size = New-Object System.Drawing.Size(880, 400)
$contentPanel.Location = New-Object System.Drawing.Point(10, 160)
$contentPanel.BackColor = $secondaryColor
$contentPanel.AutoScroll = $true

# Footer Panel
$footerPanel = New-Object System.Windows.Forms.Panel
$footerPanel.Size = New-Object System.Drawing.Size(880, 30)
$footerPanel.Location = New-Object System.Drawing.Point(10, 570)
$footerPanel.BackColor = $secondaryColor

$copyrightLabel = New-Object System.Windows.Forms.Label
$copyrightLabel.Text = "© 2023 Emazra Activator Suite. All Rights Reserved. Developed by IMaadh"
$copyrightLabel.Font = $normalFont
$copyrightLabel.ForeColor = $textColor
$copyrightLabel.AutoSize = $true
$copyrightLabel.Location = New-Object System.Drawing.Point(10, 5)

# Global variables for MAC verification controls
$global:macLabel = $null
$global:activateButton = $null
$global:statusLabel = $null

# Home/About Screen
function Show-HomeAboutScreen {
    $contentPanel.Controls.Clear()
    
    # Welcome Label
    $welcomeLabel = New-Object System.Windows.Forms.Label
    $welcomeLabel.Text = "Emazra Activator Suite"
    $welcomeLabel.Font = $titleFont
    $welcomeLabel.ForeColor = $primaryColor
    $welcomeLabel.AutoSize = $true
    $welcomeLabel.Location = New-Object System.Drawing.Point(20, 20)
    
    $subtitleLabel = New-Object System.Windows.Forms.Label
    $subtitleLabel.Text = "Professional Windows Activation Tool"
    $subtitleLabel.Font = $subtitleFont
    $subtitleLabel.ForeColor = [System.Drawing.Color]::FromArgb(189, 195, 199)
    $subtitleLabel.AutoSize = $true
    $subtitleLabel.Location = New-Object System.Drawing.Point(25, 70)
    
    # Description
    $descLabel = New-Object System.Windows.Forms.Label
    $descLabel.Text = "This application provides authorized Windows activation services.`n`nTo activate Windows, please navigate to the 'Activate Windows' tab and follow the instructions.`n`nOnly authorized devices with approved MAC addresses can use this activation tool."
    $descLabel.Font = $normalFont
    $descLabel.ForeColor = $textColor
    $descLabel.AutoSize = $false
    $descLabel.Size = New-Object System.Drawing.Size(800, 100)
    $descLabel.Location = New-Object System.Drawing.Point(20, 120)
    
    # Developer Info
    $devLabel = New-Object System.Windows.Forms.Label
    $devLabel.Text = "Application Developed by IMaadh`nFor support, please contact the developer"
    $devLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    $devLabel.ForeColor = $primaryColor
    $devLabel.AutoSize = $true
    $devLabel.Location = New-Object System.Drawing.Point(20, 240)
    
    $contentPanel.Controls.Add($welcomeLabel)
    $contentPanel.Controls.Add($subtitleLabel)
    $contentPanel.Controls.Add($descLabel)
    $contentPanel.Controls.Add($devLabel)
}

# Activate Screen
function Show-ActivateScreen {
    $contentPanel.Controls.Clear()
    
    # Title
    $activateTitle = New-Object System.Windows.Forms.Label
    $activateTitle.Text = "Windows 10 Activation"
    $activateTitle.Font = $titleFont
    $activateTitle.ForeColor = $primaryColor
    $activateTitle.AutoSize = $true
    $activateTitle.Location = New-Object System.Drawing.Point(20, 20)
    
    # System Info
    $sysInfo = Get-SystemInfo
    
    $yPos = 80
    foreach ($key in $sysInfo.Keys) {
        $keyLabel = New-Object System.Windows.Forms.Label
        $keyLabel.Text = "$($key):"
        $keyLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
        $keyLabel.ForeColor = $primaryColor
        $keyLabel.AutoSize = $true
        $keyLabel.Location = New-Object System.Drawing.Point(20, $yPos)
        
        $valueLabel = New-Object System.Windows.Forms.Label
        $valueLabel.Text = $sysInfo[$key]
        $valueLabel.Font = $normalFont
        $valueLabel.ForeColor = $textColor
        $valueLabel.AutoSize = $true
        $valueLabel.Location = New-Object System.Drawing.Point(200, $yPos)
        
        $contentPanel.Controls.Add($keyLabel)
        $contentPanel.Controls.Add($valueLabel)
        
        $yPos += 25
    }
    
    # MAC Verification Label
    $global:macLabel = New-Object System.Windows.Forms.Label
    $global:macLabel.Text = "MAC Address Status: Not Checked"
    $global:macLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
    $global:macLabel.ForeColor = $textColor
    $global:macLabel.AutoSize = $true
    $global:macLabel.Location = New-Object System.Drawing.Point(20, ($yPos + 20))
    
    # Check MAC Button
    $checkMacBtn = New-Object System.Windows.Forms.Button
    $checkMacBtn.Text = "Check MAC Authorization"
    $checkMacBtn.Font = $buttonFont
    $checkMacBtn.Size = New-Object System.Drawing.Size(200, 40)
    $checkMacBtn.Location = New-Object System.Drawing.Point(20, ($yPos + 50))
    $checkMacBtn.BackColor = $primaryColor
    $checkMacBtn.ForeColor = [System.Drawing.Color]::White
    $checkMacBtn.FlatStyle = "Flat"
    $checkMacBtn.FlatAppearance.BorderSize = 0
    $checkMacBtn.Add_Click({
        $mac = Get-MacAddress
        if (-not $mac) {
            $global:macLabel.Text = "MAC Address Status: ❌ Not Available"
            $global:macLabel.ForeColor = $errorColor
            [System.Windows.Forms.MessageBox]::Show("Could not retrieve MAC address. Please check your network connection.", "Error", "OK", "Error")
            return
        }
        
        $stdMac = $mac -replace ":", "-"
        if ($allowedMACs -contains $stdMac) {
            $global:macLabel.Text = "MAC Address Status: Authorized ($mac)"
            $global:macLabel.ForeColor = $successColor
            $global:activateButton.Enabled = $true
            
            # Update last active time in Firestore
            Update-DeviceLastActive -macAddress $stdMac
        }
        else {
            $global:macLabel.Text = "MAC Address Status: Unauthorized ($mac)"
            $global:macLabel.ForeColor = $errorColor
            $global:activateButton.Enabled = $false
            [System.Windows.Forms.MessageBox]::Show("This device is not authorized.`nPlease contact IMaadh with your MAC address to get approval.`nYour MAC: $mac", "Unauthorized", "OK", "Warning")
        }
    })
    
    # Activation Button
    $global:activateButton = New-Object System.Windows.Forms.Button
    $global:activateButton.Text = "Activate Windows 10"
    $global:activateButton.Font = $buttonFont
    $global:activateButton.Size = New-Object System.Drawing.Size(200, 50)
    $global:activateButton.Location = New-Object System.Drawing.Point(340, ($yPos + 60))
    $global:activateButton.BackColor = $primaryColor
    $global:activateButton.ForeColor = [System.Drawing.Color]::White
    $global:activateButton.FlatStyle = "Flat"
    $global:activateButton.FlatAppearance.BorderSize = 0
    $global:activateButton.Enabled = $false
    $global:activateButton.Add_Click({ Activate-Windows })
    
    # Status Label
    $global:statusLabel = New-Object System.Windows.Forms.Label
    $global:statusLabel.Text = ""
    $global:statusLabel.Font = $normalFont
    $global:statusLabel.ForeColor = $textColor
    $global:statusLabel.AutoSize = $true
    $global:statusLabel.Location = New-Object System.Drawing.Point(20, ($yPos + 130))
    
    $contentPanel.Controls.Add($activateTitle)
    $contentPanel.Controls.Add($global:macLabel)
    $contentPanel.Controls.Add($checkMacBtn)
    $contentPanel.Controls.Add($global:activateButton)
    $contentPanel.Controls.Add($global:statusLabel)
}

# System Info Function
function Get-SystemInfo {
    $os = Get-CimInstance Win32_OperatingSystem
    $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
    
    $sysInfo = @{
        "Operating System" = "$($os.Caption) $($os.Version)"
        "System Architecture" = $os.OSArchitecture
        "Processor" = $cpu.Name
        "MAC Address" = (Get-MacAddress)
    }
    
    return $sysInfo
}

# MAC Address Function
function Get-MacAddress {
    try {
        $mac = (Get-CimInstance Win32_NetworkAdapterConfiguration |
                Where-Object { $_.MACAddress -and $_.IPEnabled -eq $true -and $_.Description -notmatch "Hyper-V|Virtual|VMware|Loopback" } |
                Select-Object -First 1 -ExpandProperty MACAddress).ToUpper()
        
        if (-not $mac) {
            # Alternative method using Get-NetAdapter
            $mac = (Get-NetAdapter | Where-Object { $_.Status -eq "Up" -and $_.MacAddress } | 
                   Select-Object -First 1 -ExpandProperty MacAddress).ToUpper()
        }
        
        return $mac
    }
    catch {
        return $null
    }
}

# Update device last active time in Firestore
function Update-DeviceLastActive {
    param (
        [string]$macAddress
    )
    
    try {
        $body = @{
            fields = @{
                lastActive = @{
                    timestampValue = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
                }
            }
        } | ConvertTo-Json -Depth 5
        
        # First find the document ID for this MAC address
        $queryUrl = "https://firestore.googleapis.com/v1/projects/$($firebaseConfig.projectId)/databases/(default)/documents/devices?mask.fieldPaths=macAddress&mask.fieldPaths=lastActive"
        $queryBody = @{
            structuredQuery = @{
                where = @{
                    fieldFilter = @{
                        field = @{ fieldPath = "macAddress" }
                        op = "EQUAL"
                        value = @{ stringValue = $macAddress }
                    }
                }
                from = @( @{ collectionId = "devices" } )
                limit = 1
            }
        } | ConvertTo-Json -Depth 5
        
        $queryResponse = Invoke-RestMethod -Uri $queryUrl -Method Post -Body $queryBody -ContentType "application/json"
        
        if ($queryResponse.documents -and $queryResponse.documents.Count -gt 0) {
            $documentId = $queryResponse.documents[0].name.Split('/')[-1]
            $updateUrl = "https://firestore.googleapis.com/v1/projects/$($firebaseConfig.projectId)/databases/(default)/documents/devices/$documentId?updateMask.fieldPaths=lastActive"
            
            $response = Invoke-RestMethod -Uri $updateUrl -Method Patch -Body $body -ContentType "application/json"
            return $true
        }
        
        return $false
    }
    catch {
        Write-Host "Error updating device last active time: $_"
        return $false
    }
}

# Activation Function
function Activate-Windows {
    # Check admin privileges
    if (-not (Test-Admin)) {
        [System.Windows.Forms.MessageBox]::Show("This operation requires administrator privileges.", "Admin Required", "OK", "Error")
        return
    }
    
    $global:statusLabel.Text = "Starting activation process..."
    $global:statusLabel.ForeColor = $textColor
    $mainForm.Refresh()
    
    try {
        # Install product key
        $global:statusLabel.Text = "Installing product key..."
        $mainForm.Refresh()

        $installResult = Start-Process "cscript.exe" -ArgumentList "//Nologo C:\Windows\System32\slmgr.vbs /ipk $productKey" -Wait -NoNewWindow -PassThru

        if ($installResult.ExitCode -eq 0) {
            $global:statusLabel.Text = "Product key installed. Activating Windows..."
            $mainForm.Refresh()
            
            # Activate Windows
            $activateResult = Start-Process "cscript.exe" -ArgumentList "//Nologo C:\Windows\System32\slmgr.vbs /ato" -Wait -NoNewWindow -PassThru
            
            if ($activateResult.ExitCode -eq 0) {
                $global:statusLabel.Text = "✅ Windows activated successfully!"
                $global:statusLabel.ForeColor = $successColor
                [System.Windows.Forms.MessageBox]::Show("Windows has been activated successfully!", "Success", "OK", "Information")
            }
            else {
                $global:statusLabel.Text = "❌ Activation failed. Please check your connection."
                $global:statusLabel.ForeColor = $errorColor
                [System.Windows.Forms.MessageBox]::Show("Windows activation failed. Please check your internet connection.", "Error", "OK", "Error")
            }
        }
        else {
            $global:statusLabel.Text = "❌ Product key installation failed."
            $global:statusLabel.ForeColor = $errorColor
            [System.Windows.Forms.MessageBox]::Show("Failed to install product key.", "Error", "OK", "Error")
        }
    }
    catch {
        $global:statusLabel.Text = "❌ Error during activation: $($_.Exception.Message)"
        $global:statusLabel.ForeColor = $errorColor
        [System.Windows.Forms.MessageBox]::Show("An error occurred during activation.", "Error", "OK", "Error")
    }
}

# Admin Check Function
function Test-Admin {
    try {
        $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal($identity)
        return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    }
    catch {
        return $false
    }
}

# Button Click Events
$homeBtn.Add_Click({ Show-HomeAboutScreen })
$activateBtn.Add_Click({ Show-ActivateScreen })

# Add Controls to Form
$headerPanel.Controls.Add($titleLabel)
$navPanel.Controls.Add($homeBtn)
$navPanel.Controls.Add($activateBtn)
$footerPanel.Controls.Add($copyrightLabel)

$mainForm.Controls.Add($headerPanel)
$mainForm.Controls.Add($navPanel)
$mainForm.Controls.Add($contentPanel)
$mainForm.Controls.Add($footerPanel)

# Show Home/About Screen by default
Show-HomeAboutScreen

# Display Form
$mainForm.ShowDialog() | Out-Null
