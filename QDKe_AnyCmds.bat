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

set "QDK_ROOT=D:/qdk"
set "QDKE_ROOT=D:/work_code/qdke"

set "MSYS_ROOT=%QDK_ROOT%/msys64"
set "MINGW32_ROOT=%MSYS_ROOT%/ming32"
set "MINGW64_ROOT=%MSYS_ROOT%/ming64"

set "MXE_ROOT=%QDKE_ROOT%/home/mxe"

set "QDKE_PURE_PATH=C:/WINDOWS/system32;C:/WINDOWS;C:/WINDOWS/System32/Wbem"
set "PATH=%QDKE_PURE_PATH%"

set "PATH=%MXE_ROOT%/usr/x86_64-pc-mingw32/bin;%MXE_ROOT%/usr/bin;%PATH%"
set "PATH=%PATH%;%MINGW32_ROOT%/bin;%MSYS_ROOT%/usr/bin"

set QDKE_CROSS_COMPILE=i686-w64-mingw32.static-
set QDKE_CC=%QDKE_CROSS_COMPILE%gcc
set QDKE_CXX=%QDKE_CROSS_COMPILE%g++

set CC=%QDKE_CC%
set CXX=%QDKE_CXX%

set TMP=%cd%/tmp
set TMPDIR=%TMP%
set TEMP=%TMP%

set MSYSTEM=MINGW32

:loop
	title %~n0

	cmd
	echo last return - %errorlevel%.
	goto :loop

PAUSE
EXIT