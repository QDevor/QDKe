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
if "x%INCLUDE_WORKBENCH_ANY_BATCH%" == "xtrue" (
	goto :EOF
)
:----------------RUN-ONCE----------------

:: Checking QDKe Env again but not really
:----------------------------------------
echo [QDKe] - We Are Checking QDKe Env.
call env/env-win/entry-common.bat
:----------------------------------------
call env/env-workbench/workbench-common.bat
:----------------------------------------

set "mxe_call_args=%*"
set "PGM_BATCH_FILE=%~n0"
rem set "PGM_BATCH_FILE=!PGM_BATCH_FILE:~9!"
rem for /f "tokens=x,y,m-n delims=chars" %%a in ("str")   do cmd
for /f "tokens=1* delims=-" %%a in ("!PGM_BATCH_FILE!") do (
	set PGM_USER=%%a
	set PGM_NAME=%%b
)
set "PGM_HOST=github.com"
rem set "PGM_WORK_HOME=!QDKE_HOME!/mxe_home"
set "PGM_WORK_HOME=!QDKE_HOME!/mxe_home"
set "PGM_WORK_HOME=!PGM_WORK_HOME:/=\!"
:----------------------------------------
echo [Building][WorkBench] - Starting  - !PGM_BATCH_FILE!.
:----------------------------------------
rem git clone git://git.openpilot.org/OpenPilot.git OpenPilot
:----------------------------------------
echo [Building][WorkBench] - Makeing  - !PGM_BATCH_FILE!.

if not exist !PGM_NAME!-patch-stamp (
	rem echo [Building][WorkBench] - Makeing  - !PGM_USER!.

	rem cd !PGM_WORK_HOME!

	rem set "PATH=%MSYS_ROOT%/usr/bin;%QDKE_PURE_PATH%"
rem goto :LABEL_SKIP_RESET_PATH_VAR	
	
:LABEL_SKIP_RESET_PATH_VAR
  rem env > before_call_workbench.env
	bash --login -i -c "../env/env-workbench/workbench-any.sh %workbench_call_args%"
	
	rem touch !PGM_WORK_HOME!/!PGM_NAME!-patch-stamp
)
:----------------------------------------

:----------------------------------------
echo [Building][WorkBench] - Ending    - !PGM_BATCH_FILE!.
:----------------RUN-ONCE----------------
set INCLUDE_WORKBENCH_ANY_BATCH=true
:EOF
:----------------RUN-ONCE----------------