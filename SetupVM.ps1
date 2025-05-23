Set-ExecutionPolicy Unrestricted -Force

$env:TEMP = "D:\Temp"
New-Item -ItemType Directory -Force -Path $env:TEMP
$ProgressPreference = 'SilentlyContinue'

#This needs a browsing cookie so it 403's :( 
#Invoke-WebRequest -Uri "https://www.e2esoft.com/files/VSC_v2.2.exe" -OutFile "$($env:TEMP)\VSC_v2.2.exe"
#Start-Process -FilePath "$($env:TEMP)\VSC_v2.2.exe"

Invoke-WebRequest -Uri "https://download.vb-audio.com/Download_CABLE/VBCABLE_Driver_Pack43.zip" -OutFile "$($env:TEMP)\VBCABLE_Driver_Pack43.zip"
Expand-Archive  -Path "$($env:TEMP)\VBCABLE_Driver_Pack43.zip" -DestinationPath "$($env:TEMP)\VBCABLE_Driver_Pack43"
#This doesn't actually silent isntall but what can you do lol.
Start-Process "$($env:TEMP)\VBCABLE_Driver_Pack43\VBCABLE_Setup_x64.exe" -ArgumentList "/silent"

Invoke-WebRequest -Uri "https://download.radmin-vpn.com/download/files/Radmin_VPN_1.4.4642.1.exe" -OutFile "$($env:TEMP)\Radmin_VPN_1.4.exe"
Start-Process "$($env:TEMP)\Radmin_VPN_1.4.exe" -ArgumentList "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-"

Invoke-WebRequest -Uri "https://builds.parsec.app/package/parsec-windows.exe" -OutFile "$($env:TEMP)\parsec-windows.exe"
Start-Process "$($env:TEMP)\parsec-windows.exe" -ArgumentList "/silent /shared"

Invoke-WebRequest -Uri "https://builds.dotnet.microsoft.com/dotnet/Sdk/8.0.410/dotnet-sdk-8.0.410-win-x64.exe" -OutFile "$($env:TEMP)\windowsdesktop-runtime-8.0.410-win-x64.exe"
Start-Process "$($env:TEMP)\windowsdesktop-runtime-8.0.410-win-x64.exe" -ArgumentList "/install /passive /norestart"

Invoke-WebRequest -Uri "https://download.microsoft.com/download/9/1/e/91ed0d01-1a2c-46ad-b014-51ece3b1936c/amd-software-cloud-edition-23.q3-azure-ngads-v620.exe" -OutFile "$($env:TEMP)\amd-software-cloud-edition-23.q3-azure-ngads-v620.exe"
Start-Process "$($env:TEMP)\amd-software-cloud-edition-23.q3-azure-ngads-v620.exe"

# Stop OneDrive if it's running
Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue
# Uninstall OneDrive for all users
Start-Process -FilePath "$env:SystemRoot\System32\OneDriveSetup.exe" -ArgumentList "/uninstall" -NoNewWindow -Wait
# Remove OneDrive leftovers
Remove-Item -Path "$env:UserProfile\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:LocalAppData\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:ProgramData\Microsoft OneDrive" -Recurse -Force -ErrorAction SilentlyContinue

Invoke-WebRequest -Uri "https://www.7-zip.org/a/7z2409-x64.exe" -OutFile "$($env:TEMP)\7z2409-x64.exe"
Start-Process "$($env:TEMP)\7z2409-x64.exe" -ArgumentList "/S" -Wait

$code = Read-Host "Press Enter Once 7zip is installed."
#find the 7-zip folder path
$7zPath = (Get-ChildItem "C:\Program Files","C:\Program Files (x86)" -Include "7-zip" -Recurse -ErrorAction SilentlyContinue).FullName
#add it to PATH environment variable
$env:Path += ";$7zPath;"
[System.Environment]::SetEnvironmentVariable('PATH',$env:Path, 'Machine')


$code = Read-Host "Press Enter Once AMD Drivers are installed."
Get-PnpDevice -FriendlyName "Microsoft Hyper-V Video" | Disable-PnpDevice -Confirm:$false

Write-Host "You're done :)!"
pause
