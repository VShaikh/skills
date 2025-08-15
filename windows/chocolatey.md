## choco installation
```
-- Open Windows Powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install chocolateygui
choco install <package> --params "'/D=C:\MyPath'"
choco install <package> --install-arguments "'INSTALLDIR=D:\MyPath'"
choco info 
choco search cuda

choco install chocolateygui --params="'/ShowConsoleOutput=$true /UseDelayedSearch=$false /OutdatedPackagesCacheDurationInMinutes=120'" -y

choco uninstall miniconda3 -y
choco install miniconda3 --params="'/InstallationType:AllUsers /AddToPath:1 /RegisterPython:1 /D:E:\miniconda3'" -y

choco install visualstudio2019community -y
choco install visualstudio2019-workload-nativedesktop -y

choco install vlc.install -y

choco install nvidia-display-driver -y
choco install cuda -y
```
