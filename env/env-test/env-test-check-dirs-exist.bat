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

call env/env-win/set-dflt-vars.bat
call env/env-win/set-dflt-dirs.bat

set filename=%~n0
set filename=!filename:~9,50!

:: env-test: check-dirs-exist
:-------------------------------------
echo [QDKe] - We Are Testing - !filename! start.

cd /d %QDKE_HOME% || exit !errorlevel!
mkdir test\!filename! >nul 2>&1
cd test/!filename!

set "args=1 2 3 4 5 6 7 8 9"
set "args=1 2 3 4 5 6 7 8 9 10 11"
call %QDKE_ENV%/env-win/check-dirs-exist.bat %args%

cd /d %QDKE_HOME% || exit !errorlevel!

echo [QDKe] - We Are Testing - !filename! finish.
:-------------------------------------

:EOF