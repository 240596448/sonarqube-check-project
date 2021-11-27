@chcp 65001 >nul
@set SONAR_SCANNER_OPTS=-Xmx16g

@SET CURRENT_DIR=%~dp0

@REM Сканер определяет путь к проекту как текущий каталог %CD%
@REM Возможность указать путь к анализируемому репозиторию
@SET PROJECT_PATH=%~f1
if defined PROJECT_PATH (cd %PROJECT_PATH%)

@ECHO Путь к репозиторию: %PROJECT_PATH%

@if %ERRORLEVEL% NEQ 0 (
    @ECHO Error level: %ERRORLEVEL% && exit %ERRORLEVEL%
    )

@REM Если пусть к сканеру указан в PATH, то переменную задавать не нужно
@if not defined PATH_SONAR_SCANNER (
    set PATH_SONAR_SCANNER=.
    ) else (
        if %PATH_SONAR_SCANNER:~-1%==\ (
            set PATH_SONAR_SCANNER=%PATH_SONAR_SCANNER:~0,-1%
        )
    )

@call %PATH_SONAR_SCANNER%\sonar-scanner.bat -D"sonar.login=%SONAR_TOKEN%"

@cd %CURRENT_DIR%