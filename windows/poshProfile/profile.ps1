# & ([ScriptBlock]::Create((oh-my-posh init pwsh --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/agnoster.omp.json" --print) -join "`n"))
& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "C:\Users\fvaccari\OneDrive - Delft University of Technology\BackupConfigs\hotstick\hotstick.minimal.omp.json" --print) -join "`n"))

# Auto complete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Disable venv writing in shell prompt added separately by the theme
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1


# function ll {Get-ChildItem | Format-Wide -Column 5 }
function lll {Get-ChildItem | Sort-Object LastWriteTime}

function ex { explorer.exe .}

#function l { # Simple list 
#    param (
#        [string]$Path = ".",
#        [switch]$FoldersOnly
#    )
#
#    $items = Get-ChildItem -Path $Path 
#
#    # Iterate through the items
#    foreach ($item in $items) {
#        if ($item.PsIsContainer) {
#            # Highlight folders in yellow
#            Write-Host $item.Name -ForegroundColor Yellow
#        } elseif (-not $FoldersOnly) {
#            # Show files in white (default color)
#            Write-Host $item.Name -ForegroundColor White
#        }
#    }
#}


function l { # Print the last modified last
    param (
        [string]$Path = ".",
        [switch]$FoldersOnly
    )

    # Retrieve items, sorted by last write time
    $items = Get-ChildItem -Path $Path | Sort-Object LastWriteTime

    # Iterate through the items
    foreach ($item in $items) {
        if ($item.PsIsContainer) {
            # Highlight folders in yellow
            Write-Host $item.Name -ForegroundColor Yellow
        } elseif (-not $FoldersOnly) {
            # Show files in white (default color)
            Write-Host $item.Name -ForegroundColor White
        }
    }
}

function rmrf ([string] $path){ rm -Force -Recurse $path}

function Watch([string] $command, [int] $period) {
    while ($true) {
        Clear-Host
        Invoke-Expression $command
        Start-Sleep -Seconds $period
    }
}

# Add VS Code to PATH and
# Add an alias that makes vsc open vscode maximized
$env:Path += ";C:\Users\$env:USERNAME\AppData\Local\Programs\Microsoft VS Code\bin"
Set-Alias vsc "code"
