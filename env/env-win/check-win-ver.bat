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
if "x%INCLUDE_CHECK_WIN_VER_BATCH%" == "xtrue" (
	goto :EOF
)
:----------------RUN-ONCE----------------

rem uncomment following sentence, output debug info to be enabled separately
rem set QDKe_VAR_DEBUG_%~n0=true
if "x!QDKe_VAR_DEBUG_%~n0!" == "xtrue" (
	set decho=echo
) else (
	set decho=rem
)

:: NT3.5					3.5
:: NT3.51					3.51
:: NT4						4.0
:: 2000						5.0
:: XP							5.1
:: Sever2003			5.2
:: Sever2003R2		5.2
:: Vista					6.0
:: Sever2008			6.0
:: 7							6.0
:: Sever2008R2		6.1
:: 8							6.2
:: 10             10.0

rem set QDKe_VAR_IS_XP=true

:: CheckWindowsVersion by ver
:: http://ss64.com/nt/ver.html
:----------------------------------------
rem  --> Check Windows Version

set QDKe_VAR_WIN_VER="Unkown"
for /f "delims=" %%a in ('ver') do call :.ver %%a

if %QDKe_VAR_WIN_VER_INT% GTR 100 (
	echo [QDKe] - We Are Checking Windows Version - Unkown.
) else (
	echo [QDKe] - We Are Checking Windows Version - !QDKe_VAR_WIN_VER!.
	if !QDKe_VAR_WIN_VER_INT! GEQ 60 (
		set QDKe_VAR_IS_XP=false
	) else (
		set QDKe_VAR_IS_XP=true
	)
)

%decho% win_ver=%QDKe_VAR_WIN_VER%
%decho% win_xp =%QDKe_VAR_IS_XP%
goto :QDKe_CHECK_WIN_VER_EOF

:.ver
	if not "%2"=="" shift /1 &goto :.ver
	set QDKe_VAR_WIN_VER=%1
	for /F "usebackq tokens=1-3 delims=." %%v in ('!QDKe_VAR_WIN_VER!') do (
	  set _local_loop_cnts=0
	  if !_local_loop_cnts!==0 (
		  set QDKe_VAR_WIN_VER_MAJOR=%%v
		  set QDKe_VAR_WIN_VER_MINOR=%%w
		  set QDKe_VAR_WIN_VER_PLUS=%%x
		)
		set /a _local_loop_cnts=!_local_loop_cnts!+1
	)
	rem set QDKe_VAR_WIN_VER=%QDKe_VAR_WIN_VER:~0,3%
	set "QDKe_VAR_WIN_VER=!QDKe_VAR_WIN_VER_MAJOR!.!QDKe_VAR_WIN_VER_MINOR!"
	set "QDKe_VAR_WIN_VER_INT=!QDKe_VAR_WIN_VER_MAJOR!!QDKe_VAR_WIN_VER_MINOR!"
	exit /b

	goto :QDKe_CHECK_WIN_VER_EOF

:----------------------------------------


:: CheckWindowsVersion by wmic
:----------------------------------------
REM  --> Check Windows Version
for /f "tokens=3" %%a in ('wmic os get Caption') do if /i "%%a" neq "" set QDKe_VAR_WIN_VER=%%a
if /i %QDKe_VAR_WIN_VER%==xp goto :XP
if /i %QDKe_VAR_WIN_VER%==7 goto :WIN7
%decho% [QDKe]: Unkown windows version.
goto :QDKe_CHECK_WIN_VER_EOF
:XP
:WIN7
goto :QDKe_CHECK_WIN_VER_EOF

:----------------------------------------

:QDKe_CHECK_WIN_VER_EOF
:----------------RUN-ONCE----------------
set INCLUDE_CHECK_WIN_VER_BATCH=true
:EOF
:----------------RUN-ONCE----------------