@echo off
setlocal enableextensions enabledelayedexpansion
echo Preparing from directory %~dp0
cd /d "%~dp0"
echo.
set stringbuild={"LoadList":[
for %%a in (*) do (
	set check=%%a
	if "!check:~-5!"==".json" (Call :isjson) else (Call :skipentry)
)
set stringbuild=%stringbuild%""]}
echo.
echo -v- Prepared Load List -v-
echo %stringbuild%
echo.
echo %stringbuild%>"%~dp0_LoadList.json"
echo _LoadList.json created at %~dp0_LoadList.json
pause

:isjson
	if NOT "!check:~0,1!"=="_" (Call :checkcontent) else (Call :skipentry)
	GoTo :EOF

:checkcontent
	findstr /m "SkelMeshSwap" "!check!" >nul
	if %errorlevel%==0 (
		GoTo :addstring
	)
	GoTo :skipentry

:addstring
	set stringbuild=!stringbuild!"!check:~0,-5!",
	echo ++ !check!
	GoTo :EOF

:skipentry
	echo -- !check!
	GoTo :EOF