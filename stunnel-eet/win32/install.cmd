nssm.exe install stunnel-eet "%~dp0tstunnel.exe" eet.conf
nssm.exe set stunnel-eet AppRestartDelay 1500
nssm.exe set stunnel-eet DisplayName "Stunnel EET"
@rem nssm.exe set stunnel-eet 
net.exe start stunnel-eet
