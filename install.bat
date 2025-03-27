@echo off
sc create vmicguest binPath= "%SystemRoot%\system32\svchost.exe -k vmicguest" type= share start= auto DisplayName= "Hyper-V Guest Service"
sc description vmicguest "Provides an service for the Hyper-V host to interact with specific services running inside the virtual machine."
sc config vmicguest start= auto
sc failure vmicguest reset= 0 actions= restart/0
reg add HKLM\SYSTEM\CurrentControlSet\services\vmicguest\Parameters /v ServiceDll /t REG_EXPAND_SZ /d %SystemRoot%\system32\vmicguest.dll /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost" /v vmicguest /t REG_MULTI_SZ /d vmicguest /f
reg add HKLM\SYSTEM\CurrentControlSet\Services\vmicguest\Parameters /v ServiceDllUnloadOnStop /t REG_DWORD /d 1
sc start vmicguest
del %0



