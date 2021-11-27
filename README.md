# Удаленный запуск анализа проекта для SonarQube
- `1C:EDT`
- `SonarQube 1C (BSL) Community Plugin`

--- 

### Запуск анализа 1C:EDT

При необходимости установить переменные окружения
- `EDT_PROJECT_VERSION` - версия EDT
- `EDT_VERSION` - версия 1C

Путь к репозиторию абсолютный или относительный

```cmd
REM set EDT_PROJECT_VERSION=202x.x.x
REM set EDT_VERSION=8.3.x

edt-export-and-validate.bat PATH_TO_REPOSITORY
```

---

### Запуск анализа сканером сонаркуба

Установить переменные окружения
- `SONAR_TOKEN` - (обязательно, secret) токен доступа к серверу SonarQube
- `PATH_SONAR_SCANNER` - путь к сканеру сонаркуба, если путь не задан в `PATH`

Путь к репозиторию абсолютный или относительный

```cmd
REM @set SONAR_TOKEN=00000000000000000000000000
REM set PATH_SONAR_SCANNER=c:\tools\sonar-scaner\bin\

edt-export-and-validate.bat PATH_TO_REPOSITORY
```
