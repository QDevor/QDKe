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

:----------------------------------------
set "PGM_BATCH_FILE=%~n0"
set "PGM_BATCH_FILE=!PGM_BATCH_FILE:~3!"
rem for /f "tokens=x,y,m-n delims=chars" %%a in ("str")   do cmd
for /f "tokens=1* delims=-" %%a in ("!PGM_BATCH_FILE!") do (
	set PGM_USER=%%a
	set PGM_NAME=%%b
)
set "PGM_HOST=github.com"
set "PGM_WORK_HOME=!GOPATH!/src/!PGM_HOST!/!PGM_USER!/!PGM_NAME!"
set "PGM_WORK_HOME=!PGM_WORK_HOME:/=\!"
:----------------------------------------
cd !PGM_WORK_HOME!
echo [Building][Go] - Clone - !PGM_BATCH_FILE!.
echo [Building][Go] - Clone - !PGM_USER!/!PGM_NAME!.
go get !PGM_HOST!/!PGM_USER!/!PGM_NAME!
:----------------------------------------
dir *.ui >nul 2>&1
if "!errorlevel!" == "0" (
	echo [Building][Go] - Compiling - UI.
	cd !PGM_WORK_HOME!
	ui2walk
)
:----------------------------------------
dir *.ico *.rc >nul 2>&1
if "!errorlevel!" == "0" (
	echo [Building][Go] - Compiling - Resource.
	cd !PGM_WORK_HOME!
	rem rsrc [-manifest FILE.exe.manifest] [-ico FILE.ico[,FILE2.ico...]] -o FILE.syso
	rem rsrc -data FILE.dat -o FILE.syso > FILE.c
	rem rsrc -manifest dft.exe.manifest -ico ./icon/4.ico,./icon/6.ico -o %~n0.syso
	rem echo WINDRES -o %~n0.syso %~n0_ui_res.rc
	windres -o !PGM_NAME!.syso !PGM_NAME!_ui_res.rc
)
:----------------------------------------
echo [Building][Go] - Compiling - Program.
rem go build -ldflags="-s -w -H windowsgui"
go install github.com/michaeldv/mop/cmd
mv !GOPATH!/bin/cmd.exe !GOPATH!/bin/!PGM_NAME!.exe
:----------------------------------------
echo [Building][Go] - Running   - Program.
!PGM_NAME!
:----------------------------------------
echo [Building][Go] - Compiling - Doc.
rem godoc -http=":8080"
:----------------------------------------

:----------------RUN-ONCE----------------
set INCLUDE_GO_INSTRANCE_BATCH=true
:EOF
:----------------RUN-ONCE----------------