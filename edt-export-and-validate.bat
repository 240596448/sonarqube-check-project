@chcp 65001 1>nul

@setlocal

@if not defined EDT_PROJECT_VERSION (
    set EDT_PROJECT_VERSION=8.3.20
    )
@if not defined EDT_VERSION (
    set EDT_VERSION=2021.2.10
    )

@REM Первый параметр - путь к репозиторию
@set REPO_PATH=%~f1
@if defined REPO_PATH (
    if %REPO_PATH:~-1%==\ (
        set ROOT=%REPO_PATH:~0,-1%
        ) else (
        set ROOT=%REPO_PATH%
        )
    ) else (
    set ROOT=%~dp0
    )
@ECHO Путь к репозиторию: %ROOT%

@set SRC=%ROOT%\src

@set EDT=%ROOT%\edt
@set WORKSPACE=%EDT%\edt-workspace
@set PROJECT_PATH=%EDT%\edt-project

@set EDT_VALIDATION_RESULT=%EDT%\edt-result.out

@set RING_OPTS=-Dfile.encoding=UTF-8 -Dosgi.nl=ru -Xmx16g

@rd /S /Q "%WORKSPACE%" 2>nul
@md  "%WORKSPACE%"
@rd /S /Q "%PROJECT_PATH%" 2>nul
@DEL "%EDT_VALIDATION_RESULT%" 2>nul

@ECHO ------------ Создание проекта в EDT %date% - %time% ------------ 

call ring edt@%EDT_VERSION% workspace import --workspace-location "%WORKSPACE%" --configuration-files "%SRC%" --project "%PROJECT_PATH%" --version %EDT_PROJECT_VERSION%

@ECHO ------------ Проект в EDT создан %date% - %time% ------------
@ECHO Error level: %ERRORLEVEL% 

if %ERRORLEVEL% NEQ 0 exit %ERRORLEVEL%

@ECHO ------------ Запуск проверки проекта в EDT %date% - %time% ------------

call ring edt@%EDT_VERSION% workspace validate --workspace-location "%WORKSPACE%" --file "%EDT_VALIDATION_RESULT%" --project-list "%PROJECT_PATH%"

@ECHO ------------ Проверка завершена %date% - %time% ------------

call stebi c "%EDT%\edt-result.out" "%EDT%\edt-report.json" "%ROOT%\src"

@rd /S /Q "%WORKSPACE%"
@rd /S /Q "%PROJECT_PATH%"
