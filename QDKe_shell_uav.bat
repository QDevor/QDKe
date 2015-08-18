@echo off

rem 1 - means origin size
rem 2 - means two times origin size
rem 5 - means full size
call env/env-win/set-win-mode.bat 4

echo.
echo            Copyright (C) 2015 QDevor
echo.
echo  Licensed under the GNU General Public License, Version 3.0 (the License);
echo  you may not use this file except in compliance with the License.
echo  You may obtain a copy of the License at
echo.
echo            http://www.gnu.org/licenses/gpl-3.0.html
echo.
echo Unless required by applicable law or agreed to in writing, software
echo distributed under the License is distributed on an AS IS BASIS,
echo WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
echo See the License for the specific language governing permissions and
echo limitations under the License.
echo.

cd /d %~dp0
title %~n0

:: setlocal enabledelayedexpansion
:-------------------------------------
setlocal enabledelayedexpansion
:-------------------------------------

:: settings requirements
:-------------------------------------
:--Default setting to false
set QDKe_VAR_INCLUDED_MINGW=true
:--Default setting to true
:Assumeing system detect
rem None 2005 2008
set QDKe_VAR_FORCE_MSVS_VER_YEAR=2010
:-------------------------------------
rem Default setting to V60A(WINXP) or V71(WIN7)
rem Depending On Variable QDKe_VAR_MSVS_VER_YEAR
rem VXPSP2 V60A V70 V70A V71
rem set QDKe_VAR_MSSDK_VER=V60A
:-------------------------------------
rem Default setting to 1.4
set QDKe_VAR_GO_VER=1.5
:-------------------------------------

:: Checking QDKe Env
:-------------------------------------
echo [QDKe] - We Are Checking QDKe Env.
call env/env-win/entry-common.bat
:-------------------------------------

rem echo "%PATH%"

:+++++++++++++++++++++++++++++++++++++
:: Doing Jobs Start...
echo [QDKe] - We Are Doing Jobs... Start.
:+++++++++++++++++++++++++++++++++++++
:: OpenPilot-OpenPilot
:: 
:+++++++++++++++++++++++++++++++++++++
set DJN=OpenPilot-OpenPilot
set DJNLOG=0
if "x%DJNLOG%" == "x1" (
  call "env/env-uav/uav-%DJN%.bat" > var/log/%~n0.log 2>&1
) else (
  call "env/env-uav/uav-%DJN%.bat"
)
:+++++++++++++++++++++++++++++++++++++
:: Doing Jobs Finish...
echo [QDKe] - We Are Doing Jobs... Finish.
:+++++++++++++++++++++++++++++++++++++
title %~n0
:: setlocal disabledelayedexpansion
:-------------------------------------
setlocal disabledelayedexpansion
:-------------------------------------

PAUSE
EXIT