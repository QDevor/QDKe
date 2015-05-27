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

rem if "x%INCLUDE_SET_DFLT_DIRS_BATCH%" == "xtrue" (
rem 	goto :EOF
rem )

:: Run %1 as Administrator
:-------------------------------------
if "x%1" == "x" (
	goto :EOF
)
set needed_admin_batch=%1
:-------------------------------------
:: Check for permissions
:-------------------------------------
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
:-------------------------------------
:: If error flag set, we do not have admin.
:-------------------------------------
if '%errorlevel%' NEQ '0' (  
    echo [QDKe] - Requesting administrative privileges...  
    goto UACPrompt  
) else ( goto gotAdmin )
:-------------------------------------
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%needed_admin_batch%", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
		
    "%temp%\getadmin.vbs"
    exit /B
:-------------------------------------
:gotAdmin  
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
:-------------------------------------
set INCLUDE_SET_DFLT_DIRS_BATCH=true
:EOF