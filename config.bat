@echo off
setlocal EnableExtensions

echo.
echo ==========================================
echo       DBT ENVIRONMENT CONFIGURATION
echo ==========================================
echo.

REM --------------------------------------------------
REM 1. Create Conda environment from environment.yml
REM --------------------------------------------------

echo [1/4] Creating Conda environment: dbt_env
echo.

call conda env create -f python_environment.yml

REM If environment already exists, conda returns an error.
REM We continue because the environment may already be available.
if errorlevel 1 (
echo.
echo Environment may already exist or creation failed.
echo Checking whether dbt_env exists...

```
call conda env list | findstr /R /C:"dbt_env" >nul

if errorlevel 1 (
    echo.
    echo ERROR: dbt_env does not exist.
    echo Please check python_environment.yml and your Conda installation.
    pause
    exit /b 1
)

echo dbt_env already exists. Continuing...
```

)

echo.
echo ==========================================
echo [2/4] Activating dbt_env
echo ==========================================
echo.

call conda activate dbt_env

if errorlevel 1 (
echo.
echo ERROR: Could not activate dbt_env.
echo.
echo Make sure Conda is initialized:
echo     conda init cmd.exe
echo.
pause
exit /b 1
)

echo Active environment:
echo %CONDA_DEFAULT_ENV%

echo.
echo ==========================================
echo [3/4] Configuring dbt profiles.yml
echo ==========================================
echo.

REM --------------------------------------------------
REM Create .dbt directory if it does not exist
REM --------------------------------------------------

if not exist "%USERPROFILE%.dbt" (
mkdir "%USERPROFILE%.dbt"
echo Created directory:
echo %USERPROFILE%.dbt
)

set "PROFILE_FILE=%USERPROFILE%.dbt\profiles.yml"

REM --------------------------------------------------
REM Create profiles.yml if it does not exist
REM --------------------------------------------------

if not exist "%PROFILE_FILE%" (
type nul > "%PROFILE_FILE%"
echo Created:
echo %PROFILE_FILE%
)

REM --------------------------------------------------
REM Check whether Banking_Project already exists
REM --------------------------------------------------

findstr /B /C:"Banking_Project:" "%PROFILE_FILE%" >nul

if not errorlevel 1 (
echo.
echo Banking_Project already exists in profiles.yml.
echo No changes were made to avoid creating a duplicate.
) else (
echo.
echo Adding Banking_Project to profiles.yml...

```
>>"%PROFILE_FILE%" echo.
>>"%PROFILE_FILE%" echo Banking_Project:
>>"%PROFILE_FILE%" echo   outputs:
>>"%PROFILE_FILE%" echo     dev:
>>"%PROFILE_FILE%" echo       account: BXQKRAL-HTB51610
>>"%PROFILE_FILE%" echo       database: bank360_project
>>"%PROFILE_FILE%" echo       password: dbt@password
>>"%PROFILE_FILE%" echo       role: bank360_role
>>"%PROFILE_FILE%" echo       schema: staging
>>"%PROFILE_FILE%" echo       threads: 1
>>"%PROFILE_FILE%" echo       type: snowflake
>>"%PROFILE_FILE%" echo       user: dbt_user
>>"%PROFILE_FILE%" echo       warehouse: bank_wh

echo Banking_Project added successfully.
```

)

echo.
echo ==========================================
echo [4/4] Configuration Complete
echo ==========================================
echo.

echo Conda environment:
echo     dbt_env

echo.
echo dbt profile:
echo     Banking_Project

echo.
echo profiles.yml:
echo     %PROFILE_FILE%

echo.
echo ==========================================
echo Testing dbt installation
echo ==========================================
echo.

dbt --version

echo.
echo ==========================================
echo Starting CMD with dbt_env activated
echo ==========================================
echo.

cmd /k

endlocal
