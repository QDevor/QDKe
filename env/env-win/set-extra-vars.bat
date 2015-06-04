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

:----------------RUN-ONCE----------------
if "x%INCLUDE_SET_EXTRA_VARS_BATCH%" == "xtrue" (
	goto :EOF
)
:----------------RUN-ONCE----------------

:: Setting extra-vars
:----------------------------------------
set "ORIGIN_USERNAME=%USERNAME%"
set "ORIGIN_HOMEPATH=%HOMEPATH%"
set "ORIGIN_USERPROFILE=%USERPROFILE%"

set "ORIGIN_USERDNSDOMAIN=%USERDNSDOMAIN%"
set "ORIGIN_USERDOMAIN=%USERDOMAIN%"

set "USERNAME=QDKe"
set "USEREMAIL=QDevor@163.com"
set "HOMEPATH=%QDKE_USR%/%USERNAME%"
set "USERPROFILE=%HOMEPATH%"

set "USERDNSDOMAIN=QDKe"
set "USERDOMAIN=QDKe"

set "args=/"
set "HOMEPATH=!HOMEPATH:%args%=\!"
set "USERPROFILE=!USERPROFILE:%args%=\!"

set "args=%HOMEPATH%"
call %QDKE_ENV%/env-win/check-dirs-exist.bat %args%
:----------------------------------------
:: common include, lib
:----------------------------------------
set "INCLUDE=%QDK_OPT_DIR%/include"
rem set "LIB=%QDK_OPT_DIR%/lib"
set "LIBPATH=%QDK_OPT_DIR%/lib"

:----------------------------------------
:: ready python
:----------------------------------------
set "PYTHONPATH=%LIBPATH%"
set "PATH=%PATH%;%LIBPATH%"

:----------------RUN-ONCE----------------
set INCLUDE_SET_EXTRA_VARS_BATCH=true
:EOF
:----------------RUN-ONCE----------------