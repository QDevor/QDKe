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
:: runner_go_libs
:: runner_djcs runner_quantdigger
goto :runner_go_libs
:+++++++++++++++++++++++++++++++++++++
:+++++++++++++++++++++++++++++++++++++
:runner_go_libs
go env
set work_home=home\test_home
set apps_name=talib
if not exist %work_home% (
  mkdir %work_home%
)
cd %work_home%
rem go get github.com/d4l3k/talib
cd /d %~dp0
cd home\go_home\src\github.com\d4l3k\talib
rem gem sources --remove https://rubygems.org/
rem gem sources -a http://ruby.taobao.org/
rem gem sources -l
rem gem install cast pry
rem ruby generate.rb ||goto :EOF
rem go install
go install
cd /d %~dp0
cd %work_home% ||goto :EOF
go build example.go
rem go run example.go
goto :runner_end
:+++++++++++++++++++++++++++++++++++++
:runner_quantdigger
set work_home=home/qstk_home/QuantFans/quantdigger/github/quantdigger/demo
set apps_name=main.py
goto :runner_start
:+++++++++++++++++++++++++++++++++++++
:runner_djcs
set work_home=home/qstk_home/QDevor/djcs/github/src
set apps_name=djcs.py
goto :runner_start
:+++++++++++++++++++++++++++++++++++++
:runner_start
cd %work_home% && python %apps_name%
cmd
:runner_end
:+++++++++++++++++++++++++++++++++++++
:: Doing Jobs Finish...
echo [QDKe] - We Are Doing Jobs... Finish.
:+++++++++++++++++++++++++++++++++++++
title %~n0
:: setlocal disabledelayedexpansion
:-------------------------------------
setlocal disabledelayedexpansion
:-------------------------------------
:EOF
PAUSE
EXIT