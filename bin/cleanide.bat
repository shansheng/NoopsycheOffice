@echo off
rem /**
rem  * Author: ThinkGem@163.com
rem  */
echo.
echo [信息] 清理Eclipse工程文件。
echo.
pause
echo.

cd %~dp0
cd..

set currPath=%cd%

call bin/maven/settings.bat 1
cd %currPath%

call mvn -Declipse.workspace=%cd% eclipse:clean eclipse:eclipse -U

del %cd%\.classpath
del %cd%\.project

del %cd%\jflow-parent\.classpath
del %cd%\jflow-parent\.project

del %cd%\jflow-core\.classpath
del %cd%\jflow-core\.project

del %cd%\jflow-web\.classpath
del %cd%\jflow-web\.project

pause