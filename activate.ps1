<#
    Emazra Activation Suite - Professional Windows Activation Tool
    Version 2.0.0
    Copyright © 2023 Emazra Technologies. All rights reserved.
    App Developed by IMaadh
#>

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# Main Form
$mainForm = New-Object System.Windows.Forms.Form
$mainForm.Text = "Emazra Activation Suite Powered By IMaadh"
$mainForm.Size = New-Object System.Drawing.Size(900, 600)
$mainForm.StartPosition = "CenterScreen"
$mainForm.BackColor = "#2c3e50"
$mainForm.FormBorderStyle = "FixedSingle"
$mainForm.MaximizeBox = $false
$mainForm.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon((Get-Command powershell).Path)

# Fonts
$titleFont = New-Object System.Drawing.Font("Segoe UI", 24, [System.Drawing.FontStyle]::Bold)
$buttonFont = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
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
$titleLabel.Text = "Emazra Activation Suite Powered By IMaadh"
$titleLabel.Font = $titleFont
$titleLabel.ForeColor = [System.Drawing.Color]::White
$titleLabel.AutoSize = $true
$titleLabel.Location = New-Object System.Drawing.Point(20, 20)

# Content Panel
$contentPanel = New-Object System.Windows.Forms.Panel
$contentPanel.Size = New-Object System.Drawing.Size(880, 400)
$contentPanel.Location = New-Object System.Drawing.Point(10, 100)
$contentPanel.BackColor = $secondaryColor

# Footer Panel
$footerPanel = New-Object System.Windows.Forms.Panel
$footerPanel.Size = New-Object System.Drawing.Size(880, 30)
$footerPanel.Location = New-Object System.Drawing.Point(10, 510)
$footerPanel.BackColor = $secondaryColor

# Status Label (fixed declaration)
$statusLabel = New-Object System.Windows.Forms.Label
$statusLabel.Text = "Select your Windows version to activate"
$statusLabel.Font = $normalFont
$statusLabel.ForeColor = $textColor
$statusLabel.AutoSize = $true
$statusLabel.Location = New-Object System.Drawing.Point(50, 30)
$statusLabel.Size = New-Object System.Drawing.Size(800, 30)

# Windows 10 Button
$win10Button = New-Object System.Windows.Forms.Button
$win10Button.Text = "Windows 10"
$win10Button.Font = $buttonFont
$win10Button.Size = New-Object System.Drawing.Size(350, 100)
$win10Button.Location = New-Object System.Drawing.Point(150, 100)
$win10Button.BackColor = $primaryColor
$win10Button.ForeColor = [System.Drawing.Color]::White
$win10Button.FlatStyle = "Flat"
$win10Button.FlatAppearance.BorderSize = 0
$win10Button.Add_Click({
    $script:statusLabel.Text = "Loading Windows 10 activation..."
    $script:statusLabel.ForeColor = $textColor
    $mainForm.Refresh()
    
    try {
        Invoke-RestMethod "https://www.emazra.com/Emazra%20Activation%20Suite/Emazra-Activation-Suite-Win10-Pro.ps1" | Invoke-Expression
        $script:statusLabel.Text = "✅ Windows 10 activation loaded successfully"
        $script:statusLabel.ForeColor = $successColor
    }
    catch {
        $script:statusLabel.Text = "❌ Error loading Windows 10 activation: $($_.Exception.Message)"
        $script:statusLabel.ForeColor = $errorColor
    }
})

# Windows 11 Button
$win11Button = New-Object System.Windows.Forms.Button
$win11Button.Text = "Windows 11"
$win11Button.Font = $buttonFont
$win11Button.Size = New-Object System.Drawing.Size(350, 100)
$win11Button.Location = New-Object System.Drawing.Point(150, 230)
$win11Button.BackColor = $primaryColor
$win11Button.ForeColor = [System.Drawing.Color]::White
$win11Button.FlatStyle = "Flat"
$win11Button.FlatAppearance.BorderSize = 0
$win11Button.Add_Click({
    $script:statusLabel.Text = "Loading Windows 11 activation..."
    $script:statusLabel.ForeColor = $textColor
    $mainForm.Refresh()
    
    try {
        Invoke-RestMethod "https://www.emazra.com/Emazra%20Activation%20Suite/Emazra-Activation-Suite-Win11-Pro.ps1" | Invoke-Expression
        $script:statusLabel.Text = "✅ Windows 11 activation loaded successfully"
        $script:statusLabel.ForeColor = $successColor
    }
    catch {
        $script:statusLabel.Text = "❌ Error loading Windows 11 activation: $($_.Exception.Message)"
        $script:statusLabel.ForeColor = $errorColor
    }
})

# Copyright Label
$copyrightLabel = New-Object System.Windows.Forms.Label
$copyrightLabel.Text = "© 2023 Emazra Activation Suite. All Rights Reserved. Developed by IMaadh"
$copyrightLabel.Font = $normalFont
$copyrightLabel.ForeColor = $textColor
$copyrightLabel.AutoSize = $true
$copyrightLabel.Location = New-Object System.Drawing.Point(10, 5)

# Add Controls to Panels
$headerPanel.Controls.Add($titleLabel)
$contentPanel.Controls.Add($statusLabel)
$contentPanel.Controls.Add($win10Button)
$contentPanel.Controls.Add($win11Button)
$footerPanel.Controls.Add($copyrightLabel)

# Add Panels to Form
$mainForm.Controls.Add($headerPanel)
$mainForm.Controls.Add($contentPanel)
$mainForm.Controls.Add($footerPanel)

# Display Form
$mainForm.ShowDialog() | Out-Null
