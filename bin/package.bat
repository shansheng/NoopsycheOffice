@echo off
rem /**
rem  * Author: ThinkGem@163.com
rem  */
echo.
echo [信息] 打包Web工程，生成war包文件。
echo.
pause
echo.

cd %~dp0
cd..

set currPath=%cd%

call bin/maven/settings.bat 1
cd %currPath%

if exist "jflow-parent/pom.xml" (
	cd jflow-parent
	call mvn clean install -Dmaven.test.skip=true
	cd %currPath%
)

if exist "jflow-core/pom.xml" (
	cd jflow-core
	call mvn clean install -Dmaven.test.skip=true
	cd %currPath%
)

if exist "jflow-web/pom.xml" (
	cd jflow-web
	call mvn clean package -Dmaven.test.skip=true -U
	cd %currPath%
)

pause