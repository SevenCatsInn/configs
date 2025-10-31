# Define the source paths
$vscodeSourcePath = "$HOME\scoop\apps\vscode\current\data\user-data\User"
$terminalSourceFile = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$nvimSourceFolder = "$env:LOCALAPPDATA\nvim"  # Location of the nvim folder in AppData\Local
$ahkSourceFolder = "$HOME\ahk"  # Location of the ahk folder in the home directory
$komorebiSourceFolder = "$HOME\.komorebi"
$profileFile = $PROFILE  # PowerShell profile

# Define the destination path
$destinationPath = "$HOME\OneDrive - Delft University of Technology\BackupConfigs"

# Get the current script path
$scriptPath = $MyInvocation.MyCommand.Path

# Ensure the destination directory exists
if (-not (Test-Path -Path $destinationPath)) {
    New-Item -ItemType Directory -Path $destinationPath | Out-Null
}

# Define subfolders for VS Code, Windows Terminal, Neovim, and other files
$vscodeFolder = Join-Path -Path $destinationPath -ChildPath "vscode"
$wintermFolder = Join-Path -Path $destinationPath -ChildPath "winterm"
$komorebiFolder = Join-Path -Path $destinationPath -ChildPath "komorebi"
$ahkFolder = Join-Path -Path $destinationPath -ChildPath "ahk"
$profileFolder = Join-Path -Path $destinationPath -ChildPath "poshProfile"
$scriptFolder = Join-Path -Path $destinationPath -ChildPath "backupScript"

# Ensure the subfolders exist
if (-not (Test-Path -Path $vscodeFolder)) { New-Item -ItemType Directory -Path $vscodeFolder | Out-Null }
if (-not (Test-Path -Path $wintermFolder)) { New-Item -ItemType Directory -Path $wintermFolder | Out-Null }
if (-not (Test-Path -Path $komorebiFolder)) { New-Item -ItemType Directory -Path $komorebiFolder | Out-Null }
if (-not (Test-Path -Path $ahkFolder)) { New-Item -ItemType Directory -Path $ahkFolder | Out-Null }
if (-not (Test-Path -Path $profileFolder)) { New-Item -ItemType Directory -Path $profileFolder | Out-Null }
if (-not (Test-Path -Path $scriptFolder)) { New-Item -ItemType Directory -Path $scriptFolder | Out-Null }

# Define the files to copy from VS Code
$vscodeFilesToCopy = @("settings.json", "keybindings.json")

# Copy VS Code files to the 'vscode' subfolder
foreach ($file in $vscodeFilesToCopy) {
    $sourceFile = Join-Path -Path $vscodeSourcePath -ChildPath $file
    $destinationFile = Join-Path -Path $vscodeFolder -ChildPath $file
    
    # Remove any previous versions
    if (Test-Path -Path $destinationFile) {
        Remove-Item -Path $destinationFile -Force
        Write-Host "Removed old version of $file from $vscodeFolder"
    }

    if (Test-Path -Path $sourceFile) {
        # Copy the file
        Copy-Item -Path $sourceFile -Destination $destinationFile -Force
        Write-Host "Copied $file to $vscodeFolder"
    } else {
        Write-Host "File $file does not exist in the source directory."
    }
}

# Copy Windows Terminal settings.json to the 'winterm' subfolder
$terminalDestinationFile = Join-Path -Path $wintermFolder -ChildPath "settings.json"

# Remove any previous version of Windows Terminal settings
if (Test-Path -Path $terminalDestinationFile) {
    Remove-Item -Path $terminalDestinationFile -Force
    Write-Host "Removed old version of settings.json from $wintermFolder"
}

if (Test-Path -Path $terminalSourceFile) {
    # Copy the file
    Copy-Item -Path $terminalSourceFile -Destination $terminalDestinationFile -Force
    Write-Host "Copied Windows Terminal settings.json to $wintermFolder"
} else {
    Write-Host "Windows Terminal settings.json does not exist in the source directory."
}

# Copy PowerShell profile to the 'poshProfile' subfolder
$profileDestinationFile = Join-Path -Path $profileFolder -ChildPath (Split-Path -Leaf $profileFile)
if (Test-Path -Path $profileDestinationFile) {
    Remove-Item -Path $profileDestinationFile -Force
    Write-Host "Removed old version of PowerShell profile from $profileFolder"
}

if (Test-Path -Path $profileFile) {
    # Copy the file
    Copy-Item -Path $profileFile -Destination $profileFolder -Force
    Write-Host "Copied PowerShell profile to $profileFolder"
} else {
    Write-Host "PowerShell profile does not exist at $profileFile"
}

# Copy the nvim folder to the 'nvim' subfolder
if (Test-Path -Path $nvimSourceFolder) {
    # Remove any previous nvim folder in the backup location
    $nvimDestinationFolder = Join-Path -Path $destinationPath -ChildPath "nvim"
    if (Test-Path -Path $nvimDestinationFolder) {
        Remove-Item -Path $nvimDestinationFolder -Recurse -Force
        Write-Host "Removed old nvim folder from $destinationPath"
    }

    # Copy the nvim folder
    Copy-Item -Path $nvimSourceFolder -Destination $nvimDestinationFolder -Recurse -Force
    Write-Host "Copied nvim folder to $destinationPath"
} else {
    Write-Host "nvim folder does not exist in the source directory."
}

# Copy the komorebi folder to the 'komorebi' subfolder
if (Test-Path -Path $komorebiSourceFolder) {
    # Remove any previous komorebi folder in the backup location
    if (Test-Path -Path $komorebiFolder) {
        Remove-Item -Path $komorebiFolder -Recurse -Force
        Write-Host "Removed old komorebi folder from $komorebiFolder"
    }

    # Copy the komorebi folder
    Copy-Item -Path $komorebiSourceFolder -Destination $komorebiFolder -Recurse -Force
    Write-Host "Copied komorebi folder to $komorebiFolder"
} else {
    Write-Host "komorebi folder does not exist in the source directory."
}

# Copy the ahk folder to the 'ahk' subfolder
if (Test-Path -Path $ahkSourceFolder) {
    # Remove any previous ahk folder in the backup location
    if (Test-Path -Path $ahkFolder) {
        Remove-Item -Path $ahkFolder -Recurse -Force
        Write-Host "Removed old ahk folder from $ahkFolder"
    }

    # Copy the ahk folder
    Copy-Item -Path $ahkSourceFolder -Destination $ahkFolder -Recurse -Force
    Write-Host "Copied ahk folder to $ahkFolder"
} else {
    Write-Host "ahk folder does not exist in the source directory."
}

# Copy this script to the 'script' subfolder
$scriptDestinationFile = Join-Path -Path $scriptFolder -ChildPath (Split-Path -Leaf $scriptPath)
if (Test-Path -Path $scriptDestinationFile) {
    Remove-Item -Path $scriptDestinationFile -Force
    Write-Host "Removed old version of the script from $scriptFolder"
}

Copy-Item -Path $scriptPath -Destination $scriptFolder -Force
Write-Host "Copied this script to $scriptFolder"
