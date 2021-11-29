@chcp 65001 >nul
@set SONAR_SCANNER_OPTS=-Xmx16g

@SET CURRENT_DIR=%~dp0

@REM Сканер определяет путь к проекту как текущий каталог %CD%
@REM Возможность указать путь к анализируемому репозиторию
@SET PROJECT_PATH=%~f1
@if defined PROJECT_PATH (cd /d %PROJECT_PATH%)

@ECHO Путь к репозиторию: %PROJECT_PATH%
@ECHO Текущая директория изменена на %cd%

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
@ECHO Путь к sonar-scanner: %PATH_SONAR_SCANNER%

@ call %PATH_SONAR_SCANNER%\sonar-scanner.bat -D"sonar.login=%SONAR_TOKEN%"

@cd /d %CURRENT_DIR%
@ECHO Текущая директория восстановлена в %cd%