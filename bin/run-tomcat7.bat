@echo off
rem /**
rem  * Author: ThinkGem@163.com
rem  */
title %cd%
echo.
echo [信息] 使用Tomcat7插件运行Web工程。
echo.
rem pause
rem echo.

cd %~dp0
cd..

set currPath=%cd%

call bin/maven/settings.bat 1
cd %currPath%

set MAVEN_OPTS=%MAVEN_OPTS% -Xms256m -Xmx512m -XX:PermSize=128m -XX:MaxPermSize=256m

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
	mvn clean tomcat7:run -D maven.javadoc.skip=true
	cd %currPath%
)

pause