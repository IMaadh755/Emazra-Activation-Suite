Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Emazra Activation Suite"
$form.Size = New-Object System.Drawing.Size(800, 600)
$form.StartPosition = "CenterScreen"
$form.BackColor = "#0F1923" -as [System.Drawing.Color]
$form.ForeColor = "White"
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
$form.Padding = New-Object System.Windows.Forms.Padding(30)

# Custom close button
$closeButton = New-Object System.Windows.Forms.Button
$closeButton.Text = "X"
$closeButton.Size = New-Object System.Drawing.Size(40, 40)
$closeButton.Location = New-Object System.Drawing.Point(710, 10)
$closeButton.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$closeButton.BackColor = "#FF5555" -as [System.Drawing.Color]
$closeButton.ForeColor = "White"
$closeButton.FlatStyle = "Flat"
$closeButton.FlatAppearance.BorderSize = 0
$closeButton.Cursor = [System.Windows.Forms.Cursors]::Hand
$closeButton.Add_Click({ $form.Close() })
$form.Controls.Add($closeButton)

# Header Panel
$headerPanel = New-Object System.Windows.Forms.Panel
$headerPanel.Size = New-Object System.Drawing.Size(740, 80)
$headerPanel.Location = New-Object System.Drawing.Point(10, 10)
$headerPanel.BackColor = "#0A101A" -as [System.Drawing.Color]
$form.Controls.Add($headerPanel)

# Title Label
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Text = "EMAZRA ACTIVATION SUITE"
$titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
$titleLabel.AutoSize = $true
$titleLabel.Location = New-Object System.Drawing.Point(220, 20)
$headerPanel.Controls.Add($titleLabel)

# Version Label
$versionLabel = New-Object System.Windows.Forms.Label
$versionLabel.Text = "Version 2.0.0"
$versionLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$versionLabel.AutoSize = $true
$versionLabel.Location = New-Object System.Drawing.Point(340, 50)
$headerPanel.Controls.Add($versionLabel)

# Main Content Panel
$mainPanel = New-Object System.Windows.Forms.Panel
$mainPanel.Size = New-Object System.Drawing.Size(740, 400)
$mainPanel.Location = New-Object System.Drawing.Point(10, 100)
$mainPanel.BackColor = "#0A101A" -as [System.Drawing.Color]
$form.Controls.Add($mainPanel)

# Info Label
$infoLabel = New-Object System.Windows.Forms.Label
$infoLabel.Text = "Professional Windows Activation Tool"
$infoLabel.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$infoLabel.AutoSize = $true
$infoLabel.Location = New-Object System.Drawing.Point(200, 40)
$mainPanel.Controls.Add($infoLabel)

# Button Container (centered)
$buttonPanel = New-Object System.Windows.Forms.Panel
$buttonPanel.Size = New-Object System.Drawing.Size(500, 200)
$buttonPanel.Location = New-Object System.Drawing.Point(120, 120)
$buttonPanel.BackColor = "#0F1923" -as [System.Drawing.Color]
$mainPanel.Controls.Add($buttonPanel)

# Centered Windows Buttons
$buttonY = 70  # Y position for both buttons
$buttonSpacing = 80  # Space between buttons

# Windows 10 Button (centered)
$win10Button = New-Object System.Windows.Forms.Button
$win10Button.Text = "WINDOWS 10"
$win10Button.Size = New-Object System.Drawing.Size(200, 60)
$win10Button.Location = New-Object System.Drawing.Point(50, $buttonY)
$win10Button.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$win10Button.BackColor = "#0078D7" -as [System.Drawing.Color]
$win10Button.ForeColor = "White"
$win10Button.FlatStyle = "Flat"
$win10Button.FlatAppearance.BorderSize = 0
$win10Button.Cursor = [System.Windows.Forms.Cursors]::Hand
$win10Button.Add_Click({
    irm "https://www.emazra.com/Emazra%20Activation%20Suite/Emazra-Activation-Suite-Win10-Pro.ps1" | iex
})
$buttonPanel.Controls.Add($win10Button)

# Windows 11 Button (centered)
$win11Button = New-Object System.Windows.Forms.Button
$win11Button.Text = "WINDOWS 11"
$win11Button.Size = New-Object System.Drawing.Size(200, 60)
$win11Button.Location = New-Object System.Drawing.Point(250, $buttonY)
$win11Button.Font = New-Object System.Drawing.Font("Segoe UI", 12, [System.Drawing.FontStyle]::Bold)
$win11Button.BackColor = "#0078D7" -as [System.Drawing.Color]
$win11Button.ForeColor = "White"
$win11Button.FlatStyle = "Flat"
$win11Button.FlatAppearance.BorderSize = 0
$win11Button.Cursor = [System.Windows.Forms.Cursors]::Hand
$win11Button.Add_Click({
    irm "https://www.emazra.com/Emazra%20Activation%20Suite/Emazra-Activation-Suite-Win11-Pro.ps1" | iex
})
$buttonPanel.Controls.Add($win11Button)

# Footer Panel
$footerPanel = New-Object System.Windows.Forms.Panel
$footerPanel.Size = New-Object System.Drawing.Size(740, 50)
$footerPanel.Location = New-Object System.Drawing.Point(10, 510)
$footerPanel.BackColor = "#0A101A" -as [System.Drawing.Color]
$form.Controls.Add($footerPanel)

# Copyright Label
$copyrightLabel = New-Object System.Windows.Forms.Label
$copyrightLabel.Text = "Copyright © 2025 Emazra Group. All rights reserved."
$copyrightLabel.AutoSize = $true
$copyrightLabel.Location = New-Object System.Drawing.Point(220, 15)
$footerPanel.Controls.Add($copyrightLabel)

# Developer Label
$devLabel = New-Object System.Windows.Forms.Label
$devLabel.Text = "App Developed by IMaadh"
$devLabel.AutoSize = $true
$devLabel.Location = New-Object System.Drawing.Point(580, 15)
$devLabel.Font = New-Object System.Drawing.Font("Segoe UI", 8)
$footerPanel.Controls.Add($devLabel)

# Show form
$form.Add_Shown({$form.Activate()})
[void]$form.ShowDialog()
