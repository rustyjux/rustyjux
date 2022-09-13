@echo off
call :sub >>%TEMP%\geoserver_install_log.txt
exit /b

:sub
for /F "tokens=2" %%i in ('date /t') do set date=%%i
set time=%time%
echo Install Log %date%:%time%

echo Downloading GeoServer binary
powershell -Command "Invoke-WebRequest -UserAgent "Wget" -Uri https://sourceforge.net/projects/geoserver/files/latest/download -OutFile geoserver.bin.zip"
echo Download complete

echo Uninstall previous versions
@REM
echo/|call "C:\Program Files\GeoServer\bin\shutdown.bat"
@RD /S /Q "C:\Program Files\GeoServer"
echo Uninstalled

echo Extracting GeoServer binary
powershell -command "Expand-Archive -Force '%~dp0geoserver.bin.zip' 'C:\Program Files\GeoServer'" 
echo Archive extracted

echo Setting environment variables
setx JAVA_HOME "C:\Program Files (x86)\Java\jre1.8.0_341"
setx GEOSERVER_HOME "C:\Program Files\GeoServer"
echo Installation complete
echo -