@echo off
rem /**
rem  * Author: ThinkGem@163.com
rem  */
echo.
echo [��Ϣ] ��������·����
echo.
pause
echo.

cd %~dp0
cd..

set currPath=%cd%

call bin/maven/settings.bat 1
cd %currPath%

call mvn clean

pause