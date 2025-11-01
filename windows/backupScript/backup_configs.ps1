# Backup Configuration
$config = @{
    Destination = "$HOME\OneDrive - Delft University of Technology\configs\windows"
    Files = @(
        @{ Source = "$HOME\scoop\apps\vscode\current\data\user-data\User"; Dest = "vscode"; Files = @("settings.json", "keybindings.json") }
        @{ Source = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"; Dest = "winterm" }
        @{ Source = "$HOME\AppData\Roaming\helix"; Dest = "helix"; Files = @("languages.toml", "config.toml") }
        @{ Source = $PROFILE; Dest = "poshProfile" }
        @{ Source = $MyInvocation.MyCommand.Path; Dest = "backupScript" }
    )
    Folders = @(
        @{ Source = "$env:LOCALAPPDATA\nvim"; Dest = "nvim" }
        @{ Source = "$HOME\.komorebi"; Dest = "komorebi" }
        @{ Source = "$HOME\ahk"; Dest = "ahk" }
    )
}

# Helper Functions
function Ensure-Directory {
    param([string]$Path)
    if (-not (Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
}

function Copy-FileWithLogging {
    param(
        [string]$Source,
        [string]$Destination,
        [string]$Name
    )

    if (-not (Test-Path $Source)) {
        Write-Host "Skipped: $Name (source not found)" -ForegroundColor Yellow
        return
    }

    if (Test-Path $Destination) {
        Remove-Item $Destination -Force
    }

    Copy-Item -Path $Source -Destination $Destination -Force
    Write-Host "Backed up: $Name" -ForegroundColor Green
}

function Copy-FolderWithLogging {
    param(
        [string]$Source,
        [string]$Destination,
        [string]$Name
    )

    if (-not (Test-Path $Source)) {
        Write-Host "Skipped: $Name (source not found)" -ForegroundColor Yellow
        return
    }

    if (Test-Path $Destination) {
        Remove-Item $Destination -Recurse -Force
    }

    Copy-Item -Path $Source -Destination $Destination -Recurse -Force
    Write-Host "Backed up: $Name" -ForegroundColor Green
}

# Main Execution
Ensure-Directory $config.Destination

# Process Files
foreach ($item in $config.Files) {
    $destFolder = Join-Path $config.Destination $item.Dest
    Ensure-Directory $destFolder

    if ($item.Files) {
        # Multiple files from same source
        foreach ($file in $item.Files) {
            $sourceFile = Join-Path $item.Source $file
            $destFile = Join-Path $destFolder $file
            Copy-FileWithLogging -Source $sourceFile -Destination $destFile -Name "$($item.Dest)/$file"
        }
    } else {
        # Single file
        $destFile = Join-Path $destFolder (Split-Path $item.Source -Leaf)
        Copy-FileWithLogging -Source $item.Source -Destination $destFile -Name $item.Dest
    }
}

# Process Folders
foreach ($item in $config.Folders) {
    $destFolder = Join-Path $config.Destination $item.Dest
    Copy-FolderWithLogging -Source $item.Source -Destination $destFolder -Name $item.Dest
}

Write-Host "`nBackup completed!" -ForegroundColor Cyan
