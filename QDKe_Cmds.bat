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
:--Default setting to true
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

rm -rf *.bak
rm -rf env/*/*.bak

set DJN=win-check-dirs-exist
call env/env-test/%DJN%.bat

:+++++++++++++++++++++++++++++++++++++
:: Doing Jobs Finish...
echo [QDKe] - We Are Doing Jobs... Finish.
:+++++++++++++++++++++++++++++++++++++
title %~n0
cmd
:: setlocal disabledelayedexpansion
:-------------------------------------
setlocal disabledelayedexpansion
:-------------------------------------

PAUSE
EXIT