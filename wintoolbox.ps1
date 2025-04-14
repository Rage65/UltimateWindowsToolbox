$uwtFolder = "$env:temp\UltimateWindowsToolbox"

# Deletes old Windows Toolbox files to avoid conflicts if you've run the script before.
if (Test-Path $uwtFolder) {
    Remove-Item -Recurse -Force -Confirm:$false -Path $uwtFolder
}
# Creates new directory for UltimateWindowsToolbox's files and scripts
New-Item -Path $uwtFolder -Type Directory

# Sets location to the windows toolbox folder
Set-Location $uwtFolder

# Downloads welcome.txt - welcome message for the main script
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/PowerPCFan/UltimateWindowsToolbox/main/welcome.txt" -OutFile "welcome.txt"

# Downloads main script
$scriptUrl = "https://raw.githubusercontent.com/PowerPCFan/UltimateWindowsToolbox/main/ultimatewindowstoolbox.cmd"
$scriptOutFilePath = "ultimatewindowstoolbox.cmd"
$lfcontent = (Invoke-WebRequest -UseBasicParsing -Uri $scriptUrl).Content
$crlfContent = $lfcontent -replace "`r?`n", "`r`n"
$utf8nobom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($scriptOutFilePath, $crlfContent, $utf8nobom)

# Changes PowerShell's execution policy to Unrestricted
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force

# Runs the script
powershell.exe ".\ultimatewindowstoolbox.cmd"
