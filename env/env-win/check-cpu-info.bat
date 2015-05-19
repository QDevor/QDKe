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

if "x%INCLUDE_CHECK_CPU_INFO_BATCH%" == "xtrue" (
	goto :EOF
)

rem uncomment following sentence, output debug info to be enabled separately
rem set QDKe_VAR_DEBUG_%~n0=true
if "x!QDKe_VAR_DEBUG_%~n0!" == "xtrue" (
	set decho=echo
) else (
	set decho=rem
)

:: Checking and Setting cpu-info
:: http://ss64.com/nt/ver.html
:-------------------------------------

set "QDKe_VAR_NPROCS=%number_of_processors%"
set "QDKe_VAR_CPU_ARCH=%PROCESSOR_ARCHITECTURE%"
set "QDKe_VAR_CPU_ID=%PROCESSOR_IDENTIFIER%"

echo [QDKe] - We Are Checking CPU Info.
echo [CPU Info] - NPROCS   = !QDKe_VAR_NPROCS!.
echo [CPU Info] - CPU_ID   = !QDKe_VAR_CPU_ID!.
%decho% [CPU Info] - CPU_ARCH = !QDKe_VAR_CPU_ARCH!.

set "xOS=x64"
set "xCMD=x64"
if "%PROCESSOR_ARCHITECTURE%"=="x86" set "xCMD=x32" & if not defined PROCESSOR_ARCHITEW6432 set "xOS=x32"
%decho% [CPU Info] - xOS      = !xOS!.
%decho% [CPU Info] - xCMD     = !xCMD!.

set "QDKe_VAR_xOS=!xOS!"
set "QDKe_VAR_xCMD=!xCMD!"

echo [QDKe] - We Are Running !xCMD!(cmd) On !xOS!(os).

:-------------------------------------
set INCLUDE_CHECK_CPU_INFO_BATCH=true
:EOF