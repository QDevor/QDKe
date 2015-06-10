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
set "QDK_ROOT=D:/qdk"
set "QDK_OPTDIR=%QDK_ROOT%/opt"
:-------------------------------------
set "QDKE_ROOT=%cd%"
set "QDKE_USR=%QDKE_ROOT%/usr"
set "QDKE_HOME=%QDKE_ROOT%/home"
set "QDKE_ENV=%QDKE_ROOT%/env"
set "QDKE_TMP=%QDKE_ROOT%/tmp"
set "QDKE_VAR=%QDKE_ROOT%/var"
set "QDKE_ETC=%QDKE_ROOT%/etc"
:-------------------------------------
set "QDKE_STAMPDIR=%QDKE_VAR%/ready_qdke"
set "QDKE_LOGDIR=%QDKE_VAR%/log"
set "QDKE_PATCHDIR=%QDKE_ETC%/patch"
:-------------------------------------

set "ORIGIN_WORK_HOME=%WORK_HOME%"
set "ORIGIN_TEMP=%TEMP%"
set "ORIGIN_TMP=%TMP%"
set "ORIGIN_TMPDIR=%TMPDIR%"
set "ORIGIN_APPDATA=%APPDATA%"

set "WORK_HOME=%QDKE_HOME%"
set "HOME=%WORK_HOME%"
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
set "win_token=\"
set "unix_token=/"
:-------------------------------------
set "_old_char=%unix_token%"
set "_new_char=%win_token%"
set "QDKE_ROOT=!QDKE_ROOT:%_old_char%=%_new_char%!"
set "QDKE_USR=!QDKE_USR:%_old_char%=%_new_char%!"
set "QDKE_HOME=!QDKE_HOME:%_old_char%=%_new_char%!"
set "QDKE_ENV=!QDKE_ENV:%_old_char%=%_new_char%!"
set "QDKE_TMP=!QDKE_TMP:%_old_char%=%_new_char%!"
set "QDKE_VAR=!QDKE_VAR:%_old_char%=%_new_char%!"
set "QDKE_ETC=!QDKE_ETC:%_old_char%=%_new_char%!"

set "QDKE_STAMPDIR=!QDKE_STAMPDIR:%_old_char%=%_new_char%!"
set "QDKE_LOGDIR=!QDKE_LOGDIR:%_old_char%=%_new_char%!"
set "QDKE_PATCHDIR=!QDKE_PATCHDIR:%_old_char%=%_new_char%!"
:-------------------------------------

set "WORK_HOME=!WORK_HOME:%_old_char%=%_new_char%!"
set "HOME=!HOME:%_old_char%=%_new_char%!"
set "TEMP=!TEMP:%_old_char%=%_new_char%!"
set "TMP=!TMP:%_old_char%=%_new_char%!"
set "TMPDIR=!TMPDIR:%_old_char%=%_new_char%!"
set "APPDATA=!APPDATA:%_old_char%=%_new_char%!"

:-------------------------------------

set "args=%QDKE_USR%,%QDKE_HOME%,%QDKE_ENV%"
set "args=%args%,%QDKE_TMP%,%QDKE_VAR%,%QDKE_ETC%,%QDKE_STAMPDIR%,%QDKE_LOGDIR%,%QDKE_PATCHDIR%"
set "args=%args%,%TEMP%,%TMP%,%TMPDIR%,%APPDATA%"
call %QDKE_ENV%/env-win/check-dirs-exist.bat %args%

:-------------------------------------
set "_old_char=%win_token%"
set "_new_char=%unix_token%"
set "QDKE_ROOT=!QDKE_ROOT:%_old_char%=%_new_char%!"
set "QDKE_USR=!QDKE_USR:%_old_char%=%_new_char%!"
set "QDKE_HOME=!QDKE_HOME:%_old_char%=%_new_char%!"
set "QDKE_ENV=!QDKE_ENV:%_old_char%=%_new_char%!"
set "QDKE_TMP=!QDKE_TMP:%_old_char%=%_new_char%!"
set "QDKE_VAR=!QDKE_VAR:%_old_char%=%_new_char%!"
set "QDKE_ETC=!QDKE_ETC:%_old_char%=%_new_char%!"

set "QDKE_STAMPDIR=!QDKE_STAMPDIR:%_old_char%=%_new_char%!"
set "QDKE_LOGDIR=!QDKE_LOGIDR:%_old_char%=%_new_char%!"
set "QDKE_PATCHDIR=!QDKE_PATCHDIR:%_old_char%=%_new_char%!"
:-------------------------------------

set "WORK_HOME=!WORK_HOME:%_old_char%=%_new_char%!"
set "HOME=!HOME:%_old_char%=%_new_char%!"
set "TEMP=!TEMP:%_old_char%=%_new_char%!"
set "TMP=!TMP:%_old_char%=%_new_char%!"
set "TMPDIR=!TMPDIR:%_old_char%=%_new_char%!"
set "APPDATA=!APPDATA:%_old_char%=%_new_char%!"
:-------------------------------------

:-------------------------------------
set INCLUDE_SET_DFLT_DIRS_BATCH=true
:EOF