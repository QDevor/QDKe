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
if "x%INCLUDE_SET_EXTRA_CROSS_COMPILE_BATCH%" == "xtrue" (
	goto :EOF
)
:----------------RUN-ONCE----------------

set "CROSS_COMPILE_QT_QMAKE_WIN_ROOT=!QDK_ROOT!/Qt/Qt5.4.0/5.4/mingw491_32/bin"
set "CROSS_COMPILE_QT_MINGW_WIN_ROOT=!QDK_ROOT!/Qt/Qt5.4.0/Tools/mingw491_32/bin"

set "CROSS_COMPILE_MSYS_ROOT=!MSYS_ROOT!/usr/bin"
set "CROSS_COMPILE_MINGW32_ROOT=!MINGW32_ROOT!/bin"
set "CROSS_COMPILE_MINGW64_ROOT=!MINGW32_ROOT!/bin"
set "CROSS_COMPILE_MXE_ROOT=!QDKE_ROOT!/home/mxe/usr/bin"

set "CROSS_COMPILE_MSYS_PREFIX="
set "CROSS_COMPILE_MINGW32_PREFIX=i686-w64-mingw32"
set "CROSS_COMPILE_MINGW64_PREFIX=x86_64-w64-mingw32"
set "CROSS_COMPILE_MXE32_PREFIX=i686-w64-mingw32.static"
set "CROSS_COMPILE_MXE64_PREFIX=x86_64-w64-mingw32.static"
set "CROSS_COMPILE_MXE32_SHARED_PREFIX=i686-w64-mingw32.shared"
set "CROSS_COMPILE_MXE64_SHARED_PREFIX=x86_64-w64-mingw32.shared"

:----------------RUN-ONCE----------------
set INCLUDE_SET_EXTRA_CROSS_COMPILE_BATCH=true
:EOF
:----------------RUN-ONCE----------------