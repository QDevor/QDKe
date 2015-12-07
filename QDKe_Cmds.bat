@echo off

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
rem None 2005 2008
set QDKe_VAR_MSVS_VER_YEAR=2010
:-------------------------------------
rem Default setting to VXPSP2(WINXP) or V71(WIN7)
rem VXPSP2 V60A V70 V70A V71
set QDKe_VAR_MSSDK_VER=V60A
:-------------------------------------
:-------------------------------------
set MSYSTEM=MINGW32

:: Checking QDKe Env
:-------------------------------------
echo [QDKe] - We Are Checking QDKe Env.
call env/env-win/entry-common.bat
:-------------------------------------

echo "%PATH%"

:+++++++++++++++++++++++++++++++++++++
:: Doing Jobs Start...
echo [QDKe] - We Are Doing Jobs... Start.
:+++++++++++++++++++++++++++++++++++++

rm -rf *.bak
rm -rf env/*/*.bak

set DJN=win-check-dirs-exist
rem call env/env-test/%DJN%.bat

:+++++++++++++++++++++++++++++++++++++
:: Doing Jobs Finish...
echo [QDKe] - We Are Doing Jobs... Finish.
:+++++++++++++++++++++++++++++++++++++
title %~n0
pacman -Sl > msys2_remote_pkglist.txt

set "PATH=%PATH%;home\uav_home\OpenPilot\OpenPilot\build\openpilotgcs_release\bin"
set "PATH=%PATH%;home\uav_home\OpenPilot\OpenPilot\build\openpilotgcs_release\lib\openpilotgcs"
rem openpilotgcs
cmd
:: setlocal disabledelayedexpansion
:-------------------------------------
setlocal disabledelayedexpansion
:-------------------------------------
:eof
PAUSE
EXIT