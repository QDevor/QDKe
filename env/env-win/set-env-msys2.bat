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

if "x%INCLUDE_SET_MSYS2_PATH_BATCH%" == "xtrue" (
	goto :EOF
)

rem uncomment following sentence, output debug info to be enabled separately
rem set QDKe_VAR_DEBUG_%~n0=true
if "x!QDKe_VAR_DEBUG_%~n0!" == "xtrue" (
	set decho=echo
) else (
	set decho=rem
)

:: Getting MSYS2
:-------------------------------------
:: set PKG=msys2
:: set PKG_ARCH=i686
:: rem set PKG_ARCH=x86_64
:: set PKG_VERSION=20150202
:: set PKG_FILE=!PKG!-!PKG_ARCH!-!PKG_VERSION!.exe
:: set PKG_URL=http://jaist.dl.sourceforge.net/project/msys2/Base/i686/!PKG_FILE!
:: set PKG_URL=http://jaist.dl.sourceforge.net/project/msys2/Base/i686/msys2-i686-20150202.exe
:: set PKG_URL=http://jaist.dl.sourceforge.net/project/msys2/Base/x86_64/msys2-x86_64-20150202.exe
:: wget -t 10 --retry-connrefused --no-check-certificate !PKG_URL!
:-------------------------------------

:: Setting MSYS2 PATH
:-------------------------------------
set MSYS2_ROOT_32=%QDK_ROOT%/msys32
set MSYS2_ROOT_64=%QDK_ROOT%/msys64

:: Setting MSYS or MINGW PATH
:-------------------------------------
if "!QDKe_VAR_MSYS2!" == "false" (
	if "!QDKe_VAR_IS_XP!" == "true" (
		set MSYS_ROOT=!MSYS_ROOT_MINGW32!
		set MINGW_ROOT=!MSYS_MINGW32_ROOT!
	) else (
		set MSYS_ROOT=!MSYS_ROOT_MINGW64!
		set MINGW_ROOT=!MSYS_MINGW64_ROOT!
	)
) else (
	if "!QDKe_VAR_IS_XP!" == "true" (
		set MSYS_ROOT=!MSYS2_ROOT_32!
		set MINGW_ROOT=!MSYS2_ROOT_32!/mingw32
	) else (
		set MSYS_ROOT=!MSYS2_ROOT_64!
		set MINGW_ROOT=!MSYS2_ROOT_64!/mingw64
	)
)

%decho%  MSYS_ROOT=%MSYS_ROOT%
%decho% MINGW_ROOT=%MINGW_ROOT%

:: Can Swtich MinGW to 32bit when On WIN7
:: Nothing to do
:: Only set MSYSTEM=MINGW32
:-------------------------------------
if "x!MSYSTEM!" == "xMINGW32" (
  set MINGW_ROOT=!MSYS_ROOT!/mingw32
)

:: Add MSYS or MINGW to PATH
:-------------------------------------
if "!QDKe_VAR_MSYS2!" == "false" (
	set "PATH=!MSYS_ROOT!/bin;!PATH!"
	set "PATH=!MINGW_ROOT!/bin;!PATH!"
) else (
	set "PATH=!MSYS_ROOT!/usr/bin;!PATH!"
	if "!QDKe_VAR_INCLUDED_MINGW!" == "true" (
		set "PATH=!MINGW_ROOT!/bin;!PATH!"
	)
)

for /F "usebackq delims=-" %%v in (`uname`) do (
	set version=%%v
)
echo [QDKe] - We Are Running On !version!(msys2).

:-------------------------------------
set INCLUDE_SET_MSYS2_PATH_BATCH=true
:EOF