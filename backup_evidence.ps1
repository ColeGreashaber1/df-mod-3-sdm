# Define source (evidence) destination (backup) folders
$fromFolder = ".\evidence"
$toFolder = ".\backup"

# Create the backup folder 
if (!(Test-Path $toFolder)) {
    New-Item -Path $toFolder -ItemType Directory
}

# Copy  contents of  evidence folder to  backup folder
Copy-Item -Path $fromFolder\* -Destination $toFolder -Recurse -Force

# Redirect security log events to file in backup folder
Get-WinEvent -LogName Security -MaxEvents 20 | Out-File "$toFolder\Logs.txt"

# Make all files in backup folder read-only
Get-ChildItem $toFolder -Recurse -File | ForEach-Object {
    $_.IsReadOnly = $true
}


