rem.
rem            Copyright (C) 2015 QDevor
rem.
rem  Licensed under the GNU General Public License, Version 3.0 (the License);
rem  you may not use this file except in compliance with the License.
rem  You may obtain a copy of the License at
rem.
rem            http://www.gnu.org/licenses/gpl-3.0.html
rem.
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an AS IS BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.
rem.

if "x%INCLUDE_SET_DFLT_DIRS_BATCH%" == "xtrue" (
	goto :EOF
)

:: Setting and Checking dflt-dirs
:-------------------------------------
set "QDKE_ROOT=%cd%"
set "QDKE_USR=%QDKE_ROOT%/usr"
set "QDKE_HOME=%QDKE_ROOT%/home"
set "QDKE_ENV=%QDKE_ROOT%/env"
set "QDKE_TMP=%QDKE_ROOT%/tmp"
set "QDKE_VAR=%QDKE_ROOT%/var"
set "QDKE_ETC=%QDKE_ROOT%/etc"

set "ORIGIN_WORK_HOME=%WORK_HOME%"
set "ORIGIN_TEMP=%TEMP%"
set "ORIGIN_TMP=%TMP%"
set "ORIGIN_TMPDIR=%TMPDIR%"
set "ORIGIN_APPDATA=%APPDATA%"

set "WORK_HOME=%QDKE_HOME%"
set "TEMP=%QDKE_TMP%"
set "TMP=%TEMP%"
set "TMPDIR=%TEMP%"
set "APPDATA=%TEMP%/appdata"

:: Windows batches variables name rules:
:: Some windows commands only support char '\' not '/', examples as 'mkdir',
:: So we are using char '\' in any dirs variables at windows batches.
:: In addition, more working needed to be moved into Linux-like shell(msys2).
:: But now we are formatting the path variables string.
:-------------------------------------
set "args=/"
set "QDKE_ROOT=!QDKE_ROOT:%args%=\!"
set "QDKE_USR=!QDKE_USR:%args%=\!"
set "QDKE_HOME=!QDKE_HOME:%args%=\!"
set "QDKE_ENV=!QDKE_ENV:%args%=\!"
set "QDKE_TMP=!QDKE_TMP:%args%=\!"
set "QDKE_VAR=!QDKE_VAR:%args%=\!"
set "QDKE_ETC=!QDKE_ETC:%args%=\!"

set "WORK_HOME=!WORK_HOME:%args%=\!"
set "TEMP=!TEMP:%args%=\!"
set "TMP=!TMP:%args%=\!"
set "TMPDIR=!TMPDIR:%args%=\!"
set "APPDATA=!APPDATA:%args%=\!"
:-------------------------------------

rem set "args=%QDKE_USR%,%QDKE_HOME%,%QDKE_ENV%"
set "args=%QDKE_TMP%,%QDKE_VAR%,%QDKE_ETC%"
set "args=%args%,%TEMP%,%TMP%,%TMPDIR%,%APPDATA%"
call %QDKE_ENV%/env-win/check-dirs-exist.bat %args%

:-------------------------------------
set INCLUDE_SET_DFLT_DIRS_BATCH=true
:EOF