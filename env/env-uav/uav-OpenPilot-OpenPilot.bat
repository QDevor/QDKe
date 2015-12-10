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
set "PGM_BATCH_FILE=!PGM_BATCH_FILE:~3!"
rem for /f "tokens=x,y,m-n delims=chars" %%a in ("str")   do cmd
for /f "tokens=1* delims=-" %%a in ("!PGM_BATCH_FILE!") do (
	set PGM_USER=%%a
	set PGM_NAME=%%b
)
set "PGM_HOST=github.com"
set "PGM_WORK_HOME=!QDKE_HOME!/uav_home/!PGM_USER!/!PGM_NAME!"
set "PGM_WORK_HOME=!PGM_WORK_HOME:/=\!"
:----------------------------------------
echo [Building][Go] - Starting  - !PGM_BATCH_FILE!.
:----------------------------------------
rem git clone git://git.openpilot.org/OpenPilot.git OpenPilot
:----------------------------------------
echo [Building][Go] - Makeing  - !PGM_USER!/!PGM_NAME!.
cd !PGM_WORK_HOME! ||goto :EOF
if not exist !PGM_NAME!-patch-stamp (
	echo [Building][Go] - Makeing  - !PGM_USER!/!PGM_NAME!.
	
	cd !PGM_WORK_HOME!
  
  set "CROSS_COMPILE_QT_QMAKE_OPENPILOT_ROOT=!QDKE_ROOT!/home/uav_home/OpenPilot/OpenPilot/tools/qt-5.4.0/5.4/mingw491_32/bin"
  set "CROSS_COMPILE_QT_MINGW_OPENPILOT_ROOT=!QDKE_ROOT!/home/uav_home/OpenPilot/OpenPilot/tools/qt-5.4.0/Tools/mingw491_32/bin"
  
  rem _WIN _OPENPILOT
  set "CROSS_COMPILE_QT_QMAKE_ROOT=!CROSS_COMPILE_QT_QMAKE_WIN_ROOT!"
  set "CROSS_COMPILE_QT_MINGW_ROOT=!CROSS_COMPILE_QT_MINGW_WIN_ROOT!"
  
  rem _MSYS _MINGW32 _MINGW64 _MXE
  set "CROSS_COMPILE_ROOT=!CROSS_COMPILE_QT_MINGW_OPENPILOT_ROOT!"
  set "CROSS_COMPILE="
  
  set "TMP_PATH=!PATH!"
  set "NEWPATH=%MSYS_ROOT%/usr/bin;%QDKE_PURE_PATH%"
  set "NEWPATH=%MSYS_ROOT%/usr/bin"
	
	set "NEWPATH=!CROSS_COMPILE_QT_QMAKE_OPENPILOT_ROOT!;!NEWPATH!"
  set "NEWPATH=!CROSS_COMPILE_ROOT!;!NEWPATH!"
  
  rem echo "PATH=!NEWPATH!"
  set "PATH=!NEWPATH!"
  
goto :LABEL_SKIP_MAKE_INSTALL_TOOLS	
  
	rem make libkml_install V=1
	rem qmake -query QMAKE_SPEC
	rem sh ./make/scripts/win_sdk_install.sh
	rem make arm_sdk_install V=1
	rem make sdl_install V=1
	rem make all_sdk_install V=1
:LABEL_SKIP_MAKE_INSTALL_TOOLS
	echo !errorlevel!
	if "!errorlevel!" == "0" (
    make all V=1
    rem cd build/openpilotgcs_release/src/plugins/kmlexport && make all V=1
  )
	
	set "PATH=!TMP_PATH!"
	rem touch !PGM_WORK_HOME!/!PGM_NAME!-patch-stamp
)
:----------------------------------------

:----------------------------------------
echo [Building][Go] - Ending    - !PGM_BATCH_FILE!.
:----------------RUN-ONCE----------------
set INCLUDE_GO_INSTRANCE_BATCH=true
:EOF
:----------------RUN-ONCE----------------