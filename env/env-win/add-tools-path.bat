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
if "x%INCLUDE_ADD_TOOLS_PATH_BATCH%" == "xtrue" (
	goto :EOF
)
:----------------RUN-ONCE----------------

:: Add Tools to PATH
:----------------------------------------
:: Microsoft Visual Studio
:: Run vcvars32.bat at first
:----------------------------------------
if x%QDKe_VAR_MSVS_VER_YEAR% == "xNone" goto :skip_add_tools_path_msvs
rem set "PATH=!PATH!;!MSVS_VC_ROOT!/bin"
set "MSVS_VCVARSALL_BATCH=%MSVS_VC_ROOT%/vcvarsall.bat"
if exist "!MSVS_VCVARSALL_BATCH!" (
	echo [QDKe] - We Are Calling vcvars32.bat !QDKe_VAR_MSVC_ARCH! Will Reset Envirment Variables.
	rem call "!MSVS_VCVARSALL_BATCH!" !QDKe_VAR_MSVC_ARCH!
	set "PATH=!PATH!;!MSVS_VC_ROOT!/bin/amd64"
	set INCLUDE=!MSVS_VC_ROOT!/include;!INCLUDE!
	set LIB=!MSVS_VC_ROOT!/lib;!INCLUDE!
	echo [QDKe] - We Are Adding Microsoft Visual Studio.
) else (
	echo [QDKe] - We Are Finding Microsoft Visual Studio Not Exist.
)
rem echo [Debug] - PATH=%PATH%
:skip_add_tools_path_msvs
:----------------------------------------
:: Microsoft SQL Server
:----------------------------------------
set "PATH=!PATH!;!MSSQL_TOOLS_ROOT!"
set "PATH=!PATH!;!MSSQL_DTS_ROOT!"
:skip_add_tools_path_mssql
:----------------------------------------
:: Microsoft Platform SDK
:----------------------------------------
if x%QDKe_VAR_MSSDK_VER% == "xNone" goto :skip_add_tools_path_mssdk
set "PATH=!PATH!;!MSSDK_ROOT!/bin"
:skip_add_tools_path_mssdk
:----------------------------------------
:: MySQL
:----------------------------------------
rem goto :skip_add_tools_path_mysql
set "PATH=!PATH!;!MYSQL_SERVER_ROOT!/bin"
set "PATH=!PATH!;!MYSQL_UTILITIES_ROOT!"
set "PATH=!PATH!;!MYSQL_UTILITIES_EXT_ROOT!"
:skip_add_tools_path_mysql
rem set "PATH=!PATH!;!QDK_ROOT!//mysql-gpl/bin"
:----------------------------------------
:: Java
:----------------------------------------
set "PATH=!PATH!;!JAVA_ROOT!/bin"
:----------------------------------------
:: Python
:----------------------------------------
set "PATH=!PYTHON_ROOT!;!PATH!"
set "PATH=!PYTHON_ROOT!/Tools;!PATH!"
set "PATH=!PYTHON_ROOT!/Scripts;!PATH!"
:----------------------------------------

:----------------------------------------
:: Finally add %QDK_OPT_DIR%/bin
:----------------------------------------
set "PATH=!PATH!;!QDK_OPT_DIR!/bin"
:----------------------------------------
:----------------RUN-ONCE----------------
set INCLUDE_ADD_TOOLS_PATH_BATCH=true
:EOF
:----------------RUN-ONCE----------------