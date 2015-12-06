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

:loop
	title %~n0
set "PATH=%PATH%;home\uav_home\OpenPilot\OpenPilot\build\openpilotgcs_release\bin"
set "PATH=%PATH%;home\uav_home\OpenPilot\OpenPilot\build\openpilotgcs_release\lib\openpilotgcs"
openpilotgcs -log eAnyPilotRun.log
	cmd
	echo last return - %errorlevel%.
	goto :loop

PAUSE
EXIT