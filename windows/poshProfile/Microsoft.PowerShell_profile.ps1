# & ([ScriptBlock]::Create((oh-my-posh init pwsh --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/agnoster.omp.json" --print) -join "`n"))
& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "C:\Users\fvaccari\OneDrive - Delft University of Technology\configs\windows\hotstick\hotstick.minimal.omp.json" --print) -join "`n"))

# Auto complete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Disable venv writing in shell prompt added separately by the theme
$Env:VIRTUAL_ENV_DISABLE_PROMPT = 1
# Set komorebi folder
$Env:KOMOREBI_CONFIG_HOME = 'C:\Users\fvaccari\.komorebi\'



function ll {Get-ChildItem | Format-Wide -Column 5 }
function lll {Get-ChildItem | Sort-Object LastWriteTime}

function ex { explorer.exe .}

function venv_activate {
	$paths = @(
			"./.venv/Scripts/Activate.ps1",
			"../.venv/Scripts/Activate.ps1",
			"../../.venv/Scripts/Activate.ps1"
			)

		foreach ($path in $paths) {
			if (Test-Path $path) {
				& $path
					return
			}
		}

	Write-Error "Virtual environment not found"
}

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
function ff ([string] $file_name){ Get-ChildItem . -Recurse -Name $file_name}

function nw ([string] $path = ".") {wt -w new -d (Join-Path $PWD $path)}
function pdb ([string] $path){ uv run -m pdb $path}
function ipdb ([string] $path){ ipython --colors linux -m ipdb $path}
function ipp { ipython --colors linux --no-confirm-exit --no-banner $args}

function watch([string] $command, [int] $period) {
    while ($true) {
        Clear-Host
        Invoke-Expression $command
        Start-Sleep -Seconds $period
    }
}

# Make a nvim-config variable
$NVIM += "C:\Users\$env:USERNAME\AppData\Local\nvim\init.lua"
