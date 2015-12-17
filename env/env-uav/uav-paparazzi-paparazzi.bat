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

:: Checking QDKe Env again but not really
:----------------------------------------
echo [QDKe] - We Are Checking QDKe Env.
call env/env-win/entry-common.bat
:----------------------------------------
call env/env-uav/uav-common.bat
:----------------------------------------
set "PGM_BATCH_FILE=%~n0"
set "PGM_BATCH_FILE=!PGM_BATCH_FILE:~4!"
rem for /f "tokens=x,y,m-n delims=chars" %%a in ("str")   do cmd
for /f "tokens=1* delims=-" %%a in ("!PGM_BATCH_FILE!") do (
	set PGM_USER=%%a
	set PGM_NAME=%%b
)
set "PGM_HOST=github.com"
set "PGM_WORK_HOME=!QDKE_HOME!/uav_home/!PGM_USER!/!PGM_NAME!"
set "PGM_WORK_HOME=!PGM_WORK_HOME:/=\!"
:----------------------------------------
echo [Building][UAV] - Starting  - !PGM_BATCH_FILE!.
:----------------------------------------

:----------------------------------------
echo [Building][UAV] - Makeing  - !PGM_USER!/!PGM_NAME!.
if not exist !PGM_NAME!-patch-stamp (
	echo [Building][UAV] - Makeing  - !PGM_USER!/!PGM_NAME!.
  bash --login -i -c "../env/env-uav/uav-!PGM_USER!-!PGM_NAME!.sh"
)
:----------------------------------------

:----------------------------------------
echo [Building][UAV] - Ending    - !PGM_BATCH_FILE!.
