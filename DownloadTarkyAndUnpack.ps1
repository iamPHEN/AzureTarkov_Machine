# Setup Envs
$env:TEMP = "D:\Temp"
New-Item -ItemType Directory -Force -Path $env:TEMP

# Define the file name
$fileName = "$env:TEMP\Tarky.7z"

$accessToken = Read-Host "Please enter auth code from PromptGDriveLogin here:"

# Download the Excel file from Google Drive
[string]$FileID = "fileidhere"
[string]$url = "https://www.googleapis.com/drive/v3/files/" + $FileID + "?alt=media&source=downloadUrl"
$headers = @{
    Authorization = "Bearer $accessToken"
}

echo "Downloading: $url"

$ProgressPreference = 'SilentlyContinue'
# set protocol to tls version 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$response = Invoke-WebRequest -Uri $url -Headers $headers -OutFile "$fileName"

#find the 7-zip folder path
$7zPath = (Get-ChildItem "C:\Program Files","C:\Program Files (x86)" -Include "7-zip" -Recurse -ErrorAction SilentlyContinue).FullName
#add it to PATH environment variable
$env:Path += ";$7zPath;"

7z x -y "$fileName" -o"C:\Tarky\"
cp "$env:TEMP\Setup.bat" "C:\Tarky\Setup.bat"

Set-Location -Path "C:\Tarky\"
Start-Process "C:\Tarky\Setup.bat"