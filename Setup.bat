@Echo Off
FSUTIL dirty query %SystemDrive% >nul
if %errorlevel% EQU 0 goto START

ver |>NUL find /v "5." && if "%~1"=="" (
  Echo CreateObject^("Shell.Application"^).ShellExecute WScript.Arguments^(0^),"1","","runas",1 >"%temp%\Elevating.vbs"
  cscript.exe //nologo "%temp%\Elevating.vbs" "%~f0"& goto :eof
)
:START
cls
cd /d %~dp0

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\EscapeFromTarkov" /f /v "InstallLocation" /t REG_SZ /d "%~dp0Install_EFT"

mkdir "%~dp0Install_EFT"  2>nul
mkdir "%~dp0Install_EFT\BattlEye"  2>nul

echo "111111" > "%~dp0Install_EFT\BattlEye\BEClient_x64.dll"
echo "111111" > "%~dp0Install_EFT\BattlEye\BEService_x64.exe"
echo "111111" > "%~dp0Install_EFT\ConsistencyInfo"
echo "111111" > "%~dp0Install_EFT\Uninstall.exe"
echo "111111" > "%~dp0Install_EFT\UnityCrashHandler64.exe"

del /f /q "%~dp0BepInEx\plugins\Phen.RoamingBots.dll" 2>nul
RMDIR /s /q "%~dp0BepInEx\plugins\sinai-dev-UnityExplorer\" 2>nul
RMDIR /s /q "%~dp0BepInEx\plugins\acidphantasm-accessibilityindicators\" 2>nul
del /f /q "%~dp0BepInEx\plugins\skwizzy.LootingBots.bak" 2>nul
del /f /q "%~dp0BepInEx\plugins\UnityExplorer.BIE5.Mono.dll" 2>nul
del /f /q "%~dp0BepInEx\plugins\UniverseLib.Mono.dll" 2>nul

del /f /q "%temp%\Elevating.vbs" 2>nul

pause